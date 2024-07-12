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
; CPU_RDSEED_Supported
;
; Check if the RDSEED instruction is supported.
; 
; Parameters:
; 
; No Parameters.
; 
; Returns:
; 
; TRUE if RDSEED instruction is supported, or FALSE otherwise.
; 
;------------------------------------------------------------------------------
CPU_RDSEED_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_RDSEED_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
	mov eax, 7
	cpuid
	shr ebx, 18
	and ebx, 1
	mov eax, ebx
    
    jmp CPU_RDSEED_Supported_Exit
    
CPU_RDSEED_Supported_Error:
    
    mov rax, 0

CPU_RDSEED_Supported_Exit:
    
    ret
CPU_RDSEED_Supported ENDP


END

