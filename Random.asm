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

.DATA
nrandom_seed DQ 12345678

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Random_Number
;
; Generate random number.
; 
; Parameters:
; 
; * base - Zero based range for random output. If 0 then it used the time 
;   stamp counter to generate a value from.
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
; On a CPU that supports the RDRAND instruction, this is used instead of the
; original code path ported from the x86 function in the MASM32 Library.
; 
; For a CPU that doesnt support RDRAND, we also allow base parameter to be
; a 0, which will use the time stamp counter to generate a value for us.
;
; nrandom_seed global variable is used to store a seed value generated from the
; Random_Seed function (or default value of 12345678) that is used for CPU's 
; that dont support RDRAND to generate a random number.
;
; See Also:
;
; CPU_RDRAND_Supported, CPU_RDSEED_Supported
;
;------------------------------------------------------------------------------
Random_Number PROC FRAME USES RBX RCX RDX base:QWORD

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
        .IF base == 0
            rdtsc
            mov rbx, rax
            xor rdx, rdx
            mov rax, rcx
            div rbx
        .ELSE
            xor rdx, rdx
            mov rax, rcx
            div base
        .ENDIF
        mov rax, rdx
    .ENDIF
    
    ret
Random_Number ENDP

UASM64_ALIGN
;------------------------------------------------------------------------------
; Random_Seed
;
; Generate a random seed.
; 
; Parameters:
; 
; * TheSeed - seed value to use. If 0 then uses the time stamp counter to 
;   generate a value from.
; 
; Returns:
; 
; In RAX a random seed.
;
; Notes:
; 
; On a CPU that supports the RDSEED instruction, this is used instead of the
; original code path ported from the x86 function in the MASM32 Library.
; 
; For a CPU that doesnt support RDSEED, we also allow TheSeed parameter to be
; a 0, which will use the time stamp counter to generate a value for us.
;
; nrandom_seed global variable is used to store that value for use in the 
; Random_Number function, for CPU's that dont support RDSEED.
;
; See Also:
;
; CPU_RDRAND_Supported, CPU_RDSEED_Supported
;
;------------------------------------------------------------------------------
Random_Seed PROC FRAME USES RDX TheSeed:QWORD
    Invoke CPU_RDSEED_Supported
    .IF rax == TRUE
        RDSEED rax ; DB 0Fh, 0C7h, 0F8h - `rdseed eax`
    .ELSE
        .IF TheSeed == 0
            rdtsc
        .ELSE
            mov rax, TheSeed
        .ENDIF
        
    .ENDIF
    mov nrandom_seed, rax
    ret
Random_Seed ENDP


END

