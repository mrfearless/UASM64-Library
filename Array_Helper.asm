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

_Array_SysAllocStringByteLen PROTO psz:QWORD, len:QWORD
_Array_SysFreeString         PROTO pString:QWORD

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; _Array_SysAllocStringByteLen
;
; Internal function used by array functions to emulate a 64bit version of
; a SysAllocStringByteLen function with QWORD size length at start of the BSTR
; structure.
; 
; Parameters:
; 
; * psz - The string to copy.
; 
; * len - The number of bytes to copy.
; 
; Returns:
; 
; Pointer to the BSTR string, or 0 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: 
;
; See Also:
;
; _Array_SysFreeString
; 
;------------------------------------------------------------------------------
_Array_SysAllocStringByteLen PROC FRAME USES RCX RDX RDI RSI psz:QWORD, len:QWORD
    LOCAL pBSTR:QWORD
    LOCAL pBSTR_String:QWORD
    LOCAL qwBSTR_Size:QWORD
    
    .IF psz == 0 || len == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rax, len
    add rax, 12d ; 8 for length at start and 4 for null ending
    mov qwBSTR_Size, rax
    Invoke Memory_Alloc, qwBSTR_Size
    .IF rax != 0
        mov pBSTR, rax
        mov rcx, pBSTR
        mov rax, len
        mov [rcx], rax
        add rcx, 8
        mov pBSTR_String, rcx
        
        IF @Platform EQ 1 ; Win x64
            Invoke Memory_Copy, psz, pBSTR_String, len
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            mov rdi, psz
            mov rsi, pBSTR_String
            mov rdx, len
            call Memory_Copy
        ENDIF
        mov rax, pBSTR_String
    .ENDIF
    ret
_Array_SysAllocStringByteLen ENDP


UASM64_ALIGN
;------------------------------------------------------------------------------
; _Array_SysFreeString
;
; Internal function used by array functions to emulate a 64bit version of
; SysFreeString functions.
;
; Parameters:
; 
; * pString - The previously allocated string.
; 
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
; 
; Notes:
;
; This function as based on the MASM32 Library function: 
;
; See Also:
;
; _Array_SysFreeString
; 
;------------------------------------------------------------------------------
_Array_SysFreeString PROC FRAME USES RBX pString:QWORD
    LOCAL pBSTR:QWORD
    .IF pString == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rbx, pString
    sub rbx, 8
    mov pBSTR, rbx
    mov rax, [rbx]
    .IF rax != 0 ; check there is a length value
        mov rax, 0 ; null it
        mov [rbx], rax
        Invoke Memory_Free, pBSTR
    .ENDIF
    
    ret
_Array_SysFreeString ENDP


END
