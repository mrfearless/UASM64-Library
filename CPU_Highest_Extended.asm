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
CPU_HIGHEST_EXTENDED_LEVEL DQ -1

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Highest_Extended
;
; Returns the highest value for extended processor information available.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; 0 if CPUID is not supported, otherwise the highest extended information (the
; value used in eax for CPUID to obtain extended information from a particular 
; leaf = 80000000h upwards)
;
;------------------------------------------------------------------------------
CPU_Highest_Extended PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        mov CPU_HIGHEST_EXTENDED_LEVEL, 0
        jmp CPU_Highest_Extended_Error
    .ENDIF
    
    mov rax, CPU_HIGHEST_EXTENDED_LEVEL
    .IF CPU_HIGHEST_EXTENDED_LEVEL == -1
    
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        
        mov eax, 080000000h
        cpuid
        mov CPU_HIGHEST_EXTENDED_LEVEL, rax
    .ELSE
        ; save result so we dont have to keep doing cpuid call
        mov rax, CPU_HIGHEST_EXTENDED_LEVEL
    .ENDIF
    
    jmp CPU_Highest_Extended_Exit
    
CPU_Highest_Extended_Error:
    
    mov rax, 0

CPU_Highest_Extended_Exit:
    
    ret
CPU_Highest_Extended ENDP


END

