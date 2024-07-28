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
;WriteFile   PROTO hFile:QWORD, lpBuffer:QWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:QWORD, lpOverlapped:QWORD
;CloseHandle PROTO hObject:QWORD
;FlushFileBuffers PROTO hFile:QWORD

;IFNDEF INVALID_HANDLE_VALUE
;INVALID_HANDLE_VALUE EQU -1
;ENDIF

;IFNDEF GENERIC_WRITE
;GENERIC_WRITE EQU 40000000h
;ENDIF
;IFNDEF CREATE_ALWAYS
;CREATE_ALWAYS EQU 2
;ENDIF
;IFNDEF FILE_ATTRIBUTE_NORMAL
;FILE_ATTRIBUTE_NORMAL EQU 00000080h
;ENDIF

;includelib kernel32.lib

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_WriteMemoryToFileA
;
; Write the contents of a memory buffer to a disk file. This is the Ansi 
; version of File_WriteMemoryToFile, File_WriteMemoryToFileW is the Unicode 
; version.
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
; This function as based on the MASM32 Library function: write_disk_file
;
; See Also:
;
; File_WriteMemoryToFileW, File_ReadFileToMemoryA, File_ReadFileToMemoryW, File_OpenA, File_Write, File_Flush, File_Close
; 
;------------------------------------------------------------------------------
File_WriteMemoryToFileA PROC FRAME lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD
    LOCAL hFile:QWORD
    LOCAL BytesWritten:QWORD
    
    Invoke File_CreateA, lpszFilename
    ;Invoke CreateFileA, lpszFilename, GENERIC_WRITE, 0, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
    cmp rax, -1 ; INVALID_HANDLE_VALUE
    jne @F
    xor rax, rax
    ret
  @@:
    mov hFile, rax
    
    Invoke File_Write, hFile, lpMemory, qwMemoryLength
    mov BytesWritten, rax
    ;Invoke WriteFile, hFile, lpMemory, dword ptr qwMemoryLength, Addr bytesWritten, 0
    
    Invoke File_Flush, hFile
    ;Invoke FlushFileBuffers, hFile
    
    Invoke File_Close, hFile
    ;Invoke CloseHandle, hFile

    mov rax, BytesWritten                 ; return written byte count

    ret
File_WriteMemoryToFileA ENDP


END

