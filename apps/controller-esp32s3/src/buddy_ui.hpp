// SPDX-License-Identifier: MIT
#pragma once
#include "controller.hpp"
#include <cstdio>
#include <initializer_list>

namespace loa {

template <typename Canvas> void drawPairHelp(Canvas &d) {
    d.setTextColor(1);
    d.setTextWrap(false);
    d.setTextSize(1);
    const char *lines[] = {"LET'S RECONNECT", "On the sign:", "Tap RESET 5 times",
                           "2 seconds apart", "Press to connect"};
    const int y[] = {0, 17, 29, 39, 56};
    for (int i = 0; i < 5; ++i) {
        d.setCursor(0, y[i]);
        d.print(lines[i]);
    }
    d.drawFastHLine(0, 10, 128, 1);
}

inline const char *moodName(loa_status value) {
    switch (value) {
    case LOA_STATUS_WARN:
        return "WARN";
    case LOA_STATUS_ON_AIR:
        return "ON AIR";
    case LOA_STATUS_OKAY:
        return "OKAY";
    case LOA_STATUS_REQUEST:
        return "REQUEST";
    case LOA_STATUS_SPECIAL:
        return "SPECIAL";
    default:
        return "OFF";
    }
}

inline const char *moodLine(loa_status value) {
    switch (value) {
    case LOA_STATUS_WARN:
        return "One moment...";
    case LOA_STATUS_ON_AIR:
        return "I'm live!";
    case LOA_STATUS_OKAY:
        return "Come say hi!";
    case LOA_STATUS_REQUEST:
        return "A little help?";
    case LOA_STATUS_SPECIAL:
        return "Let's glow!";
    default:
        return "Taking a break";
    }
}

// Keep routine checks visually quiet, including when the OLED is asleep.
inline bool foregroundBusy(bool busy, bool background) {
    return busy && !background;
}
inline int screenPower(uint32_t idleMs, bool foreground) {
    return foreground ? 2 : idleMs >= 120000 ? 0 : idleMs >= 30000 ? 1 : 2;
}

struct HomeView {
    loa_status selected;
    loa_status confirmed;
    bool known, verified, bonded, working;
    const char *activity;
    const char *notice;
};

template <typename Canvas> void uiText(Canvas &d, int x, int y, const char *value, int size = 1) {
    d.setTextSize(size);
    d.setCursor(x, y);
    d.print(value);
}

template <typename Canvas>
void drawBuddy(Canvas &d, loa_status mood, bool offline, bool working, uint32_t now) {
    constexpr int ink = 1;
    d.drawRoundRect(3, 17, 32, 29, 8, ink);
    d.drawLine(19, 12, 19, 16, ink);
    d.fillCircle(19, 12, 1, ink);
    const bool blink = now % 6000U >= 5850U;
    if (mood == LOA_STATUS_OFF && !offline && !working) {
        d.drawLine(9, 29, 14, 29, ink);
        d.drawLine(24, 29, 29, 29, ink);
        uiText(d, 24, 12, "z");
    } else if (offline) {
        d.drawLine(9, 26, 14, 28, ink);
        d.drawLine(24, 28, 29, 26, ink);
        d.drawCircle(12, 32, 1, ink);
        d.drawCircle(26, 32, 1, ink);
    } else if (mood == LOA_STATUS_ON_AIR && !working) {
        d.fillRoundRect(7, 25, 10, 7, 2, ink);
        d.fillRoundRect(21, 25, 10, 7, 2, ink);
        d.drawLine(16, 27, 22, 27, ink);
    } else if (mood == LOA_STATUS_SPECIAL && !working) {
        for (int x : {12, 26}) {
            d.drawLine(x - 3, 28, x + 3, 28, ink);
            d.drawLine(x, 25, x, 31, ink);
        }
    } else if (blink) {
        d.drawLine(9, 29, 14, 29, ink);
        d.drawLine(24, 29, 29, 29, ink);
    } else {
        const int glance = working ? ((now / 350U) % 2U ? 1 : -1) : 0;
        d.fillRoundRect(10 + glance, 25, 4, 8, 1, ink);
        d.fillRoundRect(24 + glance, 25, 4, 8, 1, ink);
    }
    if (offline || mood == LOA_STATUS_WARN) {
        d.drawLine(15, 39, 23, 39, ink);
    } else if (working || mood == LOA_STATUS_REQUEST) {
        d.drawCircle(19, 38, 3, ink);
    } else if (mood == LOA_STATUS_OFF) {
        d.drawLine(17, 38, 21, 38, ink);
    } else {
        d.drawLine(13, 36, 16, 39, ink);
        d.drawLine(16, 39, 22, 39, ink);
        d.drawLine(22, 39, 25, 36, ink);
    }
}

// This exact renderer is also used by the desktop OLED preview.
template <typename Canvas> void drawHome(Canvas &d, const HomeView &view, uint32_t now) {
    d.setTextColor(1);
    d.setTextWrap(false);
    const bool preview = view.known && view.selected != view.confirmed;
    const bool offline = view.bonded && !view.verified;
    uiText(d, 0, 0,
           !view.bonded   ? "MEET YOUR SIGN"
           : offline      ? "SIGN IS OFFLINE"
           : view.working ? "ONE SEC..."
           : preview      ? "PICK A MOOD"
                          : "YOUR SIGN");
    if (view.bonded && view.verified && !view.working) {
        for (int i = 0; i < LOA_STATUS_COUNT; ++i)
            if (i == static_cast<int>(view.selected))
                d.fillCircle(95 + i * 6, 3, 2, 1);
            else
                d.drawPixel(95 + i * 6, 3, 1);
    }
    d.drawFastHLine(0, 10, 128, 1);
    drawBuddy(d, view.selected, offline, view.working, now);
    uiText(d, 42, 17, moodName(view.selected), 2);
    uiText(d, 42, 35,
           !view.bonded ? "Let's connect!"
           : offline    ? "Check power"
                        : moodLine(view.selected));
    char line[24];
    if (view.working) {
        uiText(d, 0, 47, view.activity);
    } else if (preview || offline) {
        std::snprintf(line, sizeof(line), "%s%s", view.verified ? "Sign: " : "Last: ",
                      view.known ? moodName(view.confirmed) : "not checked");
        uiText(d, 0, 47, line);
    } else {
        uiText(d, 0, 47, !view.bonded ? "Keep the sign nearby" : "Turn to pick a mood");
    }
    uiText(d, 0, 56,
           view.working       ? "Hang tight..."
           : view.notice      ? view.notice
           : !view.bonded     ? "Press to connect"
           : preview          ? "Press to set this"
           : now / 6000U % 2U ? "Hold for settings"
                              : "Press:set Hold:menu");
}
} // namespace loa
