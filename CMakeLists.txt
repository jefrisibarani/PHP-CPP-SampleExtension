cmake_minimum_required(VERSION 3.11-3.18)

# Extension name
set(MY_EXTENSION_NAME       "functionwithparameters")
project(${MY_EXTENSION_NAME})

# Uncomment and set the value, or set directly with cmake

# PHP-CPP static or shared library
#set(PHPCPP_BUILD_SHARED FALSE) 

if(WIN32)

# Options for building on Windows with MSVC
# -----------------------------------------------------------------------------
   # Path to PHP-CPP include dir
   #set(PHPCPP_INCLUDE_DIR   "d:/projects/php-cpp/PHP-CPP-compiled/include")
   
   # Path to PHP-CPP library dir
   #set(PHPCPP_LIB_DIR       "d:/projects/php-cpp/PHP-CPP-compiled/lib")
   
   # PHP-CPP build mode, Release or Debug, set to TRUE, 
   # when linking with Debug build of PHP-CPP library and compiling extension in Debug mode
   #set(PHPCPP_BUILD_DEBUG   FALSE)
   
   # PHP devel pack, download from https://windows.php.net/download/
   #set(PHP_DEV_DIR          "D:/dev/cpp_php/ts/php-7.4.30-devel-vc15-x64")



   # PHP library dir
   set(PHP_LIB_DIR          "${PHP_DEV_DIR}/lib")
   # PHP library file name
   set(PHP_LIB_NAME         "php7ts")

   set(LIBFOLDER "release")
   if(PHPCPP_BUILD_DEBUG)
      set(LIBFOLDER "debug")
   endif()

   if(PHPCPP_BUILD_SHARED)
      set(PHPCPP_LIB_DIR   "${PHPCPP_LIB_DIR}_shared/${LIBFOLDER}")
   else()
      set(PHPCPP_LIB_DIR   "${PHPCPP_LIB_DIR}_static/${LIBFOLDER}")
   endif()
   
   message(STATUS "PHP_LIB_DIR           ${PHP_LIB_DIR}")

else()

# Uncomment and set the value, or set directly with cmake
# Non windows build options
# -----------------------------------------------------------------------------
   # Path to PHPCPP include dir
   #set(PHPCPP_INCLUDE_DIR   "/usr/local/include")
   # Path to PHPCPP library
   #set(PHPCPP_LIB_DIR       "/usr/local/lib64")


   # Try find PHP-CPP library
   if(PHPCPP_BUILD_SHARED)
      find_library(PHPCPP_FOUND libphpcpp.so ${PHPCPP_LIB_DIR} NO_DEFAULT_PATH)
   else()
      find_library(PHPCPP_FOUND libphpcpp.a ${PHPCPP_LIB_DIR} NO_DEFAULT_PATH)
   endif()   
   
   if(NOT PHPCPP_FOUND)
      message(FATAL_ERROR "Failed to find PHP-CPP library")
   endif()
endif()



# The Extension
# -----------------------------------------------------------------------------
add_library(${PROJECT_NAME} MODULE )
target_sources(${PROJECT_NAME} PRIVATE ${MY_EXTENSION_NAME}.cpp)

target_include_directories(${PROJECT_NAME}
   PUBLIC ${PROJECT_SOURCE_DIR}
   PUBLIC ${PHPCPP_INCLUDE_DIR} )

target_link_libraries(${PROJECT_NAME} PRIVATE phpcpp phpcpp-common)
target_link_directories(${PROJECT_NAME} PRIVATE ${PHPCPP_LIB_DIR})

if(WIN32)
   target_link_directories(${PROJECT_NAME} PRIVATE ${PHP_LIB_DIR})

   if(NOT PHPCPP_BUILD_SHARED)
      target_link_libraries(${PROJECT_NAME} PRIVATE ${PHP_LIB_NAME} )
   endif()
endif()

if(WIN32 AND PHPCPP_BUILD_SHARED)
   target_compile_definitions(${PROJECT_NAME} PRIVATE USING_PHPCPP_DLL )
endif()

if(NOT WIN32)
   target_link_options(${PROJECT_NAME} PRIVATE -shared)
   target_compile_options(${PROJECT_NAME} PRIVATE -c -Wall )
endif()

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)


# Copy binaries, resources to _output folder
# -----------------------------------------------------------------------------
set(OUTPUT_LIBDIR "${CMAKE_CURRENT_SOURCE_DIR}/_output/static")
if(PHPCPP_BUILD_SHARED)
  set(OUTPUT_LIBDIR "${CMAKE_CURRENT_SOURCE_DIR}/_output/shared")
endif()

# Copy extension to _output dir
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E make_directory ${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release>
   COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${PROJECT_NAME}> ${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release> )

# Copy php sample to _output dir
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/${MY_EXTENSION_NAME}.php ${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release> )
