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

IF @Platform EQ 1
    wsprintfA PROTO lpszDestination:QWORD, lpszFormat:QWORD, args:VARARG
    includelib user32.lib
ENDIF

include UASM64.inc

.CODE

IF @Platform EQ 1
UASM64_ALIGN
;------------------------------------------------------------------------------
; ltoa
;
; Convert signed 32 bit integer "lValue" to zero terminated string and store 
; string at address in "lpBuffer"

; Parameters:
; 
; * lValue - Parameter details.
; 
; * lpBuffer - Parameter details.
; 
; Returns:
; 
; TRUE if successful, or FALSE otherwise.
; 
; Notes:
;
; This function as based on the MASM32 Library function: 
;
;------------------------------------------------------------------------------
ltoa PROC FRAME USES RCX RDX RDI RSI lValue:QWORD, lpBuffer:QWORD
    jmp @F
    fMtStrinG db "%ld",0
  @@:

    Invoke wsprintfA, lpBuffer, Addr fMtStrinG, lValue
    cmp rax, 3
    jge @F
    xor rax, rax    ; zero EAX on fail
  @@:               ; else EAX contain count of bytes written

    ret
ltoa ENDP
ENDIF

IF @Platform EQ 3 ; Linux x64
ltoa PROC FRAME USES RCX RDX RDI RSI lValue:QWORD, lpBuffer:QWORD
    mov rax, 0
    ret
ltoa ENDP
ENDIF

END

