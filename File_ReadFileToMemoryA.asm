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

;CreateFileA PROTO lpFileName:QWORD, dwDesiredAccess:DWORD, dwShareMode:DWORD, lpSecurityAttributes:QWORD, dwCreationDisposition:DWORD, dwFlagsAndAttributes:DWORD, hTemplateFile:QWORD
;GetFileSize PROTO hFile:QWORD, lpFileSizeHigh:QWORD
;GlobalAlloc PROTO uFlags:DWORD, dwBytes:QWORD
;ReadFile    PROTO hFile:QWORD, lpBuffer:QWORD, nNumberOfBytesToRead:DWORD, lpNumberOfBytesRead:QWORD, lpOverlapped:QWORD
;CloseHandle PROTO hObject:QWORD

;IFNDEF INVALID_HANDLE_VALUE
;INVALID_HANDLE_VALUE EQU -1
;ENDIF
;IFNDEF GENERIC_READ
;GENERIC_READ EQU   80000000h
;ENDIF
;IFNDEF FILE_SHARE_READ
;FILE_SHARE_READ EQU    00000001h
;ENDIF
;IFNDEF OPEN_EXISTING
;OPEN_EXISTING EQU  3
;ENDIF
;IFNDEF GMEM_FIXED
;GMEM_FIXED EQU 0000h
;ENDIF
;IFNDEF GMEM_ZEROINIT
;GMEM_ZEROINIT EQU  0040h
;ENDIF

;includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_ReadFileToMemoryA
;
; Reads a disk file into memory and returns the address and length in two QWORD 
; variables. This is the Ansi version of File_ReadFileToMemory, 
; File_ReadFileToMemoryW is the Unicode version.
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
; This function as based on the MASM32 Library function: read_disk_file
;
; See Also:
;
; File_ReadFileToMemoryW, File_WriteMemoryToFileA, File_WriteMemoryToFileW, File_OpenA, File_Read, File_FileSize, File_Close, Memory_Alloc
; 
;------------------------------------------------------------------------------
File_ReadFileToMemoryA PROC FRAME USES RCX lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD
    LOCAL hFile:QWORD
    LOCAL fl:QWORD
    LOCAL hMem:QWORD
    LOCAL bytesRead:QWORD
    
    Invoke File_OpenA, lpszFilename
    ;Invoke CreateFileA, lpszFilename, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0
    mov hFile, rax
    cmp hFile, -1 ; INVALID_HANDLE_VALUE
    jne @F
    xor rax, rax                                    ; return zero on error
    ret
  @@:
    ;Invoke GetFileSizeEx, hFile, Addr fl
    Invoke File_FileSize, hFile
    ;Invoke GetFileSize, hFile, 0
    mov fl, rax                                     ; get the file length,
    add fl, 32                                      ; add some spare bytes
    
    Invoke Memory_Alloc, rax
    ;Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, rax
    mov hMem, rax                                   ; alloc(fl) allocate a buffer of that size
    
    Invoke File_Read, hFile, hMem, fl
    ;Invoke ReadFile, hFile, hMem, dword ptr fl, Addr bytesRead, 0; read file into buffer
    
    Invoke File_Close, hFile
    ;Invoke CloseHandle, hFile                       ; close the handle

    mov rax, lpqwMemory                             ; write memory address to
    mov rcx, hMem                                   ; address of variable
    mov [rax], rcx                                  ; passed on the stack

    mov rax, lpqwMemoryLength                       ; write byte count to
    mov rcx, bytesRead                              ; address of variable
    mov [rax], rcx                                  ; passed on the stack

    mov rax, 1                                      ; non zero value returned on success

    ret
File_ReadFileToMemoryA ENDP


END

