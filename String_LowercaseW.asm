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
; String_LowercaseW
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
; Notes:
;
; This function as based on the MASM32 Library function: ucLower
;
; See Also:
;
; String_UppercaseW, String_MonospaceW
; 
;------------------------------------------------------------------------------
String_LowercaseW PROC FRAME lpszString:QWORD
    mov rax, lpszString
    sub rax, 2

  @@:
    add rax, 2
    cmp WORD PTR [rax], 0
    je @F
    cmp WORD PTR [rax], 41h ; "A"
    jb @B
    cmp WORD PTR [rax], 5Ah ; "Z"
    ja @B
    add byte ptr [rax+0], 32
    mov byte ptr [rax+1], 0h
    jmp @B
  @@:

    mov rax, lpszString
    ret
String_LowercaseW ENDP


END

