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

include commctrl.inc
includelib user32.lib
includelib kernel32.lib

include UASM64.inc

.DATA
szUASM64_CPU_Brand  DB 48 DUP (0)

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Brand
;
; Return a string with the CPU brand. 
; 
; Parameters:
; 
; No Parameters
; 
; Returns:
; 
; RAX contains a pointer to a string containing the CPU brand or 0 if not 
; supported.
; 
;------------------------------------------------------------------------------
CPU_Brand PROC FRAME USES RBX RCX RDX RDI
    LOCAL idx:DWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Brand_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
	mov eax, 80000000h
	cpuid
	cmp eax, 80000004h
	jnge CPU_Brand_Error
    
	mov eax, 80000002h
	cpuid
    
    ; Zero out string
    lea rdi, szUASM64_CPU_Brand
    mov rax, 0
    mov qword ptr [rdi+00d], rax
    mov qword ptr [rdi+08d], rax
    mov qword ptr [rdi+16d], rax
    mov qword ptr [rdi+24d], rax
    mov qword ptr [rdi+32d], rax
    mov qword ptr [rdi+40d], rax

    mov idx, 80000002h
    
CPU_Brand_Next:
    xor rax, rax
	mov eax, idx
	cpuid
	mov dword ptr [rdi], eax
	mov dword ptr [rdi+4], ebx
	mov dword ptr [rdi+8], ecx
	mov dword ptr [rdi+12], edx
	add rdi, 16
	add idx, 1
	cmp idx, 80000004h
	jna CPU_Brand_Next

    lea rax, szUASM64_CPU_Brand
    jmp CPU_Brand_Exit
    
CPU_Brand_Error:
    mov rax, NULL
    
CPU_Brand_Exit:    
    
    ret
CPU_Brand ENDP


END

