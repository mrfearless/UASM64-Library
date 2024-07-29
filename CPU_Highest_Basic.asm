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

.DATA
CPU_HIGHEST_BASIC_LEVEL DQ -1

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Highest_Basic
;
; Returns the highest value for basic processor information available.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; 0 if CPUID is not supported, otherwise the highest basic information (the
; value used in eax for CPUID to obtain information from a particular leaf)
;
;------------------------------------------------------------------------------
CPU_Highest_Basic PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        mov CPU_HIGHEST_BASIC_LEVEL, 0
        jmp CPU_Highest_Basic_Error
    .ENDIF
    
    mov rax, CPU_HIGHEST_BASIC_LEVEL
    .IF CPU_HIGHEST_BASIC_LEVEL == -1
    
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        
        mov eax, 0
        cpuid
        mov CPU_HIGHEST_BASIC_LEVEL, rax
    .ELSE
        ; save result so we dont have to keep doing cpuid call
        mov rax, CPU_HIGHEST_BASIC_LEVEL
    .ENDIF
    
    jmp CPU_Highest_Basic_Exit
    
CPU_Highest_Basic_Error:
    
    mov rax, 0

CPU_Highest_Basic_Exit:
    
    ret
CPU_Highest_Basic ENDP


END

