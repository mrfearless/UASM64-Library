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
; Array_ItemLength
;
; Get the stored length of an array item.
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * nItemIndex - the index of the array item to return the length for.
; 
; Returns:
; 
; Returns the length of the array item, or 0 if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrlen
;
; See Also:
;
; Array_ItemAddress, Array_ItemSetData, Array_ItemSetText
; 
;------------------------------------------------------------------------------
Array_ItemLength PROC FRAME USES RCX pArray:QWORD, nItemIndex:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rcx, pArray                             ; load array adress in ESI
    mov rax, [rcx]                              ; write member count to EAX
    .IF nItemIndex > sqword ptr rax
        mov rax, 0
        ret
    .ENDIF

    mov rcx, pArray                     ; load array address
    mov rax, nItemIndex                 ; write index to EAX
    mov rax, [rcx+rax*8]                ; get the address of the OLE string
    sub rax, 8                          ; sub 4 from the address
    mov rax, [rax]                      ; write stored string length to EAX
    ret
Array_ItemLength ENDP


END

