:: this script should run the sync bash script on windows, once cygwin has been installed

set curdir=%~dp0

C:\cygwin64\bin\bash -l %curdir%INIT-sync


pause

set curdir=%~dp0
for /f %%i in ('git -C %curdir% rev-parse --show-toplevel') do set projectdir=%%i

cd %projectdir%

set /p commitmessage=

datalad update -r --how=merge
datalad save -r -m %commitmessage%
datalad push -r --to origin
