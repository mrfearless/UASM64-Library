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
; String_LeftA
;
; Gets a substring from the left side of a zero terminated string. String_Left 
; reads a set number of characters from the beginning (left) position in the 
; source zero terminated string and writes them to the destination string 
; address. This is the Ansi version of String_LeftA, String_LeftW is the 
; Unicode version.
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
; This function as based on the MASM32 Library function: szLeft
;
; See Also:
;
; String_RightA, String_MiddleA, String_SubstringA
; 
;------------------------------------------------------------------------------
String_LeftA PROC FRAME USES RBX RCX RDX lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD

    .IF lpszSource == 0 || lpszDestination == 0 || qwLengthToRead == 0
        mov rax, 0
        ret
    .ENDIF

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
String_LeftA ENDP


END

