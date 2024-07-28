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
; Text_LineCountExA
;
; Get the line count of text by counting line feeds. This is the Ansi version 
; of Text_LineCountEx, Text_LineCountExW is the Unicode version.
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
; Text_LineCountA, Text_ParseLineA, Text_ReadLineA
; 
;------------------------------------------------------------------------------
Text_LineCountExA PROC FRAME USES RDX lpszText:QWORD, qwTextLength:QWORD
  ; mem = address of loaded file
  ; blen = length of loaded file

    mov rcx, qwTextLength
    mov rdx, rcx
    sub rdx, 2
    mov rax, lpszText
    cmp WORD PTR [rax+rdx], 0A0Dh       ; if no trailing CRLF
    je cntlf

    mov WORD PTR [rax+rcx], 0A0Dh       ; append CRLF
    mov BYTE PTR [rax+rcx+2], 0         ; add terminator
    add qwTextLength, 2                 ; correct blen by 2

  cntlf:
    or rcx, -1
    xor rax, rax
    mov rdx, lpszText
  @@:
    add rcx, 1
    cmp BYTE PTR [rdx+rcx], 0
    je @F
    cmp BYTE PTR [rdx+rcx], 10          ; count the line feed character
    jne @B
    add rax, 1
    jmp @B
  @@:

    mov rcx, qwTextLength               ; return count in EAX, length in ECX
    ret
Text_LineCountExA ENDP


END

