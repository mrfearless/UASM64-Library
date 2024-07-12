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
; String_Length
;
; Reads the length of a zero terminated string and returns its length in RAX.
;
; Parameters:
; 
; * lpszString - Address of zero terminated string.
; 
; Returns:
; 
; The length of the zero terminated string without the terminating null in RAX.
; 
;------------------------------------------------------------------------------
String_Length PROC FRAME USES R10 lpszString:QWORD

  ; rcx = address of string

    mov rax, lpszString
    sub rax, 1
  lbl:
  REPEAT 3
    add rax, 1
    movzx r10, BYTE PTR [rax]
    test r10, r10
    jz lbl1
  ENDM

    add rax, 1
    movzx r10, BYTE PTR [rax]
    test r10, r10
    jnz lbl

  lbl1:
    sub rax, lpszString

    ret
String_Length ENDP


END

