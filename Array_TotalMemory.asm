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
; Array_TotalMemory
;
; Get the total amount of memory to store the whole array and its items.
; 
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * lpdwTotalMemory - variable to store the total memory for the array.
; 
; Returns:
; 
; The total amount of memory that each array item takes up in total.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrtotal
;
; See Also:
;
; Array_TotalItems
; 
;------------------------------------------------------------------------------
Array_TotalMemory PROC FRAME USES RCX RDX RDI RSI pArray:QWORD, lpdwTotalMemory:QWORD
    mov rsi, pArray             
    mov rdi, [rsi]                  ; get the array member count
    xor rdx, rdx
    mov rcx, 1

  @@:
    mov rax, [rsi+rcx*8]            ; get array member address
    sub rax, 8                      ; sub 4 to get stored OLE length
    add rdx, [rax]                  ; add it to EDX
    add rcx, 1                      ; increment index
    cmp rcx, rdi                    ; test if index == array count
    jle @B

    ;cmp DWORD PTR [esp+8][8], 0
    ;je @F
    add rdx, rdi
    add rdx, rdi
  @@:

    mov rax, rdx
    ret
Array_TotalMemory ENDP


END

