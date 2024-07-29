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
; CPU_Signature
;
; Read the processor family, model and stepping (the cpu signature) and return
; the values in the QWORD variables pointed to by the parameters.
; 
; Parameters:
; 
; * lpqwFamilyID - Returns a combination of the Extended Family ID and Family ID
; 
; * lpqwExtFamilyID - Returns the Extended Family ID (corresponds to bits 20-27)
; 
; * lpqwBaseFamilyID - Returns the base Family ID (corresponds to bits 8-11) 

; * lpqwModelID - Returns a combination of the Extended Model ID and Model ID
; 
; * lpqwExtModelID -  Returns the Extended Model ID (corresponds to bits 16-19)

; * lpqwBaseModelID - Returns the base Model ID (corresponds to bits 4-7) 
; 
; * lpqwStepping - Returns the Stepping ID (corresponds to bits 0-3)
; 
; Returns:
; 
; In EAX the raw CPUID EAX value if successful, or 0 otherwise.
;
; Notes:
;
; The parameters passed can be NULL if you do not require that particular info
; returned. 
;
; See Also:
;
; CPU_Brand, CPU_Manufacturer, CPU_ManufacturerID
; 
;------------------------------------------------------------------------------
CPU_Signature PROC FRAME USES RBX lpqwFamilyID:QWORD, lpqwExtFamilyID:QWORD, lpqwBaseFamilyID:QWORD, lpqwModelID:QWORD, lpqwExtModelID:QWORD, lpqwBaseModelID:QWORD, lpqwStepping:QWORD 
    LOCAL qwCPUEAX:QWORD
    LOCAL qwExtFamilyID:QWORD
    LOCAL qwBaseFamilyID:QWORD
    LOCAL qwFamilyID:QWORD
    LOCAL qwExtModelID:QWORD
    LOCAL qwBaseModelID:QWORD
    LOCAL qwModelID:QWORD
    LOCAL qwStepping:QWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Signature_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic
    .IF rax == 0
        jmp CPU_Signature_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 1
    cpuid
    mov qwCPUEAX, rax
    
    mov rax, qwCPUEAX
    shr rax, 20d
    and rax, 0FFh
    mov qwExtFamilyID, rax
    
    mov rax, qwCPUEAX
    shr rax, 8d
    and rax, 0Fh
    mov qwBaseFamilyID, rax

    mov rax, qwCPUEAX
    shr rax, 16d
    and rax, 0Fh
    mov qwExtModelID, rax
    
    mov rax, qwCPUEAX
    shr rax, 4d
    and rax, 0Fh
    mov qwBaseModelID, rax

    mov rax, qwCPUEAX
    and rax, 0Fh
    mov qwStepping, rax
    
    mov rax, qwExtFamilyID
    mov rbx, qwBaseFamilyID
    add rax, rbx
    mov qwFamilyID, rax
    
    mov rax, qwExtModelID
    shl rax, 4
    mov rbx, qwBaseModelID
    add rax, rbx
    mov qwModelID, rax
    
    .IF lpqwFamilyID != 0 
        mov rbx, lpqwFamilyID
        mov rax, qwFamilyID
        mov [rbx], rax
    .ENDIF
    .IF lpqwExtFamilyID != 0 
        mov rbx, lpqwExtFamilyID
        mov rax, qwExtFamilyID
        mov [rbx], rax
    .ENDIF
    .IF lpqwBaseFamilyID != 0 
        mov rbx, lpqwBaseFamilyID
        mov rax, qwBaseFamilyID
        mov [rbx], rax
    .ENDIF
    .IF lpqwModelID != 0 
        mov rbx, lpqwModelID
        mov rax, qwModelID
        mov [rbx], rax
    .ENDIF
    .IF lpqwExtModelID != 0 
        mov rbx, lpqwExtModelID
        mov rax, qwExtModelID
        mov [rbx], rax
    .ENDIF
    .IF lpqwBaseModelID != 0 
        mov rbx, lpqwBaseModelID
        mov rax, qwBaseModelID
        mov [rbx], rax
    .ENDIF
    .IF lpqwStepping != 0 
        mov rbx, lpqwStepping
        mov rax, qwStepping
        mov [rbx], rax
    .ENDIF
    
    mov rax, qwCPUEAX
    ret
    
CPU_Signature_Error:
    mov rax, 0
    
    ret
CPU_Signature ENDP


END

