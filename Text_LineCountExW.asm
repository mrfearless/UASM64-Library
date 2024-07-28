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
; Text_LineCountExW
;
; Get the line count of text by counting line feeds. This is the Unicode 
; version of Text_LineCountEx, Text_LineCountExA is the Ansi version.
; 
; Parameters:
; 
; * lpszText - The address of the text to count line feeds in.
; 
; * qwTextLength - the length of the text string pointed to by lpszText.
;
; Returns:
; 
; The count of line feeds in the text or 0 if there are none.
;
; Notes:
;
; This function will add an additional CRLF pair at the end of the text if 
; it previously did not have one.
;
; This function as based on the MASM32 Library function: get_line_count
;
; See Also:
;
; Text_LineCountW, Text_ParseLineW, Text_ReadLineW
; 
;------------------------------------------------------------------------------
Text_LineCountExW PROC FRAME USES RDX lpszText:QWORD, qwTextLength:QWORD
    mov rcx, qwTextLength
    add rcx, qwTextLength ; double it
    mov rdx, rcx
    sub rdx, 4
    mov rax, lpszText
    cmp DWORD PTR [rax+rdx], 000A000Dh  ; if no trailing CRLF
    je cntlf

    mov DWORD PTR [rax+rcx], 000A000Dh  ; append CRLF
    mov WORD PTR [rax+rcx+4], 0         ; add terminator
    add qwTextLength, 4                 ; correct blen by 2

  cntlf:
    ;or rcx, -1
    mov rcx, -2
    xor rax, rax
    mov rdx, lpszText
  @@:
    add rcx, 2
    cmp WORD PTR [rdx+rcx], 0
    je @F
    cmp WORD PTR [rdx+rcx], 10          ; count the line feed character
    jne @B
    add rax, 1
    jmp @B
  @@:

    mov rcx, qwTextLength               ; return count in EAX, length in ECX
    shr rcx, 1 ; /2
    ret
Text_LineCountExW ENDP


END

