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

;GlobalFree      PROTO pMem:QWORD
;SysFreeString   PROTO pString:QWORD
;includelib kernel32.lib
;includelib OleAut32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_Destroy
;
; Deallocates and frees all array items and the array itself.

; Parameters:
; 
; * pArray - pointer to the array to destroy/free.
; 
; Returns:
; 
; The count of items deallocated/freed or 0 if an error occured.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrfree
;
; See Also:
;
; Array_Create, Array_CreateEx, Array_Resize
; 
;------------------------------------------------------------------------------
Array_Destroy PROC FRAME USES RBX RDI RSI pArray:QWORD

    .IF pArray == 0
        jmp Array_Destroy_Error
    .endif
    mov rsi, pArray ; [esp+4][12]
    mov rdi, [rsi]                  ; get count from 1st member
    mov rbx, 1
  @@:
    mov rax, [rsi+rbx*8]
    cmp QWORD PTR [rax], 0          ; if member is a NULL pointer
    jz nxt                          ; don't try and free an OLE string
    Invoke _Array_SysFreeString, rax
    ;Invoke SysFreeString, rax       ; else free each OLE string
  nxt:
    add rbx, 1
    cmp rbx, rdi
    jl @B
    
    Invoke Memory_Free, pArray
    ;Invoke GlobalFree, pArray ; [esp+4][12]   ; free the pointer array
    mov rax, rdi
    
    jmp Array_Destroy_Exit

Array_Destroy_Error:
    
    mov rax, 0

Array_Destroy_Exit:

    ret
Array_Destroy ENDP


END

