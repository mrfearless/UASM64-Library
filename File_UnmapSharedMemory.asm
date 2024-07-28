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
    UnmapViewOfFile     PROTO lpBaseAddress:QWORD
    ;CloseHandle         PROTO hObject:QWORD
    includelib kernel32.lib
ENDIF
IF @Platform EQ 3 ; Linux x64

ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_UnmapSharedMemory
;
; Closes a shared memory object created by the File_MapSharedMemory function. 
; The memory mapped file handle and memory view pointer returned by the 
; File_MapSharedMemory function are closed.
; 
; Parameters:
; 
; * qwMemoryMapHandle -The shared memory's memory map handle. This handle value 
;   is returned by the File_MapSharedMemory function.
; 
; * qwMemoryViewPointer - The shared memory's memory view pointer. This value 
;   is returned by the File_MapSharedMemory function.
; 
; Returns:
; 
; No return value.
; 
; Notes:
;
; When more than one application has opened the same named memory mapped file, 
; the file is not closed until the last application that has opened it closes 
; the file. It is safe to call this procedure even if the memory mapped file is 
; still being used by another application as the operating system will leave it 
; open until the last application using it closes it
;
; See Also:
;
; File_MapSharedMemory
; 
;------------------------------------------------------------------------------
File_UnmapSharedMemory PROC FRAME qwMemoryViewPointer:QWORD, qwMemoryMapHandle:QWORD
    IF @Platform EQ 3 ; Linux x64
    LOCAL qwLen:QWORD
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        .IF qwMemoryViewPointer != 0
            Invoke UnmapViewOfFile, qwMemoryViewPointer
        .ENDIF
        .IF qwMemoryMapHandle != 0
            Invoke File_Close, qwMemoryMapHandle
            ;Invoke CloseHandle, qwMemoryMapHandle
        .ENDIF
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rbx, qwMemoryViewPointer
        sub rbx, 8
        mov rax, [rbx] ; get mapping length
        add rax, 8 ; add 8 to get total length
        mov qwLen, rax
        
        mov rdi, qwMemoryViewPointer ; address
        mov rsi, qwLen ; length
        mov rax, 0Bh ; unmap
        syscall 
        
    ENDIF
    xor rax, rax
    ret
File_UnmapSharedMemory ENDP


END

