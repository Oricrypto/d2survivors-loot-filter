@echo off
rem Vigia do filtro (modo automático) / filter watcher (automatic mode): roda escondido, de tempos em tempos, pela tarefa agendada criada pelo INSTALAR.bat.
rem Se o jogo está fechado e o arquivo dele mudou desde a última vez (uma atualização trocou o app.asar), reaplica o filtro.
rem If the game is closed and its file changed since last time (an update replaced app.asar), it re-applies the filter.
rem Quase sempre termina na hora: só chama o patcher quando o tamanho ou a data do arquivo do jogo mudou.
cd /d "%~dp0"

set "GAME_DIR="
if exist "%~dp0config.txt" set /p GAME_DIR=<"%~dp0config.txt"
if not defined GAME_DIR exit /b 0
set "ASAR=%GAME_DIR%\resources\app.asar"
if not exist "%ASAR%" exit /b 0

rem Com o jogo aberto o arquivo está travado: espera a próxima vez.
"%SystemRoot%\System32\tasklist.exe" /fi "imagename eq D2 Survivors.exe" 2>nul | "%SystemRoot%\System32\find.exe" /i "D2 Survivors.exe" >nul
if not errorlevel 1 exit /b 0

set "SIG="
for %%F in ("%ASAR%") do set "SIG=%%~zF %%~tF"
set "LAST="
if exist "%~dp0vigia-estado.txt" set /p LAST=<"%~dp0vigia-estado.txt"
if "%SIG%"=="%LAST%" exit /b 0

rem O registro não passa de uns 200 KB.
for %%L in ("%~dp0vigia.log") do if exist "%%~fL" if %%~zL gtr 200000 del "%%~fL"
>>"%~dp0vigia.log" echo [%date% %time%] o arquivo do jogo mudou / the game file changed ^(%SIG%^): aplicando o filtro / applying the filter

set "D2S_MODE=filter"
set "D2S_FILTER_BUNDLE=%~dp0d2filter.js"
set "D2S_FILTER_UI_BUNDLE=%~dp0d2filter-ui.js"
"%~dp0node.exe" "%~dp0apply-patches.mjs" "%ASAR%" >>"%~dp0vigia.log" 2>&1
if errorlevel 1 (
  >>"%~dp0vigia.log" echo [%date% %time%] NAO FOI POSSIVEL aplicar o filtro / COULD NOT apply the filter ^(see above^). O jogo nao foi alterado / The game was not changed.
)

rem Guarda a assinatura do arquivo como ele ficou, para não tentar de novo até ele mudar outra vez.
for %%F in ("%ASAR%") do set "SIG=%%~zF %%~tF"
>"%~dp0vigia-estado.txt" echo %SIG%
exit /b 0
