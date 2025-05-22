cmake_minimum_required(VERSION 3.5)
project(solver_lib)

add_library(solver_lib STATIC solver.cpp)
target_include_directories(solver_lib PUBLIC .)
