#!/bin/bash

# 
# Build extension with PHP-CPP static/shared, Release/Debug build 
#
# Adapt the paths PHPCPP_INCLUDE_DIR and PHPCPP_LIB_DIR
# Run this script from project root dir
#
# Author: jefrisibarani@gmail.com
# 

PHPCPP_INCLUDE_DIR="/home/dev/PHP-CPP-cmake/_output/include"
PHPCPP_LIB_DIR_SHARED_DEBUG="/home/dev/PHP-CPP-cmake/_output/lib_shared/debug"
PHPCPP_LIB_DIR_SHARED_RELEASE="/home/dev/PHP-CPP-cmake/_output/lib_shared/release"
PHPCPP_LIB_DIR_STATIC_DEBUG="/home/dev/PHP-CPP-cmake/_output/lib_static/debug"
PHPCPP_LIB_DIR_STATIC_RELEASE="/home/dev/PHP-CPP-cmake/_output/lib_static/release"


echo --------------------------------------------------------
echo -- Building with PHP-CPP shared library - Debug 
echo --------------------------------------------------------
cmake -S . -B build_shared_d -G "Unix Makefiles" \
-DPHPCPP_BUILD_SHARED=TRUE \
-DPHPCPP_INCLUDE_DIR=${PHPCPP_INCLUDE_DIR} \
-DPHPCPP_LIB_DIR=${PHPCPP_LIB_DIR_SHARED_DEBUG} \
-DCMAKE_BUILD_TYPE="Debug" 

sleep 3
cmake --build build_shared_d
sleep 3



echo --------------------------------------------------------
echo -- Building with PHP-CPP shared library - Release 
echo --------------------------------------------------------
cmake -S . -B build_shared_r -G "Unix Makefiles" \
-DPHPCPP_BUILD_SHARED=TRUE \
-DPHPCPP_INCLUDE_DIR=${PHPCPP_INCLUDE_DIR} \
-DPHPCPP_LIB_DIR=${PHPCPP_LIB_DIR_SHARED_RELEASE} \
-DCMAKE_BUILD_TYPE="Release"

sleep 3
cmake --build build_shared_r
sleep 3



echo --------------------------------------------------------
echo -- Building with PHP-CPP static library - Debug 
echo --------------------------------------------------------
cmake -S . -B build_static_d -G "Unix Makefiles" \
-DPHPCPP_BUILD_SHARED=FALSE \
-DPHPCPP_INCLUDE_DIR=${PHPCPP_INCLUDE_DIR} \
-DPHPCPP_LIB_DIR=${PHPCPP_LIB_DIR_STATIC_DEBUG} \
-DCMAKE_BUILD_TYPE="Debug"

sleep 3
cmake --build build_static_d
sleep 3



echo --------------------------------------------------------
echo -- Building with PHP-CPP static library - Release 
echo --------------------------------------------------------
cmake -S . -B build_static_r -G "Unix Makefiles" \
-DPHPCPP_BUILD_SHARED=FALSE \
-DPHPCPP_INCLUDE_DIR=${PHPCPP_INCLUDE_DIR} \
-DPHPCPP_LIB_DIR=${PHPCPP_LIB_DIR_STATIC_RELEASE} \
-DCMAKE_BUILD_TYPE="Release"

sleep 3
cmake --build build_static_r