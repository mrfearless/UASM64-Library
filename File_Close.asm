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
    CloseHandle PROTO hObject:QWORD
    includelib kernel32.lib
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_Close
;
; Closes and open file.
; 
; Parameters:
; 
; * hFile - handle of the opened file to close.
; 
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
;
; Notes:
;
; This function as based on the MASM32 Library macro: fclose
;
; See Also:
;
; File_OpenA, File_OpenW, File_CreateA, File_CreateW
; 
;------------------------------------------------------------------------------
File_Close PROC FRAME USES RDX RDI RSI hFile:QWORD
    IF @Platform EQ 1 ; Win x64
        Invoke CloseHandle, hFile
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, hFile ; fd
        mov rsi, 0
        mov rdx, 0
        mov rax, 3 ; close
        syscall
        .IF rax == -1
            mov rax, 0
        .ELSE
            mov rax, 1
        .ENDIF
    ENDIF
    ret
File_Close ENDP


END

