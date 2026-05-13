@echo off
title MENU PILIHAN LENGKAP - Windows Server
color 0A

:MAIN_MENU
cls
echo ========================================
echo     MENU PILIHAN LENGKAP
echo ========================================
echo 1. Blokir Anti-Malware Executable
echo 2. Blokir Windows Update
echo 3. RDP tidak mati sendiri
echo 4. Jalankan SEMUA blokir
echo 5. Kembalikan ke default
echo 6. Ganti Password Administrator
echo 7. Ganti Nama PC
echo 8. Install Notepad++ 8.5
echo 9. Install Python 3.12.2
echo 10. Install 7-Zip 25.01
echo 11. Set Wallpaper Frieren
echo 12. Keluar
echo ========================================
echo.

set /p pilihan="Pilih nomor (1-12): "

if "%pilihan%"=="1" goto MALWARE
if "%pilihan%"=="2" goto UPDATE
if "%pilihan%"=="3" goto RDP
if "%pilihan%"=="4" goto ALL
if "%pilihan%"=="5" goto RESTORE
if "%pilihan%"=="6" goto PASSWORD
if "%pilihan%"=="7" goto PCNAME
if "%pilihan%"=="8" goto INSTALL_NPP
if "%pilihan%"=="9" goto INSTALL_PYTHON
if "%pilihan%"=="10" goto INSTALL_7ZIP
if "%pilihan%"=="11" goto WALLPAPER
if "%pilihan%"=="12" goto KELUAR

echo Pilihan salah!
pause
goto MAIN_MENU

:MALWARE
cls
echo ========================================
echo BLOKIR ANTI-MALWARE EXECUTABLE...
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

echo Killing MsMpEng.exe...
taskkill /f /im MsMpEng.exe /t >nul 2>&1

echo Disabling services...
net stop WinDefend /y >nul 2>&1
net stop WdNisSvc /y >nul 2>&1
net stop SecurityHealthService /y >nul 2>&1
net stop wscsvc /y >nul 2>&1

sc config WinDefend start= disabled >nul 2>&1
sc config WdNisSvc start= disabled >nul 2>&1
sc config SecurityHealthService start= disabled >nul 2>&1
sc config wscsvc start= disabled >nul 2>&1

echo Blocking via Registry...
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1

echo.
echo BERHASIL!
echo Anti-Malware Executable MATI PERMANEN
pause
goto MAIN_MENU

:UPDATE
cls
echo ========================================
echo BLOKIR WINDOWS UPDATE...
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

echo Stopping services...
net stop wuauserv /y 2>nul
net stop bits /y 2>nul

echo Disabling services...
sc config wuauserv start= disabled 2>nul
sc config bits start= disabled 2>nul

echo Blocking Update...
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1

echo Disabling tasks...
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Disable 2>nul
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Disable 2>nul

echo.
echo BERHASIL!
echo Windows Update BLOCKED FOREVER
pause
goto MAIN_MENU

:RDP
cls
echo ========================================
echo AKTIFKAN RDP NEVER DIE...
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

echo Setting RDP never timeout...
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxIdleTime /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxDisconnectionTime /t REG_DWORD /d 0 /f >nul 2>&1

echo No sleep no hibernate...
powercfg /x monitor-timeout-ac 0 2>nul
powercfg /x standby-timeout-ac 0 2>nul
powercfg /hibernate off 2>nul

echo.
echo BERHASIL!
echo RDP AMAN 24/7 - TIDAK MATI SENDIRI
pause
goto MAIN_MENU

:ALL
cls
echo ========================================
echo MENJALANKAN SEMUA BLOKIR SEKALIGUS...
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

echo Blocking Anti-Malware...
taskkill /f /im MsMpEng.exe /t >nul 2>&1
net stop WinDefend /y >nul 2>&1
net stop WdNisSvc /y >nul 2>&1
net stop SecurityHealthService /y >nul 2>&1
net stop wscsvc /y >nul 2>&1
sc config WinDefend start= disabled >nul 2>&1
sc config WdNisSvc start= disabled >nul 2>&1
sc config SecurityHealthService start= disabled >nul 2>&1
sc config wscsvc start= disabled >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1

echo Blocking Update...
net stop wuauserv /y 2>nul
net stop bits /y 2>nul
sc config wuauserv start= disabled 2>nul
sc config bits start= disabled 2>nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableWindowsUpdateAccess /t REG_DWORD /d 1 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Disable 2>nul
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Disable 2>nul

echo Setting RDP never die...
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxIdleTime /t REG_DWORD /d 0 /f >nul 2>&1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxDisconnectionTime /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /x monitor-timeout-ac 0 2>nul
powercfg /x standby-timeout-ac 0 2>nul
powercfg /hibernate off 2>nul

echo.
echo BERHASIL TOTAL!
echo Semua blokir sudah aktif
pause
goto MAIN_MENU

:RESTORE
cls
echo ========================================
echo KEMBALIKAN SEMUA KE DEFAULT...
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

echo Enabling services...
sc config wuauserv start= auto 2>nul
sc config bits start= auto 2>nul
sc config WinDefend start= auto 2>nul
sc config WdNisSvc start= auto 2>nul
sc config SecurityHealthService start= auto 2>nul
sc config wscsvc start= auto 2>nul

echo Removing blocks...
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f 2>nul
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /f 2>nul

echo Enabling tasks...
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Enable 2>nul
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Enable 2>nul

echo Restoring RDP...
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxIdleTime /f 2>nul
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v MaxDisconnectionTime /f 2>nul

echo Restoring power...
powercfg /x monitor-timeout-ac 30 2>nul
powercfg /x standby-timeout-ac 30 2>nul
powercfg /hibernate on 2>nul

echo.
echo BERHASIL! Semua kembali normal
pause
goto MAIN_MENU

:PASSWORD
cls
echo ========================================
echo GANTI PASSWORD ADMINISTRATOR
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set /p user="Username (kosongkan = Administrator): "
if "%user%"=="" set user=Administrator

set /p pass="Password baru: "

net user %user% %pass% >nul 2>&1
if %errorLevel%==0 (
    echo BERHASIL! Password sudah diganti.
) else (
    echo GAGAL!
)
pause
goto MAIN_MENU

:PCNAME
cls
echo ========================================
echo GANTI NAMA PC
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set /p newname="Nama PC baru (tanpa spasi): "
if "%newname%"=="" (
    echo Nama tidak boleh kosong!
    pause
    goto MAIN_MENU
)

wmic computersystem where name="%computername%" call rename name="%newname%" >nul 2>&1
echo BERHASIL! Nama PC diubah (restart diperlukan)
pause
goto MAIN_MENU

:INSTALL_NPP
cls
echo ========================================
echo INSTALL NOTEPAD++ 8.5
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set "DOWNLOAD_DIR=%TEMP%\ServerTools"
md "%DOWNLOAD_DIR%" 2>nul

echo Downloading Notepad++...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5/npp.8.5.Installer.x64.exe' -OutFile '%DOWNLOAD_DIR%\npp.8.5.Installer.x64.exe' -UseBasicParsing" >nul 2>&1

if not exist "%DOWNLOAD_DIR%\npp.8.5.Installer.x64.exe" (
    echo Download GAGAL!
    pause
    goto MAIN_MENU
)

start /wait "" "%DOWNLOAD_DIR%\npp.8.5.Installer.x64.exe" /S
echo BERHASIL! Notepad++ sudah terinstall
pause
goto MAIN_MENU

:INSTALL_PYTHON
cls
echo ========================================
echo INSTALL PYTHON 3.12.2
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set "DOWNLOAD_DIR=%TEMP%\ServerTools"
md "%DOWNLOAD_DIR%" 2>nul

echo Downloading Python...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.12.2/python-3.12.2-amd64.exe' -OutFile '%DOWNLOAD_DIR%\python-3.12.2-amd64.exe' -UseBasicParsing" >nul 2>&1

if not exist "%DOWNLOAD_DIR%\python-3.12.2-amd64.exe" (
    echo Download GAGAL!
    pause
    goto MAIN_MENU
)

start /wait "" "%DOWNLOAD_DIR%\python-3.12.2-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1
echo BERHASIL! Python sudah terinstall
pause
goto MAIN_MENU

:INSTALL_7ZIP
cls
echo ========================================
echo INSTALL 7-ZIP 25.01
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set "DOWNLOAD_DIR=%TEMP%\ServerTools"
md "%DOWNLOAD_DIR%" 2>nul

echo Downloading 7-Zip...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://www.7-zip.org/a/7z2501-x64.exe' -OutFile '%DOWNLOAD_DIR%\7z2501-x64.exe' -UseBasicParsing" >nul 2>&1

if not exist "%DOWNLOAD_DIR%\7z2501-x64.exe" (
    echo Download GAGAL!
    pause
    goto MAIN_MENU
)

start /wait "" "%DOWNLOAD_DIR%\7z2501-x64.exe" /S
echo BERHASIL! 7-Zip sudah terinstall
pause
goto MAIN_MENU

:WALLPAPER
cls
echo ========================================
echo SET WALLPAPER FRIEREN
echo ========================================
echo.

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: Jalankan sebagai Administrator!
    pause
    goto MAIN_MENU
)

set "WALLPAPER_DIR=%USERPROFILE%\Pictures\Wallpapers"
md "%WALLPAPER_DIR%" 2>nul

echo Downloading wallpaper Frieren...
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://4kwallpapers.com/images/wallpapers/frieren-magical-3840x2160-15165.jpeg' -OutFile '%WALLPAPER_DIR%\Frieren.jpg' -UseBasicParsing" >nul 2>&1

if not exist "%WALLPAPER_DIR%\Frieren.jpg" (
    echo Download GAGAL! Cek koneksi internet.
    pause
    goto MAIN_MENU
)

echo Applying wallpaper...
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%WALLPAPER_DIR%\Frieren.jpg" /f >nul
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v TileWallpaper /t REG_SZ /d 0 /f >nul

echo Restarting explorer (supaya wallpaper langsung berubah)...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

echo.
echo BERHASIL! Wallpaper Frieren sudah di-set.
pause
goto MAIN_MENU

:KELUAR
exit
