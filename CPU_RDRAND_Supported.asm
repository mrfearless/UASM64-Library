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
; CPU_RDRAND_Supported
;
; Check if the RDRAND instruction is supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if RDRAND instruction is supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/RDRAND
;
; See Also:
;
; CPU_CPUID_Supported, CPU_RDSEED_Supported 
; 
;------------------------------------------------------------------------------
CPU_RDRAND_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_RDRAND_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    shr ecx, 30
    and ecx, 1
    mov eax, ecx
    
    jmp CPU_RDRAND_Supported_Exit
    
CPU_RDRAND_Supported_Error:
    
    mov rax, 0

CPU_RDRAND_Supported_Exit:
    
    ret
CPU_RDRAND_Supported ENDP


END

