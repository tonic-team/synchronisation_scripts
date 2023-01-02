@echo off

rem set server, use HU server
if not gin use-server hu (
  echo "set gin server"
  rem set gin remote from git information (on the hu server)
  gin add-server --web https://gindata.biologie.hu-berlin.de:443 --git git@gindata.biologie.hu-berlin.de:10022 hu

  rem chose hu server for this computer
  gin use-server hu

)

rem set remote
if not gin remotes (
  echo "set gin remote"
  rem set gin remote from git information (on the hu server)
  for /F "delims=" %%i in ('git remote get-url origin') do set "remotegit=%%i"
  set "remotegin=%remotegit:*/=%"
  set "remotegin=%remotegin:.git=%"
  set "remotegin=hu:%remotegin%"
  gin add-remote primary %remotegin%
) else (
    echo gin remote set
)
