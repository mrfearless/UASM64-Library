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
; Memory_Copy
;
; Copy a specified amount of bytes of memory from the source buffer to the 
; destination buffer.
;
; Parameters:
; 
; * pMemSource - source address of memory to copy from.
; 
; * pMemDestination - destination address of memory to copy to.
; 
; * qwAmount - the amount of bytes to copy from pMemSource to pMemDestination.
; 
; Returns:
; 
; No return value.
; 
; Notes:
;
; The destination buffer must be at least as large as the source buffer 
; otherwise a page fault will be generated.
;
; This function as based on the MASM32 Library function: MemCopy
;
; See Also:
;
; Memory_Move
; 
;------------------------------------------------------------------------------
Memory_Copy PROC FRAME USES RCX RDI RSI pMemSource:QWORD, pMemDestination:QWORD, qwAmount:QWORD
    
    .IF pMemSource == 0 || pMemDestination == 0 || qwAmount == 0
        mov rax, 0
        ret
    .ENDIF
    
    cld
    mov rsi, pMemSource
    mov rdi, pMemDestination
    mov rcx, qwAmount

    shr rcx, 3
    rep movsq

    mov rcx, qwAmount
    and rcx, 7
    rep movsb
    ret
Memory_Copy ENDP


END

