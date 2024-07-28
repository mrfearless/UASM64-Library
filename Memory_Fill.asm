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
; Memory_Fill
;
; Memory_Fill is a fast memory filling function that works in QWORD unit sizes 
; It is usually good practice to allocate memory in intervals of eight for 
; alignment purposes and this function is designed to work with memory 
; allocated in this way
;
; Parameters:
; 
; * pMemoryAddress - The address of the memory block to fill.
; 
; * qwMemoryLength - The buffer length to fill.
; 
; * qwFill - The fill character(s).
; 
; Returns:
; 
; There is no return value.
; 
; Notes:
;
; In most instances the fill character will be ascii zero but the QDWORD value 
; can be arranged in any manner convenient, it also can be loaded as a string 
; which will be repeated at 8 byte intervals.
;
; NOTE that the characters in the string will be reversed so that if you place 
; "12345678" in the QWORD variable, it will be written to the memory filled as 
; "87654321" for the length of the filled memory. Also note that the function 
; will round down the fill to the next interval of 8 if the buffer does not 
; divide equally by eight.
;
; This function as based on the MASM32 Library function: memfill
;
; See Also:
;
; Memory_Zero
; 
;------------------------------------------------------------------------------
Memory_Fill PROC FRAME USES RCX RDX pMemoryAddress:QWORD, qwMemoryLength:QWORD, qwFill:QWORD

    .IF pMemoryAddress == 0 || qwMemoryLength == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rdx, pMemoryAddress ; buffer address
    mov rax, qwFill         ; fill chars

    mov rcx, qwMemoryLength ; byte length
    shr rcx, 6              ; divide by 64 ;32
    cmp rcx, 0
    jz rmndr

    align 8

  ; ------------
  ; unroll by 8
  ; ------------
  @@:
    mov [rdx],    rax   ; put fill chars at address in edx
    ;mov [rdx+4],  eax
    mov [rdx+8],  rax
    ;mov [rdx+12], eax
    mov [rdx+16], rax
    ;mov [rdx+20], eax
    mov [rdx+24], rax
    ;mov [rdx+28], eax
    mov [rdx+32], rax
    mov [rdx+40], rax
    mov [rdx+48], rax
    mov [rdx+56], rax
    add rdx, 64 ;32
    dec rcx
    jnz @B

  rmndr:

    and qwMemoryLength, 63 ;31          ; get remainder
    cmp qwMemoryLength, 0
    je mfQuit
    mov rcx, qwMemoryLength
    shr rcx, 3 ;2          ; divide by 8 ;4

  @@:
    mov [rdx], rax
    add rdx, 8 ;4
    dec rcx
    jnz @B

  mfQuit:
  
    ret
Memory_Fill ENDP


END

