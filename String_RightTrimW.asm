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
; String_RightTrimW
;
; Trims the trailing spaces and tabs from a zero terminated string and places 
; the results in the destination buffer provided.
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
; This function as based on the MASM32 Library function: ucRtrim
;
; See Also:
;
; String_LeftTrimW, String_MonospaceW
; 
;------------------------------------------------------------------------------
String_RightTrimW PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rsi, lpszSource
    mov rdi, lpszDestination
    xor rcx, rcx
    xor rax, rax
    xor rdx, rdx

  rtst:
    mov ax, word ptr [rsi+rcx]
    mov word ptr [rdi+rcx], ax
    test ax, ax
    jz rtout
    add rcx, 2
    cmp ax, 32
    je rtst
    mov rdx, rcx
    jmp rtst

  rtout:

    mov WORD PTR [rdi+rdx], 0

  szLout:

    ret
String_RightTrimW ENDP


END

