@echo off

rem Upload changes from inside repository using GIN CLI
rem Works with submodules.
rem needs git config to be set and user should be logged in
rem needs submodules and main repo to be initialised (gin init)

rem Checking synchronisation option and giving feedback
:checkargs
if "%~1" == "download" (
  echo "Downloading and keep all large file content"
) else if "%~1" == "keep" (
  echo "Keeping existing local large file content, do not downlad extra files"
) else if "%~1" == "remove" (
  echo "Removing all local local file content"
) else (
  goto :usage
)

:checkerror
if %1 neq 0 (
  echo %2 >> ./.log/gin.log
  echo %1 >> ./.log/gin.log
  echo %2
  echo Press [Enter] to close this window
  pause >nul
  exit /B 1
)

rem Set commit message
set /p commitmessage="Optionally enter a commit message, and hit return: "  
if "%commitmessage%" == "" (
  echo using date as commit message
  set "commitmessage=commit on %date:~-10,2%-%date:~-7,2%-%date:~-4,4%"
)

rem write log
if not exist .\.log md .\.log
echo %date:~-4,4%-%date:~-7,2%-%date:~-10,2%T%time:~0,2%:%time:~3,2%:%time:~6,2% Sync script executed >> .\.log\gin.log

rem create empty .gitmodules if it does not exist
if exist .gitmodules (
  echo .gitmodules already exists.
) else (
  type nul > .gitmodules
)

echo intialise submodules
gin git submodule foreach gin init

echo Synchronising submodules
gin git submodule foreach gin commit . -m "%commitmessage%"
call :checkerror %errorlevel% "Error occurred during 'gin commit'"
gin git submodule foreach gin sync
call :checkerror %errorlevel% "Error occurred during 'gin sync'"

gin git submodule foreach gin upload
call :checkerror %errorlevel% "Error occurred during 'gin upload'"

rem remove uploaded (annexed) content
if "%syncopt%" == "remove" (
  git submodule foreach gin remove-content 
  call :checkerror %errorlevel% "Error occurred during 'gin remove-content'"
)
rem get annexed content 
if "%syncopt%" == "download" (
  git submodule foreach gin get-content .
