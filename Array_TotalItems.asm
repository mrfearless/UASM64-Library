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
; Array_TotalItems
;
; Get the total count of all array items in an array.
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; Returns:
; 
; The count of array items, or 0 if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrcnt
;
; See Also:
;
; Array_TotalMemory
; 
;------------------------------------------------------------------------------
Array_TotalItems PROC FRAME pArray:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rax, pArray
    mov rax, [rax]
    ret
Array_TotalItems ENDP


END

