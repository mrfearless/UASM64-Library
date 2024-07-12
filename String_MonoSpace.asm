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
; String_MonoSpace
;
; Format a string with single spaces and trimmed ends. String_MonoSpace formats
; a zero terminated string with single spaces only, replacing any tabs with 
; spaces and trimming tabs and spaces from either end of the string.
;
; Parameters:
; 
; * lpszSource - The address of the zero terminated string to format.
; 
; Returns:
; 
; The return value is the address of the source string.
; 
; Notes:
;
; The algorithm removes any leading tabs and spaces then formats the string 
; with single spaces replacing any tabs in the source with spaces. 
; If there is a trailing space, the string is truncated to remove it.
;
;------------------------------------------------------------------------------
String_MonoSpace PROC FRAME USES RBX RCX RDX RDI RSI RBP lpszSource:QWORD

    mov rsi, 1
    mov rdi, 32
    mov bl, 32
    mov rbp, 9

    mov rcx, lpszSource
    xor rax, rax
    sub rcx, rsi
    mov rdx, lpszSource
    jmp ftrim                       ; trim the start of the string

  wspace:
    mov BYTE PTR [rdx], bl          ; always write a space
    add rdx, rsi

  ftrim:
    add rcx, rsi
    movzx rax, BYTE PTR [rcx]
    cmp rax, rdi                    ; throw away space
    je ftrim
    cmp rax, rbp                    ; throw away tab
    je ftrim
    sub rcx, rsi

  stlp:
    add rcx, rsi
    movzx rax, BYTE PTR [rcx]
    cmp rax, rdi                    ; loop back on space
    je wspace
    cmp rax, rbp                    ; loop back on tab
    je wspace
    mov [rdx], al                   ; write the non space character
    add rdx, rsi
    test rax, rax                   ; if its not zero, loop back
    jne stlp

    cmp BYTE PTR [rdx-2], bl        ; test for a single trailing space
    jne quit
    mov BYTE PTR [rdx-2], 0         ; overwrite it with zero if it is

  quit:
    mov rax, lpszSource

    ret
String_MonoSpace ENDP


END

