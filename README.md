# Setup
How to setup the tools to be ready to use your computer

You can find on this repo an .bat which will install all the 
software you can need as a Java Dev. 

## 1 : Install Chocolatey
These command will install Chocolatey
You must run this on a elevated Powershell terminal
```
Set-ExecutionPolicy AllSigned
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

## 2 : Run autoSetup.bat

The script will require credentials to access this repo, as
it's still private.

You must provide if you want an auto configuration of Windows Terminal

## 3 :  IntelliJ 

_____
###Configure Terminal 

Ctrl+Alt+S &#8594; Terminal 

Start Directory :``Your/Project/Repo``  
Shell Path : ``"cmd.exe" /k ""%CMDER_ROOT%\vendor\init.bat""``
Tab Name : ``Cmder``

![image info](./src/IntelliJTerminalSetup.png)

#####Verify UTF-8 encoding support
You might need to restart IntelliJ to make work properly the CLI

Check if UTF-8 encoding work properly 
```shell script
cmd /c %ConEmuDir%\ConEmu\Addons\utf-8-test.cmd
```
#####Verify LN Line separator
If IntelliJ dont use LF line separator, configure it  
Settings &#8594; Code Style &#8594; Line Separator : ``Unix and MacOs``
![image info](./src/IntelliJLineSeparator.png)

###Configure Docker

Docker need some additional component to work

Need to elevate the powershell Terminal to run
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName $("VirtualMachinePlatform", "Microsoft-Windows-Subsystem-Linux")
```

Now [complete the WLS installation](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)


###Start New React App
```shell
yarn create react-app MY_PROJECT --template typescript
yarn add @material-ui/core
```