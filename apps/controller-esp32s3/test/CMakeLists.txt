cmake_minimum_required(VERSION 3.16)
project(loa_desk_tests LANGUAGES C CXX)
enable_testing()
add_executable(controller_tests test_controller/main.cpp
    ../../../src/status.c ../../../src/protocol.c)
target_include_directories(controller_tests PRIVATE ../src ../../../include)
target_compile_features(controller_tests PRIVATE cxx_std_11)
target_compile_options(controller_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME controller_tests COMMAND controller_tests)

# Exercise the real receiver indicator with a deterministic desktop scheduler.
add_executable(indicator_tests ../../../tests/indicator/main.c
    ../../../src/indicator.c ../../../src/status.c ../../../src/patterns.c)
target_include_directories(indicator_tests PRIVATE
    ../../../tests/indicator/host ../../../include)
target_compile_features(indicator_tests PRIVATE c_std_99)
target_compile_options(indicator_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME indicator_tests COMMAND indicator_tests)

add_executable(pairing_reset_tests ../../../tests/reset/main.c
    ../../../src/reset_input.c ../../../src/reset_gesture.c
    ../../receiver/src/pair_reset.c)
target_include_directories(pairing_reset_tests PRIVATE
    ../../../tests/reset/host ../../../tests/indicator/host
    ../../../include ../../receiver/src)
target_compile_features(pairing_reset_tests PRIVATE c_std_99)
target_compile_options(pairing_reset_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME pairing_reset_tests COMMAND pairing_reset_tests)

add_executable(output_tests ../../../tests/outputs/main.c
    ../../../src/status_output_pwm.c ../../../src/status.c)
target_include_directories(output_tests PRIVATE
    ../../../tests/outputs/host ../../../tests/indicator/host ../../../include)
target_compile_definitions(output_tests PRIVATE CONFIG_LOA_RECEIVER_POWER_LED=1)
target_compile_features(output_tests PRIVATE c_std_11)
target_compile_options(output_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME output_tests COMMAND output_tests)

add_executable(bond_store_tests ../../../tests/bond_store/main.cpp ../src/bond_store.cpp)
target_include_directories(bond_store_tests PRIVATE ../../../tests/bond_store/host ../src)
target_compile_features(bond_store_tests PRIVATE cxx_std_11)
target_compile_options(bond_store_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME bond_store_tests COMMAND bond_store_tests)
find_package(Python3 REQUIRED COMPONENTS Interpreter)
add_test(NAME nimble_guard_tests COMMAND ${Python3_EXECUTABLE}
    ${CMAKE_CURRENT_SOURCE_DIR}/../../../tests/bond_store/test_nimble_guard.py)
