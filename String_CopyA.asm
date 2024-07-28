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
; String_CopyA
;
; Copies a zero terminated string from the source buffer to the destination 
; buffer. This is the Ansi version of String_Copy, String_CopyW is the Unicode 
; version.
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
; This function as based on the MASM32 Library function: 
;
; See Also:
;
; String_LengthA, String_ConcatA
; 
;------------------------------------------------------------------------------
String_CopyA PROC FRAME USES RBX RCX RDX RSI lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rdx, lpszSource
    mov rbx, lpszDestination
    mov rax, -1
    mov rsi, 1

  @@:
    add rax, rsi
    movzx rcx, BYTE PTR [rdx+rax]
    mov [rbx+rax], cl
    test rcx, rcx
    jnz @B

    ret
String_CopyA ENDP


END

