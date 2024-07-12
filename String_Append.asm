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
; String_Append
;
; Appends a zero terminated string to the end of an existing zero terminated 
; string.
; 
; Parameters:
; 
; * lpszDestination - The main string buffer to append the extra string to.
; 
; * lpszSource - The string to append to the main string buffer.
; 
; * qwDestinationOffset - The location offset to begin the append at.
; 
; Returns:
; 
; The location of the end of the source buffer which can be used for the next 
; call to String_Append as the qwDestinationOffset parameter.
;
; Notes:
;
; This algorithm is designed to repeatedly append zero terminated string data 
; to the end of a user defined buffer. It uses a location pointer to save 
; repeatedly scanning the buffer for the end position. With a new buffer, the 
; first byte should be set to ascii zero, with an existing zero terminated 
; string in a buffer, you should supply the length and set the location 
; parameter to that length.

; The return value is the buffer end position which you pass back to the 
; function for the next appended data.
; 
;------------------------------------------------------------------------------
String_Append PROC FRAME USES RCX RDX RDI RSI lpszDestination:QWORD,lpszSource:QWORD,qwDestinationOffset:QWORD

    mov rdi, 1
    mov rax, -1
    mov rsi, lpszDestination        ; string
    mov rcx, lpszSource             ; buffer
    add rsi, qwDestinationOffset    ; location ; add offset pointer to source address

  @@:
    add rax, rdi
    movzx rdx, BYTE PTR [rcx+rax]
    mov [rsi+rax], dl
    test rdx, rdx
    jnz @B                          ; exit on written terminator

    add rax, qwDestinationOffset    ; location ; return updated offset pointer

    ret
String_Append ENDP


END

