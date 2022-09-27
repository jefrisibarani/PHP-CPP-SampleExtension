cmake_minimum_required(VERSION 3.11-3.18)

# Extension name
set(MY_EXTENSION_NAME       "functionwithparameters")


# -----------------------------------------------------------------------------
# PHPCPP build we want to use, shared(dll) or static library
# -----------------------------------------------------------------------------
set(PHPCPP_BUILD_SHARED     1)

if(WIN32)
   # -----------------------------------------------------------------------------
   # Windows build options
   # -----------------------------------------------------------------------------
   # PHP-CPP build mode, Release or Debug
   set(PHPCPP_BUILD_DEBUG   0)
   # PHP devel pack, download from https://windows.php.net/download/
   set(PHP_DEV_PATH         "d:/dev/cpp_php/ts/php-7.4.30-devel-vc15-x64")
   # Path to PHPCPP include dir
   set(PHPCPP_INC_PATH      "d:/projects/php-cpp/PHP-CPP-cmake/_output/include")
   # Path to PHPCPP library dir
   set(PHPCPP_LIB_PATH      "d:/projects/php-cpp/PHP-CPP-cmake/_output/lib")
   # PHP library file name
   set(PHP_LIBNAME          "php7ts.lib")

   set(LIBFOLDER "release")
   if(PHPCPP_BUILD_DEBUG)
      set(LIBFOLDER "debug")
   endif()

   if(PHPCPP_BUILD_SHARED)
      set(PHPCPP_LIB_PATH   "${PHPCPP_LIB_PATH}_shared/${LIBFOLDER}")
   else()
      set(PHPCPP_LIB_PATH   "${PHPCPP_LIB_PATH}_static/${LIBFOLDER}")
   endif()

else()
   # -----------------------------------------------------------------------------
   # Non windows build options
   # -----------------------------------------------------------------------------
   # Path to PHPCPP include dir
   set(PHPCPP_INC_PATH      "/usr/local/include")
   # Path to PHPCPP library
   set(PHPCPP_LIB_PATH      "/usr/local/lib64")
endif()


# -----------------------------------------------------------------------------
# Example project
# -----------------------------------------------------------------------------
project(${MY_EXTENSION_NAME})

add_library(${PROJECT_NAME} MODULE )

target_sources(${PROJECT_NAME} PRIVATE ${MY_EXTENSION_NAME}.cpp)

target_include_directories(${PROJECT_NAME}
   PUBLIC ${PROJECT_SOURCE_DIR}
   PUBLIC ${PHPCPP_INC_PATH} )

if(WIN32)
   if (PHPCPP_BUILD_SHARED)
      target_compile_definitions(${PROJECT_NAME} PRIVATE USING_PHPCPP_DLL )
   endif()

   target_link_libraries(${PROJECT_NAME}
      "${PHPCPP_LIB_PATH}/phpcpp-common.lib"
      "${PHPCPP_LIB_PATH}/phpcpp.lib"
      "${PHP_DEV_PATH}/lib/${PHP_LIBNAME}" )

else()

   target_link_options(${PROJECT_NAME} PRIVATE -shared)
   target_compile_options(${PROJECT_NAME} PRIVATE -c -Wall )
   target_link_directories(${PROJECT_NAME} PRIVATE ${PHPCPP_LIB_PATH})
   target_link_libraries(${PROJECT_NAME} PRIVATE phpcpp phpcpp-common)

endif()

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)


# -----------------------------------------------------------------------------
# Output folder
# -----------------------------------------------------------------------------
if (PHPCPP_BUILD_SHARED)
  set (OUTPUT_LIBDIR "_output/shared")
else()
  set (OUTPUT_LIBDIR "_output/static")
endif()

# Copy extension to _output dir
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E make_directory
      ${CMAKE_CURRENT_SOURCE_DIR}/${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release>
   COMMAND ${CMAKE_COMMAND} -E copy
      $<TARGET_FILE:${PROJECT_NAME}> ${CMAKE_CURRENT_SOURCE_DIR}/${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release> )

# Copy php sample to _output dir
add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/${MY_EXTENSION_NAME}.php ${CMAKE_CURRENT_SOURCE_DIR}/${OUTPUT_LIBDIR}/$<$<CONFIG:Debug>:debug>$<$<CONFIG:Release>:release> )
