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
; CPU_Highest_Basic_Ext
;
; Returns the highest basic extended level supported. That is the highest level
; that ECX supports for EAX=7, which is used in the CPU_Basic_Features_ExtX
; functions. 
;
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; In RAX the highest basic extended level supported. This can be used to 
; determine if calls to the functions CPU_Basic_Features_Ext0, 
; CPU_Basic_Features_Ext1 or CPU_Basic_Features_Ext2 can be made.
 
; If the return value is -1 then the calls to CPU_Basic_Features_Ext0, 
; CPU_Basic_Features_Ext1 or CPU_Basic_Features_Ext2 are not supported. 

; A return value of 0 means that only a call to CPU_Basic_Features_Ext0 is 
; supported.
;
; A return value of 1 means that a call to CPU_Basic_Features_Ext0 and/or
; CPU_Basic_Features_Ext1 is supported.
;
; A return value of 2 means that a call to CPU_Basic_Features_Ext0 and/or
; CPU_Basic_Features_Ext1 and/or CPU_Basic_Features_Ext2 is supported.
; 
;------------------------------------------------------------------------------
CPU_Highest_Basic_Ext PROC FRAME USES RBX RCX RDX

    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Highest_Basic_Ext_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic
    .IF rax == 0 || sqword ptr rax < 7
        jmp CPU_Highest_Basic_Ext_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 7
    cpuid
    ; rax contains highest level of ECX for EAX=7
    ret
    
CPU_Highest_Basic_Ext_Error:
    
    mov rax, -1

    ret
CPU_Highest_Basic_Ext ENDP


END

