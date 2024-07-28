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
; Memory_Zero
;
; Memory_Zero is a fast memory zeroing function that works in QWORD unit sizes 
; It is usually good practice to allocate memory in intervals of eight for 
; alignment purposes and this function is designed to work with memory 
; allocated in this way
;
; Parameters:
; 
; * pMemoryAddress - The address of the memory block to zero.
; 
; * qwMemoryLength - The buffer length to zero.
; 
; Returns:
; 
; There is no return value.
; 
; Notes:
;
; This function as based on: Memory_Fill
;
; See Also:
;
; Memory_Fill
; 
;------------------------------------------------------------------------------
Memory_Zero PROC FRAME pMemoryAddress:QWORD, qwMemoryLength:QWORD
    Invoke Memory_Fill, pMemoryAddress, qwMemoryLength, 0
    ret
Memory_Zero ENDP


END

