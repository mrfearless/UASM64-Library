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
; Text_ReadLineW
;
; Read a line of text into a buffer. This is the Unicode version of 
; Text_ReadLine, Text_ReadLineA is the Ansi version.
; 
; Parameters:
; 
; * lpszTextSource - the address of the memory to read the text from.
; 
; * lpszTextLineBuffer - the destination buffer to write the line of text to.
; 
; * qwTextSourceOffset - the current source location pointer.
; 
; Returns:
; 
; In RAX the updated offset in the source text.
; In RCX the line length not including the terminating 0 or carriage return.
;
; Notes:
;
; Text_ReadLine copies a line of text from the source (lpszTextSource) to the 
; buffer (lpszTextLineBuffer) starting from the offset set in the 
; qwTextSourceOffset parameter. Initially qwTextSourceOffset should be set to 0
;
; The return value from Text_ReadLine should be used to update the 
; qwTextSourceOffset parameter to start again at the following line of text.
;
; RAX returns ZERO if the end of the source is on the curent line.
;
; The length of the line not including ascii 0 and 13 is returned in RCX. 
;
; You should test the buffer if ZERO is returned in RAX as it may contain the 
; last line of text that is zero terminated.
;
; Conditions to test for:
;
; - End of source returns zero in RAX.
; - blank line has 1st byte in buffer set to zero and a line length in RCX of 0
; - Line length is returned in RCX.
;
; This function as based on the MASM32 Library function: readline
;
; See Also:
;
; Text_LineCountW, Text_LineCountExW, Text_ParseLineW, Text_TestLineW, Text_WriteLineW
; 
;------------------------------------------------------------------------------
Text_ReadLineW PROC FRAME USES RDX RDI RSI lpszTextSource:QWORD, lpszTextLineBuffer:QWORD, qwTextSourceOffset:QWORD
    mov rsi, lpszTextSource     ; src
    mov rdx, lpszTextLineBuffer ; dst
    add rsi, qwTextSourceOffset ; cloc
    sub rsi, 2
    sub rdx, 2

  lbl0:
    add rsi, 2
    add rdx, 2
    movzx rax, WORD PTR [rsi]
    test rax, rax               ; test for terminator
    jz iszero
    cmp rax, 13                 ; test for leading CR
    je quit
    mov [rdx], ax               ; write WORD to destination buffer
    jmp lbl0

  iszero:                       ; EAX is set to ZERO by preceding loop
    mov QWORD PTR [rdx], 0      ; write terminator to destination buffer
    ret

  quit:
    mov QWORD PTR [rdx], 0      ; write the terminator
    add rsi, 4                  ; increment ESI up 2 WORD characters

    mov rax, rsi
    sub rax, lpszTextSource     ; return the current location in the source
    
    ret
Text_ReadLineW ENDP


END

