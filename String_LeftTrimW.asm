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
; String_LeftTrimW
;
; Trims the leading spaces and tabs from a zero terminated string and places 
; the results in the destination buffer provided.
;
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination - The address of the destination buffer.
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
; This function as based on the MASM32 Library function: ucLtrim
;
; See Also:
;
; String_RightTrimW, String_MonospaceW
; 
;------------------------------------------------------------------------------
String_LeftTrimW PROC FRAME USES RCX RDX lpszSource:QWORD, lpszDestination:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rdx, lpszSource
    mov rcx, lpszDestination
    sub rdx, 2

  @@:
    add rdx, 2
    cmp WORD PTR [rdx], 32
    jz @B

  @@:
    mov ax, [rdx]
    mov [rcx], ax
    add rdx, 2
    add rcx, 2
    test ax, ax

    ret
String_LeftTrimW ENDP


END

