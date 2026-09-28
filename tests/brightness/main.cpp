// SPDX-License-Identifier: MIT
#include "brightness_ui.hpp"
#include <cassert>
#include <cstdio>
#include <cstring>

int main() {
    const unsigned low[] = {50, 50, 41, 0, 13}, high[] = {500, 250, 207, 40, 76};
    const unsigned defaults[] = {160, 125, 207, 0, 24};
    for (int i = 0; i < LOA_LIGHT_COUNT; ++i) {
        const auto light = static_cast<loa_light>(i);
        assert(loa_brightness_native(light, 0) == low[i]);
        assert(loa_brightness_native(light, 100) == high[i]);
        assert(loa_brightness_native(light, loa_brightness_default(light)) == defaults[i]);
        for (int p = 1; p <= 100; ++p) {
            auto native = loa_brightness_native(light, p);
            assert(native >= low[i] && native <= high[i]);
            assert(native >= loa_brightness_native(light, p - 1));
        }
        loa::BrightnessEditor editor;
        editor.open(light, 50, false);
        editor.turn(1);
        assert(editor.row == 0 && editor.value == 50);
        editor.ready = true;
        editor.turn(-1);
        assert(editor.row == 3);
        editor.editing = true;
        for (int p = 0; p < 100; ++p)
            editor.turn(1);
        assert(editor.value == 100);
        for (int p = 0; p < 100; ++p)
            editor.turn(-1);
        assert(editor.value == 0);
        editor.reset();
        assert(editor.value == loa_brightness_default(light) && editor.row == 1);
    }
    // Even the brightest idle contrast remains below the lowest awake contrast.
    assert(loa_brightness_native(LOA_LIGHT_SCREEN_DIM, 100) <
           loa_brightness_native(LOA_LIGHT_SCREEN, 0));
    loa::LocalBrightness saved;
    saved.awake = 35;
    saved.dim = 65;
    saved.led = 15;
    uint8_t local[LOA_LOCAL_BRIGHTNESS_RECORD_LEN];
    saved.encode(local);
    loa::LocalBrightness boot;
    assert(boot.restore(local, sizeof(local)));
    assert(boot.awake == 35 && boot.dim == 65 && boot.led == 15);
    // Unsaved previews/reset drafts do not change the persisted values.
    auto preview = boot;
    preview.set(LOA_LIGHT_DESK_LED, 100);
    assert(boot.led == 15);
    for (unsigned i = 0; i < sizeof(local); ++i) {
        local[i] ^= 1;
        assert(!boot.restore(local, sizeof(local)));
        assert(boot.awake == 100 && boot.dim == 0 && boot.led == 50);
        local[i] ^= 1;
    }
    assert(!boot.restore(local, sizeof(local) - 1));
    local[2] = 101;
    local[4] = loa_brightness_checksum(local, 4);
    assert(!boot.restore(local, sizeof(local)));
    loa_brightness value{0x12345678, 0, 100}, decoded{};
    uint8_t packet[LOA_BRIGHTNESS_PAYLOAD_LEN];
    const uint8_t expected[] = {1, 0x78, 0x56, 0x34, 0x12, 0, 100};
    assert(loa_brightness_encode(packet, &value) == 0);
    assert(memcmp(packet, expected, sizeof(packet)) == 0);
    assert(loa_brightness_decode(&decoded, packet, sizeof(packet)) == 0);
    assert(loa_brightness_equal(&value, &decoded));
    decoded.transaction_id++;
    assert(!loa_brightness_equal(&value, &decoded));
    decoded = value;
    decoded.indicator--;
    assert(!loa_brightness_equal(&value, &decoded));
    decoded = value;
    decoded.frame++;
    assert(!loa_brightness_equal(&value, &decoded));
    assert(loa_brightness_decode(&decoded, packet, sizeof(packet) - 1) != 0);
    packet[0] = 2;
    assert(loa_brightness_decode(&decoded, packet, sizeof(packet)) != 0);
    packet[0] = 1;
    packet[5] = 101;
    assert(loa_brightness_decode(&decoded, packet, sizeof(packet)) != 0);
    packet[5] = 0;
    packet[6] = 101;
    assert(loa_brightness_decode(&decoded, packet, sizeof(packet)) != 0);
    uint8_t record[LOA_BRIGHTNESS_RECORD_LEN];
    loa_brightness_record_encode(record, &value);
    assert(loa_brightness_record_decode(&decoded, record, sizeof(record)));
    for (unsigned i = 0; i < sizeof(record); ++i) {
        for (unsigned bit = 0; bit < 8; ++bit) {
            record[i] ^= 1 << bit;
            assert(!loa_brightness_record_decode(&decoded, record, sizeof(record)));
            assert(decoded.frame == 50 && decoded.indicator == 50 && decoded.transaction_id == 0);
            record[i] ^= 1 << bit;
        }
    }
    puts("PASS brightness bounds/defaults, editor limits/reset, local reboot/corruption, exact "
         "ACK/wire/record validation");
}
