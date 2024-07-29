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
    FindFirstFileA  PROTO lpFileName:QWORD, lpFindFileData:QWORD
    FindClose       PROTO hFindFile:QWORD
    
;    IFNDEF INVALID_HANDLE_VALUE
;    INVALID_HANDLE_VALUE EQU -1
;    ENDIF
    
    IFNDEF MAX_PATH
    MAX_PATH EQU 260
    ENDIF
    
    IFNDEF FILETIME
    FILETIME            STRUCT
        dwLowDateTime   DWORD ?
        dwHighDateTime  DWORD ?
    FILETIME            ENDS
    ENDIF
    
    IFNDEF WIN32_FIND_DATAA
    WIN32_FIND_DATAA        STRUCT 8
        dwFileAttributes    DWORD ?
        ftCreationTime      FILETIME <>
        ftLastAccessTime    FILETIME <>
        ftLastWriteTime     FILETIME <>
        nFileSizeHigh       DWORD ?
        nFileSizeLow        DWORD ?
        dwReserved0         DWORD ?
        dwReserved1         DWORD ?
        cFileName           BYTE MAX_PATH DUP (?)
        cAlternateFileName  BYTE 14 DUP (?)
        dwFileType          DWORD ? ; Obsolete. Do not use.
        dwCreatorType       DWORD ? ; Obsolete. Do not use.
        wFinderFlags        WORD ? ; Obsolete. Do not use.
    WIN32_FIND_DATAA        ENDS
    ENDIF
    
    includelib kernel32.lib
ENDIF

IF @Platform EQ 3 ; Linux x64
    IFNDEF LINUX_STAT
    LINUX_STAT          STRUCT
        st_dev          QWORD ? ;   linux_uword_t 
        st_ino          QWORD ? ;   linux_uword_t 
        st_nlink        QWORD ? ;   linux_uword_t 
        st_mode         DWORD ? ;   unsigned int 
        st_uid          DWORD ? ;   unsigned int 
        st_gid          DWORD ? ;   unsigned int 
        _pad0           DWORD ? ;   unsigned int 
        st_rdev         QWORD ? ;   linux_uword_t 
        st_size         QWORD ? ;   linux_word_t 
        st_blksize      QWORD ? ;   linux_word_t 
        st_blocks       QWORD ? ;   linux_word_t 
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
; File_SizeA
;
; This function returns the size of a file if it exists.
;
; Parameters:
; 
; * lpszFileName - The zero terminated string that has the path & filename of 
;   the file to return the size of. 
; 
; Returns:
; 
; If the return value is minus one (-1) then the file does not exist, 
; otherwise RAX contains the size of the file in bytes.
; 
; Notes:
; 
; This function will return the size of a file without opening it.
;
; This function as based on the MASM32 Library function: filesize
;
; See Also:
;
; File_SizeW, File_ExistsA, File_ExistsW, File_FileSize
; 
;------------------------------------------------------------------------------
File_SizeA PROC FRAME USES RDX RDI RSI lpszFileName:QWORD
    IF @Platform EQ 1 ; Win x64
        LOCAL wfd:WIN32_FIND_DATAA
    ENDIF
    IF @Platform EQ 3 ; Linux x64
        LOCAL statbuf:LINUX_STAT
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        Invoke FindFirstFileA, lpszFileName, Addr wfd
        .IF rax == -1 ; INVALID_HANDLE_VALUE
            ret
        .ENDIF
        Invoke FindClose, rax
        mov rax, qword ptr wfd.nFileSizeHigh ; also reads file size low
    ENDIF
    
    IF @Platform EQ 3 ; Linux x64
        mov rdi, lpszFileName
        lea rsi, statbuf
        mov rdx, 0
        mov rax, 6 ; lstat
        syscall
        .IF rax == -1
            ret
        .ENDIF
        lea rdx, statbuf
        mov rax, [rdx].LINUX_STAT.st_size
    ENDIF
    
    ret
File_SizeA ENDP


END

