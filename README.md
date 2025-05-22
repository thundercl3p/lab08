# Домашнее задание #
## Студента группы ИУ8-22 Kiselyov Artyom ##

Представьте, что вы стажер в компании "Formatter Inc.".

### Задание 1
Вам поручили перейти на систему автоматизированной сборки **CMake**.
Исходные файлы находятся в директории *formatter_lib*.
В этой директории находятся файлы для статической библиотеки *formatter*.
Создайте `CMakeList.txt` в директории *formatter_lib*,
с помощью которого можно будет собирать статическую библиотеку *formatter*.

```
$ git clone https://github.com/tp-labs/lab03/
Cloning into 'lab03'...
remote: Enumerating objects: 91, done.
remote: Counting objects: 100% (30/30), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 91 (delta 23), reused 21 (delta 21), pack-reused 61 (from 1)
Receiving objects: 100% (91/91), 1.02 MiB | 3.37 MiB/s, done.
Resolving deltas: 100% (41/41), done.
$ cd lab03
$ cd formatter_lib
$ cat > CMakeLists.txt << 'EOF'
> cmake_minimum_required(VERSION 3.4)
> project(formatter)
> 
> set(CMAKE_CXX_STANDARD 11)
> set(CMAKE_CXX_STANDARD_REQUIRED ON)
> 
> add_library(formatter STATIC formatter.cpp)
> target_include_directories(formatter PUBLIC include)
> EOF
$ mkdir build
$ cd build
$ cmake ..
CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


-- The C compiler identification is GNU 13.3.0
-- The CXX compiler identification is GNU 13.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.5s)
-- Generating done (0.0s)
-- Build files have been written to: /home/artyom/lab03/formatter_lib/build
$ cmake --build .
[ 50%] Building CXX object CMakeFiles/formatter.dir/formatter.cpp.o
[100%] Linking CXX static library libformatter.a
[100%] Built target formatter
```

### Задание 2
У компании "Formatter Inc." есть перспективная библиотека,
которая является расширением предыдущей библиотеки. Т.к. вы уже овладели
навыком созданием `CMakeList.txt` для статической библиотеки *formatter*, ваш 
руководитель поручает заняться созданием `CMakeList.txt` для библиотеки 
*formatter_ex*, которая в свою очередь использует библиотеку *formatter*.

```
$ cd lab03/formatter_ex_lib
$ cat > CMakeLists.txt << 'EOF'
> сmake_minimum_required(VERSION 3.5)
> project(formatter_ex_lib)
> 
> set(CMAKE_CXX_STANDARD 11)
> set(CMAKE_CXX_STANDARD_REQUIRED ON)
> 
> add_library(formatter_ex STATIC formatter_ex.cpp)
> target_include_directories(formatter_ex PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
> target_link_libraries(formatter_ex PUBLIC formatter)
> EOF
$ cmake -B build
-- The C compiler identification is GNU 13.3.0
-- The CXX compiler identification is GNU 13.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done (0.3s)
-- Generating done (0.0s)
-- Build files have been written to: /home/artyom/lab03/formatter_ex_lib/build
$ cmake --build build
[ 50%] Building CXX object CMakeFiles/formatter_ex.dir/formatter_ex.cpp.o
[100%] Linking CXX static library libformatter_ex.a
[100%] Built target formatter_ex
```

### Задание 3
Конечно же ваша компания предоставляет примеры использования своих библиотек.
Чтобы продемонстрировать как работать с библиотекой *formatter_ex*,
вам необходимо создать два `CMakeList.txt` для двух простых приложений:
* *hello_world*, которое использует библиотеку *formatter_ex*;
* *solver*, приложение которое испольует статические библиотеки *formatter_ex* и *solver_lib*.

```
$ cd ~/lab03
$ cat > CMakeLists.txt << 'EOF'
> cmake_minimum_required(VERSION 3.5)
> project(FormatterProject)
> 
> set(CMAKE_CXX_STANDARD 11)
> 
> add_subdirectory(formatter_lib)
> add_subdirectory(formatter_ex_lib)
> add_subdirectory(solver_lib)
> 
> add_subdirectory(solver_application)
> add_subdirectory(hello_world_application)
> EOF
$ cd solver_lib
$ cat > CMakeLists.txt << 'EOF'
> cmake_minimum_required(VERSION 3.5)
> project(solver_lib)
> 
> add_library(solver_lib STATIC solver.cpp)
> target_include_directories(solver_lib PUBLIC .)
> EOF
$ cd ..
$ cd solver_application
$ cat > CMakeLists.txt << 'EOF'
> cmake_minimum_required(VERSION 3.5)
> project(SolverApplication)
> 
> add_executable(solver equation.cpp)
> target_link_libraries(solver PRIVATE formatter_ex solver_lib)
> target_include_directories(solver PRIVATE 
>     ../formatter_ex_lib
>     ../formatter_lib
>     ../solver_lib
> )
> EOF
$ cd ..
$ cd hello_world_application
$ cat > CMakeLists.txt << 'EOF'
> cmake_minimum_required(VERSION 3.5)
> project(HelloWorldApplication)
> 
> add_executable(hello_world hello_world.cpp)
> target_link_libraries(hello_world PRIVATE formatter_ex)
> target_include_directories(hello_world PRIVATE 
>     ../formatter_ex_lib
>     ../formatter_lib
> )
> EOF
$ cd ..
$ cmake -B build
-- The C compiler identification is GNU 13.3.0
-- The CXX compiler identification is GNU 13.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
CMake Deprecation Warning at formatter_lib/CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.


-- Configuring done (0.3s)
-- Generating done (0.0s)
-- Build files have been written to: /home/artyom/lab03/build
$ cmake --build build
[ 20%] Built target formatter
[ 40%] Built target formatter_ex
[ 50%] Building CXX object solver_lib/CMakeFiles/solver_lib.dir/solver.cpp.o
[ 60%] Linking CXX static library libsolver_lib.a
[ 60%] Built target solver_lib
[ 70%] Building CXX object solver_application/CMakeFiles/solver.dir/equation.cpp.o
[ 80%] Linking CXX executable solver
[ 80%] Built target solver
[ 90%] Building CXX object hello_world_application/CMakeFiles/hello_world.dir/hello_world.cpp.o
[100%] Linking CXX executable hello_world
[100%] Built target hello_world
```
