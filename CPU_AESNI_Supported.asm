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
; CPU_AESNI_Supported
;
; Check if Advanced Encryption Standard New Instructions (AES-NI) instructions 
; are supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if AES-NI instructions are supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/AES_instruction_set
;
; See Also:
;
; CPU_CPUID_Supported, CPU_AVX_Supported
; 
;------------------------------------------------------------------------------
CPU_AESNI_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_AESNI_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    shr ecx, 25
    and ecx, 1
    mov eax, ecx
    
    jmp CPU_AESNI_Supported_Exit
    
CPU_AESNI_Supported_Error:
    
    mov rax, 0

CPU_AESNI_Supported_Exit:
    
    ret
CPU_AESNI_Supported ENDP


END

