# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.20.0)

set(DTC_OVERLAY_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../../boards/xiao_ble_nrf52840.overlay)

find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(little_on_air_receiver)

include(${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/loa-common.cmake)

target_sources(app PRIVATE
  src/ble_server.c
  src/main.c
  src/pair_reset.c
  src/device_indicator.c
)

target_include_directories(app PRIVATE src)

if(CONFIG_LOA_PIXELS_PADDED_SPI)
  target_sources(app PRIVATE
    src/padded_pixels.c
    ../../src/ws2812_frame.c
  )
endif()
