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
; String_MultiCatW
;
; Concatenate multiple strings. String_MultiCat uses a buffer that can be 
; appended with multiple zero terminated strings, which is more efficient when 
; multiple strings need to be concantenated.
; 
; Parameters:
; 
; * qwNumberOfStrings - The number of zero terminated strings to append.
; 
; * lpszDestination - The address of the buffer to appends the strings to.
; 
; * StringArgs - The comma seperated parameter list, each with the address of a zero
;   terminated string to append to the main destination string.
; 
; Returns:
; 
; This function does not return a value.
;
; Notes:
;
; The allocated buffer pointed to by the lpszDestination parameter must be 
; large enough to accept all of the appended zero terminated strings. 

; The parameter count using StringArgs must match the number of zero terminated 
; strings as specified by the qwNumberOfStrings parameter.
; 
; This original algorithm was designed by Alexander Yackubtchik. It was 
; re-written in August 2006.
; 
; This function as based on the MASM32 Library function: ucMultiCat
;
; See Also:
;
; String_AppendW, String_ConcatW
; 
;------------------------------------------------------------------------------
String_MultiCatW PROC FRAME USES RCX RDX RDI RSI qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG

    xor rax, rax                ; clear EAX for following partial reads and writes
    mov rdi, lpszDestination
    xor rcx, rcx                ; clear arg counter
    lea rdx, StringArgs
    sub rdi, 2
  @@:
    add rdi, 2
    mov ax, [rdi]
    test ax, ax
    jne @B
  newstr:
    sub rdi, 2
    mov rsi, [rdx+rcx*8]
  @@:
    add rdi, 2
    mov ax, [rsi]
    mov [rdi], ax
    add rsi, 2
    test ax, ax
    jne @B
    add rcx, 1
    cmp rcx, qwNumberOfStrings
    jne newstr

    mov rax, lpszDestination

    ret
String_MultiCatW ENDP


END

