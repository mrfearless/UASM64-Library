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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include windows.inc

include commctrl.inc
includelib user32.lib
includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_ReadFileToMemory
;
; Reads a disk file into memory and returns the address and length in two QWORD 
; variables.
;
; Parameters:
; 
; * lpszFilename - The zero terminated file name to open and read into memory.
; 
; * lpqwMemory - The address of the QWORD variable that receives the starting 
;   address of the buffer, for the file contents.
; 
; * lpqwMemoryLength - The address of the QWORD variable that receives the 
;   number of bytes written to the memory buffer.
; 
; Returns:
; 
; The return value is zero on error, otherwise non-zero.
; 
; Notes:
;
; The memory address written to lpqwMemory must be deallocated using the 
; GlobalFree function, once the memory buffer is no longer required.
; 
;------------------------------------------------------------------------------
File_ReadFileToMemory PROC FRAME USES RCX lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD
    LOCAL hFile:QWORD
    LOCAL fl:QWORD
    LOCAL hMem:QWORD
    LOCAL bytesRead:QWORD
    
    Invoke CreateFile, lpszFilename, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL
    mov hFile, rax
    cmp hFile, INVALID_HANDLE_VALUE
    jne @F
    xor rax, rax                                    ; return zero on error
    ret
  @@:
    ;Invoke GetFileSizeEx, hFile, Addr fl
    Invoke GetFileSize, hFile, NULL
    mov fl, rax                                     ; get the file length,
    add fl, 32                                      ; add some spare bytes
    Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, rax
    mov hMem, rax                                   ; alloc(fl) allocate a buffer of that size
    invoke ReadFile, hFile, hMem, dword ptr fl, Addr bytesRead, NULL; read file into buffer
    invoke CloseHandle, hFile                       ; close the handle

    mov rax, lpqwMemory                             ; write memory address to
    mov rcx, hMem                                   ; address of variable
    mov [rax], rcx                                  ; passed on the stack

    mov rax, lpqwMemoryLength                       ; write byte count to
    mov rcx, bytesRead                              ; address of variable
    mov [rax], rcx                                  ; passed on the stack

    mov rax, 1                                      ; non zero value returned on success

    ret
File_ReadFileToMemory ENDP


END

