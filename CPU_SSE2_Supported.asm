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
; CPU_SSE2_Supported
;
; Check if Streaming SIMD Extensions 2 (SSE2) instructions are supported.
; 
; Parameters:
; 
; No Parameters.
; 
; Returns:
; 
; TRUE if SSE2 instructions are supported, or FALSE otherwise.
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

