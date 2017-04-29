@echo off

reg query HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment 2> null
if %ERRORLEVEL% EQU 0 goto jre
if %ERRORLEVEL% EQU 1 goto jdk

:jre
set KeyName=HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment
if %ERRORLEVEL% EQU 1 goto JDK
else(
set Cmd=reg query "%KeyName%" /s 
for /f "tokens=2*" %%i in ('%Cmd% ^| find "JavaHome"') do set JAVA_HOME=%%j
)

:jdk
set KeyName=HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Development Kit
set Cmd=reg query "%KeyName%" /s
for /f "tokens=2*" %%i in ('%Cmd% ^| find "JavaHome"') do set JAVA_HOME=%%j


set /p UserInputPath= Which applet do you want to load? (example: applet2-1.html) file-name: 
start "" "%~dp0%UserInputPath%"
CD %JAVA_HOME%\bin
appletviewer %~dp0%UserInputPath%