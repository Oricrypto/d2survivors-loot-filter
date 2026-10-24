@echo off
chcp 65001 >nul
title Filtro de loot para D2 Survivors / Loot filter for D2 Survivors
rem Aplica o filtro no jogo (se faltar) e abre o jogo. Esta janela fica aberta (minimizada) enquanto você joga:
rem quando o jogo se atualiza, ela aplica o filtro de novo na versão nova e, depois do botão "Restart to update", abre o jogo outra vez.
rem Applies the filter (if missing) and opens the game. Keep this window open (minimized) while you play.
cd /d "%~dp0"

set "NODE=%~dp0node.exe"
set "D2S_MODE=filter"
set "D2S_FILTER_BUNDLE=%~dp0d2filter.js"
set "D2S_FILTER_UI_BUNDLE=%~dp0d2filter-ui.js"

set "GAME_DIR="
if exist "%~dp0config.txt" set /p GAME_DIR=<"%~dp0config.txt"
if not defined GAME_DIR set "GAME_DIR=%LOCALAPPDATA%\Programs\D2 Survivors"

rem O jogo cria este arquivo quando você aperta "Restart to update" (patch 6 do patcher).
set "FLAG=%~dp0relaunch.flag"

"%SystemRoot%\System32\tasklist.exe" /fi "imagename eq D2 Survivors.exe" 2>nul | "%SystemRoot%\System32\find.exe" /i "D2 Survivors.exe" >nul
if not errorlevel 1 (
  echo O jogo já está aberto. Feche o jogo completamente e abra de novo por este atalho.
  echo The game is already open. Close it completely and open it again from this shortcut.
  pause
  exit /b 1
)

if not exist "%GAME_DIR%\D2 Survivors.exe" (
  echo Não encontrei o jogo em "%GAME_DIR%".
  echo Rode o INSTALAR.bat de novo, ou abra o config.txt desta pasta e corrija o caminho.
  echo I did not find the game in "%GAME_DIR%".
  echo Run INSTALAR.bat again, or open config.txt in this folder and fix the path.
  pause
  exit /b 1
)

:launch
"%NODE%" apply-patches.mjs "%GAME_DIR%\resources\app.asar"
if errorlevel 1 (
  echo.
  echo Não consegui aplicar o filtro. O jogo NÃO foi alterado e não foi aberto por aqui.
  echo Provavelmente o jogo foi atualizado e esta versão do filtro ainda não serve para ele. Avise o OrgunBr.
  echo Enquanto isso, você pode abrir o jogo normalmente pelo atalho dele.
  echo I could not apply the filter. The game was NOT changed and was not opened from here.
  echo The game was probably updated and this version of the filter does not fit it yet. Tell OrgunBr.
  echo Meanwhile you can open the game normally from its own shortcut.
  pause
  exit /b 1
)

if exist "%FLAG%" del "%FLAG%"
set "D2S_RELAUNCH_FLAG=%FLAG%"
start "" /wait "%GAME_DIR%\D2 Survivors.exe"

rem O jogo fechou. Espera (até 5 minutos) o jogo e o instalador de atualização terminarem.
echo Esperando o jogo e uma possível atualização terminarem... / Waiting for the game and a possible update to finish...
"%SystemRoot%\System32\timeout.exe" /t 3 /nobreak >nul
set /a WAITED=0
:wait
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -Command "$d = $env:GAME_DIR + '\*'; $u = $env:LOCALAPPDATA + '\d2-survivors-updater\*'; if (Get-Process | ? { $_.Path -like $d -or $_.Path -like $u -or $_.Name -in 'Au_', 'Un_A' }) { exit 0 } else { exit 1 }"
if not errorlevel 1 if %WAITED% lss 300 (
  set /a WAITED+=2
  "%SystemRoot%\System32\timeout.exe" /t 2 /nobreak >nul
  goto wait
)

if exist "%FLAG%" (
  echo Atualização instalada. Aplicando o filtro na versão nova e abrindo o jogo de novo.
  echo Update installed. Applying the filter to the new version and opening the game again.
  goto launch
)

rem Fechou normalmente. Aplica o filtro também numa atualização instalada ao sair, para o próximo início já estar pronto.
"%NODE%" apply-patches.mjs "%GAME_DIR%\resources\app.asar"
if errorlevel 1 pause
