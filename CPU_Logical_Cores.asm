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
; CPU_Logical_Cores
;
; Return the number of logical cores, if supported.
; 
; Parameters:
; 
; No Parameters.
; 
; Returns:
; 
; RAX contains number of logical cores if supported, or 0 otherwise.
; 
;------------------------------------------------------------------------------
CPU_Logical_Cores PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Logical_Cores_Error
    .ENDIF
    
    Invoke CPU_HTT_Supported
    .IF rax == FALSE
        jmp CPU_Logical_Cores_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
	mov eax, 1
	cpuid
	and ebx, 00FF0000h
	mov eax, ebx
	shr eax, 16
    
    jmp CPU_Logical_Cores_Exit
    
CPU_Logical_Cores_Error:
    
    mov rax, 0

CPU_Logical_Cores_Exit:
    
    ret
CPU_Logical_Cores ENDP


END

