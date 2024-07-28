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

IF @Platform EQ 1 ; Win x64
    GlobalFree  PROTO pMem:QWORD
    includelib kernel32.lib
ENDIF

IF @Platform EQ 3 ; Linux x64
    EXTERNDEF free: PROTO pMemoryAddress:QWORD
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Memory_Free
;
; Frees a block of memory previously allocated through a call to Memory_Alloc. 
; The number of bytes freed equals the number of bytes that were allocated. 
;
; After the call, the memory block pointed to by pMemoryAddress is invalid and 
; can no longer be used. Note: the pMemoryAddress parameter can be NULL. 
; If so, this method has no effect. 

; Parameters:
; 
; * pMemoryAddress - Address of memory returned by Memory_Alloc when the memory 
;   was initially allocated.
;
; Returns:
; 
; There is no return value.
; 
; Notes:
;
; This function as based on the MASM32 Library function: Free
;
; See Also:
;
; Memory_Alloc, Memory_Realloc
; 
;------------------------------------------------------------------------------
Memory_Free PROC FRAME USES RDI pMemoryAddress:QWORD
    IF @Platform EQ 1 ; Win x64
        .IF pMemoryAddress != 0
            Invoke GlobalFree, pMemoryAddress
        .ENDIF
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        .IF pMemoryAddress != 0
            mov rdi, pMemoryAddress
            call free
        .ENDIF
    ENDIF
    ret
Memory_Free ENDP


END

