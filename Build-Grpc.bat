@echo off
setlocal

md C:\grpc-installed\Debug
md C:\grpc-installed\Release

:: Set the installation directory
set DEBUG_INSTALL_DIR=C:\grpc-installed\Debug
set RELEASE_INSTALL_DIR=C:\grpc-installed\Release

::echo Cloning gRPC repository...
::git clone --recurse-submodules -b v1.64.0 --depth 1 --shallow-submodules https://github.com/grpc/grpc
::if %errorlevel% neq 0 (
::    echo "Git clone failed"
::    exit /b %errorlevel%
::)

cd C:\grpc

:: Create build directory
echo Creating build directory...
md .build\Debug
if %errorlevel% neq 0 (
    echo "Failed to create build directory"
    exit /b %errorlevel%
)

cd .build/Debug

:: Configure the project with CMake
echo Configuring the project with CMake...
cmake ../.. -G "Visual Studio 17 2022" -DgRPC_INSTALL=ON -DgRPC_ABSL_PROVIDER=module -DgRPC_CARES_PROVIDER=module -DgRPC_PROTOBUF_PROVIDER=module -DgRPC_RE2_PROVIDER=module -DgRPC_SSL_PROVIDER=module -DgRPC_ZLIB_PROVIDER=module -DCMAKE_INSTALL_PREFIX=%DEBUG_INSTALL_DIR%
if %errorlevel% neq 0 (
    echo "CMake configuration failed"
    exit /b %errorlevel%
)

:: Build and install the project
echo Building and installing the project...
cmake --build . --config Debug --target install
if %errorlevel% neq 0 (
    echo "Build and installation failed"
    exit /b %errorlevel%
)

cd C:\grpc

:: Create build directory
echo Creating build directory...
md .build\Release
if %errorlevel% neq 0 (
    echo "Failed to create build directory"
    exit /b %errorlevel%
)

cd .build/Release

:: Configure the project with CMake
echo Configuring the project with CMake...
cmake ../.. -G "Visual Studio 17 2022" -DgRPC_INSTALL=ON -DgRPC_ABSL_PROVIDER=module -DgRPC_CARES_PROVIDER=module -DgRPC_PROTOBUF_PROVIDER=module -DgRPC_RE2_PROVIDER=module -DgRPC_SSL_PROVIDER=module -DgRPC_ZLIB_PROVIDER=module -DCMAKE_INSTALL_PREFIX=%RELEASE_INSTALL_DIR%
if %errorlevel% neq 0 (
    echo "CMake configuration failed"
    exit /b %errorlevel%
)

:: Build and install the project
echo Building and installing the project...
cmake --build . --config Release --target install
if %errorlevel% neq 0 (
    echo "Build and installation failed"
    exit /b %errorlevel%
)

echo "Build and installation completed successfully"

endlocal
pause
