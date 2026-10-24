@echo off
chcp 65001 >nul
title Filtro de loot para D2 Survivors - instalação
cd /d "%~dp0"
echo.
echo  ==== Filtro de loot para D2 Survivors: instalação ====
echo.

set "HOME_DIR=%LOCALAPPDATA%\D2-Survivors-Filtro"
set "GAME="

rem 1) Onde está o jogo: ao lado deste arquivo, na pasta de cima (se esta pasta foi colocada dentro da pasta do jogo) ou no local padrão.
for %%D in ("%~dp0." "%~dp0.." "%LOCALAPPDATA%\Programs\D2 Survivors") do (
  if not defined GAME if exist "%%~fD\D2 Survivors.exe" set "GAME=%%~fD"
)

if not defined GAME (
  echo Não encontrei o jogo automaticamente.
  echo Abra a pasta onde o D2 Survivors está instalado ^(a pasta que tem o arquivo "D2 Survivors.exe"^),
  echo copie o caminho dela e cole aqui.
  echo.
  set /p "GAME=Pasta do jogo: "
)
set "GAME=%GAME:"=%"

if not exist "%GAME%\D2 Survivors.exe" goto semjogo
if not exist "%GAME%\resources\app.asar" goto semjogo
goto temjogo

:semjogo
echo.
echo Não encontrei o jogo em "%GAME%".
echo Esta instalação só funciona com o jogo instalado no computador ^(a versão para Windows^), não com o jogo no navegador.
echo Nada foi alterado.
pause
exit /b 1

:temjogo
echo Jogo encontrado em: %GAME%

"%SystemRoot%\System32\tasklist.exe" /fi "imagename eq D2 Survivors.exe" 2>nul | "%SystemRoot%\System32\find.exe" /i "D2 Survivors.exe" >nul
if not errorlevel 1 (
  echo.
  echo O jogo está aberto. Feche o jogo completamente e rode este arquivo de novo.
  pause
  exit /b 1
)

rem 2) O filtro fica numa pasta própria, fora da pasta do jogo: uma atualização do jogo pode apagar a pasta dele.
echo Copiando o filtro para "%HOME_DIR%" ...
if not exist "%HOME_DIR%" mkdir "%HOME_DIR%"
xcopy "%~dp0_filtro\*" "%HOME_DIR%\" /E /I /Y /Q >nul
if errorlevel 1 (
  echo Não consegui copiar os arquivos. Nada foi alterado no jogo.
  pause
  exit /b 1
)

rem 3) Os dados do filtro ficam na pasta de dados do próprio jogo. A sua seleção nunca é sobrescrita.
set "DATA=%APPDATA%\D2 Survivors\filter-data"
if not exist "%DATA%" mkdir "%DATA%"
copy /Y "%~dp0_filtro\dados\catalog.json" "%DATA%\" >nul
copy /Y "%~dp0_filtro\dados\uniques.json" "%DATA%\" >nul
copy /Y "%~dp0_filtro\dados\stats.json" "%DATA%\" >nul
if not exist "%DATA%\selection.json" copy "%~dp0_filtro\dados\selection.json" "%DATA%\selection.json" >nul

>"%HOME_DIR%\config.txt" echo %GAME%

rem 4) Aplica o filtro no jogo. O jogo original é guardado antes, em "%HOME_DIR%\backups".
set "D2S_MODE=filter"
set "D2S_FILTER_BUNDLE=%HOME_DIR%\d2filter.js"
set "D2S_FILTER_UI_BUNDLE=%HOME_DIR%\d2filter-ui.js"
"%HOME_DIR%\node.exe" "%HOME_DIR%\apply-patches.mjs" "%GAME%\resources\app.asar"
if errorlevel 1 (
  echo.
  echo Não consegui aplicar o filtro neste jogo. O jogo NÃO foi alterado e continua funcionando normalmente.
  echo Se o jogo foi atualizado agora há pouco, esta versão do filtro pode não servir para ele ainda: avise o OrgunBr.
  pause
  exit /b 1
)

rem 5) Atalho na área de trabalho. (D2F_TESTE é só para os testes de quem faz o pacote: pula o atalho.)
if not defined D2F_TESTE "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -Command "$s=(New-Object -ComObject WScript.Shell).CreateShortcut([Environment]::GetFolderPath('Desktop')+'\D2 Survivors (filtro).lnk'); $s.TargetPath=$env:HOME_DIR+'\jogar.bat'; $s.WorkingDirectory=$env:HOME_DIR; $s.IconLocation=$env:GAME+'\D2 Survivors.exe'; $s.Save()" >nul 2>nul

rem 6) Modo automático (opcional): uma tarefa agendada do Windows, sem janela, que a cada 2 minutos olha se o jogo foi
rem atualizado e, se o jogo estiver fechado, reaplica o filtro. Assim o jogo pode ser aberto pelo .exe normal dele.
rem (D2F_AUTO=S ou N responde a pergunta sozinho; D2F_TAREFA muda o nome da tarefa: só para os testes de quem faz o pacote.)
set "TAREFA=D2SurvivorsFiltroVigia"
if defined D2F_TAREFA set "TAREFA=%D2F_TAREFA%"
set "AUTO=N"
echo.
echo  Modo automático: o filtro se reaplica sozinho depois de cada atualização do jogo, e você pode abrir o jogo
echo  pelo .exe normal dele, sem usar o atalho. Cria uma tarefa agendada do Windows, sem janela, que olha a cada 2 minutos.
if defined D2F_AUTO (
  set "AUTO=%D2F_AUTO%"
) else (
  "%SystemRoot%\System32\choice.exe" /C SN /N /M "Ligar o modo automático? [S/N] "
  if errorlevel 1 if not errorlevel 2 set "AUTO=S"
)
if /i "%AUTO%"=="S" (
  "%SystemRoot%\System32\schtasks.exe" /Create /TN "%TAREFA%" /SC MINUTE /MO 2 /F /TR "wscript.exe //B //Nologo \"%HOME_DIR%\vigia.vbs\"" >nul 2>nul
  if errorlevel 1 (
    set "AUTO=N"
    echo  Não consegui criar a tarefa agendada. Sem problema: use o atalho do filtro para jogar.
  )
)

echo.
echo  Pronto! O filtro foi instalado.
echo.
if /i "%AUTO%"=="S" (
  echo  - Modo automático LIGADO: pode abrir o jogo pelo .exe normal ou pelo atalho. Depois de uma atualização do jogo,
  echo    o filtro volta sozinho quando o jogo estiver fechado ^(pode demorar até 2 minutos^).
) else (
  echo  - Modo automático desligado: abra o jogo pelo atalho "D2 Survivors (filtro)"; ele reaplica o filtro depois
  echo    de cada atualização. Pelo .exe normal o filtro funciona só até a próxima atualização do jogo.
)
echo  - Para jogar, use o atalho "D2 Survivors (filtro)" na área de trabalho. Ele reaplica o filtro sozinho
echo    depois de cada atualização do jogo.
echo  - No jogo, aperte ESC e escolha FILTER. O filtro começa em modo de TESTE: ele só anota o que faria, não vende nada.
echo  - Leia o LEIA-ME.txt antes de ligar a venda automática.
echo.
pause
