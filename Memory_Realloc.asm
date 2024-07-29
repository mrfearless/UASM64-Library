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
    GlobalReAlloc   PROTO pMem:QWORD, dwBytes:QWORD, uFlags:DWORD
    IFNDEF GMEM_MOVEABLE
    GMEM_MOVEABLE EQU 0002h
    ENDIF
    IFNDEF GMEM_FIXED
    GMEM_FIXED EQU  0000h
    ENDIF
    IFNDEF GMEM_ZEROINIT
    GMEM_ZEROINIT EQU   0040h
    ENDIF
    includelib kernel32.lib
ENDIF
IF @Platform EQ 3 ; Linux x64
    EXTERNDEF realloc: PROTO pMemoryAddress:QWORD, qwBytes:QWORD
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Memory_Realloc
;
; Re-allocates memory, by resizing and moving an existing memory block that was 
; previously allocated via the Memory_Alloc function.
; 
; Parameters:
; 
; * pMemSource - The address of memory previously allocated by Memory_Alloc
;   which is now to be resized.
; 
; * qwBytes - The new number of bytes to re-allocate.
; 
; Returns:
; 
; A pointer to the allocated memory, or 0 if an error occured.
; 
; Notes:
;
; See Also:
;
; Memory_Alloc, Memory_Free
; 
;------------------------------------------------------------------------------
Memory_Realloc PROC FRAME pMemSource:QWORD, qwBytes:QWORD
    .IF pMemSource == 0
        mov rax, 0
        ret
    .ENDIF
    IF @Platform EQ 1 ; Win x64
        Invoke GlobalReAlloc, pMemSource, qwBytes, GMEM_MOVEABLE or GMEM_ZEROINIT
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, pMemSource
        mov rsi, qwBytes
        call realloc
    ENDIF
    ret
Memory_Realloc ENDP


END

