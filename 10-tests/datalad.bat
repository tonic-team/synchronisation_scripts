:: Upload changes from inside repository using datalad

:: Set folder where script will be executed
set "loc=%~dp0"
for %%I in ("%loc%.") do set "loc=%%~fI"
set "projectdir="
for /f "delims=" %%I in ('git -C "%loc%" rev-parse --show-toplevel') do set "projectdir=%%I"

pushd "%loc%" >nul

:: initialise
if exist "00repo_needs_initialisation00.txt" (
    echo running project repository initiation (first run)
    datalad get . -n -r
    datalad update -r --how=merge
    del "00repo_needs_initialisation00.txt"
)

:: Set commit message
set /p "commitmessage=Optionally enter a commit message, and hit return: "
if not defined commitmessage (
    echo "using date as commit message"
    set "commitmessage=commit on %date:~10,4%-%date:~4,2%-%date:~7,2%"
)

:: sync
datalad update -r --how=merge
datalad save -r -m "%commitmessage%"
datalad push -r

:: Set dropping option
set /p "q_answer=Do you want to drop all files that were uploaded, they will be on the server but not on this computer anymore ? [y/n]"
if /i "%q_answer%" == "y" (
    datalad drop . -r
)

pause
