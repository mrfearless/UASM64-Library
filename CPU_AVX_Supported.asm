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

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_AVX_Supported
;
; Check if Advanced Vector Extensions (AVX) instructions are supported.
; 
; Parameters:
; 
; No Parameters.
; 
; Returns:
; 
; TRUE if AVX instructions are supported, or FALSE otherwise.
; 
;------------------------------------------------------------------------------
CPU_AVX_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_AVX_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
	mov eax, 1
	cpuid
	shr ecx, 28
	and ecx, 1
	mov eax, ecx
    
    jmp CPU_AVX_Supported_Exit
    
CPU_AVX_Supported_Error:
    
    mov rax, 0

CPU_AVX_Supported_Exit:
    
    ret
CPU_AVX_Supported ENDP


END

