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
; CPU_SSE2_Supported
;
; Check if Streaming SIMD Extensions 2 (SSE2) instructions are supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if SSE2 instructions are supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/SSE2
;
; See Also:
;
; CPU_CPUID_Supported, CPU_SSE_Supported, CPU_SSE3_Supported, 
; CPU_SSE41_Supported, CPU_SSE42_Supported
; 
;------------------------------------------------------------------------------
CPU_SSE2_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_SSE2_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    shr edx, 26
    and edx, 1
    mov eax, edx
    
    jmp CPU_SSE2_Supported_Exit
    
CPU_SSE2_Supported_Error:
    
    mov rax, 0

CPU_SSE2_Supported_Exit:
    
    ret
CPU_SSE2_Supported ENDP


END

