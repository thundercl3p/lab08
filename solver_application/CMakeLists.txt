cmake_minimum_required(VERSION 3.5)
project(SolverApplication)

add_executable(solver equation.cpp)
target_link_libraries(solver PRIVATE formatter_ex solver_lib)
target_include_directories(solver PRIVATE 
    ../formatter_ex_lib
    ../formatter_lib
    ../solver_lib
)
