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
; Text_WriteLineA
;
; Writes a line of text to a memory buffer and updates the last write position.
; This is the Ansi version of Text_WriteLine, Text_WriteLineW is the Unicode 
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
; Text_LineCountA, Text_LineCountExA, Text_ReadLineA
; 
;------------------------------------------------------------------------------
Text_WriteLineA PROC FRAME USES RDX RDI lpszTextLineBuffer:QWORD, lpszTextDestination:QWORD, qwTextDestinationOffset:QWORD, bNoCRLF:QWORD
    mov rdx, lpszTextLineBuffer         ; source address in EDX
    mov rdi, lpszTextDestination        ; buffer address in EDI
    add rdi, qwTextDestinationOffset    ; add starting position to buffer address
    xor rax, rax                        ; clear index and counter
    xor rcx, rcx                        ; prevent stall

  @@:
    mov cl, [rdx+rax]
    mov [rdi+rax], cl
    add rax, 1
    test cl, cl                         ; exit loop if zero is written
    jnz @B

    cmp bNoCRLF, 0                      ; test flag a CRLF is to be appended
    jne @F
    mov WORD PTR [rdi+rax-1], 0A0Dh     ; append CRLF to current location
    add rax, 2
    mov BYTE PTR [rdi+rax], 0           ; zero terminate CRLF
  @@:

    sub rax, 1
    mov rcx, rax                        ; bytes written returned in ECX
    add rax, qwTextDestinationOffset    ; updated "spos" returned in EAX
    ret
Text_WriteLineA ENDP


END

