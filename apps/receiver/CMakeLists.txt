# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.20.0)

set(LOA_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../..)
set(DTC_OVERLAY_FILE ${LOA_ROOT}/boards/xiao_ble_nrf52840.overlay)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(little_on_air_receiver)

set(LOA_LED_BRIGHTNESS_PERMILLE 125 CACHE STRING
    "Maximum onboard LED brightness in permille")
set(LOA_PIXEL_BRIGHTNESS_PERMILLE 160 CACHE STRING
    "Maximum external pixel brightness in permille")
set(LOA_LED_RED_CALIBRATION_PERMILLE 1000 CACHE STRING
    "Red-channel calibration in permille")
set(LOA_LED_GREEN_CALIBRATION_PERMILLE 650 CACHE STRING
    "Green-channel calibration in permille")
set(LOA_LED_BLUE_CALIBRATION_PERMILLE 500 CACHE STRING
    "Blue-channel calibration in permille")

target_sources(app PRIVATE
  src/ble_server.c
  src/main.c
  src/pair_reset.c
  src/device_indicator.c
  src/mood_indicator.c
  src/status_output.c
  src/padded_pixels.c
  ${LOA_ROOT}/src/protocol.c
  ${LOA_ROOT}/src/receiver_processor.c
  ${LOA_ROOT}/src/record.c
  ${LOA_ROOT}/src/reset_gesture.c
  ${LOA_ROOT}/src/reset_input.c
  ${LOA_ROOT}/src/status.c
  ${LOA_ROOT}/src/store.c
  ${LOA_ROOT}/src/ws2812_frame.c
)
target_include_directories(app PRIVATE src ${LOA_ROOT}/include)
target_compile_definitions(app PRIVATE
  LOA_LED_BRIGHTNESS_PERMILLE=${LOA_LED_BRIGHTNESS_PERMILLE}
  LOA_PIXEL_BRIGHTNESS_PERMILLE=${LOA_PIXEL_BRIGHTNESS_PERMILLE}
  LOA_LED_RED_CALIBRATION_PERMILLE=${LOA_LED_RED_CALIBRATION_PERMILLE}
  LOA_LED_GREEN_CALIBRATION_PERMILLE=${LOA_LED_GREEN_CALIBRATION_PERMILLE}
  LOA_LED_BLUE_CALIBRATION_PERMILLE=${LOA_LED_BLUE_CALIBRATION_PERMILLE}
)
