// SPDX-License-Identifier: MIT
#include "receiver_link.hpp"
#include "bond_store.hpp"
#include <Arduino.h>
#include <NimBLEDevice.h>
#include <atomic>
#include <little_on_air/pairing_control.h>

namespace {
constexpr char serviceUuid[] = "7f6c0000-6b7e-4c80-9f2a-f9b9d7e2a601";
constexpr char commandUuid[] = "7f6c0001-6b7e-4c80-9f2a-f9b9d7e2a601";
constexpr char stateUuid[] = "7f6c0002-6b7e-4c80-9f2a-f9b9d7e2a601";
constexpr char pixelUuid[] = "7f6c0003-6b7e-4c80-9f2a-f9b9d7e2a601";
QueueHandle_t requests, results, indications;
NimBLEClient *client = nullptr;
std::atomic<LinkPhase> phase{LinkPhase::Idle};
std::atomic<bool> busy{false}, expired{false};
std::atomic<int> encryptionResult{-1};
uint32_t startedAt, budgetMs;

int preserveBond(ble_gap_event *event, void *) {
    // NimBLE 2.5.1 normally deletes a stored key and automatically re-pairs on
    // PINKEY_MISSING. Its GAP listener runs before the client event callback.
    // Return this as an authentication failure instead: replacing a pair must
    // go through the controller's explicit Forget + Pair UI.
    if (event->type == BLE_GAP_EVENT_ENC_CHANGE) {
        Serial.printf("SECURITY encryption_result=%d\n", event->enc_change.status);
        if (event->enc_change.status == BLE_HS_HCI_ERR(BLE_ERR_PINKEY_MISSING))
            event->enc_change.status = BLE_HS_EAUTHEN;
        encryptionResult = event->enc_change.status;
    }
    return 0;
}

bool securePeer(bool pairing) {
    if (pairing)
        return client->secureConnection();
    const auto info = client->getConnInfo();
    if (!linkBonded() || info.getIdAddress() != NimBLEDevice::getBondedAddress(0))
        return false;
    ble_store_key_sec key{};
    ble_store_value_sec stored{};
    key.peer_addr = *info.getIdAddress().getBase();
    const int lookup = ble_store_read_peer_sec(&key, &stored);
    if (lookup != 0 || !stored.ltk_present || stored.key_size != 16) {
        Serial.printf("SECURITY saved_key_unavailable lookup=%d\n", lookup);
        return false;
    }
    // A routine read must only restore an existing encrypted link. The normal
    // secureConnection helper can retry by pairing after a missing-key error.
    // Start once, after confirming the stored LTK, and observe its result.
    encryptionResult = -1;
    if (!NimBLEDevice::startSecurity(info.getConnHandle()))
        return false;
    while (!expired && client->isConnected() && encryptionResult == -1)
        vTaskDelay(pdMS_TO_TICKS(10));
    return !expired && client->isConnected() && encryptionResult == 0;
}

void onIndication(NimBLERemoteCharacteristic *, uint8_t *bytes, size_t length, bool notification) {
    loa_message state{};
    if (!notification && loa_protocol_decode(&state, bytes, length) == 0)
        xQueueOverwrite(indications, &state);
}

bool readState(NimBLERemoteCharacteristic *characteristic, loa_message &state) {
    if (expired)
        return false;
    phase = LinkPhase::Reading;
    const auto value = characteristic->readValue();
    return !expired && loa_protocol_decode(&state, value.data(), value.size()) == 0;
}

bool connectPeer(bool pairing) {
    if (!pairing) {
        if (!linkBonded())
            return false;
        phase = LinkPhase::Connecting;
        // NimBLE restores the peer IRK/resolving list from NVS. Connect only to
        // this bonded identity, never to the first unrelated service advertiser.
        const bool connected = client->connect(NimBLEDevice::getBondedAddress(0), false);
        if (!connected)
            Serial.printf("LINK connect failed error=%d\n", client->getLastError());
        return connected;
    }
    auto *scan = NimBLEDevice::getScan();
    scan->setActiveScan(true);
    scan->setInterval(100);
    scan->setWindow(80);
    scan->setMaxResults(32);
    const uint32_t start = millis();
    while (!expired && millis() - start < 45000) {
        phase = LinkPhase::Scanning;
        const auto found = scan->getResults(3000, false);
        for (int i = 0; i < found.getCount() && !expired; ++i) {
            const auto *device = found.getDevice(i);
            if (!device->isAdvertisingService(NimBLEUUID(serviceUuid)))
                continue;
            phase = LinkPhase::Connecting;
            if (client->connect(device, true)) {
                scan->clearResults();
                return true;
            }
        }
        scan->clearResults();
    }
    return false;
}

bool forgetReceiver(const LinkRequest &request) {
    if (!linkBonded() || !connectPeer(false) || expired)
        return false;
    auto *service = client->getService(serviceUuid);
    auto *control = service ? service->getCharacteristic(LOA_PAIRING_CONTROL_UUID) : nullptr;
    if (!control || !control->canWrite())
        return false;
    phase = LinkPhase::Securing;
    if (expired || !securePeer(false))
        return false;
    const auto info = client->getConnInfo();
    if (expired || !info.isEncrypted() || !info.isBonded() || info.getSecKeySize() != 16 ||
        info.getIdAddress() != NimBLEDevice::getBondedAddress(0))
        return false;
    const uint32_t id = request.command.transaction_id;
    const uint8_t payload[] = {
        1, 1, uint8_t(id), uint8_t(id >> 8), uint8_t(id >> 16), uint8_t(id >> 24)};
    phase = LinkPhase::Sending;
    // The receiver persists its reset intent before returning ATT success.
    return !expired && control->writeValue(payload, sizeof(payload), true);
}

LinkResult transact(const LinkRequest &request) {
    LinkResult result{request, false, linkBonded(), {}, "Receiver unavailable", false, {}};
    if (request.operation == LinkOperation::Forget) {
        result.receiverForgotten = forgetReceiver(request);
        Serial.printf("FORGET receiver_accepted=%u\n", result.receiverForgotten);
        if (client->isConnected()) {
            client->disconnect();
            for (int i = 0; i < 100 && client->isConnected(); ++i)
                vTaskDelay(pdMS_TO_TICKS(10));
        }
        // This explicit menu action also works without the sign present.
        // The UI shows physical recovery steps when remote reset is uncertain.
        result.success = NimBLEDevice::deleteAllBonds() && ble_store_clear() == 0;
        client->deleteServices();
        result.error = "Could not clear pair";
        result.bonded = linkBonded();
        return result;
    }
    const bool pairing = request.operation == LinkOperation::Pair;
    if (pairing && linkBonded()) {
        result.error = "Already paired";
        return result;
    }
    if (!pairing && !linkBonded()) {
        result.error = "Pair receiver first";
        return result;
    }
    if (!connectPeer(pairing) || expired)
        return result;
    auto *service = client->getService(serviceUuid);
    auto *command = service ? service->getCharacteristic(commandUuid) : nullptr;
    auto *state = service ? service->getCharacteristic(stateUuid) : nullptr;
    if (!command || !state || !command->canWrite() || !state->canRead() || !state->canIndicate()) {
        result.error = "Wrong receiver service";
        return result;
    }
    phase = LinkPhase::Securing;
    if (expired || !securePeer(pairing)) {
        result.error = "Pair/encryption failed";
        return result;
    }
    const auto info = client->getConnInfo();
    if (expired || !info.isEncrypted() || !info.isBonded() || info.getSecKeySize() != 16 ||
        (!pairing && info.getIdAddress() != NimBLEDevice::getBondedAddress(0))) {
        result.error = "Peer security failed";
        return result;
    }
    result.bonded = linkBonded();
    if (request.operation == LinkOperation::ReadBrightness ||
        request.operation == LinkOperation::SetBrightness) {
        auto *brightness = service->getCharacteristic(LOA_BRIGHTNESS_UUID);
        if (!brightness || !brightness->canRead() || !brightness->canWrite()) {
            result.error = "Update sign firmware";
            return result;
        }
        if (request.operation == LinkOperation::SetBrightness) {
            uint8_t payload[LOA_BRIGHTNESS_PAYLOAD_LEN];
            phase = LinkPhase::Sending;
            if (loa_brightness_encode(payload, &request.brightness) != 0 || expired ||
                !brightness->writeValue(payload, sizeof(payload), true)) {
                result.error = "Save not confirmed";
                return result;
            }
        }
        phase = LinkPhase::Reading;
        const auto value = brightness->readValue();
        result.success =
            !expired &&
            loa_brightness_decode(&result.brightness, value.data(), value.size()) == 0 &&
            (request.operation == LinkOperation::ReadBrightness ||
             loa_brightness_equal(&request.brightness, &result.brightness));
        result.error = "Save not confirmed";
        return result;
    }
    if (request.operation == LinkOperation::Pixel) {
        auto *test = service->getCharacteristic(pixelUuid);
        if (!test || !test->canWrite() || !test->canRead()) {
            result.error = "Pixel test unsupported";
            return result;
        }
        const uint8_t payload[] = {1, request.pixelIndex, request.pixelColor.red,
                                   request.pixelColor.green, request.pixelColor.blue};
        phase = LinkPhase::Sending;
        if (expired || !test->writeValue(payload, sizeof(payload), true)) {
            result.error = "Pixel test write failed";
            return result;
        }
        const auto readback = test->readValue();
        result.success = !expired && readback.size() == sizeof(payload) &&
                         memcmp(readback.data(), payload, sizeof(payload)) == 0;
        result.error = "Pixel test read mismatch";
        return result;
    }
    if (request.operation != LinkOperation::Send) {
        result.success = readState(state, result.state);
        result.error = "State read failed";
        return result;
    }
    xQueueReset(indications);
    if (expired || !state->subscribe(false, onIndication, true)) {
        result.error = "Subscribe failed";
        return result;
    }
    uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];
    loa_protocol_encode(payload, &request.command);
    phase = LinkPhase::Sending;
    if (expired || !command->writeValue(payload, sizeof(payload), true)) {
        result.error = "Command write failed";
        return result;
    }
    phase = LinkPhase::Waiting;
    const uint32_t waitStart = millis();
    while (!expired && client->isConnected() && millis() - waitStart < 1200) {
        if (xQueueReceive(indications, &result.state, pdMS_TO_TICKS(50)) == pdTRUE &&
            loa::exactAck(request.command, result.state)) {
            result.success = true;
            return result;
        }
    }
    // A write response alone is not confirmation. Recover a lost indication
    // only when an authoritative read matches BOTH transaction and status.
    result.success = readState(state, result.state) && loa::exactAck(request.command, result.state);
    result.error = "No matching ACK";
    return result;
}

void worker(void *) {
    LinkRequest request{};
    for (;;) {
        xQueueReceive(requests, &request, portMAX_DELAY);
        LinkResult result = transact(request);
        if (client->isConnected()) {
            client->disconnect();
            for (int i = 0; i < 100 && client->isConnected(); ++i)
                vTaskDelay(pdMS_TO_TICKS(10));
        }
        if (expired && request.operation != LinkOperation::Forget) {
            result.success = false;
            result.error = "Receiver timed out";
        }
        result.bonded = linkBonded();
        phase = LinkPhase::Idle;
        xQueueSend(results, &result, portMAX_DELAY);
    }
}
} // namespace

bool linkInit() {
    requests = xQueueCreate(1, sizeof(LinkRequest));
    results = xQueueCreate(1, sizeof(LinkResult));
    indications = xQueueCreate(1, sizeof(loa_message));
    if (!requests || !results || !indications || !NimBLEDevice::init("Little On Air Desk"))
        return false;
    if (!NimBLEDevice::setCustomGapHandler(preserveBond))
        return false;
    configureBondStore();
    NimBLEDevice::setSecurityAuth(true, false, true);
    NimBLEDevice::setSecurityIOCap(BLE_HS_IO_NO_INPUT_OUTPUT);
    NimBLEDevice::setSecurityInitKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);
    NimBLEDevice::setSecurityRespKey(BLE_SM_PAIR_KEY_DIST_ENC | BLE_SM_PAIR_KEY_DIST_ID);
    client = NimBLEDevice::createClient();
    if (!client)
        return false;
    client->setConnectTimeout(4500);
    // Retry one 0x3e establishment failure before any GATT command is sent.
    // The UI's overall eight-second deadline still cancels the operation.
    client->setConnectRetries(1);
    return xTaskCreate(worker, "loa-ble", 8192, nullptr, 1, nullptr) == pdPASS;
}

bool linkBonded() {
    return NimBLEDevice::getNumBonds() > 0;
}
LinkPhase linkPhase() {
    return phase.load();
}
bool linkStart(const LinkRequest &request) {
    if (busy.exchange(true))
        return false;
    expired = false;
    startedAt = millis();
    budgetMs = request.operation == LinkOperation::Pair ? 60000 : 8000;
    if (xQueueSend(requests, &request, 0) == pdTRUE)
        return true;
    busy = false;
    return false;
}

bool linkPoll(LinkResult &result) {
    if (xQueueReceive(results, &result, 0) == pdTRUE) {
        busy = false;
        return true;
    }
    // Interrupt blocking BLE waits while the UI and encoder continue running.
    if (busy && millis() - startedAt >= budgetMs && !expired.exchange(true)) {
        NimBLEDevice::getScan()->stop();
        client->cancelConnect();
        if (client->isConnected())
            client->disconnect();
    }
    return false;
}
