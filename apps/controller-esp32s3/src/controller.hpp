// SPDX-License-Identifier: MIT
#pragma once

#include <cstdint>
extern "C" {
#include <little_on_air/protocol.h>
}

namespace loa {

// Decode complete Gray-code cycles. Reversals cancel contact bounce; illegal
// two-bit transitions discard the partial cycle instead of inventing a turn.
class Encoder {
  public:
    explicit Encoder(uint8_t initial = 3) : previous(initial) {}
    int update(uint8_t pins) {
        static constexpr int8_t transitions[16] = {0,  -1, 1, 0, 1, 0, 0,  -1,
                                                   -1, 0,  0, 1, 0, 1, -1, 0};
        const uint8_t changed = previous ^ pins;
        if (changed == 3)
            accumulated = 0;
        else
            accumulated += transitions[(previous << 2) | pins];
        previous = pins;
        if (accumulated >= 4) {
            accumulated = 0;
            return 1;
        }
        if (accumulated <= -4) {
            accumulated = 0;
            return -1;
        }
        return 0;
    }

  private:
    uint8_t previous;
    int8_t accumulated = 0;
};

enum class ButtonEvent { None, Click, Hold };

class Button {
  public:
    // Arm only after a stable release; a button held at boot does nothing.
    ButtonEvent update(bool down, uint32_t now) {
        if (down != raw) {
            raw = down;
            changedAt = now;
        }
        if (now - changedAt < 30)
            return ButtonEvent::None;
        if (!armed) {
            if (!down) {
                armed = true;
                stable = false;
            }
            return ButtonEvent::None;
        }
        if (stable != down) {
            stable = down;
            if (down) {
                pressedAt = now;
                held = false;
            } else if (!held)
                return ButtonEvent::Click;
        }
        if (stable && !held && now - pressedAt >= 1200) {
            held = true;
            return ButtonEvent::Hold;
        }
        return ButtonEvent::None;
    }

  private:
    bool raw = false, stable = false, armed = false, held = false;
    uint32_t changedAt = 0, pressedAt = 0;
};

inline loa_status rotate(loa_status value, int direction) {
    if (!loa_status_is_valid(value))
        return LOA_STATUS_OFF;
    return static_cast<loa_status>(
        (static_cast<int>(value) + (direction > 0 ? 1 : LOA_STATUS_COUNT - 1)) % LOA_STATUS_COUNT);
}

inline bool exactAck(const loa_message &command, const loa_message &response) {
    return loa_status_is_valid(response.status) &&
           command.transaction_id == response.transaction_id && command.status == response.status;
}

struct State {
    loa_message confirmed{0, LOA_STATUS_OFF};
    loa_status selected = LOA_STATUS_OFF;
    bool known = false;
    bool verified = false;

    void restore(const loa_message &cached) {
        if (!loa_status_is_valid(cached.status))
            return;
        confirmed = cached;
        selected = cached.status;
        known = true;
        verified = false; // Flash contains history, not proof the receiver is online.
    }
    bool snapshot(const loa_message &response) {
        if (!loa_status_is_valid(response.status))
            return false;
        const bool follow = !known || selected == confirmed.status;
        confirmed = response;
        known = verified = true;
        if (follow)
            selected = response.status;
        return true;
    }
    bool acknowledge(const loa_message &command, const loa_message &response) {
        if (!exactAck(command, response))
            return false;
        confirmed = response;
        known = verified = true;
        return true;
    }
};

} // namespace loa
