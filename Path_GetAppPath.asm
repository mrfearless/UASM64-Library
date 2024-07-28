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
; getpid  27h

IF @Platform EQ 1 ; Win x64
    GetModuleFileNameA PROTO hModule:QWORD, lpFilename:QWORD, nSize:DWORD
    includelib kernel32.lib
ENDIF

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Path_GetAppPath
;
; Returns the address of the running application's path as a zero terminated 
; string with the filename removed. The last character in the string is a 
; trailing backslash "\" to facilitate parsing different filenames to the path.
;
; Parameters:
; 
; * lpszPath - The address of the buffer that will receive the application path.
; 
; Returns:
; 
; There is no return value.
;
; See Also:
;
; Path_GetPathOnly, Path_NameFromPath
; 
;------------------------------------------------------------------------------
Path_GetAppPath PROC FRAME lpszPath:QWORD
    IF @Platform EQ 1 ; Win x64
        invoke GetModuleFileNameA, 0, lpszPath, 128  ; return length in rax
        add rax, lpszPath
    
      ; ---------------------------------------
      ; scan backwards for first "\" character
      ; ---------------------------------------
      @@:
        dec rax                             ; dec ECX
        cmp BYTE PTR [rax],'\'              ; compare if "\"
        jne @B                              ; jump back to @@: if not "\"
    
        mov BYTE PTR [rax+1],0              ; write zero terminator after "\"
    
        mov rax, lpszPath
    ENDIF
    ret
Path_GetAppPath ENDP


END

