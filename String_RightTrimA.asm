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
; String_RightTrimA
;
; Trims the trailing spaces and tabs from a zero terminated string and places 
; the results in the destination buffer provided. This is the Ansi version of 
; String_RightTrim, String_RightTrimW is the Unicode version.
; 
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination -  The address of the destination buffer.
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
; This function as based on the MASM32 Library function: szRtrim
;
; See Also:
;
; String_LeftTrimA, String_MonospaceA, String_TrimA
; 
;------------------------------------------------------------------------------
String_RightTrimA PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rsi, lpszSource
    mov rdi, lpszDestination
    sub rsi, 1
  @@:
    add rsi, 1
    cmp BYTE PTR [rsi], 32
    je @B
    cmp BYTE PTR [rsi], 9
    je @B
    cmp BYTE PTR [rsi], 0
    jne @F
    xor rax, rax            ; return zero on empty string
    mov BYTE PTR [rdi], 0   ; set string length to zero
    jmp szLout

  @@:
    mov rsi, lpszSource
    xor rcx, rdx
    xor rcx, rcx        ; ECX as index and location counter

  @@:
    mov al, [rsi+rcx]   ; copy bytes from src to dst
    mov [rdi+rcx], al
    add rcx, 1
    test al, al
    je @F               ; exit on zero
    cmp al, 33
    jb @B
    mov rdx, rcx        ; store count if asc 33 or greater
    jmp @B

  @@:
    mov BYTE PTR [rdi+rdx], 0

    mov rax, rdx        ; return length of trimmed string
    mov rcx, lpszDestination

  szLout:

    ret
String_RightTrimA ENDP


END

