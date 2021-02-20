cmake_minimum_required(VERSION 3.12)

link_directories(${CMAKE_SOURCE_DIR}/sled/)

# Pull in SDK (must be before project)
include(pico_sdk_import.cmake)
project(sled)
pico_sdk_init()

add_executable(sled)

pico_generate_pio_header(sled ${CMAKE_SOURCE_DIR}/src/ws2812.pio OUTPUT_DIR ${CMAKE_SOURCE_DIR}/generated)

target_sources(sled PRIVATE
    src/sled.c
)

target_link_libraries(sled pico_stdlib pico_stdio_usb hardware_pio ${CMAKE_SOURCE_DIR}/sled/libsled.a)

include(target_get_linked_libraries.cmake)
target_get_linked_libraries(sled libraries)

set(include_dirs)
foreach(lib IN LISTS libraries)
	if("${lib}" STREQUAL sled)
        get_target_property(tmp "${lib}" INCLUDE_DIRECTORIES)
    else()
        get_target_property(tmp "${lib}" INTERFACE_INCLUDE_DIRECTORIES)
    endif()
    if(NOT "${tmp}" STREQUAL tmp-NOTFOUND)
        list(APPEND include_dirs "${tmp}")
    endif()
endforeach()

list(TRANSFORM include_dirs PREPEND "-I")
list(JOIN include_dirs " " include_dirs_string)
message(STATUS "found dirs: ${include_dirs_string}")

add_dependencies(sled libsled.a)
add_custom_target(libsled.a CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CPP_COMPILER} CFLAGS=-g\ ${include_dirs_string}\ ${CMAKE_C_FLAGS} CXXFLAGS=${CMAKE_CPP_FLAGS} make -C ${CMAKE_SOURCE_DIR}/sled libsled.a)

# depending on internal target names
# you love to see it
add_dependencies(libsled.a sled_ws2812_pio_h)

pico_add_extra_outputs(sled)