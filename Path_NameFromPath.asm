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

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Path_NameFromPath
;
; Reads the filename from a complete path and returns it in the buffer 
; specified in the lpszFilename parameter.
; 
; Parameters:
; 
; * lpszFullFilenamePath - The address of the full path that has the file name.
; 
; * lpszFilename - The address of the buffer to receive the filename.
; 
; Returns:
; 
; The file name is returned in the buffer supplied in the lpszPath parameter.
; 
; Notes:
;
; The buffer to receive the filename must be large enough to accept the 
; filename. For safety reasons if dealing with both long path and file name, 
; the buffer can be made the same length as the source buffer. 
;
;------------------------------------------------------------------------------
Path_NameFromPath PROC FRAME USES RCX RDX RDI RSI lpszFullFilenamePath:QWORD, lpszFilename:QWORD

    mov rsi, lpszFullFilenamePath
    mov rcx, rsi
    mov rdx, -1
    xor rax, rax

  @@:
    add rdx, 1
    cmp BYTE PTR [rsi+rdx], 0       ; test for terminator
    je @F
    cmp BYTE PTR [rsi+rdx], "\"     ; test for "\"
    jne @B
    mov rcx, rdx
    jmp @B
  @@:
    cmp rcx, rsi                    ; test if rcx has been modified
    je error                        ; exit on error if it is the same
    lea rcx, [rcx+rsi+1]            ; add rsi to rcx and increment to following character
    mov rdi, lpszFilename           ; load destination address
    mov rdx, -1
  @@:
    add rdx, 1
    mov al, [rcx+rdx]               ; copy file name to destination
    mov [rdi+rdx], al
    test al, al                     ; test for written terminator
    jnz @B

    sub rax, rax                    ; return value zero on success
    jmp nfpout

  error:
    mov rax, -1                     ; invalid path no "\"

  nfpout:

    ret
Path_NameFromPath ENDP


END

