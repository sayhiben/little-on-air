// SPDX-License-Identifier: MIT
#include "../../apps/controller-esp32s3/src/main.cpp"
#include <cassert>

static LinkRequest submitted{};
static LinkResult completion{};
static bool completed = false;
static unsigned requestsStarted;
bool linkInit() {
    return true;
}
bool linkBonded() {
    return false;
}
bool linkStart(const LinkRequest &request) {
    submitted = request;
    ++requestsStarted;
    return true;
}
bool linkPoll(LinkResult &result) {
    if (!completed)
        return false;
    result = completion;
    completed = false;
    return true;
}
LinkPhase linkPhase() {
    return LinkPhase::Reading;
}
static void finish(bool success, loa_brightness brightness,
                   const char *error = "Receiver unavailable") {
    completion = {submitted, success, true, {}, error, false, brightness};
    completed = true;
    receive();
}
static void frame() {
    fakeNow += 100;
    render();
}
static void open(loa_light light) {
    screen = Screen::Brightness;
    brightnessItem = int(light) + 1;
    lastActivity = fakeNow;
    click();
}

int main() {
    setup();
    assert(storageReady && radioReady && !bonded && !busy);
    // Local settings work without a sign and preview without NVS writes.
    open(LOA_LIGHT_DESK_LED);
    assert(screen == Screen::LightEdit && brightnessEditor.ready);
    click();
    encoderSteps = 10;
    input();
    frame();
    assert(brightnessEditor.value == 100 && pixel.brightness == 76);
    assert(preferences.writes == 0 && requestsStarted == 0);
    click(); // Finish editing, focus Save.
    click();
    assert(localBrightness.led == 100 && preferences.writes == 1);
    open(LOA_LIGHT_DESK_LED);
    brightnessEditor.row = 2;
    click(); // Reset is a draft until Save.
    frame();
    assert(brightnessEditor.value == 50 && pixel.brightness == 24);
    assert(localBrightness.led == 100 && preferences.writes == 1);
    brightnessEditor.row = 3;
    click();
    frame();
    assert(pixel.brightness == 76 && localBrightness.led == 100);
    open(LOA_LIGHT_DESK_LED);
    brightnessEditor.row = 2;
    click();
    preferences.fail = true;
    click();
    frame();
    assert(screen == Screen::Brightness && !strcmp(notice, "Light save failed"));
    assert(localBrightness.led == 100 && pixel.brightness == 76);
    preferences.fail = false;
    open(LOA_LIGHT_SCREEN_DIM);
    brightnessEditor.value = 100;
    frame();
    assert(display.commands.back() == 40);
    fakeNow += 30001;
    frame();
    assert(screen == Screen::Home && localBrightness.dim == 0 && display.commands.back() == 0);
    // Boot reloads the saved local settings, independent of bonds/cache.
    localBrightness = {};
    setup();
    assert(localBrightness.led == 100 && localBrightness.dim == 0);
    frame();
    assert(pixel.brightness == 76);
    // Receiver settings always come from a fresh read, never the local defaults.
    bonded = true;
    retries = 1;
    retryAt = fakeNow + 4000;
    const auto existingRetry = retryAt;
    open(LOA_LIGHT_FRAME);
    assert(busy && !brightnessEditor.ready && submitted.operation == LinkOperation::ReadBrightness);
    assert(retryAt == existingRetry);
    click();
    assert(submitted.operation == LinkOperation::ReadBrightness);
    finish(true, {42, 20, 85});
    assert(brightnessEditor.ready && brightnessEditor.value == 20);
    click();
    brightnessEditor.turn(1);
    click();
    click();
    assert(submitted.operation == LinkOperation::SetBrightness);
    assert(submitted.brightness.frame == 25 && submitted.brightness.indicator == 85);
    assert(submitted.brightness.transaction_id != 42);
    finish(false, {});
    assert(!brightnessEditor.ready && !strcmp(brightnessError, "Save not confirmed"));
    click(); // Recovery only reads; it never replays the failed save.
    assert(submitted.operation == LinkOperation::ReadBrightness);
    finish(true, {43, 25, 85});
    brightnessEditor.row = 2;
    click();
    click();
    assert(submitted.brightness.frame == 50 && submitted.brightness.indicator == 85);
    finish(true, submitted.brightness);
    assert(screen == Screen::Brightness && !strcmp(notice, "Brightness saved"));
    // Leaving during a read does not reopen the editor when the result arrives.
    open(LOA_LIGHT_SIGN_LED);
    screen = Screen::Home;
    finish(true, {44, 50, 85});
    assert(screen == Screen::Home);
    // The first gesture after sleep only wakes, including menu selection.
    lastActivity = fakeNow - 120001;
    const auto selection = state.selected;
    encoderSteps = 1;
    input();
    assert(state.selected == selection && screen == Screen::Home);
    // Quiet reconciliation cannot brighten/wake the display or rewrite settings.
    fakeNow += 120001;
    const auto writes = preferences.writes;
    start(LinkOperation::Sync, 255, {0, 0, 0}, true);
    frame();
    assert(std::find(display.commands.begin(), display.commands.end(), SSD1306_DISPLAYOFF) !=
           display.commands.end());
    finish(true, {});
    frame();
    assert(fakeNow - lastActivity >= 120000 &&
           preferences.writes == writes + 1); // Only first mood cache.
    puts("PASS actual menu edit/preview/save/reset/cancel/timeout/reboot, offline reload, exact "
         "request, wake and quiet reconciliation");
}
