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
; Array_Resize
;
; Resize array (reallocate array memory) to a different item count.
;
; Parameters:
; 
; * pArray - pointer to the array to resize.
; 
; * nItemCount - the new item count for the array.
; 
; Returns:
; 
; A pointer to the newly resized array, which is used with the other array 
; functions, or 0 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: arrealloc
;
; See Also:
;
; Array_Truncate, Array_Extend
; 
;------------------------------------------------------------------------------
Array_Resize PROC FRAME pArray:QWORD, nItemCount:QWORD
    
    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF
    
;    .IF nItemCount == 0                     ; free array?
;        Invoke Array_Destroy, pArray
;        mov rax, 0
;        ret 
;    .ENDIF
    
    Invoke Array_TotalItems, pArray
    .IF nItemCount < sqword ptr rax         ; truncate array to new size
        Invoke Array_Truncate, pArray, nItemCount
        
    .ELSEIF nItemCount > sqword ptr rax     ; extend array to new size
        Invoke Array_Extend, pArray, nItemCount
        
    .ELSE
        mov rax, pArray                     ; return original array pointer
    .ENDIF

;    .if cnt < arrcnt$(arr)
;      invoke truncate_string_array,arr,cnt  ; truncate array to new size
;      ret
;    .elseif cnt > arrcnt$(arr)
;      invoke extend_string_array,arr,cnt    ; extend array to new size
;      ret
;    .else
;      mov eax, arr                          ; return original array pointer
;    .endif

    ret
Array_Resize ENDP


END

