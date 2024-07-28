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
; Text_LineCountA
;
; Get the line count of text by counting line feeds. This is the Ansi version 
; of Text_LineCount, Text_LineCountW is the Unicode version.
; 
; Parameters:
; 
; * lpszText - The address of the text to count line feeds in.
; 
; Returns:
; 
; The count of line feeds in the text or 0 if there are none.
;
; Notes:
;
; This function as based on the MASM32 Library function: lfcnt
;
; See Also:
;
; Text_LineCountExA, Text_ParseLineA, Text_ReadLineA
; 
;------------------------------------------------------------------------------
Text_LineCountA PROC FRAME USES RCX lpszText:QWORD

    mov rax, -1
    mov rcx, lpszText
    sub rcx, 1

  pre:
    add rax, 1                              ; add 1 to return value if LF found
  @@:
    add rcx, 1
    cmp BYTE PTR [rcx], 0                   ; test for zero terminator
    je ccout
    cmp BYTE PTR [rcx], 10                  ; test line feed
    je pre
    jmp @B

  ccout:

    ret
Text_LineCountA ENDP


END

