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
; String_RemoveW
;
; Removes a substring from a zero terminated source string and writes the 
; result in the destination string address.
;
; Parameters:
; 
; * lpszSource - The address of the source string.
;
; * lpszDestination - The address of the destination string, after which it 
;   will contain the source string minus the substring specified in the 
;   lpszSubStringToRemove parameter.
;
; * lpszSubStringToRemove - The address of the substring to remove from the 
;   source string.
; 
; Returns:
; 
; The destination address is returned in the RAX register.
;
; Notes:
;
; The function supports using a single buffer for both the source and 
; destination strings if the original string does not need to be preserved.
; 
; This function as based on the MASM32 Library function: ucRemove
;
; See Also:
;
; String_MiddleW, String_ReplaceW, String_WordReplaceW
; 
;------------------------------------------------------------------------------
String_RemoveW PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD

    mov rdx, lpszSubStringToRemove
    mov bx, [rdx]               ; 1st remv char in BX

    mov rsi, lpszSource
    mov rdi, lpszDestination
    sub rsi, 2

  ; --------------------------------------------------------

  prescan:
    add rsi, 2
  scanloop:
    cmp [rsi], bx               ; test for "remv" start char
    je presub
  backin:
    movzx rax, WORD PTR [rsi]
    mov [rdi], ax
    cmp WORD PTR [rdi], 0       ; exit when zero terminator
    je szrOut                   ; has been written
    add rdi, 2
    jmp prescan

  align 4
  presub:
    xor rcx, rcx
  subloop:

  REPEAT 3
    movzx rax, WORD PTR [rsi+rcx]
    cmp ax, word ptr [rdx+rcx]
    jne backin                  ; jump back on mismatch
    add rcx, 2
    cmp BYTE PTR [rdx+rcx], 0   ; test if next byte is zero
    je @F
  ENDM

    movzx rax, WORD PTR [rsi+rcx]
    cmp ax, word ptr [rdx+rcx]
    jne backin                  ; jump back on mismatch
    add rcx, 2
    cmp BYTE PTR [rdx+rcx], 0   ; test if next byte is zero
    jne subloop

  @@:
    add rsi, rcx
    jmp scanloop

  ; --------------------------------------------------------

  szrOut:

    mov rax, lpszDestination    ; return the destination address

    ret
String_RemoveW ENDP


END

