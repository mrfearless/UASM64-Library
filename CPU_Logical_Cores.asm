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
; CPU_Logical_Cores
;
; Return the number of logical cores, if supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; RAX contains number of logical cores if supported, or 0 otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/CPUID#EAX=4_and_EAX=Bh:_Intel_thread/core_and_cache_topology
;
; See Also:
;
; CPU_Basic_Features, CPU_Signature, CPU_CPUID_Supported, CPU_HTT_Supported
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

