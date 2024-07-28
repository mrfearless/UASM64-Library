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
; Array_ItemAddress
;
; Get the address of an array item specified by the item index.
; 
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * nItemIndex - the index of the array item to return the address for.
; 
; Returns:
; 
; The address of the array item, or 0 if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrget
;
; See Also:
;
; Array_ItemLength, Array_ItemSetData, Array_ItemSetText
; 
;------------------------------------------------------------------------------
Array_ItemAddress PROC FRAME USES RCX RDX pArray:QWORD, nItemIndex:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, pArray ;[esp+4]                ; write array adress to EAX
    mov rcx, nItemIndex ;[esp+8]            ; write required index to ECX
    mov rdx, [rax]                          ; write member count to EDX

    cmp rcx, 1
    jl error1                               ; lower bound error
    cmp rcx, rdx
    jg error2                               ; upper bound error

    mov rax, [rax+rcx*8]                    ; write array member address to EAX
    ret ;8

  error1:
    mov rax, 0 ; -1                         ; return -1 on lower bound error
    ret ;8

  error2:
    mov rax, 0 ; -2                         ; return -2 on upper bound error
    ret ;8

    ret
Array_ItemAddress ENDP


END

