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
; Memory_Move
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
; This function as based on: Memory_Copy
;
; See Also:
;
; Memory_Copy
; 
;------------------------------------------------------------------------------
Memory_Move PROC FRAME pMemSource:QWORD, pMemDestination:QWORD, qwAmount:QWORD
    Invoke Memory_Copy, pMemSource, pMemDestination, qwAmount
    ret
Memory_Move ENDP


END

