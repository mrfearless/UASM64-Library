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
    FlushFileBuffers PROTO hFile:QWORD
    includelib kernel32.lib
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_Flush
;
; Flushes the file buffers to disk.
;
; Parameters:
; 
; * hFile - handle of the opened file to flush.
; 
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
; 
; Notes:
;
; See Also:
;
; File_Write, File_Close
; 
;------------------------------------------------------------------------------
File_Flush PROC FRAME USES RDX RDI RSI hFile:QWORD
    IF @Platform EQ 1 ; Win x64
        Invoke FlushFileBuffers, hFile
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, hFile ; fd
        mov rsi, 0
        mov rdx, 0
        mov rax, 04Bh ; fdatasync
        syscall
        .IF rax == -1
            mov rax, 0
        .ELSE
            mov rax, 1
        .ENDIF
    ENDIF
    ret
File_Flush ENDP


END

