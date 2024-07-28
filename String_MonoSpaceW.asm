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
; String_MonoSpaceW
;
; Format a string with single spaces and trimmed ends. String_MonoSpace formats
; a zero terminated string with single spaces only, replacing any tabs with 
; spaces and trimming tabs and spaces from either end of the string.
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
; This function as based on the MASM32 Library function: ucMonoSpace
;
; See Also:
;
; String_LowercaseW, String_UppercaseW, String_LeftTrimW, String_RightTrimW
; 
;------------------------------------------------------------------------------
String_MonoSpaceW PROC FRAME USES RBX RCX RDX RDI RSI RBP lpszSource:QWORD

    mov rsi, 2
    mov rdi, 32
    mov rbx, 32
    mov rbp, 9

    mov rcx, [esp+20]
    xor rax, rax
    sub rcx, rsi
    mov rdx, [esp+20]
    jmp ftrim                       ; trim the start of the string

  wspace:
    mov WORD PTR [rdx], bx          ; always write a space
    add rdx, rsi

  ftrim:
    add rcx, rsi
    movzx rax, WORD PTR [rcx]
    cmp rax, rdi                    ; throw away space
    je ftrim
    cmp rax, rbp                    ; throw away tab
    je ftrim
    sub rcx, rsi

  stlp:
    add rcx, rsi
    movzx rax, WORD PTR [rcx]
    cmp rax, rdi                    ; loop back on space
    je wspace
    cmp rax, rbp                    ; loop back on tab
    je wspace
    mov [rdx], ax                   ; write the non space character
    add rdx, rsi
    test rax, rax                   ; if its not zero, loop back
    jne stlp

    cmp WORD PTR [edx-4], bx        ; test for a single trailing space
    jne quit
    mov WORD PTR [edx-4], 0         ; overwrite it with zero if it is

  quit:
    mov rax, [esp+20]

    ret
String_MonoSpaceW ENDP


END

