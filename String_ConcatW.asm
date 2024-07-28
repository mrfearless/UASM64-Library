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
; String_ConcatW
;
; Concatenate two strings by appending the second zero terminated string 
; (lpszSource) to the end of the first zero terminated string (lpszDestination)
;
; The result is zero terminated.
;
; Parameters:
; 
; * lpszDestination - The address of the destination string to be appended to.
; 
; * lpszSource - The address of the string to append to destination string.
; 
; Returns:
; 
; No return value.
; 
; Notes:
;
; This function as based on the MASM32 Library function: ucCatStr
;
; See Also:
;
; String_AppendW, String_MultiCatW
; 
;------------------------------------------------------------------------------
String_ConcatW PROC FRAME USES RCX RDX lpszDestination:QWORD, lpszSource:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rdx, lpszDestination
    sub rdx, 2
    mov rcx, lpszSource
    xor rax, rax

  @@:
    add rdx, 2
    cmp WORD PTR [rdx], 0       ; find the end
    jne @B

  @@:
    mov ax, [rcx]               ; append 2nd string
    mov [rdx], ax
    add rcx, 2
    add rdx, 2
    test ax, ax
    jnz @B

    ret
String_ConcatW ENDP


END

