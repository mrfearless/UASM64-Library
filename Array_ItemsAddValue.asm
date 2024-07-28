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
; Array_ItemsAddValue
;
; Add an integer value for every item of a QWORD array.
;
; Parameters:
; 
; * pArray - pointer to the array.
;
; * nItemCount - the number of members of the array.
; 
; * qwValue - The integer value to add for every array item.
; 
; Returns:
;
; None. 
;
; Notes:
;
; This function as based on the MASM32 Library function: arr_add
;
; See Also:
;
; Array_ItemsMulValue, Array_ItemSsubValue, Array_ItemSetText, Array_ItemSetData
; 
;------------------------------------------------------------------------------
Array_ItemsAddValue PROC FRAME USES RCX RDX pArray:QWORD, nItemCount:QWORD, qwValue:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rdx, qwValue
    mov rax, pArray
    mov rcx, nItemCount
    add rcx, rcx
    add rcx, rcx
    add rax, rcx
    neg rcx
    jmp @F

  align 16
  @@:
    add [rax+rcx], rdx
    add rcx, 8;4
    jnz @B
    ret
Array_ItemsAddValue ENDP


END

