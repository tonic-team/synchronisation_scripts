:: this script should run the sync bash script on windows, once cygwin has been installed

set curdir=%~dp0

C:\cygwin64\bin\bash -l %curdir%sync.sh

pause