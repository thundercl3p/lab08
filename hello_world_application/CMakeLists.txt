cmake_minimum_required(VERSION 3.5)
project(HelloWorldApplication)

add_executable(hello_world hello_world.cpp)
target_link_libraries(hello_world PRIVATE formatter_ex)
target_include_directories(hello_world PRIVATE 
    ../formatter_ex_lib
    ../formatter_lib
)
