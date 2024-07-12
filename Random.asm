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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include windows.inc

include UASM64.inc

.DATA
nrandom_seed DQ 12345678

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; nrandom
;
; Generate random number 
; 
; Parameters:
; 
; * base - Zero based range for random output.
; 
; Returns:
; 
; In RAX a random number.
; 
; Notes:
;
; A Park Miller random algorithm written by Jaymeson Trudgen (NaN) and 
; optimised by Rickey Bowers Jr. (bitRAKE).
;
; x64 version now uses RDRAND if available instead.
; 
;------------------------------------------------------------------------------
nrandom PROC FRAME USES RBX RCX RDX base:QWORD

    Invoke CPU_RDRAND_Supported
    .IF rax == TRUE
        RDRAND rax ; DB 048h, 0Fh, 0C7h, 0F0h - `rdrand rax`
    .ELSE
        mov rax, nrandom_seed
        mov ebx, 80000000h
        shr rbx, 32d
        test rax, rbx
        jz  @F
        add rax,  7fffffffh
        @@:  
        xor rdx, rdx
        mov rcx, 127773
        div rcx
        mov rcx, rax
        mov rax, 16807
        mul rdx
        mov rdx, rcx
        mov rcx, rax
        mov rax, 2836
        mul rdx
        sub rcx, rax
        xor rdx, rdx
        mov rax, rcx
        mov nrandom_seed, rcx
        div base
        mov rax, rdx
    .ENDIF
    
    ret
nrandom ENDP

UASM64_ALIGN
;------------------------------------------------------------------------------
; nseed
;
; Generate a random seed
; 
; Parameters:
; 
; * TheSeed - seed value to use.
; 
; Returns:
; 
; In RAX a random seed.
; 
;------------------------------------------------------------------------------
nseed PROC FRAME TheSeed:QWORD
    Invoke CPU_RDSEED_Supported
    .IF rax == TRUE
        RDSEED rax ; DB 0Fh, 0C7h, 0F8h - `rdseed eax`
    .ELSE
        mov rax, TheSeed
    .ENDIF
    mov nrandom_seed, rax
    ret
nseed ENDP


END

