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
; String_InStringA
;
; Find a substring in a zero terminated source string. InString searches for a 
; substring (lpszSubString) in a larger string (lpszString) and if it is found, 
; it returns its starting position in RAX. It uses a one (1) based character 
; index (1st character is 1, 2nd is 2 etc...) for both the qwStartPosition 
; parameter and the returned character position. This is the Ansi version of 
; String_InString, String_InStringW is the Unicode version.
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
; This function as based on the MASM32 Library function: InString
;
; See Also:
;
; String_CountA, String_SubstringA
; 
;------------------------------------------------------------------------------
String_InStringA PROC FRAME USES RBX RCX RDX RDI RSI qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD
    LOCAL sLen:QWORD
    LOCAL pLen:QWORD

    Invoke String_LengthA, lpszString
    mov sLen, rax           ; source length
    Invoke String_LengthA, lpszSubString
    mov pLen, rax           ; pattern length

    cmp qwStartPosition, 1
    jge @F
    mov rax, -2
    jmp isOut               ; exit if startpos not 1 or greater
  @@:

    dec qwStartPosition     ; correct from 1 to 0 based index

    cmp  rax, sLen
    jl @F
    mov rax, -1
    jmp isOut               ; exit if pattern longer than source
  @@:

    sub sLen, rax           ; don't read past string end
    inc sLen

    mov rcx, sLen
    cmp rcx, qwStartPosition
    jg @F
    mov rax, -2
    jmp isOut               ; exit if startpos is past end
  @@:

  ; ----------------
  ; setup loop code
  ; ----------------
    mov rsi, lpszString
    mov rdi, lpszSubString
    mov al, [rdi]           ; get 1st char in pattern

    add rsi, rcx            ; add source length
    neg rcx                 ; invert sign
    add rcx, qwStartPosition; add starting offset

    jmp Scan_Loop

    align 16

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Pre_Scan:
    inc rcx                 ; start on next byte

  Scan_Loop:
    cmp al, [rsi+rcx]       ; scan for 1st byte of pattern
    je Pre_Match            ; test if it matches
    inc rcx
    js Scan_Loop            ; exit on sign inversion

    jmp No_Match

  Pre_Match:
    lea rbx, [rsi+rcx]      ; put current scan address in EBX
    mov rdx, pLen           ; put pattern length into EDX

  Test_Match:
    mov ah, [rbx+rdx-1]     ; load last byte of pattern length in main string
    cmp ah, [rdi+rdx-1]     ; compare it with last byte in pattern
    jne Pre_Scan            ; jump back on mismatch
    dec rdx
    jnz Test_Match          ; 0 = match, fall through on match

  ; @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  Match:
    add rcx, sLen
    mov rax, rcx
    inc rax
    jmp isOut
    
  No_Match:
    xor rax, rax

  isOut:

    ret
String_InStringA ENDP


END

