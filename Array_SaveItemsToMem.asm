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
; Array_SaveItemsToMem
;
; Write the array items, separated with a carriage return and line feed (CRLF),
; to a pre-allocated memory buffer. 
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * pMemory - pointer to pre-allocated memory buffer.
; 
; Returns:
; 
; Number of array items written to memory buffer.
;
; Notes:
;
; This function as based on the MASM32 Library function: arr2text
;
; See Also:
;
; Array_SaveItemsToFile, Array_LoadItemsFromMem, Array_LoadItemsFromFile
; 
;------------------------------------------------------------------------------
Array_SaveItemsToMem PROC FRAME pArray:QWORD, pMemory:QWORD 
    LOCAL acnt:QWORD          ; array count
    LOCAL cloc:QWORD          ; current location pointer for szappend

    Invoke Array_TotalItems, pArray
    mov acnt, rax ;arrcnt$(arr) ; get the array count
    mov cloc, 0                 ; set current location pointer to start of buffer
    mov rbx, 1                  ; use EBX as a 1 based index
  @@:
    Invoke Array_ItemAddress, pArray, rbx
    ;mov rcx, rax ;arrget$(arr,ebx)
    Invoke String_AppendA, pMemory, rax, cloc
    mov cloc, rax ;rv(szappend,pmem,ecx,cloc)
    mov rsi, pMemory
    add rsi, cloc
    mov WORD PTR [rsi], 0A0Dh   ; append CRLF
    add cloc, 2                 ; correct cloc by 2 bytes
    add rbx, 1
    cmp rbx, acnt
    jle @B

    mov rax, acnt               ; return array line count
    ret
Array_SaveItemsToMem ENDP


END

