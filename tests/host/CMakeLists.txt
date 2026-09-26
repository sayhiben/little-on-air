cmake_minimum_required(VERSION 3.16)
project(loa_desk_tests LANGUAGES C CXX)
enable_testing()
add_executable(controller_tests ../controller/main.cpp
    ../../src/status.c ../../src/protocol.c)
target_include_directories(controller_tests PRIVATE ../../apps/controller-esp32s3/src ../../include)
target_compile_features(controller_tests PRIVATE cxx_std_11)
target_compile_options(controller_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME controller_tests COMMAND controller_tests)

# Exercise the real receiver indicator with a deterministic desktop scheduler.
add_executable(indicator_tests ../indicator/main.c
    ../../apps/receiver/src/mood_indicator.c ../../src/status.c)
target_include_directories(indicator_tests PRIVATE
    ../indicator/host ../../include ../../apps/receiver/src)
target_compile_features(indicator_tests PRIVATE c_std_99)
target_compile_options(indicator_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME indicator_tests COMMAND indicator_tests)

add_executable(pairing_reset_tests ../reset/main.c
    ../../src/reset_input.c ../../src/reset_gesture.c
    ../../apps/receiver/src/pair_reset.c)
target_include_directories(pairing_reset_tests PRIVATE
    ../reset/host ../indicator/host
    ../../include ../../apps/receiver/src)
target_compile_features(pairing_reset_tests PRIVATE c_std_99)
target_compile_options(pairing_reset_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME pairing_reset_tests COMMAND pairing_reset_tests)

add_executable(output_tests ../outputs/main.c
    ../../apps/receiver/src/status_output.c ../../src/status.c)
target_include_directories(output_tests PRIVATE
    ../outputs/host ../indicator/host ../../include ../../apps/receiver/src)
target_compile_features(output_tests PRIVATE c_std_11)
target_compile_options(output_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME output_tests COMMAND output_tests)

add_executable(bond_store_tests ../bond_store/main.cpp ../../apps/controller-esp32s3/src/bond_store.cpp)
target_include_directories(bond_store_tests PRIVATE ../bond_store/host ../../apps/controller-esp32s3/src)
target_compile_features(bond_store_tests PRIVATE cxx_std_11)
target_compile_options(bond_store_tests PRIVATE -Wall -Wextra -Werror -UNDEBUG)
add_test(NAME bond_store_tests COMMAND bond_store_tests)
find_package(Python3 REQUIRED COMPONENTS Interpreter)
add_test(NAME nimble_guard_tests COMMAND ${Python3_EXECUTABLE}
    ${CMAKE_CURRENT_SOURCE_DIR}/../bond_store/test_nimble_guard.py)
