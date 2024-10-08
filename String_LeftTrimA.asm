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
; String_LeftTrimA
;
; Trims the leading spaces and tabs from a zero terminated string and places 
; the results in the destination buffer provided. This is the Ansi version of 
; String_LeftTrim, String_LeftTrimW is the Unicode version.
;
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination - The address of the destination buffer.
; 
; Returns:
; 
; The return value is the length of the trimmed string which can be zero.
;
; Notes:
;
; If the string is trimmed to zero length if it has no other characters, the 
; first byte of the destination address will be ascii zero. Ensure the 
; destination buffer is big enough to receive the substring, normally it is 
; advisable to make the buffer the same size as the source string. If your 
; design allows for overwriting the string, you can use the same string 
; address for both source and destination.
;
; This function as based on the MASM32 Library function: szLtrim
;
; See Also:
;
; String_RightTrimA, String_MonospaceA, String_TrimA
; 
;------------------------------------------------------------------------------
String_LeftTrimA PROC FRAME USES RCX RDX RDI lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    xor rcx, rcx
    mov rdx, lpszSource
    mov rdi, lpszDestination
    sub rdx, 1

  @@:
    add rdx, 1
    cmp BYTE PTR [rdx], 32
    je @B
    cmp BYTE PTR [rdx], 9
    je @B
    cmp BYTE PTR [rdx], 0
    jne @F
    xor rax, rax            ; return zero on empty string
    mov BYTE PTR [rdi], 0   ; set string length to zero
    jmp szlOut
  @@:
    mov al, [rdx+rcx]
    mov [rdi+rcx], al
    add rcx, 1
    test al, al
    jne @B

    mov rax, rcx
    sub rax, 1              ; don't count ascii zero
                            ; return length of remaining string

    mov rcx, lpszDestination

  szlOut:


    ret
String_LeftTrimA ENDP


END

