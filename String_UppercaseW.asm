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
; String_UppercaseW
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
; Notes:
;
; This function as based on the MASM32 Library function: ucUpper
;
; See Also:
;
; String_LowercaseW, String_MonospaceW
; 
;------------------------------------------------------------------------------
String_UppercaseW PROC FRAME lpszString:QWORD

    mov rax, lpszString
    dec rax

  @@:
    add rax, 1
    cmp WORD PTR [rax], 0
    je @F
    cmp WORD PTR [rax], "a"
    jb @B
    cmp WORD PTR [rax], "z"
    ja @B
    sub BYTE PTR [rax+0], 32
    mov byte ptr [rax+1], 0h
    jmp @B
  @@:

    mov rax, lpszString
    ret
String_UppercaseW ENDP


END

