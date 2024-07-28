;==============================================================================
;
; UASM64 Library
;
; https://github.com/mrfearless/UASM64-Library
;
;==============================================================================
.686
.MMX
.XMM
.x64

option casemap : none
IF @Platform EQ 1
option win64 : 11
ENDIF
option frame : auto

IF @Platform EQ 1 ; Win x64
    CreateFileW PROTO lpFileName:QWORD, dwDesiredAccess:DWORD, dwShareMode:DWORD, lpSecurityAttributes:QWORD, dwCreationDisposition:DWORD, dwFlagsAndAttributes:DWORD, hTemplateFile:QWORD
;    IFNDEF INVALID_HANDLE_VALUE
;    INVALID_HANDLE_VALUE EQU -1
;    ENDIF
    IFNDEF GENERIC_READ
    GENERIC_READ EQU 80000000h
    ENDIF
    IFNDEF GENERIC_WRITE
    GENERIC_WRITE EQU 40000000h
    ENDIF
    IFNDEF OPEN_EXISTING
    OPEN_EXISTING EQU 3
    ENDIF
    IFNDEF FILE_ATTRIBUTE_NORMAL
    FILE_ATTRIBUTE_NORMAL EQU 00000080h
    ENDIF
    includelib kernel32.lib
ENDIF

IF @Platform EQ 3 ; Linux x64
    IFNDEF O_RDWR
    O_RDWR EQU 00000002h
    ENDIF
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_OpenW
;
; Open an existing file with read / write access and return the file handle. This 
; is the Unicode version of File_Open, File_OpenA is the Ansi version.
; 
; Parameters:
; 
; * lpszFilename - Parameter details.
; 
; Returns:
; 
; A file handle if successful or INVALID_HANDLE_VALUE if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library macro: fcreateW
;
; See Also:
;
; File_OpenA, File_CreateA, File_CreateW, File_Close, File_Read, File_Write
; 
;------------------------------------------------------------------------------
File_OpenW PROC FRAME USES RDX RDI RSI lpszFilename:QWORD
    IF @Platform EQ 1 ; Win x64
        Invoke CreateFileW, lpszFilename, GENERIC_READ or GENERIC_WRITE, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, lpszFilename
        mov rsi, O_RDWR ; flags
        mov rdi, 0 ; mode
        mov rax, 2 ; open
        syscall
    ENDIF
    ret
File_OpenW ENDP


END

