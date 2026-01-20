@echo off
setlocal enabledelayedexpansion
REM ========================================
REM SENSEI Easy Runner for Windows
REM ========================================

echo.
echo  ____  _____ _   _ ____  _____ ___ 
echo / ___^|^| ____^| \ ^| ^|/ ___^|^| ____^|_ _^|
echo \___ \^|  _^| ^|  \^| ^|\___ \^|  _^|  ^| ^| 
echo  ___) ^| ^|___^| ^|\  ^| ___) ^| ^|___ ^| ^| 
echo ^|____/^|_____^|_^| \_^|____/^|_____^|___^|
echo.
echo Chatbot Testing Made Easy!
echo.

REM Check if Docker is running
docker info > nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not running!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

REM Check for API key in .env file
set "API_KEY_SET=false"
if exist .env (
    for /f "tokens=2 delims==" %%a in ('findstr /i "OPENAI_API_KEY" .env 2^>nul') do (
        if not "%%a"=="" if not "%%a"=="your-openai-api-key-here" set "API_KEY_SET=true"
    )
)

if "%API_KEY_SET%"=="false" (
    echo.
    echo ============================================
    echo  OpenAI API Key Required
    echo ============================================
    echo.
    echo Your API key will be saved to .env for future use.
    echo Get your key at: https://platform.openai.com/api-keys
    echo.
    set /p "API_KEY=Enter your OpenAI API Key: "
    echo OPENAI_API_KEY=!API_KEY!> .env
    echo.
    echo API key saved to .env file.
    echo.
)

echo.
echo Choose an option:
echo   1. Run chatbot test (uses cached build)
echo   2. Check test results (score conversations)
echo   3. Start chatbot only (for manual testing)
echo   4. Rebuild and run (rebuilds all containers)
echo   5. Stop all services
echo   6. Exit
echo.

set /p choice="Enter choice (1-6): "

if "%choice%"=="1" (
    echo.
    echo Starting chatbot and running SENSEI tests...
    docker-compose up sensei
    echo.
    echo Test complete! Results saved to test_cases folder.
) else if "%choice%"=="2" (
    echo.
    echo Checking test results...
    docker-compose --profile check up checker
) else if "%choice%"=="3" (
    echo.
    echo Starting chatbot at http://localhost:5000
    echo Press Ctrl+C to stop.
    docker-compose up chatbot
) else if "%choice%"=="4" (
    echo.
    echo Rebuilding all containers and running tests...
    docker-compose up --build sensei
    echo.
    echo Test complete! Results saved to test_cases folder.
) else if "%choice%"=="5" (
    echo.
    echo Stopping all services...
    docker-compose down
    echo Done!
) else if "%choice%"=="6" (
    exit /b 0
) else (
    echo Invalid choice!
)

pause
