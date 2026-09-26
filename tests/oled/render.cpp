// SPDX-License-Identifier: MIT
#include "buddy_ui.hpp"
#include <Adafruit_GFX.h>
#include <cassert>
#include <fstream>
#include <string>

class CheckedCanvas : public GFXcanvas1 {
  public:
    CheckedCanvas() : GFXcanvas1(128, 64) {}
    void print(const char *value) {
        int16_t x, y;
        uint16_t w, h;
        getTextBounds(value, getCursorX(), getCursorY(), &x, &y, &w, &h);
        if (x < 0 || y < 0 || x + w > 128 || y + h > 64) {
            std::fprintf(stderr, "Clipped text: %s at %d,%d size %u,%u\n", value, x, y, w, h);
            std::abort();
        }
        Print::print(value);
    }
};

int main(int argc, char **argv) {
    assert(argc == 2);
    const std::string output = argv[1];
    struct Page {
        const char *name;
        loa::HomeView view;
    };
    const Page pages[] = {
        {"off", {LOA_STATUS_OFF, LOA_STATUS_OFF, true, true, true, false, "", nullptr}},
        {"warn", {LOA_STATUS_WARN, LOA_STATUS_WARN, true, true, true, false, "", nullptr}},
        {"on-air", {LOA_STATUS_ON_AIR, LOA_STATUS_ON_AIR, true, true, true, false, "", nullptr}},
        {"okay", {LOA_STATUS_OKAY, LOA_STATUS_OKAY, true, true, true, false, "", nullptr}},
        {"request", {LOA_STATUS_REQUEST, LOA_STATUS_REQUEST, true, true, true, false, "", nullptr}},
        {"special", {LOA_STATUS_SPECIAL, LOA_STATUS_SPECIAL, true, true, true, false, "", nullptr}},
        {"preview", {LOA_STATUS_SPECIAL, LOA_STATUS_ON_AIR, true, true, true, false, "", nullptr}},
        {"offline", {LOA_STATUS_ON_AIR, LOA_STATUS_ON_AIR, true, false, true, false, "", nullptr}},
        {"first-start", {LOA_STATUS_OFF, LOA_STATUS_OFF, false, false, false, false, "", nullptr}},
        {"sending",
         {LOA_STATUS_REQUEST, LOA_STATUS_ON_AIR, true, true, true, true, "Sharing your mood...",
          nullptr}},
        {"confirmed",
         {LOA_STATUS_ON_AIR, LOA_STATUS_ON_AIR, true, true, true, false, "", "All set!"}},
        {"not-checked", {LOA_STATUS_OFF, LOA_STATUS_OFF, false, false, true, false, "", nullptr}},
        {"pair-help", {}},
    };
    for (const auto &page : pages) {
        CheckedCanvas canvas;
        if (std::string(page.name) == "pair-help")
            loa::drawPairHelp(canvas);
        else
            loa::drawHome(canvas, page.view, 2000);
        std::ofstream file(output + "/" + page.name + ".pgm", std::ios::binary);
        file << "P5\n128 64\n255\n";
        for (int y = 0; y < 64; ++y)
            for (int x = 0; x < 128; ++x)
                file.put(canvas.getPixel(x, y) ? '\xff' : '\0');
        assert(file.good());
    }
    // Previewing is drawn independently of confirmation; drawing never mutates state.
    // Verify every label/description in the same constrained display coordinates.
    std::puts("PASS 13 real-GFX OLED screens, all text within 128 x 64");
}
