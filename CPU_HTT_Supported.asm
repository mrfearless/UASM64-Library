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
; CPU_HTT_Supported
;
; Check if Hyper-Threading Technology (HTT) is supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if the HTT is supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/Hyper-threading
;
; See Also:
;
; CPU_Basic_Features, CPU_Signature, CPU_Brand 
; 
;------------------------------------------------------------------------------
CPU_HTT_Supported PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_HTT_Supported_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    shr edx, 28
    and edx, 1
    mov eax, edx
    
    jmp CPU_HTT_Supported_Exit
    
CPU_HTT_Supported_Error:
    
    mov rax, 0

CPU_HTT_Supported_Exit:
    
    ret
CPU_HTT_Supported ENDP


END

