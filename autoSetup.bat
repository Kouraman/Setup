@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

set repoDirectory="%UserProfile%\Desktop\Info"
set cmderRoot="C:\tools\Cmder"
set conemuDir="C:\tools\Cmder\vendor\conemu-maximus5"
set configDir="%REPO_DIR%\Setup\src\config"

set timeoutValue=10

if not exist %UserProfile%\Desktop\Info (
    echo Creation du dossier Info
    mkdir %UserProfile%\Desktop\Info
    setx REPO_DIR %repoDirectory%

)
choco feature enable -n allowGlobalConfirmation

echo Install Classic Software
choco install googlechrome
choco install qbittorrent
choco install --params "/Language:fr" vlc

echo.
echo Classic Software installed
timeout %timeoutValue% && cls

::------------------------------

echo Install PasswordManager
choco install keepass && choco install keepass-plugin-keeanywhere

echo.
echo PasswordManager installed
timeout %timeoutValue% && cls

::------------------------------

echo Install and Configure Windows Terminal
choco install microsoft-windows-terminal cmder
setx CMDER_ROOT %cmderRoot%
setx ConEmuDir %conemuDir%

::Copy the Windows Terminal configuration into the right location
cd %UserProfile%\AppData\Local\Packages\Microsoft.WindowsTerminal*\
cp %configDir%\terminal\settings.json LocalState
cd %UserProfile%

echo.
echo Windows Terminal installed
timeout %timeoutValue% && cls

::------------------------------

echo Install Git,UnixCLI and AWS CLI and configure it
choco install git -params '"/GitAndUnixToolsOnPath"'
choco install awscli
call RefreshEnv.cmd
git config --global core.autocrlf input

echo.
echo Git,UnixCLI and AWS CLI installed
timeout %timeoutValue% && cls

::------------------------------

echo Install Java environments
choco install jdk8
call RefreshEnv.cmd
choco install maven
call RefreshEnv.cmd

echo.
echo Java environments installed
timeout %timeoutValue% && cls

::------------------------------

echo Install IDEs
choco install intellijidea-ultimate
choco install notepadplusplus

echo.
echo IDEs installed
timeout %timeoutValue% && cls

::------------------------------

echo Install Docker
choco install docker-desktop
call RefreshEnv.cmd

echo.
echo Docker installed
timeout %timeoutValue% && cls

::------------------------------

echo Every Soft you need should be installed and configured, thanks for using!
pause

