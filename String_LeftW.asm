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

; NOTE: doesnt work, use lstrlen instead for the moment

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_LeftW
;
; Gets a substring from the left side of a zero terminated string. String_Left 
; reads a set number of characters from the beginning (left) position in the 
; source zero terminated string and writes them to the destination string 
; address.
; 
; Parameters:
; 
; * lpszSource - Address of the source string.
; 
; * lpszDestination - Address of the destination buffer.
; 
; * qwLengthToRead - The number of characters to read from the left side.
; 
; Returns:
; 
; Returns a pointer to the destination string in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: ucLeft
;
; See Also:
;
; String_RightW, String_MiddleW, String_SubstringW
; 
;------------------------------------------------------------------------------
String_LeftW PROC FRAME USES RBX RCX RDX lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszDestination == 0 || qwLengthToRead == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, qwLengthToRead
    add qwLengthToRead, rax               ; double ccnt

    mov rax, lpszSource
    mov rdi, lpszDestination
    xor rcx, rcx

  @@:
    mov dx, [rax+rcx]
    mov [rdi+rcx], dx
    add rcx, 2
    cmp rcx, qwLengthToRead
    jne @B

    mov WORD PTR [rdi+rcx], 0

    ret
String_LeftW ENDP


END

