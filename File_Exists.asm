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
; File_Exists
;
; This function tests if a file exists at the path and file name in the zero 
; terminated string.
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
;------------------------------------------------------------------------------
File_Exists PROC FRAME lpszFileName:QWORD
    LOCAL wfd:WIN32_FIND_DATA

    invoke FindFirstFile, lpszFileName, Addr wfd
    .if rax == INVALID_HANDLE_VALUE
      mov rax, 0                    ; 0 = NOT exist
    .else
      invoke FindClose, rax
      mov rax, 1                    ; 1 = exist
    .endif

    ret
File_Exists ENDP


END

