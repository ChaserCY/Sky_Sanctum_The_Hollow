@echo off
rem =================================================================
rem  Sky Sanctum: The Hollow - one-click downloader / installer
rem
rem  Downloads the 3 release parts, verifies each with SHA-256,
rem  merges them, and extracts the game.
rem
rem  Written in plain batch on purpose: it needs no PowerShell
rem  execution-policy change and runs on stock Windows 10/11
rem  (which ships curl.exe, certutil.exe and tar.exe).
rem
rem  Usage: double-click this file.
rem =================================================================

setlocal EnableExtensions
title Sky Sanctum: The Hollow - Downloader
cd /d "%~dp0"

set "TAG=v1.0.0"
set "REPO=ChaserCY/Sky_Sanctum_The_Hollow"
set "NAME=Sky_Sanctum_The_Hollow_v1.0.0_Windows.zip"
set "BASE=https://github.com/%REPO%/releases/download/%TAG%"
set "PARTSDIR=_download_parts"
set "DEST=Sky_Sanctum_The_Hollow"
set "PF86=%ProgramFiles(x86)%"

rem --- SHA-256 of the three release assets (see SHA256SUMS in the release) ---
set "HASH001=0645006d706ff44ff4ff03f473a9adefc7edd26ecf8cd1fff6297dc5eb23c4c1"
set "HASH002=273a0223a520d03f9e0c87ab2f9a01c83df54f62a9bcb17d8cd3365109a22c78"
set "HASH003=7cf1b79c9d4cd947b19780534746ca978bfd8ec61b569675fc7001b8f9727881"
rem --- SHA-256 of the merged zip (expected result) ---
set "HASHZIP=269be3466c4bf5994c419a4057ade2e01f6077cabb6d1680a3e977b81aad5e6c"

echo ================================================================
echo    Sky Sanctum: The Hollow   -   one-click downloader
echo ================================================================
echo.
echo    Downloads     : 3 parts, about 4.6 GB in total
echo    Source        : %BASE%
echo    Extract to    : %CD%\%DEST%
echo.
echo    Downloading takes a while. If it is interrupted, just run
echo    this file again - finished parts are skipped and partial
echo    downloads are resumed.
echo.
pause
echo.

rem ---------------------------------------------------------------- tools
where curl.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR] curl.exe was not found.
    echo         It ships with Windows 10 version 1803 and newer.
    echo         You can download the 3 parts manually from:
    echo         %BASE%
    goto :fail
)
where certutil.exe >nul 2>nul
if errorlevel 1 (
    echo [ERROR] certutil.exe was not found, cannot verify the download.
    goto :fail
)

rem ---------------------------------------------------------------- download
echo [1/3] Downloading parts ...
if not exist "%PARTSDIR%" mkdir "%PARTSDIR%"

for %%P in (001 002 003) do (
    call :download_one %%P
    if errorlevel 1 goto :fail
)

rem ---------------------------------------------------------------- merge
echo.
echo [2/3] Merging parts ...
if exist "%NAME%" del /f /q "%NAME%"
copy /b "%PARTSDIR%\%NAME%.001"+"%PARTSDIR%\%NAME%.002"+"%PARTSDIR%\%NAME%.003" "%NAME%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to merge the parts.
    goto :fail
)

call :hash_of "%NAME%"
if /i not "%GOT%"=="%HASHZIP%" (
    echo [ERROR] The merged file does not match the expected SHA-256.
    echo         Please delete this folder and download again.
    goto :fail
)
echo   [OK] Merged into %NAME% and verified.

rem ---------------------------------------------------------------- extract
echo.
echo [3/3] Extracting ... this can take several minutes, please wait.
if not exist "%DEST%" mkdir "%DEST%"

set "SZ="
if exist "%ProgramFiles%\7-Zip\7z.exe" set "SZ=%ProgramFiles%\7-Zip\7z.exe"
if not defined SZ if exist "%PF86%\7-Zip\7z.exe" set "SZ=%PF86%\7-Zip\7z.exe"
if not defined SZ (
    where 7z.exe >nul 2>nul
    if not errorlevel 1 set "SZ=7z.exe"
)
if not defined SZ goto :extract_tar

echo   Using 7-Zip: %SZ%
"%SZ%" x -y -o"%DEST%" "%NAME%" >nul
if errorlevel 1 goto :extract_tar
goto :extract_done

:extract_tar
rem Prefer the Windows built-in tar (System32\bsdtar) explicitly: if Git for
rem Windows is installed, "tar.exe" on PATH resolves to GNU tar instead, and
rem GNU tar cannot read zip archives at all.
set "TAREXE=%SystemRoot%\System32\tar.exe"
if exist "%TAREXE%" goto :do_extract_tar
where tar.exe >nul 2>nul
if errorlevel 1 goto :no_extractor
set "TAREXE=tar.exe"

:do_extract_tar
echo   Using tar: %TAREXE%
"%TAREXE%" -xf "%NAME%" -C "%DEST%"
if errorlevel 1 goto :no_extractor

:extract_done
if exist "%DEST%\ArcheryBattle_5_6_1.exe" (
    echo   [OK] Extraction complete.
) else (
    echo   [WARN] Extraction finished, but the launcher was not found in
    echo          %CD%\%DEST%
    echo          Please check that folder, or extract %NAME% manually.
)

echo.
echo ================================================================
echo    Done!
echo    Game folder : %CD%\%DEST%
echo    To play     : double-click ArcheryBattle_5_6_1.exe inside it
echo ================================================================
echo.
set "ANS="
set /p "ANS=Delete the downloaded parts and merged zip to free about 9 GB? [Y/N]: "
if /i "%ANS%"=="Y" (
    if exist "%PARTSDIR%" rmdir /s /q "%PARTSDIR%"
    if exist "%NAME%" del /f /q "%NAME%"
    echo   Cleaned up.
) else (
    echo   Kept. You may delete "%PARTSDIR%" and "%NAME%" manually later.
)
echo.
pause
exit /b 0

rem ================================================================ helpers

:download_one
set "PART=%~1"
set "FILE=%PARTSDIR%\%NAME%.%PART%"
set "URL=%BASE%/%NAME%.%PART%"
set "EXPECT="
if "%PART%"=="001" set "EXPECT=%HASH001%"
if "%PART%"=="002" set "EXPECT=%HASH002%"
if "%PART%"=="003" set "EXPECT=%HASH003%"

if not exist "%FILE%" goto :dl_fetch
call :hash_of "%FILE%"
if /i "%GOT%"=="%EXPECT%" (
    echo   [OK] Part %PART% is already here and verified, skipping.
    exit /b 0
)
echo   [..] Part %PART% is incomplete or damaged, resuming ...

:dl_fetch
echo.
echo   Downloading part %PART% of 3 ...
curl.exe -L -C - --retry 5 --retry-delay 3 --fail -o "%FILE%" "%URL%"
if not errorlevel 1 goto :dl_verify
if exist "%FILE%" del /f /q "%FILE%"
echo   [..] Could not resume, starting this part over ...
curl.exe -L --retry 5 --retry-delay 3 --fail -o "%FILE%" "%URL%"
if errorlevel 1 (
    echo   [ERROR] Could not download part %PART%.
    echo           Get it manually from: %URL%
    exit /b 1
)

:dl_verify
call :hash_of "%FILE%"
if /i "%GOT%"=="%EXPECT%" (
    echo   [OK] Part %PART% downloaded and verified.
    exit /b 0
)
echo   [ERROR] Part %PART% failed SHA-256 verification and was deleted.
echo           Please run this file again to re-download it.
del /f /q "%FILE%"
exit /b 1

:hash_of
set "GOT="
for /f "skip=1 delims=" %%H in ('certutil -hashfile "%~1" SHA256 2^>nul') do (
    if not defined GOT set "GOT=%%H"
)
set "GOT=%GOT: =%"
exit /b 0

:no_extractor
echo   [ERROR] Automatic extraction failed.
echo           Please install 7-Zip from https://www.7-zip.org/ then
echo           right-click "%NAME%" -^> 7-Zip -^> Extract Here.
goto :fail

:fail
echo.
echo Installation did not finish. Please read the messages above.
echo.
pause
exit /b 1
