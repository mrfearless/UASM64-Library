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
; String_CompareA
;
; A case sensitive string comparison that compares two zero terminated strings 
; for a difference. This is the Ansi version of String_Compare, String_CompareW 
; is the Unicode version.
;
; Parameters:
; 
; * lpszString1 - The address of the first zero terminated string to compare.
; 
; * lpszString2 - The address of the second zero terminated string to compare.
; 
; Returns:
; 
; If the two strings match, the return value is the length of the string. 
; If there is no match, the return value is zero.
; 
; Notes:
;
; The function can be used on strings that may be of uneven length as the 
; terminator will produce the mismatch even if the rest of the characters match.
;
; This function as based on the MASM32 Library function: szCmp
;
; See Also:
;
; String_CompareIA, String_CompareIExA
; 
;------------------------------------------------------------------------------
String_CompareA PROC FRAME USES RBX RCX RDX RSI lpszString1:QWORD, lpszString2:QWORD

    .IF lpszString1 == 0 || lpszString2 == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rcx, lpszString1
    mov rdx, lpszString2

    mov rax, -1
    mov rsi, 1

  align 8
  cmst:
  REPEAT 3
    add rax, rsi
    movzx rbx, BYTE PTR [rcx+rax]
    cmp bl, [rdx+rax]
    jne no_match
    test rbx, rbx       ; check for terminator
    je retlen
  ENDM

    add rax, rsi
    movzx rbx, BYTE PTR [rcx+rax]
    cmp bl, [rdx+rax]
    jne no_match
    test rbx, rbx       ; check for terminator
    jne cmst

  retlen:               ; length is in EAX
    ret

  no_match:
    xor rax, rax        ; return zero on no match
    
    ret
String_CompareA ENDP


END

