@ECHO OFF
CLS
REM ;==========================================================================
REM ;
REM ; UASM64 Library for Windows
REM ;
REM ; https://github.com/mrfearless/UASM64-Library
REM ;
REM ;==========================================================================
REM For manually the building UASM64 Library for Linux from the command line

ECHO ==========================================================================
ECHO.
ECHO  UASM64 Library for Windows
ECHO.
ECHO  https://github.com/mrfearless/UASM64-Library
ECHO.
ECHO ==========================================================================
ECHO.

:TIDYUP
REM ;==========================================================================
REM ; Delete older UASM64.lib library and *.obj object files
REM ;==========================================================================
REM
IF EXIST UASM64.a DEL /Q UASM64.lib
for /f "delims=" %%a in ('dir *.obj /b /a-d') do DEL /Q "%%a"
for /f "delims=" %%a in ('dir *.err /b /a-d') do DEL /Q "%%a"

\UASM\BIN\UASM64.EXE /c /coff /Cp /nologo -Zp8 -win64 /win64 /D_WIN64 /I"\UASM64\Include" *.asm
\UASM\BIN\LIB *.obj /out:UASM64.lib

for /f "delims=" %%a in ('dir *.obj /b /a-d') do DEL /Q "%%a"
for /f "delims=" %%a in ('dir *.err /b /a-d') do DEL /Q "%%a"