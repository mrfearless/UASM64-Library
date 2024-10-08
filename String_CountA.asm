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
; String_CountA
;
; Count the number of instances of a specified substring in a zero terminated 
; string. This is the Ansi version of String_Count, String_CountW is the 
; Unicode version.
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
; This function as based on the MASM32 Library function: szWcnt
;
; See Also:
;
; String_InStringA, String_SubstringA
; 
;------------------------------------------------------------------------------
String_CountA PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD, lpszSubString:QWORD

    .IF lpszSource == 0 || lpszSubString == 0
        mov rax, 0
        ret
    .ENDIF

    Invoke String_LengthA, lpszSource
    mov rdx, rax                ; procedure call for src length ; len([esp+16])
    Invoke String_LengthA, lpszSubString
    sub rdx, rax                ; procedure call for 1st text length ; len([esp+20])

    mov rax, -1
    mov rsi, lpszSource         ; source in ESI ; [esp+16]
    add rdx, rsi                ; add src to exit position
    xor rbx, rbx                ; clear EBX to prevent stall with BL
    add rdx, 1                  ; correct to get last word
    mov rdi, lpszSubString      ; text to count in EDI ; [esp+20]
    sub rsi, 1

  pre:
    add rax, 1                  ; increment word count return value
  align 8
  wcst:
    add rsi, 1
    cmp rdx, rsi                ; test for exit condition
    jle wcout
    mov bl, byte ptr [rsi]      ; load byte at ESI
    cmp bl, byte ptr [rdi]      ; test against 1st character in EDI
    jne wcst
    xor rcx, rcx
  align 8
  test_word:
    add rcx, 1
    cmp BYTE PTR [rdi+rcx], 0   ; if terminator is reached
    je pre                      ; jump back and increment counter
    mov bl, byte ptr [rsi+rcx]  ; load byte at ESI
    cmp bl, byte ptr [rdi+rcx]  ; test against 1st character in EDI
    jne wcst                    ; exit if mismatch
    jmp test_word               ; else loop back
  wcout:

    ret
String_CountA ENDP


END

