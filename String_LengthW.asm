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
; String_LengthW
;
; Reads the length of a zero terminated string and returns its length in RAX.
;
; Parameters:
; 
; * lpszString - Address of zero terminated string.
; 
; Returns:
; 
; The length of the zero terminated string without the terminating null in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: ucLen
;
; See Also:
;
; String_CopyW, String_ConcatW
; 
;------------------------------------------------------------------------------
String_LengthW PROC FRAME USES RCX RDX lpszString:QWORD

    .IF lpszString == 0
        mov rax, 0
        ret
    .ENDIF

    mov rcx, lpszString
    mov rdx, -2
    mov rax, -1

  @@:
    add rdx, 2
    add rax, 1
    cmp WORD PTR [rcx+rdx], 0
    jne @B

    ret
String_LengthW ENDP


END

