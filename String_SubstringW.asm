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
; String_SubstringW
;
; Find a needle in a haystack, or a substring within a string. This is the 
; Unicode version of String_Substring, String_SubstringA is the Ansi version.
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
; String_LeftW, String_RightW, String_MiddleW
; 
;------------------------------------------------------------------------------
String_SubstringW PROC FRAME USES RBX RCX RDX RDI RSI R8 lpszString:QWORD, lpszSubString:QWORD

    mov rdi, lpszString
    mov rsi, lpszSubString
	xor rbx, rbx		; set an index to 0
	jmp String_SubstringA_Loop ; goto '.LOOP'

String_SubstringA_inc:
	inc rbx			    ; rbx index incrementation
	inc rbx			    ; rbx index incrementation

String_SubstringA_Loop:
	mov r8, rbx		    ; index copy into r8
	xor rcx, rcx		; set rcx index to 0
	jmp String_SubstringA_sub_loop; goto '.SUB_LOOP'

String_SubstringA_inc_sub:
	inc r8			    ; r8 incrementation
	inc r8			    ; r8 incrementation
	inc rcx			    ; rcx index incrementation
	inc rcx			    ; rcx index incrementation

String_SubstringA_sub_loop:
	mov dx, WORD PTR [rsi+rcx]; put str2[rcx] into dl
	cmp dx, 0		    ; is dl equal to 0 ?
	je String_SubstringA_ret_non_null; if yes, goto '.RET_NON_NULL'
	mov ax, WORD PTR [rdi+r8]; put str1[r8] into al
	cmp ax, 0		    ; is al equal to 0 ?
	je String_SubstringA_ret_null; if yes, goto '.RET_NULL'
	cmp ax, dx		    ; is al equal to dl ?
	je String_SubstringA_inc_sub; if yes, goto '.INC_SUB'
	jmp String_SubstringA_inc ; goto '.INCREMENT'

String_SubstringA_ret_null:
	xor rax, rax		; set return value to NULL
	jmp String_SubstringA_end; goto '.END'

String_SubstringA_ret_non_null:
	mov rax, rdi		; set return value to rdi
	add rax, rbx		; add index to return value

String_SubstringA_end:
	ret			        ; end

String_SubstringW ENDP


END

