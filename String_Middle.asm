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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_Middle
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
;------------------------------------------------------------------------------
String_Middle PROC FRAME USES RBX RCX RDX lpszSource:QWORD,lpszSubString:QWORD,qwStartPosition:QWORD,qwLengthToRead:QWORD

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
String_Middle ENDP


END

