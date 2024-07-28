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

;GlobalReAlloc   PROTO pMem:QWORD, dwBytes:QWORD, uFlags:DWORD
;
;IFNDEF GMEM_MOVEABLE
;GMEM_MOVEABLE EQU 0002h
;ENDIF
;
;includelib kernel32.lib

include UASM64.inc

EXTERNDEF d_e_f_a_u_l_t__n_u_l_l_$ :QWORD

;.DATA
;d_e_f_a_u_l_t__n_u_l_l_$ DQ 0     ; default null string as placeholder
;                         DQ 0,0,0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_Extend
;
; Extend (grow) an array and add new empty items.
; 
; Parameters:
; 
; * pArray - pointer to the array to extend.
; 
; * nItemCount - the new count of items for the array to grow to.
; 
; Returns:
; 
; A pointer to the newly resized array, which is used with the other array 
; functions, or 0 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: arrextnd
;
; See Also:
;
; Array_Truncate, Array_Resize
; 
;------------------------------------------------------------------------------
Array_Extend PROC FRAME USES RBX RDI RSI pArray:QWORD, nItemCount:QWORD                 
    LOCAL acnt:QWORD
    LOCAL oldc:QWORD
    LOCAL arr:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, pArray                         ; get the array member count
    mov rax, [rax]
    mov oldc, rax                           ; write it to old count variable

    mov rdi, nItemCount
    cmp rdi, oldc
    jg @F
    mov rax, 0 ;-1                          ; *** ERROR *** indx not greater than oldc
    jmp quit

  @@:
    mov rax, rdi
    lea rax, [8+rax*8]                      ; set new pointer array size
    
    Invoke Memory_Realloc, pArray, rax
    ;Invoke GlobalReAlloc, pArray, rax, GMEM_MOVEABLE
    mov arr, rax ;, rv(GlobalReAlloc,arr,ecx,GMEM_MOVEABLE)
    mov rsi, arr
    mov [rsi], rdi                          ; store new array count in 1st array member
    mov rbx, oldc                           ; copy the old count to EBX
    add rbx, 1                              ; add 1 for 1 based index

  @@:
    lea rax, d_e_f_a_u_l_t__n_u_l_l_$
    mov [rsi+rbx*8], rax ; OFFSET d_e_f_a_u_l_t__n_u_l_l_$
    add rbx, 1                              ; increment index
    cmp rbx, [rsi]                          ; test if it matches the array count yet
    jle @B

    mov rax, arr                            ; return the reallocated memory address

  quit:

    ret
Array_Extend ENDP


END

