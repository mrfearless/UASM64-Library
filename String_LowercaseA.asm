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
; String_LowercaseA
;
; Converts any uppercase characters in the supplied zero terminated string to 
; lowercase. String_Lowercase works on the original string and writes it back 
; to the same address. This is the Ansi version of String_Lowercase, 
; String_LowercaseW is the Unicode version.
; 
; Parameters:
; 
; * lpszString - The address of the text to convert to lowercase.
; 
; Returns:
; 
; The address of the lowercase string in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: szLower
;
; See Also:
;
; String_UppercaseA, String_MonospaceA
; 
;------------------------------------------------------------------------------
String_LowercaseA PROC FRAME lpszString:QWORD
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
String_LowercaseA ENDP


END

