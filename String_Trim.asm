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
; String_Trim
;
; Trims the leading and trailing spaces and tabs from a zero terminated string.
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
; first byte of the destination address will be ascii zero. This procedure acts 
; on the original source string and overwrites it with the result. 
;
;------------------------------------------------------------------------------
String_Trim PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD

    mov rsi, lpszSource
    mov rdi, lpszSource
    xor rcx, rcx

    sub rsi, 1
  @@:
    add rsi, 1
    cmp BYTE PTR [rsi], 32  ; strip space
    je @B
    cmp BYTE PTR [rsi], 9   ; strip tab
    je @B
    cmp BYTE PTR [rsi], 0   ; test for zero after tabs and spaces
    jne @F
    xor rax, rax            ; set EAX to zero on 0 length result
    mov BYTE PTR [rdi], 0   ; set string length to zero
    jmp tsOut               ; and exit

  @@:
    mov al, [rsi+rcx]       ; copy bytes from src to dst
    mov [rdi+rcx], al
    add rcx, 1
    test al, al
    je @F                   ; exit on zero
    cmp al, 33              ; don't store positions lower than 33 (32 + 9)
    jb @B
    mov rdx, rcx            ; store count if asc 33 or greater
    jmp @B

  @@:
    mov BYTE PTR [rdi+rdx], 0

    mov rax, rdx        ; return trimmed string length
    mov rcx, lpszSource

  tsOut:

    ret
String_Trim ENDP


END

