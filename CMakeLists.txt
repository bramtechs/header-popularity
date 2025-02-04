cmake_minimum_required(VERSION 3.10)
project(HeaderPopularity)

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 11)

add_executable(${PROJECT_NAME} main.m)
target_compile_definitions(${PROJECT_NAME} PRIVATE
  -DGNUSTEP -DGNUSTEP_BASE_LIBRARY=1 -DGNU_GUI_LIBRARY=1 -DGNU_RUNTIME=1 -DGNUSTEP_BASE_LIBRARY=1
  -D_NATIVE_OBJC_EXCEPTIONS -DGSWARN -DGSDIAGNOSE
)
target_include_directories(${PROJECT_NAME} PUBLIC
  .
  /usr/local/include/GNUstep
  /usr/include/GNUstep
)
target_compile_options(${PROJECT_NAME} PRIVATE
  -MP  -fno-strict-aliasing -fexceptions -fobjc-exceptions -pthread -fPIC -Wall
  -Wno-import -g -O2 -fconstant-string-class=NSConstantString
  -I/usr/lib/gcc/x86_64-linux-gnu/13/include/
)
target_link_options(${PROJECT_NAME} PRIVATE
  -L/home/bram/GNUstep/Library/Libraries
  -L/usr/lib/gcc/x86_64-linux-gnu/13
  -L/usr/local/lib -L/usr/lib
)
target_link_libraries(${PROJECT_NAME} PRIVATE
  -shared-libgcc -pthread -fexceptions -rdynamic -lgnustep-base -lobjc -lm
)
