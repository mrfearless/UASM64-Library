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
; String_RightTrim
;
; Trims the trailing spaces and tabs from a zero terminated string and places 
; the results in the destination buffer provided.
; 
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination -  The address of the destination buffer.
; 
; Returns:
; 
; The return value is the length of the trimmed string which can be zero.
;
; Notes:
;
; If the string is trimmed to zero length if it has no other characters, the 
; first byte of the destination address will be ascii zero. Ensure the 
; destination buffer is big enough to receive the substring, normally it is 
; advisable to make the buffer the same size as the source string. If your 
; design allows for overwriting the string, you can use the same string 
; address for both source and destination.
; 
;------------------------------------------------------------------------------
String_RightTrim PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD,lpszDestination:QWORD

    mov rsi, lpszSource
    mov rdi, lpszDestination
    sub rsi, 1
  @@:
    add rsi, 1
    cmp BYTE PTR [rsi], 32
    je @B
    cmp BYTE PTR [rsi], 9
    je @B
    cmp BYTE PTR [rsi], 0
    jne @F
    xor rax, rax            ; return zero on empty string
    mov BYTE PTR [rdi], 0   ; set string length to zero
    jmp szLout

  @@:
    mov rsi, lpszSource
    xor rcx, rdx
    xor rcx, rcx        ; ECX as index and location counter

  @@:
    mov al, [rsi+rcx]   ; copy bytes from src to dst
    mov [rdi+rcx], al
    add rcx, 1
    test al, al
    je @F               ; exit on zero
    cmp al, 33
    jb @B
    mov rdx, rcx        ; store count if asc 33 or greater
    jmp @B

  @@:
    mov BYTE PTR [rdi+rdx], 0

    mov rax, rdx        ; return length of trimmed string
    mov rcx, lpszDestination

  szLout:

    ret
String_RightTrim ENDP


END

