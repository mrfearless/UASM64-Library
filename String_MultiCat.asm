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
; String_MultiCat
;
; Concatenate multiple strings. String_MultiCat uses a buffer that can be 
; appended with multiple zero terminated strings, which is more efficient when 
; multiple strings need to be concantenated.
; 
; Parameters:
; 
; * qwNumberOfStrings - The number of zero terminated strings to append.
; 
; * lpszDestination - The address of the buffer to appends the strings to.
; 
; * StringArgs - The comma seperated parameter list, each with the address of a zero
;   terminated string to append to the main destination string.
; 
; Returns:
; 
; This function does not return a value.
;
; Notes:
;
; The allocated buffer pointed to by the lpszDestination parameter must be 
; large enough to accept all of the appended zero terminated strings. 

; The parameter count using StringArgs must match the number of zero terminated 
; strings as specified by the qwNumberOfStrings parameter.
; 
; This original algorithm was designed by Alexander Yackubtchik. It was 
; re-written in August 2006.
;
;------------------------------------------------------------------------------
String_MultiCat PROC FRAME USES RBX RCX RDX RDI RSI RBP qwNumberOfStrings:QWORD,lpszDestination:QWORD,StringArgs:VARARG

    mov rbx, 1

    mov rbp, qwNumberOfStrings

    mov rdi, lpszDestination    ; lpszDestination
    xor rcx, rcx
    lea rdx, StringArgs         ; StringArgs
    sub rdi, rbx
  align 8
  @@:
    add rdi, rbx
    movzx rax, BYTE PTR [rdi]   ; unroll by 2
    test rax, rax
    je nxtstr

    add rdi, rbx
    movzx rax, BYTE PTR [rdi]
    test rax, rax
    jne @B
  nxtstr:
    sub rdi, rbx
    mov rsi, [rdx+rcx*8]
  @@:
    add rdi, rbx
    movzx rax, BYTE PTR [rsi]   ; unroll by 2
    mov [rdi], al
    add rsi, rbx
    test rax, rax
    jz @F

    add rdi, rbx
    movzx rax, BYTE PTR [rsi]
    mov [rdi], al
    add rsi, rbx
    test rax, rax
    jne @B

  @@:
    add rcx, rbx
    cmp rcx, rbp                ; qwNumberOfStrings
    jne nxtstr

    mov rax, lpszDestination    ; lpszDestination

    ret
String_MultiCat ENDP


END

