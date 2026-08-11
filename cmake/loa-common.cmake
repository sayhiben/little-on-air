# SPDX-License-Identifier: MIT

set(LOA_ROOT ${CMAKE_CURRENT_LIST_DIR}/..)

set(LOA_LED_BRIGHTNESS_PERMILLE 125 CACHE STRING
    "Maximum onboard LED brightness in permille")
set(LOA_LED_RED_CALIBRATION_PERMILLE 1000 CACHE STRING
    "Red-channel calibration in permille")
set(LOA_LED_GREEN_CALIBRATION_PERMILLE 650 CACHE STRING
    "Green-channel calibration in permille")
set(LOA_LED_BLUE_CALIBRATION_PERMILLE 500 CACHE STRING
    "Blue-channel calibration in permille")

target_sources(app PRIVATE
  ${LOA_ROOT}/src/controller_fsm.c
  ${LOA_ROOT}/src/indicator.c
  ${LOA_ROOT}/src/patterns.c
  ${LOA_ROOT}/src/protocol.c
  ${LOA_ROOT}/src/receiver_processor.c
  ${LOA_ROOT}/src/record.c
  ${LOA_ROOT}/src/reset_gesture.c
  ${LOA_ROOT}/src/reset_input.c
  ${LOA_ROOT}/src/status.c
  ${LOA_ROOT}/src/status_output_pwm.c
  ${LOA_ROOT}/src/store.c
)
target_include_directories(app PRIVATE ${LOA_ROOT}/include)
target_compile_definitions(app PRIVATE
  LOA_LED_BRIGHTNESS_PERMILLE=${LOA_LED_BRIGHTNESS_PERMILLE}
  LOA_LED_RED_CALIBRATION_PERMILLE=${LOA_LED_RED_CALIBRATION_PERMILLE}
  LOA_LED_GREEN_CALIBRATION_PERMILLE=${LOA_LED_GREEN_CALIBRATION_PERMILLE}
  LOA_LED_BLUE_CALIBRATION_PERMILLE=${LOA_LED_BLUE_CALIBRATION_PERMILLE}
)
