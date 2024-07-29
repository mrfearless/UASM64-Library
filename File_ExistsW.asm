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
    FindFirstFileW  PROTO lpFileName:QWORD, lpFindFileData:QWORD
    FindClose       PROTO hFindFile:QWORD
    
    ;IFNDEF INVALID_HANDLE_VALUE
    ;INVALID_HANDLE_VALUE EQU -1
    ;ENDIF
    
    IFNDEF MAX_PATH
    MAX_PATH EQU 260
    ENDIF
    
    IFNDEF WCHAR
    WCHAR typedef WORD
    ENDIF
    
    IFNDEF FILETIME
    FILETIME            STRUCT
        dwLowDateTime   DWORD ?
        dwHighDateTime  DWORD ?
    FILETIME            ENDS
    ENDIF
    
    IFNDEF WIN32_FIND_DATAW
    WIN32_FIND_DATAW        STRUCT 8
        dwFileAttributes    DWORD ?
        ftCreationTime      FILETIME <>
        ftLastAccessTime    FILETIME <>
        ftLastWriteTime     FILETIME <>
        nFileSizeHigh       DWORD ?
        nFileSizeLow        DWORD ?
        dwReserved0         DWORD ?
        dwReserved1         DWORD ?
        cFileName           WCHAR MAX_PATH DUP (?)
        cAlternateFileName  WCHAR 14 DUP (?)
        dwFileType          DWORD ? ; Obsolete. Do not use.
        dwCreatorType       DWORD ? ; Obsolete. Do not use.
        wFinderFlags        WORD ? ; Obsolete. Do not use.
    WIN32_FIND_DATAW        ENDS
    ENDIF
    
    includelib kernel32.lib
ENDIF

IF @Platform EQ 3 ; Linux x64
    IFNDEF O_RDONLY
    O_RDONLY EQU 00000000h
    ENDIF
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_ExistsW
;
; This function tests if a file exists at the path and file name in the zero 
; terminated string.This is the Unicode version of File_Exists, File_ExistsA is 
; the Ansi version.
;
; Parameters:
; 
; * lpszFileName - The zero terminated string that has the path & filename of 
;   the file to test if it exists. 
; 
; Returns:
; 
; If the return value in RAX is 0, the file does not exist, if it is 1, then it 
; does exist.
;
; Notes:
;
; This function as based on the MASM32 Library function: existW
;
; See Also:
;
; File_ExistsA, File_SizeA, File_SizeW
; 
;------------------------------------------------------------------------------
File_ExistsW PROC FRAME lpszFileName:QWORD
    IF @Platform EQ 1 ; Win x64
        LOCAL wfd:WIN32_FIND_DATAW
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        Invoke FindFirstFileW, lpszFileName, Addr wfd
        .IF rax == -1 ; INVALID_HANDLE_VALUE
            mov rax, 0                    ; 0 = NOT exist
        .ELSE
            Invoke FindClose, rax
            mov rax, 1                    ; 1 = exist
        .ENDIF
    ENDIF
    
    IF @Platform EQ 3 ; Linux x64
        mov rdi, lpszFileName
        mov rsi, O_RDONLY ; flags
        mov rdx, 0 ; mode
        mov rax, 2 ; open
        syscall
        .IF rax == -1 ; file does not exist
            mov rax, 0
            ret
        .ENDIF

        mov rdi, rax ; hFile ; fd
        mov rsi, 0
        mov rdx, 0
        mov rax, 3 ; close
        syscall
        mov rax, 1 ; file exists
    ENDIF

    ret
File_ExistsW ENDP


END

