cmake_minimum_required(VERSION 3.5)
project(formatter_ex_lib)

add_library(formatter_ex STATIC formatter_ex.cpp)
target_include_directories(formatter_ex PUBLIC . ../formatter_lib)
target_link_libraries(formatter_ex PRIVATE formatter)
