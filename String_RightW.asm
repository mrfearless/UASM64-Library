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
; String_RightW
;
; Gets a substring from the right side of a zero terminated string. String_Right 
; reads a set number of characters from the end (right) position in the source 
; zero terminated string and writes them to the destination string address.
; 
; Parameters:
; 
; * lpszSource - Address of the source string
; 
; * lpszDestination - Address of the destination buffer.
; 
; * qwLengthToRead - The number of characters to read from the right side.
; 
; Returns:
; 
; Returns a pointer to the destination string in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: ucRight
;
; See Also:
;
; String_LeftW, String_MiddleW, String_SubstringW
; 
;------------------------------------------------------------------------------
String_RightW PROC FRAME USES RCX RDX RDI lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszDestination == 0 || qwLengthToRead == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, qwLengthToRead
    add qwLengthToRead, rax     ; double ccnt

    invoke String_LengthW, lpszSource
    add rax, rax                ; double char count to get byte length

    mov rdx, lpszSource
    add rdx, rax
    sub rdx, qwLengthToRead
    mov rdi, lpszDestination
    xor rcx, rcx

  @@:
    mov ax, word ptr [rdx+rcx]
    mov word ptr [rdi+rcx], ax
    add rcx, 2
    test ax, ax
    jne @B
    
    mov rax, lpszDestination
    
    ret
String_RightW ENDP


END

