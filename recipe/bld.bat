setlocal EnableDelayedExpansion
@echo on

mkdir build
cd build

:: configure
cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DLIBUSB_INCLUDE_DIR:PATH="%LIBRARY_INC%\libusb-1.0" ^
    -DLIBUSB_LIBRARIES:PATH="%LIBRARY_LIB%\libusb-1.0.lib" ^
    -DTHREADS_PTHREADS_INCLUDE_DIR="%LIBRARY_INC%" ^
    -DTHREADS_PTHREADS_WIN32_LIBRARY:FILEPATH="%LIBRARY_LIB%\pthread.lib" ^
    ..
if errorlevel 1 exit 1

:: build
cmake --build . --config Release -- -j%CPU_COUNT%
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
