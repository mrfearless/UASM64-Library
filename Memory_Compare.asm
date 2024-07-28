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
; Memory_Compare
;
; Compare two memory addresses of the same known length.
; 
; Parameters:
; 
; * pMemoryAddress1 - The first memory location to test.
; 
; * pMemoryAddress2 - The second memory location to test against the first.
; 
; * qwMemoryLength - The length of the buffers in BYTES.
; 
; Returns:
; 
; 0 = different. non 0 = byte identical.
; 
; Notes:
;
; This function as based on the MASM32 Library function: cmpmem
;
;------------------------------------------------------------------------------
Memory_Compare PROC FRAME USES RCX RDX RDI RSI pMemoryAddress1:QWORD, pMemoryAddress2:QWORD, qwMemoryLength:QWORD
    mov rcx, pMemoryAddress1        ; buf1
    mov rdx, pMemoryAddress2        ; buf2

    xor rsi, rsi
    xor rax, rax
    mov rdi, qwMemoryLength         ; bcnt
    cmp rdi, 8
    jb under

    shr rdi, 3                      ; div by 4

  align 8
  @@:
    mov rax, [rcx+rsi]              ; DWORD compare main file
    cmp rax, [rdx+rsi]
    jne fail
    add rsi, 8
    sub rdi, 1
    jnz @B

    mov rdi, qwMemoryLength         ; bcnt; calculate any remainder
    and rdi, 7
    jz match                        ; exit if its zero

  under:
    movzx rax, BYTE PTR [rcx+rsi]   ; BYTE compare tail
    cmp al, [rdx+rsi]
    jne fail
    add rsi, 1
    sub rdi, 1
    jnz under

    jmp match

  fail:
    xor rax, rax                    ; return zero if DIFFERENT
    jmp quit

  match:
    mov rax, 1                      ; return NON zero if SAME

  quit:
    ret
Memory_Compare ENDP


END

