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
; String_Replace
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
;------------------------------------------------------------------------------
String_Replace PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD,lpszDestination:QWORD,lpszTextToReplace:QWORD,lpszReplacementText:QWORD
    LOCAL lsrc:QWORD
    
    Invoke String_Length, lpszSource
    mov lsrc, rax               ; procedure call for src length
    Invoke String_Length, lpszTextToReplace
    sub lsrc, rax               ; procedure call for 1st text length

    mov rsi, lpszSource
    add lsrc, rsi               ; set exit condition
    mov rbx, lpszTextToReplace
    add lsrc, 1                 ; adjust to get last character
    mov rdi, lpszDestination
    sub rsi, 1
    jmp rpst
  ; ----------------------------
  align 8
  pre:
    add rsi, rcx                ; ecx = len of txt1, add it to ESI for next read
  align 8
  rpst:
    add rsi, 1
    cmp lsrc, rsi               ; test for exit condition
    jle rpout
    movzx rax, BYTE PTR [rsi]   ; load byte from source
    cmp al, [rbx]               ; test it against 1st character in txt1
    je test_match
    mov [rdi], al               ; write byte to destination
    add rdi, 1
    jmp rpst
  ; ----------------------------
  align 8
  test_match:
    mov rcx, -1                 ; clear ECX to use as index
    mov rdx, rbx                ; load txt1 address into EDX
  @@:
    add rcx, 1
    movzx rax, BYTE PTR [rdx]
    test rax, rax               ; if you have got to the zero
    jz change_text              ; replace the text in the destination
    add rdx, 1
    cmp [rsi+rcx], al           ; keep testing character matches
    je @B
    movzx rax, BYTE PTR [rsi]   ; if text does not match
    mov [rdi], al               ; write byte at ESI to destination
    add rdi, 1
    jmp rpst
  ; ----------------------------
  align 8
  change_text:                  ; write txt2 to location of txt1 in destination
    mov rdx, lpszReplacementText
    sub rcx, 1
  @@:
    movzx rax, BYTE PTR [rdx]
    test rax, rax
    jz pre
    add rdx, 1
    mov [rdi], al
    add rdi, 1
    jmp @B
  ; ----------------------------
  align 8
  rpout:                        ; write any last bytes and terminator
    mov rcx, -1
  @@:
    add rcx, 1
    movzx rax, BYTE PTR [rsi+rcx]
    mov [rdi+rcx], al
    test rax, rax
    jnz @B

    ret

String_Replace ENDP


END

