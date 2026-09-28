// SPDX-License-Identifier: MIT
#include "brightness_ui.hpp"
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

void saveFrame(CheckedCanvas &canvas, const std::string &path) {
    std::ofstream file(path, std::ios::binary);
    file << "P5\n128 64\n255\n";
    for (int y = 0; y < 64; ++y)
        for (int x = 0; x < 128; ++x)
            file.put(canvas.getPixel(x, y) ? '\xff' : '\0');
    assert(file.good());
}

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
        saveFrame(canvas, output + "/" + page.name + ".pgm");
    }
    // Previewing is drawn independently of confirmation; drawing never mutates state.
    // Verify every label/description in the same constrained display coordinates.
    const char *const settings[] = {"Back to my sign", "Check my sign", "Connect a sign",
                                    "Brightness",      "Light test",    "Forget this sign"};
    const char *const lights[] = {"Back to settings", "Sign frame", "Sign indicator",
                                  "Screen awake",     "Screen dim", "Controller light"};
    for (int item = 0; item < 6; ++item) {
        CheckedCanvas settingsCanvas, lightCanvas;
        loa::drawChoiceMenu(settingsCanvas, "BUDDY SETTINGS", settings, 6, item,
                            "Press:open Hold:back");
        loa::drawChoiceMenu(lightCanvas, "BRIGHTNESS", lights, 6, item, "Press:open Hold:back");
        if (item == 3)
            saveFrame(settingsCanvas, output + "/settings-brightness.pgm");
        if (item == 5)
            saveFrame(lightCanvas, output + "/brightness-list.pgm");
    }
    for (int light = 0; light < LOA_LIGHT_COUNT; ++light) {
        loa::BrightnessEditor editor;
        editor.open(static_cast<loa_light>(light), 100, true);
        for (int level : {0, 50, 100}) {
            editor.value = level;
            for (int row = 0; row < 4; ++row) {
                editor.row = row;
                for (bool editing : {false, true}) {
                    editor.editing = editing;
                    CheckedCanvas canvas;
                    loa::drawBrightness(canvas, editor, false, "");
                }
            }
        }
    }
    struct BrightnessPage {
        const char *name;
        loa_light light;
        int row;
        bool editing, busy, ready;
        const char *message;
    };
    const BrightnessPage brightnessPages[] = {
        {"sign-frame", LOA_LIGHT_FRAME, 0, false, false, true, ""},
        {"controller-light", LOA_LIGHT_DESK_LED, 1, false, false, true, ""},
        {"screen-dim-edit", LOA_LIGHT_SCREEN_DIM, 0, true, false, true, ""},
        {"brightness-saving", LOA_LIGHT_SIGN_LED, 1, false, true, true, ""},
        {"brightness-offline", LOA_LIGHT_FRAME, 0, false, false, false, "Can't read sign"},
        {"brightness-default", LOA_LIGHT_SCREEN, 2, false, false, true, ""},
        {"brightness-save-error", LOA_LIGHT_FRAME, 0, false, false, false, "Save not confirmed"},
        {"brightness-unsupported", LOA_LIGHT_FRAME, 0, false, false, false, "Update sign firmware"},
    };
    for (const auto &page : brightnessPages) {
        loa::BrightnessEditor editor;
        editor.open(page.light, 50, page.ready);
        editor.row = page.row;
        editor.editing = page.editing;
        CheckedCanvas canvas;
        loa::drawBrightness(canvas, editor, page.busy, page.message);
        saveFrame(canvas, output + "/" + page.name + ".pgm");
    }
    std::puts("PASS 23 real-GFX OLED previews plus all brightness labels, levels and actions "
              "within 128 x 64");
}
