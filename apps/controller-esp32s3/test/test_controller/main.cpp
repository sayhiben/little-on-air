// SPDX-License-Identifier: MIT
#include "buddy_ui.hpp"
#include "controller.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>
#include <initializer_list>

using loa::ButtonEvent;

static int feed(loa::Encoder &encoder, std::initializer_list<uint8_t> levels) {
    int steps = 0;
    for (auto pins : levels)
        steps += encoder.update(pins);
    return steps;
}

static void encoderTests() {
    loa::Encoder encoder;
    assert(feed(encoder, {1, 0, 2, 3}) == 1);
    assert(feed(encoder, {2, 0, 1, 3}) == -1);
    assert(feed(encoder, {1, 3, 1, 0, 1, 0, 2, 0, 2, 3}) == 1);
    assert(feed(encoder, {1, 3, 1, 3, 2, 3}) == 0);
    assert(feed(encoder, {0, 3, 0, 3}) == 0);
    assert(feed(encoder, {1, 0, 2, 3, 1, 0, 2, 3}) == 2);
    assert(loa::rotate(LOA_STATUS_OFF, -1) == LOA_STATUS_SPECIAL);
    assert(loa::rotate(LOA_STATUS_SPECIAL, 1) == LOA_STATUS_OFF);
    for (int i = 0; i < LOA_STATUS_COUNT; ++i) {
        const auto state = static_cast<loa_status>(i);
        assert(loa::rotate(loa::rotate(state, 1), -1) == state);
    }
    std::puts("PASS quadrature, reversal, contact bounce, invalid transitions, wraparound");
}

static void buttonTests() {
    loa::Button button;
    assert(button.update(true, 0) == ButtonEvent::None);
    assert(button.update(true, 1500) == ButtonEvent::None); // Boot held: ignored.
    assert(button.update(false, 1600) == ButtonEvent::None);
    assert(button.update(false, 1630) == ButtonEvent::None);
    assert(button.update(true, 1700) == ButtonEvent::None);
    assert(button.update(false, 1705) == ButtonEvent::None);
    assert(button.update(true, 1710) == ButtonEvent::None);
    assert(button.update(true, 1740) == ButtonEvent::None);
    assert(button.update(false, 1800) == ButtonEvent::None);
    assert(button.update(true, 1805) == ButtonEvent::None);
    assert(button.update(false, 1810) == ButtonEvent::None);
    assert(button.update(false, 1840) == ButtonEvent::Click);
    assert(button.update(false, 1900) == ButtonEvent::None);
    assert(button.update(true, 2000) == ButtonEvent::None);
    assert(button.update(true, 2030) == ButtonEvent::None);
    assert(button.update(true, 3229) == ButtonEvent::None);
    assert(button.update(true, 3230) == ButtonEvent::Hold);
    assert(button.update(true, 4000) == ButtonEvent::None);
    assert(button.update(false, 4030) == ButtonEvent::None);
    assert(button.update(false, 4060) == ButtonEvent::None); // No click after hold.
    assert(button.update(true, UINT32_MAX - 100) == ButtonEvent::None);
    assert(button.update(true, UINT32_MAX - 70) == ButtonEvent::None);
    assert(button.update(true, 1129) == ButtonEvent::Hold); // Clock wrap.
    std::puts(
        "PASS button bounce, boot-held suppression, single hold, no release click, clock wrap");
}

static void protocolTests() {
    const loa_message sent{0x12345678, LOA_STATUS_ON_AIR};
    uint8_t bytes[6];
    assert(loa_protocol_encode(bytes, &sent) == 0);
    const uint8_t expected[] = {1, 0x78, 0x56, 0x34, 0x12, 2};
    assert(std::memcmp(bytes, expected, 6) == 0);
    loa_message received{};
    assert(loa_protocol_decode(&received, bytes, 6) == 0);
    assert(loa::exactAck(sent, received));
    ++received.transaction_id;
    assert(!loa::exactAck(sent, received));
    received = sent;
    received.status = LOA_STATUS_WARN;
    assert(!loa::exactAck(sent, received));
    assert(loa_protocol_decode(&received, bytes, 5) != 0);
    bytes[0] = 2;
    assert(loa_protocol_decode(&received, bytes, 6) != 0);
    bytes[0] = 1;
    bytes[5] = LOA_STATUS_COUNT;
    assert(loa_protocol_decode(&received, bytes, 6) != 0);
    std::puts("PASS shared wire format, exact ACK, wrong transaction/status/version/length");
}

static void stateTests() {
    loa::State state;
    assert(!state.known && !state.verified);
    state.restore({5, LOA_STATUS_ON_AIR});
    assert(state.known && !state.verified && state.selected == LOA_STATUS_ON_AIR);
    assert(state.snapshot({6, LOA_STATUS_WARN}));
    assert(state.selected == LOA_STATUS_WARN && state.verified);
    state.selected = LOA_STATUS_OKAY;
    assert(state.snapshot({7, LOA_STATUS_OFF}));
    assert(state.selected == LOA_STATUS_OKAY); // Reconcile cannot overwrite a preview.
    const loa_message request{8, LOA_STATUS_OKAY};
    assert(!state.acknowledge(request, {7, LOA_STATUS_OKAY}));
    assert(state.confirmed.status == LOA_STATUS_OFF);
    assert(!state.acknowledge(request, {8, LOA_STATUS_ON_AIR}));
    assert(state.acknowledge(request, request));
    assert(state.confirmed.status == LOA_STATUS_OKAY);
    assert(!state.snapshot({9, static_cast<loa_status>(LOA_STATUS_COUNT)}));
    assert(state.confirmed.status == LOA_STATUS_OKAY);
    std::puts("PASS cached state is unverified, authoritative reconcile, preview preservation, ACK "
              "gating");
}

static void moodTests() {
    for (int i = 0; i < LOA_STATUS_COUNT; ++i) {
        const auto mood = static_cast<loa_status>(i);
        uint8_t wire[LOA_PROTOCOL_PAYLOAD_LEN];
        loa_message input{0x10203040U + static_cast<unsigned>(i), mood}, output{};
        assert(loa_protocol_encode(wire, &input) == 0 && wire[5] == i);
        assert(loa_protocol_decode(&output, wire, sizeof(wire)) == 0);
        assert(loa::exactAck(input, output));
        assert(std::strlen(loa::moodName(mood)) <= 7);
        assert(std::strlen(loa::moodLine(mood)) <= 14);
    }
    assert(loa_status_color_at(LOA_STATUS_REQUEST, 0, 0).green == 255);
    assert(loa_status_color_at(LOA_STATUS_REQUEST, 599, 3).green == 255);
    assert(loa_status_color_at(LOA_STATUS_REQUEST, 600, 1).green == 0);
    assert(loa_status_color_at(LOA_STATUS_REQUEST, 1199, 2).green == 0);
    assert(loa_status_color_at(LOA_STATUS_REQUEST, 1200, 0).green == 255);
    for (uint32_t t = 0; t < 20000; t += 50) {
        for (uint8_t corner = 0; corner < 4; ++corner) {
            auto a = loa_status_color_at(LOA_STATUS_SPECIAL, t, corner);
            auto b = loa_status_color_at(LOA_STATUS_SPECIAL, t + 20000, corner);
            assert(std::memcmp(&a, &b, sizeof(a)) == 0);
            assert(unsigned(a.red) + a.green + a.blue == 255); // Bounded color-wheel energy.
        }
    }
    const auto warm = loa_status_rgb(LOA_STATUS_WARN);
    assert(warm.red == 255 && warm.green > 0 && warm.green < warm.red / 2 && warm.blue == 0);
    assert(!loa::foregroundBusy(true, true));
    assert(loa::screenPower(130000, loa::foregroundBusy(true, true)) == 0);
    assert(loa::screenPower(40000, loa::foregroundBusy(true, true)) == 1);
    assert(loa::screenPower(130000, loa::foregroundBusy(true, false)) == 2);
    std::puts("PASS six moods, animation boundaries/period, warm amber, quiet background display");
}

int main() {
    encoderTests();
    buttonTests();
    protocolTests();
    stateTests();
    moodTests();
}
