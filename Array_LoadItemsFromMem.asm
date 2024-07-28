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
;GlobalFree  PROTO pMem:QWORD
;
;IFNDEF GMEM_FIXED
;GMEM_FIXED EQU 0000h
;ENDIF
;
;includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_LoadItemsFromMem
;
; Create an array by loading items array from memory. Each line of the text 
; in memory is set as a new item in the array. 
;
; Parameters:
; 
; * pMemory - address of memory where array items are stored.
; 
; Returns:
; 
; A pointer to the newly created array, which is used with the other array 
; functions, or 0 if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrtxt
;
; See Also:
;
; Array_LoadItemsFromFile, Array_SaveItemsToFile, Array_SaveItemsToMem
; 
;------------------------------------------------------------------------------
Array_LoadItemsFromMem PROC FRAME USES RBX RCX RDI RSI pMemory:QWORD
    LOCAL flen:QWORD
    LOCAL lcnt:QWORD
    LOCAL pbuf:QWORD
    LOCAL spos:QWORD
    LOCAL parr:QWORD
    LOCAL setv:QWORD
    
    Invoke String_LengthA, pMemory
    mov flen, rax ; rv(StrLen,ptxt)         ; save its length
    
    Invoke Text_LineCountExA, pMemory, flen
    ;Invoke get_line_count, pMemory, flen
    mov lcnt, rax ; rv(get_line_count,ptxt,flen)  ; get the line count
    mov flen, rcx                           ; store corrected byte count
    
    Invoke Memory_Alloc, flen
    ;Invoke GlobalAlloc, GMEM_FIXED, flen
    mov pbuf, rax ; alloc(flen)             ; allocate buffer at length of text
    
    Invoke Array_Create, lcnt
    mov parr, rax ; arralloc$(lcnt)         ; allocate empty array

    mov spos, 0                             ; set start pos to 0
    mov rbx, 1                              ; use EBX as 1 based index

  @@:
    Invoke Text_ReadLineA, pMemory, pbuf, spos
    ;Invoke readline, ptxt, pbuf, spos
    mov spos, rax ; rv(readline,ptxt,pbuf,spos)   ; read each line in sequence
    Invoke Array_ItemSetText, parr, rbx, pbuf
    mov setv, rax ; arrset$(parr,ebx,pbuf)       ; write each line to the string array
    add rbx, 1
    cmp rbx, lcnt
    jle @B
    
    Invoke Memory_Free, pbuf
    ;Invoke GlobalFree, pbuf ; free pbuf     ; free the buffer memory

    mov rax, parr                           ; return the array address

    ret
Array_LoadItemsFromMem ENDP


END

