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

IF @Platform EQ 1 ; Win x64
    ReadFile    PROTO hFile:QWORD, lpBuffer:QWORD, nNumberOfBytesToRead:DWORD, lpNumberOfBytesRead:QWORD, lpOverlapped:QWORD
    includelib kernel32.lib
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_Read
;
; Read the contents of a file into a pre-allocated memory buffer.
; 
; Parameters:
; 
; * hFile - The handle of the opened file to read.
; 
; * lpMemory - The address of the memory buffer to read the file contents into.
; 
; * qwBytesToRead - The amount, in bytes, of data to read into the buffer.
; 
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
; 
; Notes:
;
; This function as based on the MASM32 Library function: 
;
; See Also:
;
; File_Close, File_Write
; 
;------------------------------------------------------------------------------
File_Read PROC FRAME USES RDX RDI RSI hFile:QWORD, lpMemory:QWORD, qwBytesToRead:QWORD
    IF @Platform EQ 1 ; Win x64
        LOCAL qwBytesRead:QWORD
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        Invoke ReadFile, hFile, lpMemory, dword ptr qwBytesToRead, Addr qwBytesRead, 0
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, hFile ; fd
        mov rsi, lpMemory
        mov rdx, qwBytesToRead
        mov rax, 0 ; read
        syscall
        .IF rax == -1 ; error
            mov rax, 0
        .ELSE
            mov rax, 1
        .ENDIF
    ENDIF
    ret
File_Read ENDP


END

