// SPDX-License-Identifier: MIT
#pragma once
#include "controller.hpp"

enum class LinkOperation { Sync, Send, Pair, Forget, Pixel };
enum class LinkPhase { Idle, Scanning, Connecting, Securing, Reading, Sending, Waiting };
struct LinkRequest {
    LinkOperation operation;
    loa_message command;
    uint8_t pixelIndex;
    loa_rgb pixelColor;
};
struct LinkResult {
    LinkRequest request;
    bool success;
    bool bonded;
    loa_message state;
    const char *error;
    bool receiverForgotten;
};

bool linkInit();
bool linkBonded();
bool linkStart(const LinkRequest &request);
bool linkPoll(LinkResult &result);
LinkPhase linkPhase();
