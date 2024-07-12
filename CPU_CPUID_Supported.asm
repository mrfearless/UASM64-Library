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

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_CPUID_Supported
;
; Check if the CPUID instruction is supported.
; 
; Parameters:
; 
; No Parameters.
; 
; Returns:
; 
; TRUE if the CPUID instruction is supported, or FALSE otherwise.
; 
;------------------------------------------------------------------------------
CPU_CPUID_Supported PROC FRAME USES RBX RCX RDX
	
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
	;push rbx         ; save rbx for the caller
	pushfq           ; push rflags on the stack
	pop rax          ; pop them into rax
	;mov rbx, rax     ; save to rbx for restoring afterwards
	xor rax, 200000h ; toggle bit 21
	push rax         ; push the toggled rflags
	popfq            ; pop them back into rflags
	pushfq           ; push rflags
	pop rax          ; pop them back into rax
	cmp rax, rbx     ; see if bit 21 was reset
	jz CPU_CPUID_Supported_No
	
	mov eax, 1
	jmp CPU_CPUID_Supported_Exit
	
CPU_CPUID_Supported_No:
	xor eax, eax

CPU_CPUID_Supported_Exit:
	;pop rbx
	
	ret
CPU_CPUID_Supported ENDP


END

