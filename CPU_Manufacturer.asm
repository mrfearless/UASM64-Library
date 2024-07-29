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
szCPU_Manufacturer_String DB 16 DUP (0)

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Manufacturer
;
; Return a string with the CPU manufacturer. 
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; RAX contains a pointer to a string containing the CPU manufacturer or 0 if 
; not supported.
;
; See Also:
;
; CPU_ManufacturerID, CPU_Brand
; 
;------------------------------------------------------------------------------
CPU_Manufacturer PROC FRAME USES RBX RCX RDX RDI

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Manufacturer_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 0
    cpuid

    ; Zero out string
    lea rdi, szCPU_Manufacturer_String
    mov rax, 0
    mov qword ptr [rdi+00d], rax
    mov qword ptr [rdi+08d], rax

    ; Store vendor string from registers
    mov dword ptr [rdi+0], ebx
    mov dword ptr [rdi+4], edx
    mov dword ptr [rdi+8], ecx    
    
    lea rax, szCPU_Manufacturer_String
    jmp CPU_Manufacturer_Exit
    
CPU_Manufacturer_Error:
    
    mov rax, 0

CPU_Manufacturer_Exit:
    
    ret
CPU_Manufacturer ENDP


END

