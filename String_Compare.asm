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
; String_Compare
;
; A case sensitive string comparison that compares two zero terminated strings 
; for a difference.
; 
;
; Parameters:
; 
; * lpszString1 - The address of the first zero terminated string to compare.
; 
; * lpszString2 - The address of the second zero terminated string to compare.
; 
; Returns:
; 
; If the two strings match, the return value is the length of the string. 
; If there is no match, the return value is zero.
; 
; Notes:
;
; The function can be used on strings that may be of uneven length as the 
; terminator will produce the mismatch even if the rest of the characters match.
;
;------------------------------------------------------------------------------
String_Compare PROC FRAME USES RBX RCX RDX RSI lpszString1:QWORD,lpszString2:QWORD

  ; --------------------------------------
  ; scan zero terminated string for match
  ; --------------------------------------
    mov rcx, lpszString1
    mov rdx, lpszString2

    mov rax, -1
    mov rsi, 1

  align 8
  cmst:
  REPEAT 3
    add rax, rsi
    movzx rbx, BYTE PTR [rcx+rax]
    cmp bl, [rdx+rax]
    jne no_match
    test rbx, rbx       ; check for terminator
    je retlen
  ENDM

    add rax, rsi
    movzx rbx, BYTE PTR [rcx+rax]
    cmp bl, [rdx+rax]
    jne no_match
    test rbx, rbx       ; check for terminator
    jne cmst

  retlen:               ; length is in EAX
    ret

  no_match:
    xor rax, rax        ; return zero on no match
    
    ret
String_Compare ENDP


END

