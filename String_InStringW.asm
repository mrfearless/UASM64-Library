;==============================================================================
;
; UASM64 Library
;
; https://github.com/mrfearless/UASM64-Library
;
;==============================================================================

;       The subloop code for this algorithm was redesigned by EKO to
;       perform the comparison in reverse which reduced the number
;       of instructions required to set up the branch comparison.

; #########################################################################

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
; String_InStringW
;
; Find a substring in a zero terminated source string. InString searches for a 
; substring (lpszSubString) in a larger string (lpszString) and if it is found, 
; it returns its starting position in RAX. It uses a one (1) based character 
; index (1st character is 1, 2nd is 2 etc...) for both the qwStartPosition 
; parameter and the returned character position.
;
; Parameters:
; 
; * qwStartPosition - Starting position to search for the substring.
; 
; * lpszString - Address of string to be searched.
; 
; * lpszSubString - Address of substring to search for within the main string.
; 
; Returns:
; 
; If the function succeeds, it returns the 1 based index of the start of the 
; substring or 0 if no match is found.
;
; Notes:
;
; If the function fails, the following error values apply:
;
; -1 = substring same length or longer than main string.
; -2 = qwStartPosition parameter out of range (less than 1 or greater than 
;      main string length)
;
; This function as based on the MASM32 Library function: ucFind
;
; See Also:
;
; String_CountW, String_SubstringW
; 
;------------------------------------------------------------------------------
String_InStringW PROC FRAME USES RBX RCX RDX RDI RSI qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD
    LOCAL lsrc:QWORD
    LOCAL lsub:QWORD

    xor rdx, rdx
    xor rbx, rbx
    mov rdi, lpszSubString
    mov bx, [rdi]           ; 1st substring char in BX
    
    Invoke String_LengthW, lpszString
    mov lsrc, rax ; ulen$(lpszString)
    mov rax, lsrc
    add lsrc, rax           ; double for byte length
    
    Invoke String_LengthW, lpszSubString
    mov lsub, rax ; ulen$(lpszSubString)
    mov rax, lsub
    add rax, rax
    mov lsub, rax           ; double for byte length
    sub lsub, 2             ; correct for subloop

    sub lsrc, rax           ; exit position

    mov rax, qwStartPosition; double sPos to get byte location
    add qwStartPosition, rax
    mov rsi, lpszString
    add rsi, qwStartPosition
    add lsrc, rsi

    sub rsi, 2
  stlp:
    add rsi, 2
    cmp [rsi], bx           ; test for start character
    je presub
    cmp rsi, lsrc
    jle stlp                ; fall through on no match

    jmp notfound

  presub:
    mov rcx, lsub
  sublp:
    mov dx, [rsi+rcx]       ; do substring compare backwards
    cmp dx, [rdi+rcx]
    jne stlp
    sub rcx, 2
    jnz sublp               ; fall through on match

  match:
    sub rsi, lpszString     ; calculated byte length
    mov rax, rsi
    add rax, 2              ; correct for 1 base index
    shr rax, 1              ; divide by 2 to return character position
    jmp findout

  notfound:
    xor rax, rax            ; return zero on no match

  findout:

    ret
String_InStringW ENDP


END

