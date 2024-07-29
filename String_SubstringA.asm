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
; String_SubstringA
;
; Find a needle in a haystack, or a substring within a string. This is the Ansi 
; version of String_Substring, String_SubstringW is the Unicode version.
;
; Parameters:
; 
; * lpszString - Address of string to be searched.
; 
; * lpszSubString - Address of substring to search for within the main string.
; 
; Returns:
; 
; Pointer to the substring found in lpszString, or start of lpszString.
; If lpszString is empty then returns null.
; 
; Notes:
;
; This function is based on strstr by Mael Drapier, EPITECH promo 2021
;
; See Also:
;
; String_LeftA, String_RightA, String_MiddleA
; 
;------------------------------------------------------------------------------
String_SubstringA PROC FRAME USES RBX RCX RDX RDI RSI R8 lpszString:QWORD, lpszSubString:QWORD

    mov rdi, lpszString
    mov rsi, lpszSubString
    xor rbx, rbx        ; set an index to 0
    jmp String_SubstringA_Loop ; goto '.LOOP'

String_SubstringA_inc:
    inc rbx             ; rbx index incrementation

String_SubstringA_Loop:
    mov r8, rbx         ; index copy into r8
    xor rcx, rcx        ; set rcx index to 0
    jmp String_SubstringA_sub_loop; goto '.SUB_LOOP'

String_SubstringA_inc_sub:
    inc r8              ; r8 incrementation
    inc rcx             ; rcx index incrementation

String_SubstringA_sub_loop:
    mov dl, BYTE PTR [rsi+rcx]; put str2[rcx] into dl
    cmp dl, 0           ; is dl equal to 0 ?
    je String_SubstringA_ret_non_null; if yes, goto '.RET_NON_NULL'
    mov al, BYTE PTR [rdi+r8]; put str1[r8] into al
    cmp al, 0           ; is al equal to 0 ?
    je String_SubstringA_ret_null; if yes, goto '.RET_NULL'
    cmp al, dl          ; is al equal to dl ?
    je String_SubstringA_inc_sub; if yes, goto '.INC_SUB'
    jmp String_SubstringA_inc ; goto '.INCREMENT'

String_SubstringA_ret_null:
    xor rax, rax        ; set return value to NULL
    jmp String_SubstringA_end; goto '.END'

String_SubstringA_ret_non_null:
    mov rax, rdi        ; set return value to rdi
    add rax, rbx        ; add index to return value

String_SubstringA_end:
    ret                 ; end

String_SubstringA ENDP


END

