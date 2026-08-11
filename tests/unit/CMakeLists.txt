# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.20.0)

# The tests are pure host code; 64-bit mode avoids a gcc-multilib dependency.
set(M64_MODE ON)
find_package(Zephyr COMPONENTS unittest REQUIRED HINTS $ENV{ZEPHYR_BASE})

project(little_on_air_unit_tests)

target_sources(testbinary PRIVATE
  src/main.c
  ../../src/controller_fsm.c
  ../../src/patterns.c
  ../../src/protocol.c
  ../../src/receiver_processor.c
  ../../src/record.c
  ../../src/reset_gesture.c
  ../../src/status.c
)

target_include_directories(testbinary PRIVATE ../../include)
