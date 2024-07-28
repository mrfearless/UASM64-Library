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
; String_TrimA
;
; Trims the leading and trailing spaces and tabs from a zero terminated string.
; This is the Ansi version of String_Trim, String_TrimW is the Unicode version.
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
; first byte of the destination address will be ascii zero. This procedure acts 
; on the original source string and overwrites it with the result. 
;
; This function as based on the MASM32 Library function: szTrim
;
; See Also:
;
; String_LeftTrimA, String_RightTrimA, String_MonospaceA
; 
;------------------------------------------------------------------------------
String_TrimA PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD

    mov rsi, lpszSource
    mov rdi, lpszSource
    xor rcx, rcx

    sub rsi, 1
  @@:
    add rsi, 1
    cmp BYTE PTR [rsi], 32  ; strip space
    je @B
    cmp BYTE PTR [rsi], 9   ; strip tab
    je @B
    cmp BYTE PTR [rsi], 0   ; test for zero after tabs and spaces
    jne @F
    xor rax, rax            ; set EAX to zero on 0 length result
    mov BYTE PTR [rdi], 0   ; set string length to zero
    jmp tsOut               ; and exit

  @@:
    mov al, [rsi+rcx]       ; copy bytes from src to dst
    mov [rdi+rcx], al
    add rcx, 1
    test al, al
    je @F                   ; exit on zero
    cmp al, 33              ; don't store positions lower than 33 (32 + 9)
    jb @B
    mov rdx, rcx            ; store count if asc 33 or greater
    jmp @B

  @@:
    mov BYTE PTR [rdi+rdx], 0

    mov rax, rdx        ; return trimmed string length
    mov rcx, lpszSource

  tsOut:

    ret
String_TrimA ENDP


END

