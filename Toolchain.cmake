list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/switch-homebrew-toolchain-cmake")
include(libnx)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D__unix__ -fexceptions")
set(CMAKE_LD "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ld" CACHE STRING "")