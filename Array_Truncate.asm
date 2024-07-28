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

_Array_SysFreeString         PROTO pString:QWORD

;GlobalReAlloc   PROTO pMem:QWORD, dwBytes:QWORD, uFlags:DWORD
;SysFreeString   PROTO pString:QWORD
;IFNDEF GMEM_MOVEABLE
;GMEM_MOVEABLE EQU 0002h
;ENDIF
;includelib kernel32.lib
;includelib OleAut32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_Truncate
;
; Truncate (shrink) an array and free any excess items.
;
; Parameters:
; 
; * pArray - pointer to the array to truncate.
; 
; * nItemCount - the new count of items for the array to shrink to.
; 
; Returns:
; 
; A pointer to the newly resized array, which is used with the other array 
; functions, or 0 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: arrtrunc
;
; See Also:
;
; Array_Extend, Array_Resize
; 
;------------------------------------------------------------------------------
Array_Truncate PROC FRAME USES RBX RCX RDI RSI pArray:QWORD, nItemCount:QWORD
    LOCAL acnt:QWORD
    LOCAL arr:QWORD
    
    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF
    
    mov rax, pArray                         
    mov rax, [rax]                          ; get the array member count
    mov acnt, rax                           ; write it to old count variable
    mov rdi, nItemCount

    cmp rdi, acnt
    jl @F
    mov rax, 0 ;-1                          ; *** ERROR *** indx exceeds array length
    jmp quit
  @@:

    mov rsi, pArray
    mov rbx, nItemCount
    add rbx, 1

  @@:
    mov rax, [rsi+rbx*8]
    cmp QWORD PTR [rax], 0                  ; if member is a null pointer
    je nxt                                  ; bypass deallocating OLE string
    Invoke _Array_SysFreeString, [rsi+rbx*8]
    ;invoke SysFreeString, [rsi+rbx*8]
  nxt:

    add rbx, 1
    cmp rbx, acnt
    jle @B

    mov rax, nItemCount
    lea rax, [8+rax*8]                      ; mul by 4 plus 4 added
    
    Invoke Memory_Realloc, pArray, rax
    ;Invoke GlobalReAlloc, pArray, rax, GMEM_MOVEABLE
    mov arr, rax
    mov rsi, arr
    mov rdi, nItemCount
    mov QWORD PTR [rsi], rdi

    mov rax, arr

  quit:

    ret
Array_Truncate ENDP


END

