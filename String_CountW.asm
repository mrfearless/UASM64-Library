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
; String_CountW
;
; Count the number of instances of a specified substring in a zero terminated 
; string.
; 
; Parameters:
; 
; * lpszSource - The address of the zero terminated string.
; 
; * lpszSubString - The zero terminated substring to count.
; 
; Returns:
; 
; The return value is the number of instances of the substring that was 
; counted in the source string.
;
; Notes:
;
; This function as based on the MASM32 Library function: ucWcnt
;
; See Also:
;
; String_InStringW, String_SubstringW
; 
;------------------------------------------------------------------------------
String_CountW PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD, lpszSubString:QWORD

    .IF lpszSource == 0 || lpszSubString == 0
        mov rax, 0
        ret
    .ENDIF

    Invoke String_LengthW, lpszSource           ; get src length
    add rax, rax
    push rax
    Invoke String_LengthW, lpszSubString        ; get txt length
    add rax, rax
    pop rdx
    sub rdx, rax

    mov rax, -1
    mov rsi, lpszSource         ; source in ESI
    add rdx, rsi                ; add src to exit position
    xor rbx, rbx                ; clear EBX to prevent stall with BH
    add rdx, 2                  ; correct to get last word
    mov rdi, lpszSubString      ; text to count in EDI
    sub rsi, 2

  pre:
    add rax, 1                  ; increment word count return value
  align 8
  wcst:
    add rsi, 2
    cmp rdx, rsi                ; test for exit condition
    jle wcout
    mov bx, [rsi]               ; load byte at ESI
    cmp bx, [rdi]               ; test against 1st character in EDI
    jne wcst
    xor rcx, rcx
  align 8
  test_word:
    add rcx, 2
    cmp WORD PTR [rdi+rcx], 0   ; if terminator is reached
    je pre                      ; jump back and increment counter
    mov bx, [rsi+rcx]           ; load character at ESI
    cmp bx, [rdi+rcx]           ; test against 1st character in EDI
    jne wcst                    ; exit if mismatch
    jmp test_word               ; else loop back
  wcout:

    ret
String_CountW ENDP


END

