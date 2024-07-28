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
; Array_LoadItemsFromFile
;
; Create an array by loading a text file. Each line of the text file is set as
; a new item in the array. 
; 
; Parameters:
; 
; * lpszFilename - filename to load and create an array from.
; 
; Returns:
; 
; A pointer to the newly created array, which is used with the other array 
; functions, or 0 if an error occurred.
;
; Notes:
;
; This function as based on the MASM32 Library function: arrfile
;
; See Also:
;
; Array_LoadItemsFromMem, Array_SaveItemsToFile, Array_SaveItemsToMem
; 
;------------------------------------------------------------------------------
Array_LoadItemsFromFile PROC FRAME USES RBX RCX lpszFilename:QWORD
    LOCAL arr:QWORD
    LOCAL hMem:QWORD
    LOCAL flen:QWORD
    LOCAL lcnt:QWORD
    LOCAL pbuf:QWORD
    LOCAL spos:QWORD
    LOCAL void:QWORD

    ;push ebx
    Invoke  File_ReadFileToMemoryA, lpszFilename, Addr hMem, Addr flen
    ;Invoke InputFile, lpszFilename
    ;mov hMem, rax ; InputFile(file_name)
    ;mov flen, rcx
    Invoke Text_LineCountExA, hMem, flen
    ;Invoke get_line_count, hMem, flen
    mov lcnt, rax ; rv(get_line_count,hMem,flen)
    Invoke Array_Create, lcnt
    mov arr, rax ; arralloc$(lcnt)
    
    Invoke Memory_Alloc, rax
    ;Invoke GlobalAlloc, GMEM_FIXED, rax
    mov pbuf, rax ; alloc(flen)

    mov spos, 0
    mov rbx, 1
  @@:
    Invoke Text_ReadLineA, hMem, pbuf, spos
    ;Invoke readline, hMem, pbuf, spos
    mov spos, rax ; rv(readline,hMem,pbuf,spos)
    Invoke Array_ItemSetText, arr, rbx, pbuf
    mov void, rax ; arrset$(arr,rbx,pbuf)
    add rbx, 1
    cmp rbx, lcnt
    jle @B
    
    Invoke Memory_Free, pbuf
    Invoke Memory_Free, hMem
    
    ;Invoke GlobalFree, pbuf
    ;Invoke GlobalFree, hMem
    ;free pbuf
    ;free hMem

    mov rax, arr
    ;pop ebx
    ret
Array_LoadItemsFromFile ENDP


END

