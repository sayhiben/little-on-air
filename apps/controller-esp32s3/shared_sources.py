# SPDX-License-Identifier: MIT
Import("env")

env.BuildSources(
    "$BUILD_DIR/loa_shared", "../../src", src_filter=["+<protocol.c>", "+<status.c>", "+<brightness.c>"]
)
