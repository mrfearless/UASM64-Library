@ECHO OFF
CLS
REM ;==========================================================================
REM ;
REM ; UASM64 Library for Linux
REM ;
REM ; https://github.com/mrfearless/UASM64-Library
REM ;
REM ;==========================================================================
REM For manually the building UASM64 Library for Linux from the command line

ECHO ==========================================================================
ECHO.
ECHO  UASM64 Library for Linux
ECHO.
ECHO  https://github.com/mrfearless/UASM64-Library
ECHO.
ECHO ==========================================================================

:TIDYUP
REM ;==========================================================================
REM ; Delete older UASM64.a library and *.o object files
REM ;==========================================================================
REM
IF EXIST UASM64.a DEL /Q UASM64.a 
for /f "delims=" %%a in ('dir *.o /b /a-d') do DEL /Q "%%a"
for /f "delims=" %%a in ('dir *.err /b /a-d') do DEL /Q "%%a"
goto :ENUMERATE

:ENUMERATE
REM ;==========================================================================
REM ; Enumerate all.asm files and call NEXT for each file
REM ;==========================================================================
REM
for /f "delims=" %%a in ('dir *.asm /b /a-d') do call :NEXT "%%a"
goto :ARCHIVE

:NEXT
REM ;==========================================================================
REM ; Assemble and output each file to an .o object file with UASM64.EXE
REM ;==========================================================================
REM
set "ext=%~x1"
set "ext=%ext:~1%"
\UASM\bin\UASM64.EXE /c /Cp /nologo -Zp8 -elf64 /I"\UASM64\Include" /Fo"%~n1.o" "%1"
GOTO :EOF

:ARCHIVE
REM ;==========================================================================
REM ; Add all .o object files to the UASM64.a library using the AR.EXE tool
REM ;==========================================================================
REM
setlocal enabledelayedexpansion enableextensions
set LIST=
for %%x in (*.o) do set LIST=!LIST! %%x
set LIST=%LIST:~1%
ECHO.
ECHO Creating UASM64.a Library with the following: 
ECHO %LIST%
\mingw\bin\ar.exe rcs UASM64.a %LIST%
ECHO.

for /f "delims=" %%a in ('dir *.o /b /a-d') do DEL /Q "%%a"
for /f "delims=" %%a in ('dir *.err /b /a-d') do DEL /Q "%%a"

:EOF

