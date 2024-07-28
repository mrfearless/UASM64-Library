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
    WriteFile   PROTO hFile:QWORD, lpBuffer:QWORD, nNumberOfBytesToWrite:DWORD, lpNumberOfBytesWritten:QWORD, lpOverlapped:QWORD
    includelib kernel32.lib
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_Write
;
; Write the contents of a memory buffer to an opened file.
;
; Parameters:
; 
; * hFile - The handle of the opened file to write to.
; 
; * lpMemory - The address of the memory buffer to read the contents of and 
;   write them out to the file.
; 
; * qwBytesToWrite - The amount, in bytes, of data in the memory buffer to 
;   write into the file.
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
; File_Close, File_Flush, File_Read
; 
;------------------------------------------------------------------------------
File_Write PROC FRAME USES RDX RDI RSI hFile:QWORD, lpMemory:QWORD, qwBytesToWrite:QWORD
    IF @Platform EQ 1 ; Win x64
        LOCAL qwBytesWritten:QWORD
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        Invoke WriteFile, hFile, lpMemory, dword ptr qwBytesToWrite, Addr qwBytesWritten, 0
        .IF rax == 0 ; error
            ret
        .ENDIF
        mov rax, qwBytesWritten
        ; rax contains bytes written
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, hFile ; fd
        mov rsi, lpMemory
        mov rdx, qwBytesToWrite
        mov rax, 1 ; write
        syscall
        .IF rax == -1 ; error
            mov rax, 0
        .ELSE
            ; rax contains bytes written
        .ENDIF
    ENDIF
    
    ret
File_Write ENDP


END

