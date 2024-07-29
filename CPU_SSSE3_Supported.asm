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
; CPU_SSSE3_Supported
;
; Check if Supplemental Streaming SIMD Extensions 3 (SSSE3 or SSE3S) 
; instructions are supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if SSSE3 instructions are supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/SSSE3
;
; See Also:
;
; CPU_CPUID_Supported, CPU_SSE_Supported, CPU_SSE2_Supported, 
; CPU_SSE3_Supported, CPU_SSE41_Supported, CPU_SSE42_Supported
; 
;------------------------------------------------------------------------------
CPU_SSSE3_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_SSSE3_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    shr ecx, 9
    and ecx, 1
    mov eax, ecx
    
    jmp CPU_SSSE3_Supported_Exit
    
CPU_SSSE3_Supported_Error:
    
    mov rax, 0

CPU_SSSE3_Supported_Exit:
    
    ret
CPU_SSSE3_Supported ENDP


END

