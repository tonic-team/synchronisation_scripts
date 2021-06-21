
:: this script set gin to work with SFB1315 data portal GIN-Tonic instance.

:: add server, named hu
gin add-server --web https://gindata.biologie.hu-berlin.de:443 --git git@gindata.biologie.hu-berlin.de:10022 hu

:: chose hu server for this computer
gin use-server hu

:: login to the data portal
gin login