# PHP-CPP-SampleExtension
This is sample project for creating php extension with PHP-CPP and cmake


## Building with command line
We need a compiled or installed PHP-CPP-cmake, follow instruction to build [PHP-CPP-cmake](https://github.com/jefrisibarani/PHP-CPP-cmake/blob/master/README_PHP-CPP-Cmake.md).
Download sample project source, 
then from sample project source root dir, run cmake 

## Build on windows
Replace -DPHPCPP_INCLUDE_DIR, -DPHPCPP_LIB_DIR and -DPHP_DEV_DIR values with the location
of compiled PHP-CPP-cmake and php dev 

```
cmake -S . -B build_shared_d ^
   -G "Visual Studio 15 2017" -T host=x64 -A x64 ^
   -DPHPCPP_BUILD_SHARED=TRUE ^
   -DPHPCPP_INCLUDE_DIR="d:/projects/php-cpp/PHP-CPP-compiled/include" ^
   -DPHPCPP_LIB_DIR="d:/projects/php-cpp/PHP-CPP-compiled/lib" ^
   -DPHP_DEV_DIR="d:/dev/cpp_php/ts/php-7.4.30-devel-vc15-x64" ^
   -DPHPCPP_BUILD_DEBUG=TRUE
```  
```
cmake --build build_shared_d --config=Debug
```


## Build on linux
Replace -DPHPCPP_INCLUDE_DIR, -DPHPCPP_LIB_DIR and values with the location
of compiled PHP-CPP-cmake

Build and link with PHP-CPP shared debug library 
```
cmake -S . -B build_shared_d -G "Unix Makefiles" \
   -DPHPCPP_BUILD_SHARED=TRUE \
   -DPHPCPP_INCLUDE_DIR="/home/dev/PHP-CPP-cmake/_output/include" \
   -DPHPCPP_LIB_DIR="/home/dev/PHP-CPP-cmake/_output/lib_shared/debug" \
   -DCMAKE_BUILD_TYPE="Debug" 
```
```
cmake --build build_shared_d
```

Build and link with PHP-CPP static release library 
```
cmake -S . -B build_static_r -G "Unix Makefiles" \
   -DPHPCPP_BUILD_SHARED=FALSE \
   -DPHPCPP_INCLUDE_DIR="/home/dev/PHP-CPP-cmake/_output/include" \
   -DPHPCPP_LIB_DIR="/home/dev/PHP-CPP-cmake/_output/lib_static/release" \
   -DCMAKE_BUILD_TYPE="Release"
```
```
cmake --build build_static_r
```