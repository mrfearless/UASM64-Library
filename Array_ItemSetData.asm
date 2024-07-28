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

_Array_SysAllocStringByteLen PROTO psz:QWORD, len:QWORD
_Array_SysFreeString         PROTO pString:QWORD

;SysAllocStringByteLen PROTO psz:QWORD, len:DWORD
;SysFreeString         PROTO pString:QWORD
;RtlMoveMemory         PROTO destination:QWORD, Source:QWORD, BytesToCopy:QWORD
;includelib OleAut32.lib
;includelib kernel32.lib

include UASM64.inc

EXTERNDEF d_e_f_a_u_l_t__n_u_l_l_$ :QWORD

;.DATA
;d_e_f_a_u_l_t__n_u_l_l_$ DQ 0     ; default null string as placeholder
;                         DQ 0,0,0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_ItemSetData
;
; Write byte data of a specified length to an array item.
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * nItemIndex - the index of the array item to set the data for.
; 
; * lpItemData - the data to set for the specified item index.
;
; * qwItemDataLength - the length of the data specified by lpItemData. 
;
; Returns:
; 
; *  The written binary data length.
; *  0 if length is zero.
; * -1 bounds error, below 1.
; * -2 bounds error, above index.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrbin
;
; See Also:
;
; Array_ItemAddress, Array_ItemLength, Array_ItemSetText
; 
;------------------------------------------------------------------------------
Array_ItemSetData PROC FRAME USES RBX RDI RSI pArray:QWORD, nItemIndex:QWORD, lpItemData:QWORD, qwItemDataLength:QWORD
    LOCAL mcnt:QWORD

    .IF pArray == 0
        mov rax, 0
        ret
    .ENDIF

    mov rsi, pArray                             ; load array adress in ESI
    mov rax, [rsi]                              ; write member count to EAX
    mov mcnt, rax                               ; store count in local mcnt
    mov rbx, nItemIndex                         ; store the index in EBX

  ; ---------------------
  ; array bounds checking.
  ; ---------------------
    .if rbx < 1
      mov rax, -1                               ; return -1 error
      jmp quit
    .endif

    .if rbx > mcnt
      mov rax, -2                               ; return -2 error
      jmp quit
    .endif
    
    Invoke _Array_SysFreeString, [rsi+rbx*8]
    ;invoke SysFreeString, [rsi+rbx*8]           ; deallocate the array member

    .if qwItemDataLength == 0
    null_string:                                ; reset to default null string
      lea rax, d_e_f_a_u_l_t__n_u_l_l_$
      mov [rsi+rbx*8], rax ; OFFSET d_e_f_a_u_l_t__n_u_l_l_$
      xor rax, rax                              ; return zero for string length
      jmp quit
    .else
        Invoke _Array_SysAllocStringByteLen, 0, qwItemDataLength
        ;invoke SysAllocStringByteLen, 0, dword ptr qwItemDataLength ; allocate a buffer of length "lsrc"
        mov [rsi+rbx*8], rax
      
        Invoke Memory_Copy, lpItemData, [rsi+rbx*8], qwItemDataLength
        ;Invoke RtlMoveMemory, [rsi+rbx*8], lpItemData, qwItemDataLength
      
        ;invoke MemCopy, lpItemData, [rsi+rbx*8], qwItemDataLength ; copy source to buffer
        mov rax, qwItemDataLength                 ; return string length
    .endif

  quit:

    ret
Array_ItemSetData ENDP


END

