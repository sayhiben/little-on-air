// SPDX-License-Identifier: MIT
#include "buddy_ui.hpp"
#include "controller.hpp"
#include "receiver_link.hpp"
#include <Adafruit_NeoPixel.h>
#include <Adafruit_SSD1306.h>
#include <Arduino.h>
#include <Preferences.h>
#include <Wire.h>
#include <driver/gpio.h>
#include <esp_system.h>

namespace {
constexpr int encoderClk = 1, encoderDt = 2, encoderSw = 4;
constexpr int oledSda = 5, oledScl = 6, pixelPin = 44;
constexpr char firmwareVersion[] = "esp32s3-0.4.0";
static_assert(LOA_PIXEL_BRIGHTNESS > 0 && LOA_PIXEL_BRIGHTNESS <= 64, "Keep the desk pixel dim");
static_assert(LOA_ENCODER_DIRECTION == 1 || LOA_ENCODER_DIRECTION == -1, "Direction must be +/-1");

Adafruit_SSD1306 display(128, 64, &Wire, -1);
Adafruit_NeoPixel pixel(1, pixelPin, NEO_GRB + NEO_KHZ800);
Preferences preferences;
loa::State state;
loa::Button button;
loa::Encoder encoder;
portMUX_TYPE encoderLock = portMUX_INITIALIZER_UNLOCKED;
volatile int encoderSteps = 0;
bool oledReady = false, storageReady = false, radioReady = false, bonded = false, busy = false;
uint8_t oledAddress = 0;
uint32_t lastActivity = 0, lastFrame = 0, lastCheck = 0, retryAt = 0;
uint32_t effectStarted = 0;
bool quietOperation = false, sendAfterCheck = false;
loa_status queuedSelection = LOA_STATUS_OFF;
unsigned retries = 0;
int turns = 0, clicks = 0, holds = 0;
enum class Screen { Home, Menu, Test, Forget, PairHelp };
Screen screen = Screen::Home;
int menuItem = 0, testColor = 0;
bool confirmForget = false;
const char *notice = "Hi, stream buddy!";
uint32_t noticeAt = 0;
const char *const menuItems[] = {"Back to my sign", "Check my sign", "Connect a sign", "Light test",
                                 "Forget this sign"};
const char *const testNames[] = {"OFF", "RED", "GREEN", "BLUE", "WHITE", "YELLOW"};
constexpr loa_rgb testColors[] = {{0, 0, 0},   {255, 0, 0},     {0, 255, 0},
                                  {0, 0, 255}, {255, 255, 255}, {255, 255, 0}};

void IRAM_ATTR onEncoder() {
    const uint8_t pins = (gpio_get_level(static_cast<gpio_num_t>(encoderClk)) << 1) |
                         gpio_get_level(static_cast<gpio_num_t>(encoderDt));
    portENTER_CRITICAL_ISR(&encoderLock);
    encoderSteps += encoder.update(pins) * LOA_ENCODER_DIRECTION;
    portEXIT_CRITICAL_ISR(&encoderLock);
}

void say(const char *text) {
    notice = text;
    noticeAt = millis();
    Serial.printf("NOTICE %s\n", text);
}

void saveState() {
    uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];
    if (loa_protocol_encode(payload, &state.confirmed) == 0 &&
        (!storageReady ||
         preferences.putBytes("state", payload, sizeof(payload)) != sizeof(payload)))
        say("State save failed");
}

bool start(LinkOperation operation, uint8_t pixelIndex = 255, loa_rgb pixelColor = {0, 0, 0},
           bool quietly = false) {
    if (!radioReady || busy) {
        say(busy ? "One sec, please!" : "Radio needs a restart");
        return false;
    }
    if (operation == LinkOperation::Pair && bonded) {
        say("Already connected!");
        return false;
    }
    if ((operation == LinkOperation::Send || operation == LinkOperation::Sync ||
         operation == LinkOperation::Pixel) &&
        !bonded) {
        say("Connect a sign first");
        return false;
    }
    uint32_t transaction = esp_random();
    if (transaction == 0)
        transaction = 1;
    LinkRequest request{operation, {transaction, state.selected}, pixelIndex, pixelColor};
    if (!linkStart(request))
        return false;
    busy = true;
    quietOperation = quietly;
    retryAt = 0;
    if (!quietly)
        say(operation == LinkOperation::Pixel  ? "Testing a light"
            : operation == LinkOperation::Send ? "Telling your sign..."
            : operation == LinkOperation::Pair ? "Looking for a friend"
                                               : "Checking your sign");
    Serial.printf("REQUEST op=%u tx=%08lx status=%s\n", unsigned(operation),
                  static_cast<unsigned long>(transaction), loa_status_name(state.selected));
    return true;
}

void report() {
    Serial.printf("STATUS firmware=%s uptime=%lu oled=%s address=0x%02x size=128x64 "
                  "bonded=%u busy=%u known=%u verified=%u confirmed=%s selected=%s "
                  "screen=%u color=%s turns=%d clicks=%d holds=%d heap=%u\n",
                  firmwareVersion, static_cast<unsigned long>(millis()),
                  oledReady ? "ok" : "missing", oledAddress, bonded, busy, state.known,
                  state.verified, loa_status_name(state.confirmed.status),
                  loa_status_name(state.selected), unsigned(screen), testNames[testColor], turns,
                  clicks, holds, ESP.getFreeHeap());
}

void enterTest() {
    if (busy) {
        say("Wait for receiver");
        return;
    }
    screen = Screen::Test;
    testColor = 1;
    lastActivity = millis();
    Serial.println("TEST RED; rotate or click for colors; hold to exit; no receiver command sent");
}

void click() {
    switch (screen) {
    case Screen::PairHelp:
        retries = 0;
        if (start(LinkOperation::Pair))
            screen = Screen::Home;
        break;
    case Screen::Test:
        testColor = (testColor + 1) % 6;
        Serial.printf("TEST %s\n", testNames[testColor]);
        break;
    case Screen::Forget:
        if (confirmForget && start(LinkOperation::Forget))
            screen = Screen::Home;
        else if (!confirmForget)
            screen = Screen::Menu;
        break;
    case Screen::Menu:
        switch (menuItem) {
        case 0:
            screen = Screen::Home;
            break;
        case 1:
            retries = 0;
            if (start(LinkOperation::Sync))
                screen = Screen::Home;
            break;
        case 2:
            retries = 0;
            if (start(LinkOperation::Pair))
                screen = Screen::Home;
            break;
        case 3:
            enterTest();
            break;
        case 4:
            if (!busy) {
                screen = Screen::Forget;
                confirmForget = false;
            }
            break;
        }
        break;
    case Screen::Home:
        if (!bonded) {
            retries = 0;
            start(LinkOperation::Pair);
        } else if (busy && quietOperation) {
            sendAfterCheck = true;
            queuedSelection = state.selected;
            say("You're up next!");
        } else if (!busy && state.verified && state.selected == state.confirmed.status) {
            say("Already set!");
        } else {
            retries = 0;
            start(LinkOperation::Send);
        }
        break;
    }
}

void input() {
    const uint32_t now = millis();
    portENTER_CRITICAL(&encoderLock);
    int steps = encoderSteps;
    encoderSteps = 0;
    portEXIT_CRITICAL(&encoderLock);
    const auto event = button.update(digitalRead(encoderSw) == LOW, now);
    if (steps == 0 && event == loa::ButtonEvent::None)
        return;
    const bool waking = now - lastActivity >= 120000;
    lastActivity = now;
    turns += steps;
    if (event == loa::ButtonEvent::Click)
        ++clicks;
    if (event == loa::ButtonEvent::Hold)
        ++holds;
    Serial.printf("INPUT steps=%d event=%s turns=%d clicks=%d holds=%d\n", steps,
                  event == loa::ButtonEvent::Click  ? "click"
                  : event == loa::ButtonEvent::Hold ? "hold"
                                                    : "turn",
                  turns, clicks, holds);
    if (waking)
        return; // First gesture wakes the display without sending anything.
    while (steps != 0) {
        const int direction = steps > 0 ? 1 : -1;
        steps -= direction;
        switch (screen) {
        case Screen::Home:
            if ((!busy || quietOperation) && !sendAfterCheck)
                state.selected = loa::rotate(state.selected, direction);
            break;
        case Screen::Menu:
            menuItem = (menuItem + direction + 5) % 5;
            break;
        case Screen::Test:
            testColor = (testColor + direction + 6) % 6;
            break;
        case Screen::Forget:
            confirmForget = !confirmForget;
            break;
        case Screen::PairHelp:
            break;
        }
    }
    if (event == loa::ButtonEvent::Hold) {
        screen = screen == Screen::Home ? Screen::Menu : Screen::Home;
        menuItem = 0;
        confirmForget = false;
        say("Hold for menu");
    } else if (event == loa::ButtonEvent::Click)
        click();
    report();
}

void serialInput() {
    static char command[48];
    static size_t used = 0;
    static bool overflow = false;
    while (Serial.available()) {
        const char c = Serial.read();
        if (c == '\r')
            continue;
        if (c != '\n') {
            if (used < sizeof(command) - 1)
                command[used++] = c;
            else
                overflow = true;
            continue;
        }
        command[used] = 0;
        used = 0;
        if (overflow) {
            overflow = false;
            Serial.println("ERROR command too long");
            continue;
        }
        if (!strcmp(command, "status")) {
            report();
            continue;
        }
        if (!strcmp(command, "help")) {
            Serial.println("status | test [off|red|green|blue|white|yellow] | next | exit | menu | "
                           "sync | pair | send off|warn|on-air|okay|request|special | pixel 1..4 "
                           "color | pixel end");
            continue;
        }
        lastActivity = millis();
        if (!strcmp(command, "test") || !strncmp(command, "test ", 5)) {
            enterTest();
            if (screen == Screen::Test && strlen(command) > 5) {
                bool found = false;
                for (int i = 0; i < 6; ++i)
                    if (!strcasecmp(command + 5, testNames[i])) {
                        testColor = i;
                        found = true;
                    }
                if (!found)
                    Serial.println("ERROR unknown test color");
                Serial.printf("TEST %s\n", testNames[testColor]);
            }
        } else if (!strcmp(command, "next") && screen == Screen::Test)
            click();
        else if (!strcmp(command, "exit")) {
            screen = Screen::Home;
            confirmForget = false;
        } else if (!strcmp(command, "menu")) {
            screen = Screen::Menu;
            menuItem = 0;
        } else if (!strcmp(command, "sync")) {
            retries = 0;
            start(LinkOperation::Sync);
        } else if (!strcmp(command, "pair")) {
            retries = 0;
            screen = Screen::Home;
            start(LinkOperation::Pair);
        } else if (!strcmp(command, "pixel end")) {
            start(LinkOperation::Pixel);
        } else if (!strncmp(command, "pixel ", 6)) {
            unsigned index;
            char colorName[12], extra;
            bool found = false;
            if (sscanf(command + 6, "%u %11s %c", &index, colorName, &extra) == 2 && index >= 1 &&
                index <= 4) {
                for (int i = 0; i < 6; ++i) {
                    if (!strcasecmp(colorName, testNames[i])) {
                        found = true;
                        if (start(LinkOperation::Pixel, index - 1, testColors[i]))
                            Serial.printf("PIXEL index=%u color=%s; other pixels off\n", index,
                                          testNames[i]);
                        break;
                    }
                }
            }
            if (!found)
                Serial.println("ERROR pixel expects 1..4 and off|red|green|blue|white|yellow");
        } else if (!strncmp(command, "send ", 5)) {
            bool found = false;
            for (int i = LOA_STATUS_OFF; i < LOA_STATUS_COUNT; ++i) {
                const auto selected = static_cast<loa_status>(i);
                if (strcmp(command + 5, loa_status_name(selected)))
                    continue;
                found = true;
                const auto previous = state.selected;
                state.selected = selected;
                if (start(LinkOperation::Send)) {
                    retries = 0;
                    screen = Screen::Home;
                } else {
                    state.selected = previous;
                }
                break;
            }
            if (!found)
                Serial.println("ERROR send expects off|warn|on-air|okay|request|special");
        } else
            Serial.println("ERROR unknown command; type help");
        report();
    }
}

void receive() {
    if (!radioReady)
        return;
    LinkResult result{};
    if (!linkPoll(result))
        return;
    busy = false;
    const bool quiet = quietOperation;
    quietOperation = false;
    bonded = result.bonded;
    lastCheck = millis();
    Serial.printf("RESULT op=%u success=%u bonded=%u tx=%08lx status=%s detail=%s\n",
                  unsigned(result.request.operation), result.success, bonded,
                  static_cast<unsigned long>(result.state.transaction_id),
                  loa_status_name(result.state.status),
                  result.success ? "confirmed" : result.error);
    if (result.success) {
        retries = 0;
        retryAt = 0;
        if (result.request.operation == LinkOperation::Forget) {
            state = loa::State{};
            const bool removed =
                storageReady && (!preferences.isKey("state") || preferences.remove("state"));
            screen = result.receiverForgotten ? Screen::Home : Screen::PairHelp;
            say(!removed                   ? "Cache clear failed"
                : result.receiverForgotten ? "Ready to connect!"
                                           : "Reset the sign next");
        } else if (result.request.operation == LinkOperation::Pixel) {
            say(result.request.pixelIndex == 255 ? "Front test ended" : "Front pixel applied");
        } else {
            const bool changed = !state.known || state.confirmed.status != result.state.status;
            const bool recordChanged =
                changed || state.confirmed.transaction_id != result.state.transaction_id;
            if (result.request.operation == LinkOperation::Send)
                state.acknowledge(result.request.command, result.state);
            else
                state.snapshot(result.state);
            if (changed)
                effectStarted = millis();
            if (!quiet)
                say(result.request.operation == LinkOperation::Pair ? "Found my friend!"
                                                                    : "All set!");
            // Repeated reads should not keep rewriting the controller's flash.
            if (recordChanged)
                saveState();
        }
    } else {
        state.verified = false;
        say(result.request.operation == LinkOperation::Forget ? "Couldn't clear pair"
                                                              : "Can't reach your sign");
        if (result.request.operation == LinkOperation::Pair && !bonded)
            screen = Screen::PairHelp;
        // Read only after failure. Never replay a stale user command.
        if (bonded && result.request.operation != LinkOperation::Forget && retries < 3) {
            retryAt = millis() + (1000U << retries);
            ++retries;
        }
    }
    report();
    if (sendAfterCheck) {
        sendAfterCheck = false;
        if (result.success && screen == Screen::Home && bonded) {
            retries = 0;
            state.selected = queuedSelection;
            start(LinkOperation::Send);
        } else {
            say("Press to try again");
        }
    }
}

const char *linkText() {
    if (!radioReady)
        return "Restart me, please";
    if (loa::foregroundBusy(busy, quietOperation)) {
        switch (linkPhase()) {
        case LinkPhase::Scanning:
            return "Finding your sign...";
        case LinkPhase::Securing:
            return "Saying hello...";
        case LinkPhase::Sending:
            return "Sharing your mood...";
        case LinkPhase::Waiting:
            return "Waiting for the sign";
        case LinkPhase::Reading:
            return "Checking your sign";
        default:
            return "Reaching your sign";
        }
    }
    if (!bonded)
        return "Let's meet your sign";
    return state.verified ? "Your sign is ready" : "Check the sign's power";
}

void text(int x, int y, const char *value, int size = 1) {
    display.setTextSize(size);
    display.setCursor(x, y);
    display.print(value);
}

void render() {
    const uint32_t now = millis();
    if (now - lastFrame < 80)
        return;
    lastFrame = now;
    if (screen == Screen::Test && now - lastActivity >= 60000)
        screen = Screen::Home;
    if ((screen == Screen::Menu || screen == Screen::Forget) && now - lastActivity >= 30000) {
        screen = Screen::Home;
        confirmForget = false;
    }
    loa_rgb color{};
    if (screen == Screen::Test)
        color = testColors[testColor];
    else if (state.verified)
        color = loa_status_color_at(state.confirmed.status, now - effectStarted, 0);
    else
        color = {12, 12, 12}; // Quiet unknown/offline marker; details stay on the OLED.
    static uint32_t lastColor = UINT32_MAX;
    const uint32_t packed = pixel.Color(color.red, color.green, color.blue);
    if (packed != lastColor) {
        pixel.setPixelColor(0, packed);
        pixel.show();
        lastColor = packed;
    }
    if (!oledReady)
        return;
    static int power = -1;
    const int desiredPower =
        loa::screenPower(now - lastActivity, loa::foregroundBusy(busy, quietOperation));
    if (power != desiredPower) {
        display.ssd1306_command(desiredPower ? SSD1306_DISPLAYON : SSD1306_DISPLAYOFF);
        display.dim(desiredPower < 2);
        power = desiredPower;
    }
    if (!desiredPower)
        return;
    display.clearDisplay();
    display.setTextColor(SSD1306_WHITE);
    display.setTextWrap(false);
    char line[24];
    switch (screen) {
    case Screen::Home:
        loa::drawHome(display,
                      {state.selected, state.confirmed.status, state.known, state.verified, bonded,
                       loa::foregroundBusy(busy, quietOperation), linkText(),
                       now - noticeAt < 3000 ? notice : nullptr},
                      now);
        break;
    case Screen::Menu: {
        text(0, 0, "BUDDY SETTINGS");
        display.drawFastHLine(0, 11, 128, SSD1306_WHITE);
        const int first = menuItem >= 3 ? 2 : 0;
        for (int i = first; i < first + 3 && i < 5; ++i) {
            snprintf(line, sizeof(line), "%c %s", i == menuItem ? '>' : ' ', menuItems[i]);
            text(0, 16 + (i - first) * 12, line);
        }
        text(0, 56, now - noticeAt < 4000 ? notice : "Press:open Hold:back");
        break;
    }
    case Screen::Test:
        display.drawRect(0, 0, 128, 64, SSD1306_WHITE);
        text(4, 3, "LIGHT CHECK");
        text(4, 16, testNames[testColor], 2);
        snprintf(line, sizeof(line), "Turns:%d Clicks:%d", turns, clicks);
        text(4, 36, line);
        text(4, 46, "Turn/press: color");
        text(4, 55, "Hold: exit test");
        break;
    case Screen::Forget:
        text(0, 0, "FORGET THIS SIGN?");
        text(0, 16, "Keep the sign on.");
        text(0, 26, "We'll unlink both.");
        text(0, 42, confirmForget ? "> Forget sign" : "> Keep my sign");
        text(0, 56, "Turn:choose Press:OK");
        break;
    case Screen::PairHelp:
        loa::drawPairHelp(display);
        break;
    }
    display.display();
}
} // namespace

void setup() {
    Serial.setTxBufferSize(2048);
    Serial.begin(115200);
    // Keep complete diagnostic lines, with a short bound if the host stops reading.
    Serial.setTxTimeoutMs(10);
    pinMode(encoderClk, INPUT_PULLUP);
    pinMode(encoderDt, INPUT_PULLUP);
    pinMode(encoderSw, INPUT_PULLUP);
    encoder = loa::Encoder((digitalRead(encoderClk) << 1) | digitalRead(encoderDt));
    attachInterrupt(digitalPinToInterrupt(encoderClk), onEncoder, CHANGE);
    attachInterrupt(digitalPinToInterrupt(encoderDt), onEncoder, CHANGE);
    pixel.begin();
    pixel.setBrightness(LOA_PIXEL_BRIGHTNESS);
    pixel.clear();
    pixel.show();
    Wire.begin(oledSda, oledScl);
    Wire.setTimeOut(25);
    for (uint8_t address : {uint8_t(0x3c), uint8_t(0x3d)}) {
        Wire.beginTransmission(address);
        if (Wire.endTransmission() == 0) {
            oledAddress = address;
            break;
        }
    }
    oledReady = oledAddress && display.begin(SSD1306_SWITCHCAPVCC, oledAddress, false, false);
    if (oledReady) {
        display.clearDisplay();
        display.setTextColor(SSD1306_WHITE);
        text(0, 4, "LITTLE ON AIR");
        text(0, 22, "Hi, stream buddy!");
        display.display();
    }
    storageReady = preferences.begin("loa-desk", false);
    uint8_t payload[LOA_PROTOCOL_PAYLOAD_LEN];
    loa_message cached{};
    if (storageReady && preferences.getBytesLength("state") == sizeof(payload) &&
        preferences.getBytes("state", payload, sizeof(payload)) == sizeof(payload) &&
        loa_protocol_decode(&cached, payload, sizeof(payload)) == 0)
        state.restore(cached);
    radioReady = linkInit();
    bonded = radioReady && linkBonded();
    // Do not resurrect a cached receiver's state after its bond was erased.
    if (!bonded)
        state = loa::State{};
    lastActivity = lastCheck = millis();
    Serial.printf("BOOT %s reset=%d pins sda=5 scl=6 clk=1 dt=2 sw=4 pixel=44\n", firmwareVersion,
                  esp_reset_reason());
    report();
    if (bonded)
        start(LinkOperation::Sync);
    else
        say("Press to meet a sign");
}

void loop() {
    input();
    serialInput();
    receive();
    const uint32_t now = millis();
    if (!busy && bonded && screen == Screen::Home) {
        if (retryAt && static_cast<int32_t>(now - retryAt) >= 0)
            start(LinkOperation::Sync, 255, {0, 0, 0}, true);
        else if (!retryAt && retries == 0 && now - lastCheck >= 60000)
            start(LinkOperation::Sync, 255, {0, 0, 0}, true);
    }
    render();
    delay(2);
}
