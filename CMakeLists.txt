cmake_minimum_required(VERSION 3.0.0)
project(Uninitialized VERSION 0.1.0 LANGUAGES CXX) 

# ------------------------------------ #
#               PACKAGES               #
# ------------------------------------ #

# --------------- Boost -------------- #
set(Boost_USE_STATIC_LIBS ON) 
set(Boost_USE_MULTITHREADED ON)
find_package(Boost REQUIRED COMPONENTS unit_test_framework)

# ------------------------------------ #
#            GLOBAL SETTINGS           #
# ------------------------------------ #

# -------- Compiler strictness ------- #

if(MSVC)
    add_compile_options(/W3 /WX /permissive-)
else()
    add_compile_options(-W -Wall)
endif()

# ----------- C++ standard ----------- #
set(CXX_STANDARD_REQUIRED ON) # standard mandatory
set(CXX_EXTENSIONS OFF) # no gnu c++
set(CXX_STANDARD 11) # min standard

# ------------------------------------ #
#                TARGETS               #
# ------------------------------------ #
aux_source_directory(src SRC_FILES)
aux_source_directory(test TEST_FILES)

# ----------- Uninitialized ---------- #
 
add_library(Uninitialized ${SRC_FILES})
target_include_directories(Uninitialized 
    PUBLIC include/Uninitialized
    PRIVATE src) 

# --------------- Test --------------- #

include(CTest)
if(BUILD_TESTING)
    add_executable(UninitializedTest ${TEST_FILES})
    target_include_directories(UninitializedTest
        PUBLIC include/Uninitialized
        PRIVATE test)
    target_link_libraries(UninitializedTest
        PUBLIC Uninitialized Boost::unit_test_framework)
endif()
