cmake_minimum_required(VERSION 2.6)

project(enetshim)

include_directories(${PROJECT_SOURCE_DIR}/include)

add_library(enetshim STATIC arpa_inet_shim.c)
