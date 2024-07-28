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
; String_RightA
;
; Gets a substring from the right side of a zero terminated string. 
; String_Right reads a set number of characters from the end (right) position 
; in the source zero terminated string and writes them to the destination 
; string address. This is the Ansi version of String_Right, String_RightW is 
; the Unicode version.
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
; This function as based on the MASM32 Library function: szRight
;
; See Also:
;
; String_LeftA, String_MiddleA, String_SubstringA
; 
;------------------------------------------------------------------------------
String_RightA PROC FRAME USES RBX RCX RDX lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszDestination == 0 || qwLengthToRead == 0
        mov rax, 0
        ret
    .ENDIF

    Invoke String_LengthA, lpszSource        ; get source length
    sub rax, qwLengthToRead         ; sub required length from it
    mov rdx, lpszSource             ; source address in RDX
    add rdx, rax                    ; add difference to source address
    or rcx, -1                      ; index to minus one
    mov rax, lpszDestination        ; destination address in RAX

    ;push ebx

  @@:
    add rcx, 1
    movzx rbx, BYTE PTR [rdx+rcx]   ; copy bytes
    mov [rax+rcx], bl
    test rbx, rbx                   ; exit after zero written
    jne @B

    ;pop ebx

    mov rax, lpszDestination

    ret
String_RightA ENDP


END

