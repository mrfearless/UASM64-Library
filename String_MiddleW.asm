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
; String_MiddleW
;
; Gets a substring from the middle of a zero terminated string. String_Middle 
; reads a set number of characters from a set starting position in the source 
; zero terminated string and writes them to the destination string address.
; 
; Parameters:
; 
; * lpszSource - Address of the source string to read from.
; 
; * lpszSubString - Address of the destination string to receive the substring.
; 
; * qwStartPosition - Start position of first character in the source string.
; 
; * qwLengthToRead - The number of bytes to read in the source string.
;
; Returns:
; 
; There is no return value.
;
; Notes:
;
; It is the users responsibility to ensure that the length of the substring is 
; fully contained within the source string. Failure to do so will result in 
; either a read or write page fault.
; 
; This function as based on the MASM32 Library function: ucMid
;
; See Also:
;
; String_LeftW, String_RightW, String_MiddleW
; 
;------------------------------------------------------------------------------
String_MiddleW PROC FRAME USES RBX RCX RDX lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszSubString == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, qwStartPosition
    add qwStartPosition, rax        ; double start pos
    sub QWORD PTR qwStartPosition, 2; correct for base 1 character

    mov rax, qwLengthToRead         ; double length
    add qwLengthToRead, rax

    mov rdx, lpszSource
    add rdx, qwStartPosition
    mov rdi, lpszSubString
    xor rcx, rcx

  @@:
    mov ax, word ptr [rdx+rcx]
    mov word ptr [rdi+rcx], ax
    add rcx, 2
    cmp rcx, qwLengthToRead
    jne @B

    mov WORD PTR [rdi+rcx], 0

    ret
String_MiddleW ENDP


END

