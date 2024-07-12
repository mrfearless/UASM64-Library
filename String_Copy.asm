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

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_Copy
;
; Copies a zero terminated string from the source buffer to the destination 
; buffer.
;
; Parameters:
; 
; * lpszSource - The address of the source string.
;
; * lpszDestination - The address of the destination string buffer.
; 
; Returns:
; 
; The copied length minus the terminating null is returned in RAX.
;
; Notes:
;
; The destination buffer must be large enough to hold the source string 
; otherwise a page write fault will occur.
; 
;------------------------------------------------------------------------------
String_Copy PROC FRAME USES RBX RCX RDX RSI lpszSource:QWORD,lpszDestination:QWORD

    mov rdx, lpszSource
    mov rbx, lpszDestination
    mov rax, -1
    mov rsi, 1

  @@:
    add rax, rsi
    movzx rcx, BYTE PTR [rdx+rax]
    mov [rbx+rax], cl
    test rcx, rcx
    jnz @B

    ret
String_Copy ENDP


END

