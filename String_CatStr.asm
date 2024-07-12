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
; String_CatStr
;
; Concatenate two strings by appending the second zero terminated string 
; (lpszSource) to the end of the first zero terminated string (lpszDestination)
;
; The result is zero terminated.
;
; Parameters:
; 
; * lpszDestination - The address of the destination string to be appended to.
; 
; * lpszSource - The address of the string to append to destination string.
; 
; Returns:
; 
; No return value.
; 
;------------------------------------------------------------------------------
String_CatStr PROC FRAME USES RCX RDX RDI lpszDestination:QWORD,lpszSource:QWORD

    Invoke String_Length, lpszDestination   ; get source length
    mov rdi, lpszDestination
    mov rcx, lpszSource
    add rdi, rax                            ; set write starting position
    xor rdx, rdx                            ; zero index

  @@:
    movzx rax, BYTE PTR [rcx+rdx]           ; write append string to end of source
    mov [rdi+rdx], al
    add rdx, 1
    test rax, rax                           ; exit when terminator is written
    jne @B

    mov rax, lpszDestination                ; return start address of source

    ret
String_CatStr ENDP


END

