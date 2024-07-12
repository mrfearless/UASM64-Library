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

.DATA
ALIGN 16

chtbl \
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0     ; 31
db 0,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0     ; 47
db 1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1     ; 63   ; numbers
db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1     ; 79   ; upper case
db 1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,1     ; 95
db 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1     ; 111  ; lower case
db 1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0     ; 127
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; characters     ! # $ % & ? @ _
; numbers        0123456789
; upper case     ABCDEFGHIJKLMNOPQRSTUVWXYZ
; lower case     abcdefghijklmnopqrstuvwxyz

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_WordReplace
;
; Globally replace whole words in the source text and write the result to the 
; destination.
; 
; Parameters:
; 
; * lpszSource - The source text to replace words in.
; 
; * lpszDestination - The destination buffer for the result.
; 
; * lpszWordToReplace - The word to replace.
; 
; * lpszReplacementWord - The words to replace it with.
;
; Returns:
; 
; There is no return value.
; 
; Notes:
;
; This procedure is a table based linear text scanner based on the following 
; allowable characters:
;
;    characters     ! # $ % & ? @ _
;    numbers        0123456789
;    upper case     ABCDEFGHIJKLMNOPQRSTUVWXYZ
;    lower case     abcdefghijklmnopqrstuvwxyz
;
; The procedure will recognise whole words made up of the above characters and 
; will replace every instance of that word with the replacement text. It is 
; suited for simple tasks like replacing whole words in text such as in a text 
; editor but it is also fast enough to loop through a number of words and 
; replace all of them in a macro built into a scripting language or similar 
; application.
;
; It is an interim technology for tasks smaller than those normally handled by 
; a far more complex hash table.
;
;------------------------------------------------------------------------------
String_WordReplace PROC FRAME USES RCX RDX RDI RSI lpszSource:QWORD, lpszDestination:QWORD, lpszWordToReplace:QWORD, lpszReplacementWord:QWORD
    LOCAL buffer[512]:BYTE
    
    mov rsi, lpszSource
    mov rdi, lpszDestination
    xor rax, rax
    jmp badchar
  ; ---------------------------------
  ; handle unacceptable characters
  ; ---------------------------------
  align 8
  prebad:
    xor rax, rax                    ; szCmp alters rax so clear it again
    sub rsi, 1
  badchar:
    mov al, BYTE PTR [rsi]
    add rsi, 1
    lea rbx, chtbl
    cmp BYTE PTR [rbx+rax], 1     ; test if BYTE is allowable character
    je pregood
    test rax, rax                   ; test if terminator
    jz repout
    mov [rdi], al                   ; write BYTE to destination buffer
    add rdi, 1
    jmp badchar
  ; ---------------------------------
  ; handle acceptable characters
  ; ---------------------------------
  align 8
  pregood:
    lea rdx, buffer                 ; load temp buffer address in rdx
    mov [rdx], al                   ; write 1st good char to temp buffer
    add rdx, 1
  goodchar:
    mov al, BYTE PTR [rsi]
    add rsi, 1
    test rax, rax                   ; test if terminator
    jz lastword                     ; jump to last word test
    lea rbx, chtbl
    cmp BYTE PTR [rbx+rax], 0     ; test if BYTE is NOT allowable character
    je tstword                      ; jump to word test loop
    mov [rdx], al                   ; write next byte to temp buffer
    add rdx, 1
    jmp goodchar
  ; ---------------------------------
  ; test word match and return
  ; ---------------------------------
  align 8
  tstword:
    mov BYTE PTR [rdx], 0           ; terminate the word in temp buffer
    Invoke String_Compare, lpszWordToReplace, Addr buffer   ; test temp buffer against 1st word
    lea rcx, buffer
    test rax, rax                   ; if no match write original word to buffer
    jz @F
    mov rcx, lpszReplacementWord    ; if 1st word matches, put replacement address in rcx
  @@:
    mov al, [rcx]                   ; copy word to destination buffer
    add rcx, 1
    test rax, rax                   ; return on zero
    jz prebad
    mov [rdi], al
    add rdi, 1
    jmp @B
  ; ---------------------------------
  ; test word match and exit
  ; ---------------------------------
  align 8
  lastword:
    mov BYTE PTR [rdx], 0           ; terminate the word in temp buffer
    Invoke String_Compare, lpszWordToReplace, Addr buffer   ; test temp buffer against 1st word
    lea rcx, buffer
    test rax, rax                   ; if no match write original word to buffer
    jz @F
    mov rcx, lpszReplacementWord    ; if 1st word matches, put replacement address in rcx
  @@:
    mov al, [rcx]                   ; copy word to destination buffer
    add rcx, 1
    test rax, rax                   ; exit on zero
    jz repout
    mov [rdi], al
    add rdi, 1
    jmp @B
  ; ---------------------------------
  align 8
  repout:
    mov BYTE PTR [rdi], 0           ; write final terminator to destination buffer
    
    ret
String_WordReplace ENDP


END

