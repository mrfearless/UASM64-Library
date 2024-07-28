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

WriteFile PROTO hFile:QWORD, lpBuffer:QWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:QWORD, lpOverlapped:QWORD

includelib kernel32.lib

include UASM64.inc

.DATA
szASITF_CRLF DB 13,10,0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Array_SaveItemsToFile
;
; Saves all array items to a file.
;
; Parameters:
; 
; * pArray - pointer to the array.
; 
; * lpszFilename - filename to save the array items to.
; 
; Returns:
; 
; The length of the newly created file, or 0 if an error occurred.
;
; Notes:
;
; This functions writes each array member directly to a file so that an 
; intermediate buffer does not need to be allocated.
; 
; This is designed to allow very large arrays to be written to disk without 
; memory space being a limitation to the array size.
;
; This function as based on the MASM32 Library function: arr2file
;
; See Also:
;
; Array_SaveItemsToMem, Array_LoadItemsFromMem, Array_LoadItemsFromFile
; 
;------------------------------------------------------------------------------
Array_SaveItemsToFile PROC FRAME pArray:QWORD, lpszFilename:QWORD
    LOCAL acnt:QWORD
    LOCAL hFile:QWORD
    LOCAL flen:QWORD
    LOCAL BytesWritten:QWORD
    LOCAL lpszItem:QWORD
    LOCAL qwItemLength:QWORD
    
    Invoke Array_TotalItems, pArray
    mov acnt, rax ; arrcnt$(arr)            ; get the member count back from the array
    
    Invoke File_CreateA, lpszFilename
    mov hFile, rax ; fcreate(lpfile)

    mov rbx, 1
  @@:
    Invoke Array_ItemAddress, pArray, rbx
    mov lpszItem, rax
    Invoke String_LengthA, lpszItem
    mov qwItemLength, rax
    
    Invoke File_Write, hFile, lpszItem, qwItemLength
    mov BytesWritten, rax
    Invoke File_Write, hFile, Addr szASITF_CRLF, 2
    mov BytesWritten, rax
    
    ;Invoke WriteFile, hFile, lpszItem, dwItemLength, Addr BytesWritten, 0
    ;Invoke WriteFile, hFile, Addr szASITF_CRLF, 2, Addr BytesWritten, 0
    ;Invoke File_Print, hFile, rax
    ;fprint hFile,arrget$(arr,ebx)          ; write each array line to disk
    add rbx, 1
    cmp rbx, acnt
    jle @B

    Invoke File_SizeA, lpszFilename
    mov flen, rax ; fsize(hFile)
    
    Invoke File_Close, hFile
    ;fclose hFile

    mov rax, flen
    ret
Array_SaveItemsToFile ENDP


END

