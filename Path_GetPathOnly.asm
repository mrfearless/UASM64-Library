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

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Path_GetPathOnly
;
; Reads the path of a complete full filename and path and returns just the path 
; portion in the destination buffer.
; 
; Parameters:
; 
; * lpszFullFilenamePath - Address of zero terminated that contains the full 
;   filename and path.
; 
; * lpszPath - Address of buffer to receive the path portion of a complete path.
; 
; Returns:
; 
; No return value.
;
; Notes:
;
; The destination buffer must be large enough to receive the path from the 
; complete full filename and path.
;
; See Also:
;
; Path_GetAppPath, Path_NameFromPath
; 
;------------------------------------------------------------------------------
Path_GetPathOnly PROC FRAME USES RCX RDX RDI RSI lpszFullFilenamePath:QWORD, lpszPath:QWORD

    xor rcx, rcx    ; zero counter
    mov rsi, lpszFullFilenamePath
    mov rdi, lpszPath
    xor rdx, rdx    ; zero backslash location

  @@:
    mov al, [rsi]   ; read byte from address in esi
    inc rsi
    inc rcx         ; increment counter
    cmp al, 0       ; test for zero
    je gfpOut       ; exit loop on zero
    cmp al, "\"     ; test for "\"
    jne nxt1        ; jump over if not
    mov rdx, rcx    ; store counter in ecx = last "\" offset in ecx
  nxt1:
    mov [rdi], al   ; write byte to address in edi
    inc rdi
    jmp @B
    
  gfpOut:
    add rdx, lpszPath ; add destination address to offset of last "\"
    mov [rdx], al   ; write terminator to destination

    ret
Path_GetPathOnly ENDP


END

