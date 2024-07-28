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
; String_MiddleA
;
; Gets a substring from the middle of a zero terminated string. String_Middle 
; reads a set number of characters from a set starting position in the source 
; zero terminated string and writes them to the destination string address. 
; This is the Ansi version of String_Middle, String_MiddleW is the Unicode 
; version.
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
; This function as based on the MASM32 Library function: szMid
;
; See Also:
;
; String_LeftA, String_RightA, String_SubstringA
; 
;------------------------------------------------------------------------------
String_MiddleA PROC FRAME USES RBX RCX RDX lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszSubString == 0
        mov rax, 0
        ret
    .ENDIF

    mov rcx, qwLengthToRead ; ln        length in RCX
    mov rdx, lpszSource     ; src       source address
    add rdx, rcx            ; add required length
    add rdx, qwStartPosition; stp       add starting position
    mov rax, lpszSubString  ; dst       destination address
    add rax, rcx            ; add length and set terminator position
    neg rcx                 ; invert sign

    ;push ebx

  @@:
    movzx rbx, BYTE PTR [rdx+rcx]
    mov [rax+rcx], bl
    add rcx, 1
    jnz @B

    ;pop ebx

    mov BYTE PTR [rax], 0   ; write terminator

    ret
String_MiddleA ENDP


END

