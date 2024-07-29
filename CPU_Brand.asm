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

;DEBUG64 EQU 1
;
;IFDEF DEBUG64
;    PRESERVEXMMREGS equ 1
;    includelib \UASM\lib\x64\Debug64.lib
;    DBG64LIB equ 1
;    DEBUGEXE textequ <'\UASM\bin\DbgWin.exe'>
;    include \UASM\include\debug64.inc
;    .DATA
;    RDBG_DbgWin    DB DEBUGEXE,0
;    .CODE
;ENDIF

include UASM64.inc

.DATA
qwCPU_Brand_Run    DQ -1
szCPU_Brand_String DB 48 DUP (0)

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Brand
;
; Return a string with the CPU brand. 
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; RAX contains a pointer to a string containing the CPU brand or 0 if not 
; supported.
;
; Notes:
;
; https://en.wikipedia.org/wiki/CPUID#EAX=80000002h,80000003h,80000004h:_Processor_Brand_String
;
; See Also:
;
; CPU_Manufacturer, CPU_ManufacturerID, CPU_Signature, CPU_CPUID_Supported, CPU_Logical_Cores
; 
;------------------------------------------------------------------------------
CPU_Brand PROC FRAME USES RBX RCX RDX RDI
    LOCAL idx:QWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Brand_Error
    .ENDIF
    
    Invoke CPU_Highest_Extended
    .IF rax == 0 || sqword ptr rax < 080000004h
        jmp CPU_Brand_Error
    .ENDIF
    
    .IF qwCPU_Brand_Run == -1
        ; Only need to do this once
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        mov eax, 80000002h
        cpuid
        
        ; Zero out string
        lea rdi, szCPU_Brand_String
        mov rax, 0
        mov qword ptr [rdi+00d], rax
        ;mov qword ptr [rdi+04d], rax
        mov qword ptr [rdi+08d], rax
        ;mov qword ptr [rdi+12d], rax
        mov qword ptr [rdi+16d], rax
        ;mov qword ptr [rdi+20d], rax
        mov qword ptr [rdi+24d], rax
        ;mov qword ptr [rdi+28d], rax
        mov qword ptr [rdi+32d], rax
        ;mov qword ptr [rdi+36d], rax
        mov qword ptr [rdi+40d], rax
        ;mov qword ptr [rdi+44d], rax
    
        mov idx, 80000002h
        
    CPU_Brand_Next:
        xor rax, rax
        mov rax, idx
        cpuid
        mov dword ptr [rdi], eax
        mov dword ptr [rdi+4], ebx
        mov dword ptr [rdi+8], ecx
        mov dword ptr [rdi+12], edx
        add rdi, 16
        add idx, 1
        cmp idx, 80000004h
        jna CPU_Brand_Next
        
        mov qwCPU_Brand_Run, 1
    .ENDIF
    
    lea rax, szCPU_Brand_String
    jmp CPU_Brand_Exit
    
CPU_Brand_Error:
    mov qwCPU_Brand_Run, 0
    mov rax, 0
    
CPU_Brand_Exit:    
    
    ret
CPU_Brand ENDP


END

