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
; Text_ReadLineA
;
; Read a line of text into a buffer. This is the Ansi version of Text_ReadLine, 
; Text_ReadLineW is the Unicode version.
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
; Text_LineCountA, Text_LineCountExA, Text_ParseLineA, Text_TestLineA, Text_WriteLineA
; 
;------------------------------------------------------------------------------
Text_ReadLineA PROC FRAME USES RDX RDI lpszTextSource:QWORD, lpszTextLineBuffer:QWORD, qwTextSourceOffset:QWORD
    mov rdx, lpszTextSource     ; source address in EDX
    mov rdi, lpszTextLineBuffer ; buffer address in EDI
    add rdx, qwTextSourceOffset ; add spos to source
    xor rax, rax                ; clear EAX
    mov rcx, -1                 ; set index and counter to -1
    jmp ristart

  align 8
  pre:
    mov byte ptr [rdi+rcx], al  ; write BYTE to buffer
  ristart:
    add rcx, 1
    mov al, byte ptr [rdx+rcx]  ; read BYTE from source
    cmp al, 9                   ; handle TAB character
    je pre
    cmp al, 13                  ; test for ascii 13 and 0
    ja pre

    mov BYTE PTR [rdi+rcx], 0   ; write terminator to buffer
    test rax, rax               ; test for end of source
    jz liout                    ; return zero if end of source
    lea rax, [rcx+2]            ; add counter + 2 to EAX
    add rax, qwTextSourceOffset ; return next spos in eax

  liout:
    ret
Text_ReadLineA ENDP


END

