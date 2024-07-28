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
; String_CopyW
;
; Copies a zero terminated string from the source buffer to the destination 
; buffer.
;
; Parameters:
; 
; * lpszSource - The address of the source string.
;
; * lpszDestination - The address of the destination string buffer.
; 
; Returns:
; 
; The copied length minus the terminating null is returned in RAX.
;
; Notes:
;
; The destination buffer must be large enough to hold the source string 
; otherwise a page write fault will occur.
;
; This function as based on the MASM32 Library function: ucCopy
;
; See Also:
;
; String_LengthW, String_ConcatW
; 
;------------------------------------------------------------------------------
String_CopyW PROC FRAME USES RCX RDX RDI lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    xor rax, rax            ; clear EAX for partial register read/writes
    mov rdx, lpszSource
    mov rdi, lpszDestination
    mov rcx, -2

  @@:
    add rcx, 2
    mov ax, [rdx+rcx]       ; copy src to dst and get character count
    mov [rdi+rcx], ax
    test ax, ax
    jnz @B

    ret
String_CopyW ENDP


END

