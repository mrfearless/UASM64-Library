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
CPUID_SUPPORTED DQ -1

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_CPUID_Supported
;
; Check if the CPUID instruction is supported.
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; TRUE if the CPUID instruction is supported, or FALSE otherwise.
;
; Notes:
;
; https://en.wikipedia.org/wiki/CPUID
;
; See Also:
;
; CPU_Manufacturer, CPU_ManufacturerID, CPU_Signature, CPU_Brand, CPU_Logical_Cores
; 
;------------------------------------------------------------------------------
CPU_CPUID_Supported PROC FRAME USES RBX RCX RDX
	
	.IF CPUID_SUPPORTED == -1
	    ; do this once
        xor rax, rax
        xor rbx, rbx
        xor rcx, rcx
        xor rdx, rdx
        
    	pushfq           ; push rflags on the stack
    	pop rax          ; pop them into rax
    	xor rax, 200000h ; toggle bit 21
    	push rax         ; push the toggled rflags
    	popfq            ; pop them back into rflags
    	pushfq           ; push rflags
    	pop rax          ; pop them back into rax
    	cmp rax, rbx     ; see if bit 21 was reset
    	jz CPU_CPUID_Supported_No
        
        mov CPUID_SUPPORTED, 1	
    	mov rax, 1
    .ELSE
        mov rax, CPUID_SUPPORTED
    .ENDIF
	jmp CPU_CPUID_Supported_Exit
	
CPU_CPUID_Supported_No:
    mov CPUID_SUPPORTED, 0
	xor rax, rax

CPU_CPUID_Supported_Exit:
	
	ret
CPU_CPUID_Supported ENDP


END

