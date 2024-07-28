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
; String_AppendW
;
; Appends a zero terminated string to the end of an existing zero terminated 
; string. This is the Unicode version of String_Append, String_AppendA is the 
; Ansi version.
; 
; Parameters:
; 
; * lpszDestination - The main string buffer to append the extra string to.
; 
; * lpszSource - The string to append to the main string buffer.
; 
; * qwDestinationOffset - The location offset to begin the append at.
; 
; Returns:
; 
; The location of the end of the source buffer which can be used for the next 
; call to String_Append as the qwDestinationOffset parameter.
;
; Notes:
;
; This algorithm is designed to repeatedly append zero terminated string data 
; to the end of a user defined buffer. It uses a location pointer to save 
; repeatedly scanning the buffer for the end position. With a new buffer, the 
; first byte should be set to ascii zero, with an existing zero terminated 
; string in a buffer, you should supply the length and set the location 
; parameter to that length.

; The return value is the buffer end position which you pass back to the 
; function for the next appended data.
;
; NOTE that qwDestinationOffset is a BYTE counter. To get the UNICODE character 
; count, divide qwDestinationOffset by 2.
;
; This function as based on the MASM32 Library function: ucappend
;
; See Also:
;
; String_ConcatW, String_MultiCatW
; 
;------------------------------------------------------------------------------
String_AppendW PROC FRAME USES RCX RDX RDI RSI lpszDestination:QWORD,lpszSource:QWORD,qwDestinationOffset:QWORD

    .IF lpszSource == 0 || lpszDestination == 0
        mov rax, 0
        ret
    .ENDIF

    mov rsi, lpszDestination        ; string
    mov rcx, lpszSource             ; buffer
    add rsi, qwDestinationOffset    ; location ; add offset pointer to source address
    xor rax, rax
    
  @@:
    movzx rdx, WORD PTR [rcx+rax]
    mov [rsi+rax], dx
    add rax, 2
    test rdx, rdx
    jnz @B                          ; exit on written terminator

    add rax, qwDestinationOffset    ; location ; return updated offset pointer
    sub rax, 2

    ret
String_AppendW ENDP


END

