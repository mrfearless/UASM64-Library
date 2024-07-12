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
; String_Uppercase
;
; Converts any lowercase characters in the supplied zero terminated string to 
; uppercase. String_Uppercase works on the original string and writes it back 
; to the same address.
; 
; Parameters:
; 
; * lpszString - The address of the text to convert to uppercase.
; 
; Returns:
; 
; The address of the uppercase string in RAX.
; 
;------------------------------------------------------------------------------
String_Uppercase PROC FRAME lpszString:QWORD

  ; -----------------------------
  ; converts string to upper case
  ; invoke szUpper,ADDR szString
  ; -----------------------------

    mov rax, lpszString
    dec rax

  @@:
    add rax, 1
    cmp BYTE PTR [rax], 0
    je @F
    cmp BYTE PTR [rax], "a"
    jb @B
    cmp BYTE PTR [rax], "z"
    ja @B
    sub BYTE PTR [rax], 32
    jmp @B
  @@:

    mov rax, lpszString

    ret
String_Uppercase ENDP


END

