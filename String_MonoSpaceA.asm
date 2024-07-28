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
; String_MonoSpaceA
;
; Format a string with single spaces and trimmed ends. String_MonoSpace formats
; a zero terminated string with single spaces only, replacing any tabs with 
; spaces and trimming tabs and spaces from either end of the string. This is 
; the Ansi version of String_MonoSpace, String_MonoSpaceW is the Unicode 
; version.
;
; Parameters:
; 
; * lpszSource - The address of the zero terminated string to format.
; 
; Returns:
; 
; The return value is the address of the source string.
; 
; Notes:
;
; The algorithm removes any leading tabs and spaces then formats the string 
; with single spaces replacing any tabs in the source with spaces. 
; If there is a trailing space, the string is truncated to remove it.
;
; This function as based on the MASM32 Library function: szMonoSpace 	
;
; See Also:
;
; String_LowercaseA, String_UppercaseA, String_LeftTrimA, String_RightTrimA
; 
;------------------------------------------------------------------------------
String_MonoSpaceA PROC FRAME USES RBX RCX RDX RDI RSI RBP lpszSource:QWORD

    mov rsi, 1
    mov rdi, 32
    mov bl, 32
    mov rbp, 9

    mov rcx, lpszSource
    xor rax, rax
    sub rcx, rsi
    mov rdx, lpszSource
    jmp ftrim                       ; trim the start of the string

  wspace:
    mov BYTE PTR [rdx], bl          ; always write a space
    add rdx, rsi

  ftrim:
    add rcx, rsi
    movzx rax, BYTE PTR [rcx]
    cmp rax, rdi                    ; throw away space
    je ftrim
    cmp rax, rbp                    ; throw away tab
    je ftrim
    sub rcx, rsi

  stlp:
    add rcx, rsi
    movzx rax, BYTE PTR [rcx]
    cmp rax, rdi                    ; loop back on space
    je wspace
    cmp rax, rbp                    ; loop back on tab
    je wspace
    mov [rdx], al                   ; write the non space character
    add rdx, rsi
    test rax, rax                   ; if its not zero, loop back
    jne stlp

    cmp BYTE PTR [rdx-2], bl        ; test for a single trailing space
    jne quit
    mov BYTE PTR [rdx-2], 0         ; overwrite it with zero if it is

  quit:
    mov rax, lpszSource

    ret
String_MonoSpaceA ENDP


END

