@echo off
cd %~dp0

Taskkill /IM NAPS2.exe /F
if exist "%PROGRAMFILES(X86)%\Naps2\unins000.exe" (start "" /wait "%PROGRAMFILES(X86)%\Naps2\unins000.exe" /sp- /verysilent /norestart)
if exist "%PROGRAMFILES(X86)%\Naps2\" (RD /S /Q "%PROGRAMFILES(X86)%\Naps2")
if exist "%PROGRAMFILES%\Naps2\unins000.exe" (start "" /wait "%PROGRAMFILES%\Naps2\unins000.exe" /sp- /verysilent /norestart)
if exist "%PROGRAMFILES%\Naps2\" (RD /S /Q "%PROGRAMFILES%\Naps2")
if exist "%APPDATA%\NAPS2\" (RD /S /Q "%APPDATA%\NAPS2")

xcopy.exe   >nul 2>nul /C /H /I /R /S /Y /Z "tesseract-4.0.0b4" "%APPDATA%\NAPS2\components\tesseract-4.0.0b4\"
xcopy.exe   >nul 2>nul /C /H /I /R /S /Y /Z "gs-9.21" "%APPDATA%\NAPS2\components\gs-9.21\"

start "" /wait naps2-6.1.2-setup.msi /quiet /norestart

if exist "%PROGRAMFILES(X86)%" (
start "" /wait xcopy.exe >nul 2>nul /C /H /I /R /S /Y /Z "appsettings.xml" "%PROGRAMFILES(X86)%\NAPS2\"
) else (
start "" /wait xcopy.exe >nul 2>nul /C /H /I /R /S /Y /Z "appsettings.xml" "%PROGRAMFILES%\NAPS2\"
)


set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;
REM set PROGRAM_DIR=%ProgramFiles: (x86)=%
if defined ProgramFiles(x86) set PROGRAM_DIR=%ProgramFiles(x86)%
if not defined ProgramFiles(x86) set PROGRAM_DIR=%ProgramFiles%
set PROGRAM_DESC=Сканирование
set PROGRAM_NAME=NAPS2
set PROGRAM_EXEC=naps2.exe
wscript.exe >nul 2>nul "%~dp0shortcut.vbs" "%PROGRAM_DIR%\%PROGRAM_NAME%\%PROGRAM_EXEC%" "AllUsersPrograms" "%PROGRAM_DESC%"
wscript.exe >nul 2>nul "%~dp0shortcut.vbs" "%PROGRAM_DIR%\%PROGRAM_NAME%\%PROGRAM_EXEC%" "AllUsersDesktop"  "%PROGRAM_DESC%"

endlocal
exit /B
