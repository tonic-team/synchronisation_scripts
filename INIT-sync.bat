@echo off

rem Initialise or Upload changes from inside repository
rem using GIN CLI
rem Works with submodules and repo made by tonic v1 (not copying submodules content).
rem needs git config to be set 
rem needs SSH access to GIN
rem future dvt using datalad will allow use of non-GIN repositories

rem logic: template has a specific file to label it needs initialisation.
rem if this file is present, code 1 is done: template_initialisation
rem if it is absent but submodules are empty, code 2 is done: submodule_initialisation
rem if none of the above code 3 is done: synchronisation

rem Set folder where script will be executed 
set "loc=%~dp0"
for /F "delims=" %%i in ('git -C %loc% rev-parse --show-toplevel') do set "projectdir=%%i"

pushd %loc% > nul

rem set gin server and remote
if not gin remotes (
  call .script\setginserver.bat
) else (
    echo gin remote set
)

rem login if needed
if not gin info (
  echo "set gin login"
  gin login
) else (
    echo "gin logged"
)

rem code 1
if exist "00repo_needs_initialisation00.txt" (
  echo "running project repository initiation (first run)"
  call .scripts\template_init.bat
)

rem code 2

if exist ".gitmodules" (
  findstr /M "06_dissemination" ".gitmodules" > nul
  if errorlevel 1 (
    echo "not a tonic repo, please initialise submodules manually if there are any"
  ) else (
    if exist "06_dissemination\README_DISSEMINATION.md" (
      echo "submodules are initialised"
    ) else (
      echo "initialising submodules"
      gin git submodule update --init --recursive
      gin git submodule foreach gin init
    )
  )
)

rem code 3

:usage
echo %0 <sync-option>
echo.
echo <sync-option>     The sync option defines what to do with the content of large files.
echo                   It should be one of the following values:
echo                      download - Download all large file content from the server
echo                      keep     - Keep all large file content but do not download missing large files
echo                      remove   - Do not download large files and remove existing local large file content
exit /B 1

rem Set the variable for synchronisation option, see above 
set "syncopt=remove"

echo start synchronisation in %syncopt% mode, close window to cancel. change mode by changing the code in a text application
call .scripts\GIN-SYNC.bat
