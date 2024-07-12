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

; NOTE: doesnt work, use lstrlen instead for the moment

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_Left
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
;------------------------------------------------------------------------------
String_Left PROC FRAME USES RBX RCX RDX lpszSource:QWORD,lpszDestination:QWORD,qwLengthToRead:QWORD

    mov rdx, qwLengthToRead     ; ln
    mov rax, lpszSource         ; src
    mov rcx, lpszDestination    ; dst

    add rax, rdx
    add rcx, rdx
    neg rdx

    ;push rbx

  align 8
  @@:
    movzx rbx, BYTE PTR [rax+rdx]
    mov [rcx+rdx], bl
    add rdx, 1
    jnz @B

    mov BYTE PTR [rcx+rdx], 0

    ;pop rbx

    mov rax, lpszDestination    ; return the destination address in EAX

    ret
String_Left ENDP


END

