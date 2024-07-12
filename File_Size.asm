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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include windows.inc
includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_Size
;
; This function returns the size of a file if it exists.
;
; Parameters:
; 
; * lpszFileName - The zero terminated string that has the path & filename of 
;   the file to return the size of. 
; 
; Returns:
; 
; If the return value is minus one (-1) then the file does not exist, 
; otherwise RAX contains the size of the file in bytes.
; 
; Notes:
; 
; This function will return the size of a file without opening it.
;
;------------------------------------------------------------------------------
File_Size PROC FRAME lpszFileName:QWORD
    LOCAL wfd:WIN32_FIND_DATA

    invoke FindFirstFile, lpszFileName, Addr wfd
    .if rax == INVALID_HANDLE_VALUE
      mov rax, -1
      jmp fsEnd
    .endif

    invoke FindClose, rax

    mov rax, qword ptr wfd.nFileSizeHigh

    fsEnd:

    ret
File_Size ENDP


END

