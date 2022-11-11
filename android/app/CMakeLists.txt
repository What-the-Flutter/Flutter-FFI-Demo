cmake_minimum_required(VERSION 3.4.1)  # for example

add_library( example_lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        calc_example/example.cpp)

add_library( struct_example_lib

        # Sets the library as a shared library.
        SHARED

        # Provides a relative path to your source file(s).
        struct_example/struct_example.cpp)

find_library( # Defines the name of the path variable that stores the
        # location of the NDK library.
        log

        # Specifies the name of the NDK library that
        # CMake needs to locate.
        log )