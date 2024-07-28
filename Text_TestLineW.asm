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

includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Text_TestLineW
;
; This function tests the first character after any tabs or spaces to determine 
; if the line has usable text or not. If the text has the first non-white space 
; below ascii 32, which includes ascii zero (0), CR (13) and LF (10), it 
; returns zero otherwise it returns the zero extended first character in EAX 
; for testing by the caller.
;
; This can be used to test if the first character is a comment so that the 
; caller can bypass the contents of the line. The return value can be tested 
; either as a QWORD with a numeric value with RAX or directly as a BYTE in AL. 
;
; This is the Unicode version of Text_TestLine, Text_TestLineA is the Ansi 
; version.
; 
; Parameters:
; 
; * lpszTextSource - the address of the source text to test.
; 
; Returns:
; 
; If the return value is ZERO, the line of text has no useful content.
; If the return value is not ZERO, it is the ascii number of the first character 
; zero extended into RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: tstline
;
; See Also:
;
; Text_LineCountW, Text_LineCountExW, Text_ParseLineW
; 
;------------------------------------------------------------------------------
Text_TestLineW PROC FRAME lpszTextSource:QWORD
    mov rax, lpszTextSource     ; lpstr
    sub rax, 2

  @@:
    add rax, 2
    cmp WORD PTR [rax], 32      ; loop back on space
    je @B
    cmp WORD PTR [rax], 9       ; loop back on tab
    je @B
    cmp WORD PTR [rax], 32      ; reject anything with a start char below 32
    jl reject
    movzx rax, WORD PTR [rax]   ; return the first char in EAX for testing.
    ret

  reject:
    xor rax, rax                ; return ZERO on blank line
    ret
Text_TestLineW ENDP


END

