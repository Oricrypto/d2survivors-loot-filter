@echo off
chcp 65001 >nul
title Filtro de loot para D2 Survivors - desinstalar / Loot filter for D2 Survivors - uninstall
cd /d "%~dp0"
echo.
echo  ==== Desinstalar o filtro de loot / Uninstall the loot filter ====
echo.

set "GAME_DIR="
if exist "%~dp0config.txt" set /p GAME_DIR=<"%~dp0config.txt"
if not defined GAME_DIR set "GAME_DIR=%LOCALAPPDATA%\Programs\D2 Survivors"

"%SystemRoot%\System32\tasklist.exe" /fi "imagename eq D2 Survivors.exe" 2>nul | "%SystemRoot%\System32\find.exe" /i "D2 Survivors.exe" >nul
if not errorlevel 1 (
  echo O jogo está aberto. Feche o jogo completamente e rode este arquivo de novo.
  echo The game is open. Close the game completely and run this file again.
  pause
  exit /b 1
)

if not exist "%GAME_DIR%\resources\app.asar" (
  echo Não encontrei o jogo em "%GAME_DIR%". Nada foi alterado.
  echo I did not find the game in "%GAME_DIR%". Nothing was changed.
  pause
  exit /b 1
)

set "D2S_RESTORE=1"
"%~dp0node.exe" "%~dp0apply-patches.mjs" "%GAME_DIR%\resources\app.asar"
if errorlevel 1 (
  echo.
  echo Não consegui devolver o arquivo original do jogo ^(veja a mensagem acima^).
  echo Se o jogo foi atualizado depois da instalação e você não o abriu pelo atalho do filtro desde então, ele já está
  echo original: a atualização trocou o arquivo e o filtro não está nele. Se mesmo assim quiser ter certeza,
  echo reinstale o jogo pelo instalador dele.
  echo I could not give back the game's original file ^(see the message above^).
  echo If the game was updated after the install and you have not opened it from the filter shortcut since, it is
  echo already original: the update replaced the file and the filter is not in it. If you want to be sure anyway,
  echo reinstall the game with its own installer.
  pause
  exit /b 1
)

if not defined D2F_TESTE "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -Command "Remove-Item ([Environment]::GetFolderPath('Desktop')+'\D2 Survivors (filtro).lnk') -ErrorAction SilentlyContinue" >nul 2>nul

rem Remove a tarefa do modo automático, se ela existir (D2F_TAREFA muda o nome: só para os testes de quem faz o pacote).
set "TAREFA=D2SurvivorsFiltroVigia"
if defined D2F_TAREFA set "TAREFA=%D2F_TAREFA%"
"%SystemRoot%\System32\schtasks.exe" /Delete /TN "%TAREFA%" /F >nul 2>nul

echo.
echo  Pronto: o jogo voltou ao original, o atalho foi removido e o modo automático foi desligado.
echo  Done: the game is back to the original, the shortcut was removed and automatic mode was turned off.
echo.
echo  Se quiser apagar o resto, apague você mesmo estas pastas ^(a sua seleção e o registro de decisões ficam na segunda^):
echo  To delete the rest, delete these folders yourself ^(your selection and the decision log are in the second one^):
echo    %LOCALAPPDATA%\D2-Survivors-Filtro
echo    %APPDATA%\D2 Survivors\filter-data
echo.
pause
