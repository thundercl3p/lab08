cmake_minimum_required(VERSION 3.5)
project(FormatterProject)

set(CMAKE_CXX_STANDARD 11)

add_subdirectory(formatter_lib)
add_subdirectory(formatter_ex_lib)
add_subdirectory(solver_lib)

add_subdirectory(solver_application)
add_subdirectory(hello_world_application)
