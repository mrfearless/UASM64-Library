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

;GlobalAlloc PROTO uFlags:DWORD, qwBytes:QWORD

;IFNDEF GMEM_FIXED
;GMEM_FIXED EQU 0000h
;ENDIF

;includelib kernel32.lib

include UASM64.inc

PUBLIC d_e_f_a_u_l_t__n_u_l_l_$

.DATA
d_e_f_a_u_l_t__n_u_l_l_$ DQ 0     ; default null string as placeholder
                         DQ 0,0,0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_Create
;
; Create a new array with a specified number of empty items.
;
; Parameters:
; 
; * nItemCount - Number of items that the array created will hold.
; 
; Returns:
; 
; A pointer to the newly created array, which is used with the other array 
; functions, or 0 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: arralloc
;
; See Also:
;
; Array_CreateEx, Array_Destroy, Array_Resize
; 
;------------------------------------------------------------------------------
Array_Create PROC FRAME USES RCX RDX RSI nItemCount:QWORD

    mov rax, nItemCount                         ; load the member count into EAX
    add rax, 1                                  ; correct for 1 based array
    lea rax, [0+rax*8]                          ; multiply it by 4 for memory size
    
    Invoke Memory_Alloc, rax
    ;Invoke GlobalAlloc, GMEM_FIXED, rax
    mov rsi, rax

    test rax, rax                               ; if allocation failure return zero
    jz quit

    mov rax, rsi
    mov rcx, nItemCount
    mov QWORD PTR [rax], rcx                    ; write count to 1st member

    xor rdx, rdx
  @@:
    add rdx, 1                                  ; write adress of null string to all members
    lea rax, d_e_f_a_u_l_t__n_u_l_l_$
    mov [rax+rdx*8], rax ; OFFSET d_e_f_a_u_l_t__n_u_l_l_$
    cmp rdx, rcx
    jle @B

    mov rax, rsi                                ; return pointer array handle

  quit:

    ret
Array_Create ENDP


END

