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
; String_Lowercase
;
; Converts any uppercase characters in the supplied zero terminated string to 
; lowercase. String_Lowercase works on the original string and writes it back 
; to the same address.
; 
; Parameters:
; 
; * lpszString - The address of the text to convert to lowercase.
; 
; Returns:
; 
; The address of the lowercase string in RAX.
; 
;------------------------------------------------------------------------------
String_Lowercase PROC FRAME lpszString:QWORD
    mov rax, lpszString
    dec rax

  @@:
    add rax, 1
    cmp BYTE PTR [rax], 0
    je @F
    cmp BYTE PTR [rax], "A"
    jb @B
    cmp BYTE PTR [rax], "Z"
    ja @B
    add BYTE PTR [rax], 32
    jmp @B
  @@:

    mov rax, lpszString

    ret
String_Lowercase ENDP


END

