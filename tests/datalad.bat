:: Upload changes from inside repository using GIN CLI

:checkerror
    err=%1
    msg=%2
    if %err% NEQ 0 (

    )
EXIT /B

set curdir=%~dp0
for /f %%i in ('git -C %curdir% rev-parse --show-toplevel') do set projectdir=%%i



cd %projectdir%

datalad get . -n -r
datalad update -r --how=merge

echo "Enter a commit message:"
set /p input=


:: sync

datalad update -r --how=merge
datalad save -r -m  %input%
datalad push -r



set /p qanswer="Do you want to drop all files that were uploaded, they will be on the server but not on this computer anymore ? [y/n] "

if /i "%input%" == "yes" (
    datalad drop . -r
)

pause