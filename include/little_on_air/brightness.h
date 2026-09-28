/* SPDX-License-Identifier: MIT */
#pragma once
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define LOA_BRIGHTNESS_UUID             "7f6c0005-6b7e-4c80-9f2a-f9b9d7e2a601"
#define LOA_BRIGHTNESS_PAYLOAD_LEN      7U
#define LOA_BRIGHTNESS_RECORD_LEN       8U
#define LOA_LOCAL_BRIGHTNESS_RECORD_LEN 5U

enum loa_light {
	LOA_LIGHT_FRAME,
	LOA_LIGHT_SIGN_LED,
	LOA_LIGHT_SCREEN,
	LOA_LIGHT_SCREEN_DIM,
	LOA_LIGHT_DESK_LED,
	LOA_LIGHT_COUNT
};

struct loa_brightness {
	uint32_t transaction_id;
	uint8_t frame;
	uint8_t indicator;
};

/* Values shown to users are normalized; native units are permille for the sign,
 * SSD1306 contrast for the screen, and 8-bit NeoPixel brightness for the desk. */
uint8_t loa_brightness_default(enum loa_light light);
uint16_t loa_brightness_native(enum loa_light light, uint8_t percent);
struct loa_brightness loa_brightness_defaults(void);
bool loa_brightness_equal(const struct loa_brightness *a, const struct loa_brightness *b);
int loa_brightness_encode(uint8_t *payload, const struct loa_brightness *value);
int loa_brightness_decode(struct loa_brightness *value, const void *payload, size_t len);
uint8_t loa_brightness_checksum(const void *data, size_t len);
void loa_brightness_record_encode(uint8_t *record, const struct loa_brightness *value);
bool loa_brightness_record_decode(struct loa_brightness *value, const void *record, size_t len);

typedef int (*loa_brightness_step_fn)(const struct loa_brightness *value, void *context);
/* The readable state advances only after durable storage AND output application. */
int loa_brightness_process(struct loa_brightness *current, const void *payload, size_t len,
			   loa_brightness_step_fn persist, loa_brightness_step_fn apply,
			   void *context);

#ifdef __cplusplus
}
#endif
