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
; String_ReplaceA
;
; Replaces text in a zero terminated string. This is the Ansi version of 
; String_Replace, String_ReplaceW is the Unicode version.
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
; This function as based on the MASM32 Library function: szRep
;
; See Also:
;
; String_RemoveA, String_WordReplaceA, String_MiddleA
; 
;------------------------------------------------------------------------------
String_ReplaceA PROC FRAME USES RBX RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD
    LOCAL lsrc:QWORD
    
    Invoke String_LengthA, lpszSource
    mov lsrc, rax               ; procedure call for src length
    Invoke String_LengthA, lpszTextToReplace
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

String_ReplaceA ENDP


END

