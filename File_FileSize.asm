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
    GetFileSizeEx PROTO hFile:QWORD, lpFileSize:QWORD
    includelib kernel32.lib
ENDIF

IF @Platform EQ 3 ; Linux x64
    IFNDEF LINUX_STAT
    LINUX_STAT          STRUCT
        st_dev          QWORD ? ;   linux_uword_t 
        st_ino          QWORD ? ;   linux_uword_t 
        st_nlink        QWORD ? ;   linux_uword_t 
        st_mode         DWORD ? ;   unsigned int 
        st_uid          DWORD ? ; 	unsigned int 
        st_gid          DWORD ? ; 	unsigned int 
        _pad0           DWORD ? ;  	unsigned int 
        st_rdev         QWORD ? ;   linux_uword_t 
        st_size         QWORD ? ;   linux_word_t 
        st_blksize      QWORD ? ; 	linux_word_t 
        st_blocks       QWORD ? ;  	linux_word_t 
        st_atime        QWORD ? ;   linux_uword_t 
        st_atime_nsec   QWORD ? ;   linux_uword_t 
        st_mtime        QWORD ? ;   linux_uword_t 
        st_mtime_nsec   QWORD ? ;   linux_uword_t 
        st_ctime        QWORD ? ;   linux_uword_t 
        st_ctime_nsec   QWORD ? ;   linux_uword_t 
        _unused         QWORD 3 DUP (?); linux_word_t 
    LINUX_STAT          ENDS
    ENDIF
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; File_FileSize
;
; Get the size of an opened file.
; 
; Parameters:
; 
; * hFile - The handle of the opened file to get the size of.
; 
; Returns:
; 
; RAX contains the size of the file in bytes, or -1 if an error occurred.
; 
; Notes:
;
; This function as based on the MASM32 Library function: 
;
; See Also:
;
; File_SizeA, File_SizeW, File_ExistsA, File_ExistsW
; 
;------------------------------------------------------------------------------
File_FileSize PROC FRAME USES RDX RDI RSI hFile:QWORD
    IF @Platform EQ 1 ; Win x64
        LOCAL qwFileSize:QWORD
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        LOCAL statbuf:LINUX_STAT
    ENDIF
    IF @Platform EQ 1 ; Win x64
        Invoke GetFileSizeEx, hFile, Addr qwFileSize
        .IF eax == 0
            mov rax, -1
            ret
        .ENDIF
        mov rax, qwFileSize
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        mov rdi, hFile ; fd
        lea rsi, statbuf
        mov rdx, 0
        mov rax, 5 ; fstat
        syscall
        .IF rax == -1
            ret
        .ENDIF
        lea rdx, statbuf
        mov rax, [rdx].LINUX_STAT.st_size
    ENDIF
    ret
File_FileSize ENDP


END

