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
    GlobalAlloc PROTO uFlags:DWORD, dwBytes:QWORD
    IFNDEF GMEM_FIXED
    GMEM_FIXED EQU	0000h
    ENDIF
    IFNDEF GMEM_ZEROINIT
    GMEM_ZEROINIT EQU	0040h
    ENDIF
    includelib kernel32.lib
ENDIF
IF @Platform EQ 3 ; Linux x64
    EXTERNDEF malloc: PROTO qwBytes:QWORD
;    IFNDEF PROT_READ
;    PROT_READ EQU 00000001h
;    ENDIF
;    IFNDEF PROT_WRITE
;    PROT_WRITE EQU 00000002h
;    ENDIF
;    IFNDEF MAP_PRIVATE
;    MAP_PRIVATE EQU 00000002h
;    ENDIF
;    IFNDEF MAP_ANONYMOUS
;    MAP_ANONYMOUS EQU 00000020h
;    ENDIF
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Memory_Alloc
;
; Allocate a block of memory.
;
; The Alloc method allocates a memory block in essentially the same way that 
; the C Library malloc function does.
; 
; The initial contents of the returned memory block are undefined there is no 
; guarantee that the block has been initialized, so you should initialize it in 
; your code. The allocated block may be larger than cb bytes because of the 
; space required for alignment and for maintenance information.
; 
; If qwBytes is zero, Memory_Alloc allocates a zero-length item and returns a 
; valid pointer to that item. If there is insufficient memory available, 
; Memory_Alloc returns 0.
; 
; Note applications should always check the return value from this method, 
; even when requesting small amounts of memory, because there is no guarantee 
; the memory will be allocated
;
; Parameters:
; 
; * qwBytes - The number of bytes to allocate.
; 
; Returns:
; 
; A pointer to the allocated memory, or 0 if an error occured.
; 
; Notes:
;
; This function as based on the MASM32 Library function: Alloc
;
; See Also:
;
; Memory_Realloc, Memory_Free
; 
;------------------------------------------------------------------------------
Memory_Alloc PROC FRAME USES RDI qwBytes:QWORD ; RSI R10 R8 
    IF @Platform EQ 1 ; Win x64
        Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, qwBytes
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, qwBytes
        call malloc
;        mov rdi, 0 ; let OS choose address
;        mov rsi, qwBytes ; bytes to allocate
;        mov rdx, PROT_READ or PROT_WRITE
;        mov r10, MAP_PRIVATE or MAP_ANONYMOUS
;        mov r8, -1
;        mov rax, 9 ; memmap
;        syscall
;        .IF rax == -1
;            mov rax, 0
;            ret
;        .ENDIF
    ENDIF
    ret
Memory_Alloc ENDP


END

