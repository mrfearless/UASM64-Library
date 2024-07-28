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
; String_ReverseW
;
; Reverses a zero terminated string in lpszSource and places it in the string
; buffer pointed to by the lpszDestination parameter.
; 
; Parameters:
; 
; * lpszSource - The address of the source string.
; 
; * lpszDestination - The address of the destination string buffer.
; 
; Returns:
; 
; Returns a pointer to the destination string in RAX.
;
; Notes:
;
; The destination string buffer must be at least the size of the source string 
; buffer, otherwise a read page fault will occur. String_Reverse can reverses a 
; string in a single memory buffer, so it can accept the same address as both 
; the source and destination string.
; 
; This function as based on the MASM32 Library function: ucRev
;
; See Also:
;
; String_LowercaseW, String_UppercaseW
; 
;------------------------------------------------------------------------------
String_ReverseW PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD

    xor rax, rax
    mov rsi, lpszSource
    mov rdi, lpszDestination
    mov rcx, -2

  @@:
    add rcx, 2
    mov ax, word ptr [rsi+rcx]       ; copy src to dst and get character count
    mov word ptr [rdi+rcx], ax
    test ax, ax
    jnz @B

    cmp rcx, 4              ; test for single character
    jb dont_bother          ; bypass swap code if it is

    mov rsi, rdi            ; put dst address in ESI
    add rdi, rcx
    sub rdi, 2
    shr rcx, 2              ; divide byte count by 4 to get loop counter

  @@:
    mov ax, word ptr [rsi]           ; swap end characters until middle
    mov dx, word ptr [rdi]
    mov word ptr [rdi], ax
    mov word ptr [rsi], dx
    add rsi, 2
    sub rdi, 2
    sub rcx, 1
    jnz @B
    
    mov rax, lpszDestination; return destination address
    
  dont_bother:

    ret
String_ReverseW ENDP


END

