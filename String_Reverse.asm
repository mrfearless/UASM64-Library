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
; String_Reverse
;
; Reverses a zero terminated string in lpszSource and places it in the string
; buffer pointed to by the lpszDestination parameter.
; 
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination - The address of the destination string buffer.
; 
; Returns:
; 
; Returns a pointer to the destination string in RAX.
;
; Notes:
;
; The destination string buffer must be at least the size of the source string 
; buffer, otherwise a read page fault will occur. String_Reverse can reverses a 
; string in a single memory buffer, so it can accept the same address as both 
; the source and destination string.
; 
;------------------------------------------------------------------------------
String_Reverse PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD,lpszDestination:QWORD

    mov rsi, lpszSource
    mov rdi, lpszDestination
    xor rax, rax            ; use EAX as a counter

  ; ---------------------------------------
  ; first loop gets the buffer length and
  ; copies the first buffer into the second
  ; ---------------------------------------
  @@:
    mov dl, [rsi+rax]       ; copy source to dest
    mov [rdi+rax], dl
    add rax, 1              ; get the length in ECX
    test dl, dl
    jne @B

    mov rsi, lpszDestination; put dest address in ESI
    mov rdi, lpszDestination; same in EDI
    sub rax, 1              ; correct for exit from 1st loop
    lea rdi, [rdi+rax-1]    ; end address in edi
    shr rax, 1              ; int divide length by 2
    neg rax                 ; invert sign
    sub rsi, rax            ; sub half len from ESI

  ; ------------------------------------------
  ; second loop swaps end pairs of bytes until
  ; it reaches the middle of the buffer
  ; ------------------------------------------
  @@:
    mov cl, [rsi+rax]       ; load end pairs
    mov dl, [rdi]
    mov [rsi+rax], dl       ; swap end pairs
    mov [rdi], cl
    sub rdi, 1
    add rax, 1
    jnz @B                  ; exit on half length

    mov rax, lpszDestination; return destination address

    ret
String_Reverse ENDP


END

