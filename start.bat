@echo off
echo ====================================================
echo  1. COMPILING JAVA SOURCES
echo ====================================================
powershell -ExecutionPolicy Bypass -File .\compile.ps1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Compilation failed. Server will not start.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ====================================================
echo  2. STARTING TOMCAT SERVER
echo ====================================================
powershell -ExecutionPolicy Bypass -File .\run_tomcat.ps1
