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
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

include windows.inc

include commctrl.inc
includelib user32.lib
includelib kernel32.lib

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
;------------------------------------------------------------------------------
Path_GetAppPath PROC FRAME lpszPath:QWORD

    invoke GetModuleFileName, 0, lpszPath, 128  ; return length in rax
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

    ret
Path_GetAppPath ENDP


END

