#!/usr/bin/env bash
# Build ssp_remesh on Windows with MSVC + vcpkg
#
# CMakeLists.txt change required for MSVC:
#   Added the following block after target_link_libraries(...):
#
#     if(MSVC)
#       target_compile_definitions(${PROJECT_NAME}_bin PRIVATE _USE_MATH_DEFINES)
#     endif()
#
#   Reason: MSVC does not define M_PI by default (it is a POSIX extension).
#   Without _USE_MATH_DEFINES, the build fails with C2065: 'M_PI': undeclared identifier.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$SCRIPT_DIR/build"
VCPKG_TOOLCHAIN="C:/Users/alirz/Projects/vcpkg/scripts/buildsystems/vcpkg.cmake"
VCVARSALL="C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvarsall.bat"

mkdir -p "$BUILD_DIR"

cmd.exe /c "\"$VCVARSALL\" x64 && \
    cmake -G \"Ninja\" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_TOOLCHAIN_FILE=\"$VCPKG_TOOLCHAIN\" \
          -S \"$SCRIPT_DIR\" \
          -B \"$BUILD_DIR\" && \
    cmake --build \"$BUILD_DIR\" --config Release -j8"
