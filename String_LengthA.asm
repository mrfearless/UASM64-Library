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
; String_LengthA
;
; Reads the length of a zero terminated string and returns its length in RAX.
; This is the Ansi version of String_Length, String_LengthW is the Unicode 
; version.
;
; Parameters:
; 
; * lpszString - Address of zero terminated string.
; 
; Returns:
; 
; The length of the zero terminated string without the terminating null in RAX.
; 
; Notes:
;
; This function as based on the MASM32 Library function: szLen
;
; See Also:
;
; String_CopyA, String_ConcatA
; 
;------------------------------------------------------------------------------
String_LengthA PROC FRAME USES RCX RDX lpszString:QWORD
    
    .IF lpszString == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rcx, lpszString
    mov rdx, -1
    mov rax, -1

  @@:
    add rdx, 1
    add rax, 1
    cmp BYTE PTR [rcx+rdx], 0
    jne @B

;  ; rcx = address of string
;
;    mov rax, lpszString
;    sub rax, 1
;  lbl:
;  REPEAT 3
;    add rax, 1
;    movzx r10, BYTE PTR [rax]
;    test r10, r10
;    jz lbl1
;  ENDM
;
;    add rax, 1
;    movzx r10, BYTE PTR [rax]
;    test r10, r10
;    jnz lbl
;
;  lbl1:
;    sub rax, lpszString

    ret
String_LengthA ENDP


END

