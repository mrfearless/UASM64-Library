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
; String_ConcatA
;
; Concatenate two strings by appending the second zero terminated string 
; (lpszSource) to the end of the first zero terminated string (lpszDestination)
; This is the Ansi version of String_Concat, String_ConcatW is the Unicode 
; version.
;
; The result is zero terminated.
;
; Parameters:
; 
; * lpszDestination - The address of the destination string to be appended to.
; 
; * lpszSource - The address of the string to append to destination string.
; 
; Returns:
; 
; No return value.
; 
; Notes:
;
; This function as based on the MASM32 Library function: szCatStr
;
; See Also:
;
; String_AppendA, String_MultiCatA
; 
;------------------------------------------------------------------------------
String_ConcatA PROC FRAME USES RCX RDX RDI lpszDestination:QWORD, lpszSource:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    Invoke String_LengthA, lpszDestination   ; get source length
    mov rdi, lpszDestination
    mov rcx, lpszSource
    add rdi, rax                            ; set write starting position
    xor rdx, rdx                            ; zero index

  @@:
    movzx rax, BYTE PTR [rcx+rdx]           ; write append string to end of source
    mov [rdi+rdx], al
    add rdx, 1
    test rax, rax                           ; exit when terminator is written
    jne @B

    mov rax, lpszDestination                ; return start address of source

    ret
String_ConcatA ENDP


END

