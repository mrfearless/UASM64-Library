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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_Remove
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
;------------------------------------------------------------------------------
String_Remove PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD,lpszDestination:QWORD,lpszSubStringToRemove:QWORD

    mov rdx, lpszSubStringToRemove
    mov bl, [rdx]               ; 1st remv char in AH

    mov rsi, lpszSource
    mov rdi, lpszDestination
    sub rsi, 1

  ; --------------------------------------------------------

  prescan:
    add rsi, 1
  scanloop:
    cmp [rsi], bl               ; test for "remv" start char
    je presub
  backin:
    movzx rax, BYTE PTR [rsi]
    mov [rdi], al
    cmp BYTE PTR [rdi], 0       ; exit when zero terminator
    je szrOut                   ; has been written
    add rdi, 1
    jmp prescan

  align 8
  presub:
    xor rcx, rcx
  subloop:
  REPEAT 3
    movzx rax, BYTE PTR [rsi+rcx]
    cmp al, [rdx+rcx]
    jne backin                  ; jump back on mismatch
    add rcx, 1
    cmp BYTE PTR [rdx+rcx], 0   ; test if next byte is zero
    je @F
  ENDM

    movzx rax, BYTE PTR [rsi+rcx]
    cmp al, [rdx+rcx]
    jne backin                  ; jump back on mismatch
    add rcx, 1
    cmp BYTE PTR [rdx+rcx], 0   ; test if next byte is zero
    jne subloop

  @@:
    add rsi, rcx
    jmp scanloop

  ; --------------------------------------------------------

  szrOut:

    mov rax, lpszDestination    ; return the destination address

    ret
String_Remove ENDP


END

