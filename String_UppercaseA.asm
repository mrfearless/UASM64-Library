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
IF @Platform EQ 1
option win64 : 11
ENDIF
option frame : auto

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_UppercaseA
;
; Converts any lowercase characters in the supplied zero terminated string to 
; uppercase. String_Uppercase works on the original string and writes it back 
; to the same address. This is the Ansi version of String_Uppercase, 
; String_UppercaseW is the Unicode version.
; 
; Parameters:
; 
; * lpszString - The address of the text to convert to uppercase.
; 
; Returns:
; 
; The address of the uppercase string in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: szUpper
;
; See Also:
;
; String_LowercaseA, String_MonospaceA
; 
;------------------------------------------------------------------------------
String_UppercaseA PROC FRAME lpszString:QWORD

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
String_UppercaseA ENDP


END

