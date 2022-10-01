@echo off

REM
REM Build extension with PHP-CPP static/shared, Release/Debug build 
REM
REM Adapt the paths PHPCPP_INCLUDE_DIR, PHPCPP_LIB_DIR and PHP_DEV_DIR
REM Run this script from project root dir
REM
REM Author: jefrisibarani@gmail.com
REM


SET PHPCPP_INCLUDE_DIR="d:/projects/php-cpp/PHP-CPP-compiled/include"
SET PHPCPP_LIB_DIR="d:/projects/php-cpp/PHP-CPP-compiled/lib"
SET PHP_DEV_DIR="d:/dev/cpp_php/ts/php-7.4.30-devel-vc15-x64"


echo --------------------------------------------------------
echo -- Building with PHP-CPP shared library - Debug
echo --------------------------------------------------------

cmake -S . -B build_shared_d ^
-G "Visual Studio 15 2017" -T host=x64 -A x64 ^
-DPHPCPP_BUILD_SHARED=TRUE ^
-DPHPCPP_INCLUDE_DIR=%PHPCPP_INCLUDE_DIR% ^
-DPHPCPP_LIB_DIR=%PHPCPP_LIB_DIR% ^
-DPHP_DEV_DIR=%PHP_DEV_DIR% ^
-DPHPCPP_BUILD_DEBUG=TRUE

timeout 3 > NUL
cmake --build build_shared_d --config=Debug





timeout 3 > NUL
echo --------------------------------------------------------
echo -- Building with PHP-CPP shared library - Release
echo --------------------------------------------------------

cmake -S . -B build_shared_r ^
-G "Visual Studio 15 2017" -T host=x64 -A x64 ^
-DPHPCPP_BUILD_SHARED=TRUE ^
-DPHPCPP_INCLUDE_DIR=%PHPCPP_INCLUDE_DIR% ^
-DPHPCPP_LIB_DIR=%PHPCPP_LIB_DIR% ^
-DPHP_DEV_DIR=%PHP_DEV_DIR% ^
-DPHPCPP_BUILD_DEBUG=FALSE

timeout 3 > NUL
cmake --build build_shared_r --config=Release




timeout 3 > NUL
echo --------------------------------------------------------
echo -- Building with PHP-CPP static library - Debug
echo --------------------------------------------------------

cmake -S . -B build_static_d ^
-G "Visual Studio 15 2017" -T host=x64 -A x64 ^
-DPHPCPP_BUILD_SHARED=FALSE ^
-DPHPCPP_INCLUDE_DIR=%PHPCPP_INCLUDE_DIR% ^
-DPHPCPP_LIB_DIR=%PHPCPP_LIB_DIR% ^
-DPHP_DEV_DIR=%PHP_DEV_DIR% ^
-DPHPCPP_BUILD_DEBUG=TRUE

timeout 3 > NUL
cmake --build build_static_d --config=Debug




timeout 3 > NUL
echo --------------------------------------------------------
echo -- Building with PHP-CPP static library - Release 
echo --------------------------------------------------------

cmake -S . -B build_static_r ^
-G "Visual Studio 15 2017" -T host=x64 -A x64 ^
-DPHPCPP_BUILD_SHARED=FALSE ^
-DPHPCPP_INCLUDE_DIR=%PHPCPP_INCLUDE_DIR% ^
-DPHPCPP_LIB_DIR=%PHPCPP_LIB_DIR% ^
-DPHP_DEV_DIR=%PHP_DEV_DIR% ^
-DPHPCPP_BUILD_DEBUG=FALSE

timeout 3 > NUL
cmake --build build_static_r --config=Release