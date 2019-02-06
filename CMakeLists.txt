cmake_minimum_required(VERSION 2.6)

project(smw-nx)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/supermariowar/cmake")

set(USE_SDL2_LIBS ON CACHE BOOL "override" FORCE)
set(SDL2_FORCE_GLES ON CACHE BOOL "override" FORCE)
set(DISABLE_DEFAULT_CFLAGS ON CACHE BOOL "override" FORCE)
set(NO_NETWORK OFF CACHE BOOL "override" FORCE)
set(HAS_SOCKLEN_T ON CACHE BOOL "override" FORCE)

list(APPEND CMAKE_THREAD_LIBS_INIT "nx")
list(APPEND CMAKE_THREAD_LIBS_INIT "${CMAKE_BINARY_DIR}/enetshim/libenetshim.a")
list(APPEND CMAKE_THREAD_LIBS_INIT "glad")
list(APPEND CMAKE_THREAD_LIBS_INIT "EGL")
list(APPEND CMAKE_THREAD_LIBS_INIT "glapi")
list(APPEND CMAKE_THREAD_LIBS_INIT "drm_nouveau")
list(APPEND CMAKE_THREAD_LIBS_INIT "mpg123")
list(APPEND CMAKE_THREAD_LIBS_INIT "modplug")
list(APPEND CMAKE_THREAD_LIBS_INIT "jpeg")
list(APPEND CMAKE_THREAD_LIBS_INIT "png")
list(APPEND CMAKE_THREAD_LIBS_INIT "vorbisidec")
list(APPEND CMAKE_THREAD_LIBS_INIT "ogg")

include_directories(enetshim)
add_subdirectory(enetshim)
include_directories(supermariowar)
add_subdirectory(supermariowar)