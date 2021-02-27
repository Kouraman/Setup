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

::------------------------------  Variables

set repoDirectory="%UserProfile%\Desktop\Info"
set cmderRoot="C:\tools\Cmder"
set conemuDir="C:\tools\Cmder\vendor\conemu-maximus5"
set configDir="%UserProfile%\Desktop\Info\Setup\src\config"

set timeoutValue=10

::------------------------------ Configs
echo To work, the script require git credentials to download settings files
echo.

set /p username="Git Username : "
set /p pwd="Git Pwd : "

echo.
echo Parametring done, installation will start
timeout %timeoutValue% && cls

::------------------------------ Configs

choco feature enable -n allowGlobalConfirmation

::------------------------------ Info Project Folder

if not exist %UserProfile%\Desktop\Info (
    echo Creation du dossier Info
    mkdir %UserProfile%\Desktop\Info
)
setx REPO_DIR %repoDirectory%

::------------------------------ Classic Soft

echo Install Classic Software
choco install googlechrome
choco install qbittorrent
choco install --params "/Language:fr" vlc

echo.
echo Classic Software installed
timeout %timeoutValue% && cls

::------------------------------ Pwd Manager

echo Install PasswordManager
choco install keepass && choco install keepass-plugin-keeanywhere

echo.
echo PasswordManager installed
timeout %timeoutValue% && cls

::------------------------------ Database Client

echo Install DatabaseClient

choco install sqlyog

echo.
echo DatabaseClient installed
timeout %timeoutValue% && cls

::------------------------------ Cli : Git, UnixCLI, AWS


echo Install Git,UnixCLI and AWS CLI and configure it
choco install git -params '"/GitAndUnixToolsOnPath"'
choco install awscli
call RefreshEnv.cmd
git config --global core.autocrlf input

echo.
echo Git,UnixCLI and AWS CLI installed
timeout %timeoutValue% && cls

:: Get settings for git

cd %REPO_DIR%
git clone https://%username%:%pwd%@github.com/Kouraman/Setup.git

::------------------------------ Terminals

echo Install and Configure Windows Terminal
choco install microsoft-windows-terminal cmder
setx CMDER_ROOT %cmderRoot%
setx ConEmuDir %conemuDir%

echo Delete git from cmder
rm -rf %CMDER_ROOT%\vendor\git-for-windows

::Copy the Windows Terminal configuration into the right location

cd %UserProfile%\AppData\Local\Packages\Microsoft.WindowsTerminal*\
cp -f %configDir%\terminal\settings.json LocalState
cd %UserProfile%

echo.
echo Windows Terminal installed
timeout %timeoutValue% && cls

::------------------------------ Java & Maven

echo Install Java environments
choco install jdk8
call RefreshEnv.cmd
choco install maven
call RefreshEnv.cmd

echo.
echo Java environments installed
timeout %timeoutValue% && cls

echo Install Yarn and Node
choco install yarn
call RefreshEnv.cmd
choco install nodejs
call RefreshEnv.cmd

::------------------------------ IDEs

echo Install IDEs
choco install intellijidea-ultimate
choco install notepadplusplus

echo.
echo IDEs installed
timeout %timeoutValue% && cls

::------------------------------ Docker

echo Install Docker
choco install docker-desktop
choco install putty
choco install filezilla
call RefreshEnv.cmd

echo.
echo Docker installed
timeout %timeoutValue% && cls

::------------------------------ Various Soft

echo Install Postman
choco install postman

echo.
echo Postman installed
timeout %timeoutValue% && cls

::------------------------------ End

echo Every Soft you need should be installed and configured, thanks for using!
pause

