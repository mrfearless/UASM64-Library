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
;IFNDEF GMEM_ZEROINIT
;GMEM_ZEROINIT EQU 0040h
;ENDIF
;
;includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_CreateEx
;
; Create a new array with a specified number of empty items of a specified size
; (in bytes) of each item.
; 
; Parameters:
; 
; * nItemCount - Number of items that the array created will hold.
; 
; * nItemSize - byte count for each item.
;
; Returns:
; 
; In RAX a pointer to the newly created array, which is used with the other 
; array functions. In RCX a pointer to the string memory address. If an error
; occurs, both RAX and RCX will be set to 0.
;
; Notes:
;
; deallocate both of the returned memory handles when the array is no longer 
; required.
;
; This function as based on the MASM32 Library function: create_array
;
; See Also:
;
; Array_Create, Array_Destroy, Array_Resize
; 
;------------------------------------------------------------------------------
Array_CreateEx PROC FRAME USES RDX nItemCount:QWORD, nItemSize:QWORD
    LOCAL lparr:QWORD
    LOCAL lpmem:QWORD
    
    mov lparr, 0
    mov rax, nItemCount
    shl rax, 3                  ; multiply by 8
    Invoke Memory_Alloc, rax
    ;Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, rax
    .IF rax == 0
        jmp Array_CreateEx_Error
    .ENDIF
    mov lparr, rax ; alloc(ecx) ; allocate array

    mov rcx, nItemSize
    mov rax, nItemCount
    imul rcx                    ; multiply count by BYTE size for string memory length
    Invoke Memory_Alloc, rax
    ;Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, rax
    .IF rax == 0
        jmp Array_CreateEx_Error
    .ENDIF
    mov lpmem, rax ; alloc(eax) ; allocate string memory

    mov rax, lpmem              ; string memory start address
    mov rdx, lparr              ; array address
    mov rcx, nItemCount         ; item count
  @@:
    mov [rdx], rax              ; load address in EAX into location in array
    add rax, nItemSize          ; add "asize" for next start address
    add rdx, 8                  ; set next array location
    sub rcx, 1
    jnz @B

    mov rax, lparr              ; return address of array of pointers in EAX
    mov rcx, lpmem              ; return string memory address in ECX
    jmp Array_CreateEx_Exit

Array_CreateEx_Error:
    .IF lparr != 0
        Invoke Memory_Free, lparr
        ;Invoke GlobalFree, lparr
    .ENDIF
    mov rax, 0
    mov rcx, 0

Array_CreateEx_Exit:

    ret
Array_CreateEx ENDP


END

