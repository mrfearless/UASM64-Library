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
; String_CompareW
;
; A case sensitive string comparison that compares two zero terminated strings 
; for a difference.
; 
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
; This function as based on the MASM32 Library function: ucCmp
;
; See Also:
;
; String_CompareIW, String_CompareIExW
; 
;------------------------------------------------------------------------------
String_CompareW PROC FRAME USES RCX RDX RDI lpszString1:QWORD, lpszString2:QWORD

    .IF lpszString1 == 0 || lpszString2 == 0
        mov rax, 0
        ret
    .ENDIF

    mov rdx, lpszString1
    mov rdi, lpszString2
    mov rax, -2
    xor rcx, rcx

  @@:
    add rax, 2
    mov cx, [rdx+rax]
    cmp cx, [rdi+rax]
    jne mismatch
    test cx, cx
    jnz @B

    shr rax, 1          ; half for character count on match
    jmp match

  mismatch:
    xor rax, rax        ; zero for mismatch
   
  match:
    
    ret
String_CompareW ENDP


END

