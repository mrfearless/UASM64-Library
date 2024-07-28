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
;includelib OleAut32.lib

include UASM64.inc

EXTERNDEF d_e_f_a_u_l_t__n_u_l_l_$ :QWORD

;.DATA
;d_e_f_a_u_l_t__n_u_l_l_$ DQ 0     ; default null string as placeholder
;                         DQ 0,0,0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_ItemSetText
;
; Write a zero terminated text string to an array item.
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * nItemIndex - the index of the array item to set the text for.
; 
; * lpszItemText - the text string to set for the specified item index.
; 
; Returns:
; 
; *  The written text length.
; *  0 if text length or argument is zero.
; * -1 bounds error, below 1.
; * -2 bounds error, above index.
; * -3 out of memory error.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrset
;
; See Also:
;
; Array_ItemAddress, Array_ItemLength, Array_ItemSetData
; 
;------------------------------------------------------------------------------
Array_ItemSetText PROC FRAME USES RBX RDI RSI pArray:QWORD, nItemIndex:QWORD, lpszItemText:QWORD
    LOCAL mcnt:QWORD
    LOCAL len:QWORD

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
      mov rax, -1                               ; return -1 below bound error
      jmp quit
    .endif

    .if rbx > mcnt
      mov rax, -2                               ; return -2 above bound error
      jmp quit
    .endif

    mov rax, [rsi+rbx*8]
    .if QWORD PTR [rax] != 0                    ; if its not a NULL string
        Invoke _Array_SysFreeString, [rsi+rbx*8]
        ;invoke SysFreeString, [rsi+rbx*8]         ; deallocate the array member
    .endif

    .if lpszItemText == 0
    null_string:                                ; reset to default null string
      lea rax, d_e_f_a_u_l_t__n_u_l_l_$
      mov [rsi+rbx*8], rax ; OFFSET d_e_f_a_u_l_t__n_u_l_l_$
      xor rax, rax                              ; return zero for string length
      jmp quit
    .else
      Invoke String_LengthA, lpszItemText
      mov rdi, rax ; rv(StrLen,ptxt)
      mov len, rax
      test rdi, rdi
      jz null_string
      
      Invoke _Array_SysAllocStringByteLen, lpszItemText, len
      ;invoke SysAllocStringByteLen, lpszItemText, edi     ; allocate a buffer of that length
      .if rax != 0
        mov [rsi+rbx*8], rax                    ; write new handle back to pointer array
        mov rax, rdi                            ; return the written length
      .else
        mov rax, -3                             ; return -3 out of memory error
        jmp quit
      .endif
    .endif

  quit:
    
    ret
Array_ItemSetText ENDP


END

