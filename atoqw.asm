; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

.686
.MMX
.XMM
.x64

option casemap : none
IF @Platform EQ 1
option win64 : 11
ENDIF
option frame : auto


.code

; ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл

align 8

atoqw PROC FRAME USES RCX RDX lpSrc:QWORD

    xor rax, rax                ; zero EAX
    mov rdx, lpSrc
    movzx rcx, BYTE PTR [rdx]
    add rdx, 1
    cmp rcx, "-"                ; test for sign
    jne lbl0
    add rax, 1                  ; set EAX if sign
    movzx rcx, BYTE PTR [rdx]
    add rdx, 1

  lbl0:
    push rax                    ; store sign on stack
    xor rax, rax                ; so eax*10 will be 0 for first digit

  lbl1:
    sub rcx, 48
    jc  lbl2
    lea rax, [rax+rax*4]        ; mul eax by 5
    lea rax, [rcx+rax*2]        ; mul eax by 2 and add digit value
    movzx rcx, BYTE PTR [rdx]   ; get next digit
    add rdx, 1
    jmp lbl1

  lbl2:
    pop rcx                     ; retrieve sign
    test rcx, rcx
    jnz lbl3
    ret

  lbl3:
    neg rax                     ; negative return value is sign set
    ret

atoqw ENDP


END

