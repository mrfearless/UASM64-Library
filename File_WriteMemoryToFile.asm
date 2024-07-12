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
; File_WriteMemoryToFile
;
; Write the contents of a memory buffer to a disk file. 
;
; Parameters:
; 
; * lpszFilename - The zero terminated file name to write the memory buffer to.
; 
; * lpMemory - The address of the buffer that contains the data to write.
; 
; * qwMemoryLength - The number of bytes to write to the file.
; 
; Returns:
; 
; The return value is the number of bytes written if the function succeeds or 
; zero if it fails.
; 
; Notes:
;
; This procedure is designed to write a complete disk file each time it is 
; called. It will overwrite an existing file of the same name.
;
;------------------------------------------------------------------------------
File_WriteMemoryToFile PROC FRAME lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD
    LOCAL hFile:QWORD
    LOCAL bytesWritten:QWORD

    invoke CreateFile, lpszFilename, GENERIC_WRITE, NULL, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    cmp rax, INVALID_HANDLE_VALUE
    jne @F
    xor rax, rax
    ret
  @@:
    mov hFile, rax
    invoke WriteFile, hFile, lpMemory, dword ptr qwMemoryLength, Addr bytesWritten, NULL
    invoke FlushFileBuffers, hFile
    invoke CloseHandle, hFile

    mov rax, bytesWritten                 ; return written byte count

    ret
File_WriteMemoryToFile ENDP


END

