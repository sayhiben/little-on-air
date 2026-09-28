// SPDX-License-Identifier: MIT
#pragma once
#include <cstdio>
#include <little_on_air/brightness.h>

namespace loa {
static const char *const lightNames[] = {"Sign frame", "Sign indicator", "Screen awake",
                                         "Screen dim", "Controller light"};

struct LocalBrightness {
    uint8_t awake = 100, dim = 0, led = 50;
    uint8_t get(loa_light light) const {
        return light == LOA_LIGHT_SCREEN ? awake : light == LOA_LIGHT_SCREEN_DIM ? dim : led;
    }
    void set(loa_light light, uint8_t value) {
        if (light == LOA_LIGHT_SCREEN)
            awake = value;
        else if (light == LOA_LIGHT_SCREEN_DIM)
            dim = value;
        else if (light == LOA_LIGHT_DESK_LED)
            led = value;
    }
    void encode(uint8_t *p) const {
        p[0] = 1;
        p[1] = awake;
        p[2] = dim;
        p[3] = led;
        p[4] = loa_brightness_checksum(p, 4);
    }
    bool restore(const uint8_t *p, size_t len) {
        *this = LocalBrightness{};
        if (!p || len != LOA_LOCAL_BRIGHTNESS_RECORD_LEN || p[0] != 1 || p[1] > 100 || p[2] > 100 ||
            p[3] > 100 || p[4] != loa_brightness_checksum(p, 4))
            return false;
        awake = p[1];
        dim = p[2];
        led = p[3];
        return true;
    }
};

struct BrightnessEditor {
    loa_light light = LOA_LIGHT_FRAME;
    uint8_t value = 50;
    int row = 0;
    bool editing = false, ready = false;
    void open(loa_light target, uint8_t level, bool loaded) {
        light = target;
        value = level;
        row = 0;
        editing = false;
        ready = loaded;
    }
    bool remote() const {
        return light <= LOA_LIGHT_SIGN_LED;
    }
    void turn(int direction) {
        if (!ready)
            return;
        if (editing) {
            int next = int(value) + direction * 5;
            value = next < 0 ? 0 : next > 100 ? 100 : next;
        } else
            row = (row + direction + 4) % 4;
    }
    void reset() {
        value = loa_brightness_default(light);
        row = 1; // Reset is a draft; Save confirms it like any other change.
    }
};

template <class Display>
void drawChoiceMenu(Display &d, const char *title, const char *const *items, int count,
                    int selected, const char *footer) {
    d.setTextSize(1);
    d.setCursor(0, 0);
    d.print(title);
    d.drawFastHLine(0, 11, 128, 1);
    const int first = selected < 2 ? 0 : selected - 2;
    for (int i = first; i < count && i < first + 3; ++i) {
        char line[24];
        snprintf(line, sizeof(line), "%c %s", i == selected ? '>' : ' ', items[i]);
        d.setCursor(0, 16 + (i - first) * 12);
        d.print(line);
    }
    d.setCursor(0, 56);
    d.print(footer);
}

template <class Display>
void drawBrightness(Display &d, const BrightnessEditor &e, bool busy, const char *message) {
    d.setTextSize(1);
    d.setCursor(0, 0);
    d.print(lightNames[e.light]);
    d.drawFastHLine(0, 11, 128, 1);
    if (busy || !e.ready) {
        d.setCursor(0, 24);
        d.print(busy ? "One sec..." : message);
        d.setCursor(0, 56);
        d.print(busy ? "Hold:leave" : "Press:read Hold:exit");
        return;
    }
    char line[24];
    if (e.editing) {
        snprintf(line, sizeof(line), "%u%%", e.value);
        d.setTextSize(2);
        d.setCursor(0, 19);
        d.print(line);
        d.setTextSize(1);
        d.setCursor(0, 43);
        d.print("Turn to adjust");
        d.setCursor(0, 56);
        d.print("Press:done Hold:exit");
        return;
    }
    snprintf(line, sizeof(line), "%c Level: %u%%", e.row == 0 ? '>' : ' ', e.value);
    d.setCursor(0, 15);
    d.print(line);
    const char *actions[] = {"Save", "Reset default", "Cancel"};
    for (int i = 1; i < 4; ++i) {
        snprintf(line, sizeof(line), "%c %s", e.row == i ? '>' : ' ', actions[i - 1]);
        d.setCursor(0, 15 + i * 12);
        d.print(line);
    }
}
} // namespace loa
