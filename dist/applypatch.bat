@echo on
IF "%*"=="" (
    FOR /F "tokens=*" %%i in ('tools\Get-SteamAppPath 1374840') DO SET DDPATH=%%i
) else (
    SET DDPATH=%*
)
SET DATAWIN=%DDPATH%\data.win
utmt_cli\undertalemodcli load "%DATAWIN%" -s tools\scriptupdater.csx -o "%DATAWIN%"

