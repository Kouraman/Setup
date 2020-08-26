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

if not exist %UserProfile%\Desktop\Info (
    mkdir %UserProfile%\Desktop\Info
    setx REPO_DIR "%UserProfile%\Desktop\Info"
    echo Creation du dossier Info
)

echo install Classic Software

choco install googlechrome
choco install qbittorrent
choco install --params "/Language:fr"


::echo Install KeePass

choco install keepass &&
choco install keepass-plugin-keeanywhere

choco install microsoft-windows-terminal

cmchoco install jdk8
refreshenv

choco install maven
refreshenv

choco install intellijidea-ultimate

choco install git
refreshenv
git config --global core.autocrlf input

choco install docker-desktop

pause
