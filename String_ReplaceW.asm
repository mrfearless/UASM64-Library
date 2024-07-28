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
; String_ReplaceW
;
; Replaces text in a zero terminated string.
; 
; Parameters:
; 
; * lpszSource - The address of the source to replace text in.
; 
; * lpszDestination - The address of the destination string for the results.
; 
; * lpszTextToReplace - The address of the substring text to replace in the 
;   source string.
; 
; * lpszReplacementText - The address of the replacement text to use in place
;   of the text in the lpszTextToReplace parameter in the source string.
;
; Returns:
; 
; No return value.
; 
; Notes:
;
; This function as based on the MASM32 Library function: ucRep
;
; See Also:
;
; String_RemoveW, String_WordReplaceW, String_MiddleW
; 
;------------------------------------------------------------------------------
String_ReplaceW PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD
    LOCAL lsrc:QWORD

    Invoke String_LengthW, lpszSource
    mov lsrc, rax

    Invoke String_LengthW, lpszTextToReplace
    sub lsrc, rax

    mov rax, lsrc
    add lsrc, rax               ; double len to get byte length

    mov rsi, lpszSource
    add lsrc, rsi               ; set exit condition
    mov rbx, lpszTextToReplace
    add lsrc, 2                 ; adjust to get last character
    mov rdi, lpszDestination
    sub rsi, 2
    jmp rpst
  ; ----------------------------
  align 4
  pre:
    add rsi, rcx                ; ecx = len of txt1, add it to ESI for next read
  align 4
  rpst:
    add rsi, 2
    cmp lsrc, rsi               ; test for exit condition
    jle rpout
    movzx rax, WORD PTR [rsi]   ; load WORD from source
    cmp ax, word ptr [rbx]      ; test it against 1st character in txt1
    je test_match
    mov word ptr [rdi], ax      ; write byte to destination
    add rdi, 2
    jmp rpst
  ; ----------------------------
  align 4
  test_match:
    mov rcx, -2                 ; clear ECX to use as index
    mov rdx, rbx                ; load txt1 address into EDX
  @@:
    add rcx, 2
    movzx rax, WORD PTR [rdx]
    test rax, rax               ; if you have got to the zero
    jz change_text              ; replace the text in the destination
    add rdx, 2
    cmp word ptr [rsi+rcx], ax  ; keep testing character matches
    je @B
    movzx rax, WORD PTR [rsi]   ; if text does not match
    mov word ptr [rdi], ax      ; write byte at ESI to destination
    add rdi, 2
    jmp rpst
  ; ----------------------------
  align 4
  change_text:                  ; write txt2 to location of txt1 in destination
    mov rdx, lpszReplacementText
    sub rcx, 2
  @@:
    movzx rax, WORD PTR [rdx]
    test rax, rax
    jz pre
    add rdx, 2
    mov word ptr [rdi], ax
    add rdi, 2
    jmp @B
  ; ----------------------------
  align 4
  rpout:                        ; write any last characters and terminator
    mov rcx, -2
  @@:
    add rcx, 2
    movzx rax, WORD PTR [rsi+rcx]
    mov word ptr [rdi+rcx], ax
    test rax, rax
    jnz @B
    ret

String_ReplaceW ENDP


END

