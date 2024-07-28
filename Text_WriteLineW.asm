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
; Text_WriteLineW
;
; Writes a line of text to a memory buffer and updates the last write position.
; This is the Ansi version of Text_WriteLine, Text_WriteLineA is the Unicode 
; version.
;
; Parameters:
; 
; * lpszTextLineBuffer - The address of the text line to write to the buffer.
; 
; * lpszTextDestination - The address of the destination buffer to write to.
; 
; * qwTextDestinationOffset - The current destination location pointer.
;
; * bNoCRLF - TRUE = no CRLF appended, FALSE = CRLF is appended.
; 
; Returns:
; 
; In RAX the updated offset in the desintation buffer.
; In RCX the number of BYTES written.
;
; Notes:
;
; This algorithm is useful for writing text files directly to memory so the 
; result can be written in one disk write. Normally the qwTextDestinationOffset  
; variable is allocated before the procedure is called, initialised to zero and  
; updated each time the procedure returns with the new value.
;
; This function as based on the MASM32 Library function: writeline
;
; See Also:
;
; Text_LineCountW, Text_LineCountExW, Text_ReadLineW
; 
;------------------------------------------------------------------------------
Text_WriteLineW PROC FRAME USES RDX RDI lpszTextLineBuffer:QWORD, lpszTextDestination:QWORD, qwTextDestinationOffset:QWORD, bNoCRLF:QWORD
    mov rdx, lpszTextLineBuffer         ; source address in EDX
    mov rdi, lpszTextDestination        ; buffer address in EDI
    add rdi, qwTextDestinationOffset    ; add starting position to buffer address
    xor rax, rax                        ; clear index and counter
    xor rcx, rcx                        ; prevent stall

  @@:
    mov cx, [rdx+rax]
    mov [rdi+rax], cx
    add rax, 2
    test cx, cx                         ; exit loop if zero is written
    jnz @B

    cmp bNoCRLF, 0                      ; test flag a CRLF is to be appended
    jne @F
    mov DWORD PTR [rdi+rax-2], 000A000Dh; append CRLF to current location
    add rax, 4
    mov WORD PTR [rdi+rax], 0           ; zero terminate CRLF
  @@:

    sub rax, 2
    mov rcx, rax                        ; bytes written returned in ECX
    add rax, qwTextDestinationOffset    ; updated "spos" returned in EAX
    ret
Text_WriteLineW ENDP


END

