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
; String_Right
;
; Gets a substring from the right side of a zero terminated string. String_Right 
; reads a set number of characters from the end (right) position in the source 
; zero terminated string and writes them to the destination string address.
; 
; Parameters:
; 
; * lpszSource - Address of the source string
; 
; * lpszDestination - Address of the destination buffer.
; 
; * qwLengthToRead - The number of characters to read from the right side.
; 
; Returns:
; 
; Returns a pointer to the destination string in RAX.
; 
;------------------------------------------------------------------------------
String_Right PROC FRAME USES RBX RCX RDX lpszSource:QWORD,lpszDestination:QWORD,qwLengthToRead:QWORD

    invoke szLen, lpszSource        ; get source length
    sub rax, qwLengthToRead         ; sub required length from it
    mov rdx, lpszSource             ; source address in RDX
    add rdx, rax                    ; add difference to source address
    or rcx, -1                      ; index to minus one
    mov rax, lpszDestination        ; destination address in RAX

    ;push ebx

  @@:
    add rcx, 1
    movzx rbx, BYTE PTR [rdx+rcx]   ; copy bytes
    mov [rax+rcx], bl
    test rbx, rbx                   ; exit after zero written
    jne @B

    ;pop ebx

    mov rax, lpszDestination

    ret
String_Right ENDP


END

