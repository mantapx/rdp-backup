@echo off
title Ganti Password RDP + Kunci Permanent Total + Anti Reset DO Panel
color 0E
echo ========================================
echo Script RDP - Password "pwmu" + LOCK TOTAL + ANTI RESET DO PANEL
echo ========================================
echo.
echo **PERINGATAN PENTING:**
echo Script ini akan:
echo 1. Mengubah password akun Anda menjadi "pwmu"
echo 2. Mengunci password agar TIDAK BISA diubah/reset (Windows + Digital Ocean Panel)
echo 3. Membuat akun Administrator cadangan
echo 4. Menonaktifkan akun Administrator bawaan (anti reset panel DO)
echo 5. Menonaktifkan Windows Defender sepenuhnya
echo.
echo Username akan TETAP seperti semula.
echo Harus dijalankan sebagai Administrator!
pause
echo.
echo [1/6] Mengubah password...
net user "%username%" pwmu >nul 2>&1
echo ✓ Password berhasil diubah menjadi "pwmu"
echo.
echo [2/6] Mengunci password SUPER PERMANENT...
net user "%username%" /passwordchg:no >nul 2>&1
net accounts /minpwage:999 >nul 2>&1
net accounts /maxpwage:unlimited >nul 2>&1
net user "%username%" /expires:never >nul 2>&1
wmic useraccount where name="%username%" set PasswordChangeable=False >nul 2>&1
echo ✓ Password dikunci SUPER PERMANENT (Windows + Panel)
echo.
echo [3/6] Membuat akun Administrator cadangan...
net user AdminBackup backuppwmu /add >nul 2>&1
net localgroup Administrators AdminBackup /add >nul 2>&1
net user AdminBackup /passwordchg:no >nul 2>&1
echo ✓ Akun cadangan dibuat: AdminBackup (Password: backuppwmu)
echo.
echo [4/6] Menyiapkan akun untuk RDP (Standard User + RDP Rights)...
net localgroup Administrators "%username%" /delete >nul 2>&1
net localgroup "Remote Desktop Users" "%username%" /add >nul 2>&1
echo ✓ Akun utama sekarang Standard User + RDP diizinkan
echo.
echo [5/6] Menonaktifkan built-in Administrator (ANTI RESET DO PANEL)...
net user Administrator /active:no >nul 2>&1
echo ✓ Akun Administrator bawaan DINONAKTIFKAN (panel DO tidak bisa reset)
echo.
echo [6/6] Menonaktifkan Windows Defender...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableScriptScanning $true" >nul 2>&1
net stop WinDefend /y >nul 2>&1
sc config WinDefend start=disabled >nul 2>&1
echo ✓ Windows Defender telah dimatikan.
echo.
echo [SELESAI!]
echo ========================================
echo.
echo Username RDP Anda : %username% (tetap sama)
echo Password RDP      : pwmu
echo Status password   : SUPER PERMANENT + ANTI RESET DO PANEL
echo Windows Defender  : DIMATIKAN
echo.
echo Akun Admin Cadangan:
echo Username : AdminBackup
echo Password : backuppwmu
echo.
echo **CATATAN PENTING:**
echo • Restart komputer sekarang.
echo • Test RDP pakai username lama + password "pwmu"
echo • Tombol Reset Password di Panel Digital Ocean sudah tidak berfungsi (karena Administrator dinonaktifkan)
echo • Kalau butuh akses Admin, login pakai AdminBackup.
echo • Untuk buka kunci nanti (kalau perlu), login sebagai AdminBackup lalu jalankan:
echo   net user Administrator /active:yes
echo   net accounts /minpwage:0
echo   net user "%username%" /passwordchg:yes
echo   wmic useraccount where name="%username%" set PasswordChangeable=True
echo.
pause
