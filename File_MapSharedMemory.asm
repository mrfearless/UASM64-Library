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
    CreateFileMappingA  PROTO hFile:QWORD, lpFileMappingAttributes:QWORD, flProtect:DWORD, dwMaximumSizeHigh:DWORD, dwMaximumSizeLow:DWORD, lpName:QWORD
    MapViewOfFile       PROTO hFileMappingObject:QWORD, dwDesiredAccess:DWORD, dwFileOffsetHigh:DWORD, dwFileOffsetLow:DWORD, dwNumberOfBytesToMap:QWORD
    ;CloseHandle         PROTO hObject:QWORD
    
    IFNDEF PAGE_READWRITE
    PAGE_READWRITE EQU 04h
    ENDIF 
    IFNDEF SEC_COMMIT
    SEC_COMMIT EQU 8000000h
    ENDIF
    IFNDEF SECTION_MAP_WRITE
    SECTION_MAP_WRITE EQU 0002h
    ENDIF
    IFNDEF FILE_MAP_WRITE
    FILE_MAP_WRITE EQU <SECTION_MAP_WRITE>
    ENDIF
    
    includelib kernel32.lib
ENDIF
IF @Platform EQ 3 ; Linux x64
    IFNDEF
    MAP_SHARED EQU 00000001h
    ENDIF
    IFNDEF PROT_READ
    PROT_READ EQU 00000001h
    ENDIF
    IFNDEF PROT_WRITE
    PROT_WRITE EQU 00000002h
    ENDIF
    IFNDEF MAP_ANONYMOUS
    MAP_ANONYMOUS EQU 00000020h
    ENDIF
ENDIF

include UASM64.inc

.DATA
szSharedMemoryMappingFile DB 'shared.mem',0

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_MapSharedMemory
;
; Creates a shared memory mapped file from the system paging file. The memory 
; allocated (commited) can be shared by other applications in seperate 
; processes.
;
; Parameters:
; 
; * lpszSharedMemoryName - The zero terminated string that names the shared 
;   memory object.
; 
; * qwMemorySize - The size of the memory to be shared in the memory object.
; 
; * lpqwMemoryMapHandle - The address of a QWORD variable to receive the memory 
;   mapped file handle for the shared memory object.
; 
; * lpqwMemoryViewPointer - The address of a QWORD variable to receive the 
;   memory view pointer for the shared memory object.
;
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
;
;
; A memory mapped file backed by the system paging file is effectively 
; allocated memory but it has the attribute of being sharable between 
; applications that call the same file name. This allows applications to share 
; data by reading and writing to the memory mapped file.
;
; NOTE: that a memory mapped file allocate at a specified size cannot be 
; reallocated to a different size. The file must be closed by all applications 
; that access it and then reallocated to a different size.
;
; Use File_UnmapSharedMemory to close the memory mapped file.
;
; See Also:
;
; File_UnmapSharedMemory
; 
;------------------------------------------------------------------------------
File_MapSharedMemory PROC FRAME USES RBX lpszSharedMemoryName:QWORD, qwMemorySize:QWORD, lpqwMemoryMapHandle:QWORD, lpqwMemoryViewPointer:QWORD
    LOCAL hFile:QWORD
    LOCAL MMHandle:QWORD
    LOCAL MVPointer:QWORD
    LOCAL dwMemorySizeHI:DWORD
    LOCAL dwMemorySizeLO:DWORD
    mov MMHandle, 0
    mov MVPointer, 0
    
    .IF qwMemorySize == 0 || lpqwMemoryMapHandle == 0 || lpqwMemoryViewPointer == 0
        jmp File_MapSharedMemory_Error
    .ENDIF
    
    mov rax, qwMemorySize
    shr rax, 32d
    mov dwMemorySizeHI, eax
    mov rax, qwMemorySize
    mov dwMemorySizeLO, eax
    IF @Platform EQ 1 ; Win x64
        Invoke CreateFileMappingA, -1, 0, PAGE_READWRITE or SEC_COMMIT, dwMemorySizeHI, dwMemorySizeLO, lpszSharedMemoryName
        .IF rax == 0
            jmp File_MapSharedMemory_Error
        .ENDIF
        mov MMHandle, rax
        
        Invoke MapViewOfFile, MMHandle, FILE_MAP_WRITE, 0, 0, 0
        .IF rax == 0
            jmp File_MapSharedMemory_Error
        .ENDIF
        mov MVPointer, rax
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov MMHandle, 0
        ; create shared.mem file
        lea rdi, szSharedMemoryMappingFile ;lpszFilename
        mov rsi, O_RDWR or O_CREAT ; flags
        mov rdx, 0 ; mode
        mov rax, 2 ; open
        syscall
        .IF rax != -1
            mov hFile, rax
            
            mov rax, qwMemorySize
            add rax, 8 ; alloc 8 extra to store length of mapping
            
            ; memmap shared.mem file
            mov rdi, 0 ; let OS choose address
            mov rsi, rax ; bytes to allocate
            mov rdx, PROT_READ or PROT_WRITE
            mov r10, MAP_SHARED ;or MAP_ANONYMOUS
            mov r8, hFile
            mov r9, 0
            mov rax, 9 ; memmap
            syscall
            .IF rax == -1
                mov rax, 0
                ret
            .ENDIF
            mov MVPointer, rax
            mov rbx, rax
            mov rax, qwMemorySize
            mov [rbx], rax
            
            ; close shared.mem file but keep mapping
            mov rdi, hFile ; fd
            mov rsi, 0
            mov rdx, 0
            mov rax, 3 ; close
            syscall
            
            mov rax, MVPointer
            add rax, 8 ; return mapping +8 past the length
            
        .ELSE
            mov rax, 0
            ret
        .ENDIF
    ENDIF
    
    jmp File_MapSharedMemory_Exit

File_MapSharedMemory_Error:

    .IF lpqwMemoryMapHandle != 0
        mov rbx, lpqwMemoryMapHandle
        mov rax, 0
        mov [rbx], rax
    .ENDIF
    .IF lpqwMemoryViewPointer != 0
        mov rbx, lpqwMemoryViewPointer
        mov rax, 0
        mov [rbx], rax
    .ENDIF
    .IF MMHandle != 0
        Invoke File_Close, MMHandle
        ;Invoke CloseHandle, MMHandle
    .ENDIF
    
    mov rax, 0
    ret

File_MapSharedMemory_Exit:

    .IF lpqwMemoryMapHandle != 0
        mov rbx, lpqwMemoryMapHandle
        mov rax, MMHandle
        mov [rbx], rax
    .ENDIF
    .IF lpqwMemoryViewPointer != 0
        mov rbx, lpqwMemoryViewPointer
        mov rax, MVPointer
        mov [rbx], rax
    .ENDIF
    
    mov rax, 1
    
    ret
File_MapSharedMemory ENDP


END

