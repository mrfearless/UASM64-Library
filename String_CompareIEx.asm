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

include UASM64.inc

.DATA
ALIGN 16

Cmpi_tbl \
db   0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15
db  16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
db  32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47
db  48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
db  64, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111
db 112,113,114,115,116,117,118,119,120,121,122, 91, 92, 93, 94, 95
db  96, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111
db 112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127
db 128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143
db 144,145,146,147,148,149,150,151,152,153,154,155,156,156,158,159
db 160,161,162,163,164,165,166,167,168,169,170,171,172,173,173,175
db 176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191
db 192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207
db 208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223
db 224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239
db 240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; String_CompareIEx
;
; A case insensitive string comparison that compares two zero terminated 
; strings for a difference.
;
; Parameters:
; 
; * lpszCaseInsensitiveString1 - The address of the first zero terminated 
;   string to compare.
; 
; * lpszCaseInsensitiveString2 - The address of the second zero terminated 
;   string to compare.
; 
; * qwLengthString - The number of characters to test for, usually the length 
;   of the first string.
;
; Returns:
; 
; If the two text sources match as case insensitive, the return value is 0, 
; otherwise the return value is non zero.
; 
; Notes:
; 
; This function uses a character table and a character count and it can be 
; used on any BYTE sequence including string. If you need to emulate the 
; characteristics of the case sensitive version, convert both strings to a 
; single case and then do a case sensitive comparison.
; 
;------------------------------------------------------------------------------
String_CompareIEx PROC FRAME USES RBX RCX RDX RDI RSI R8 lpszCaseInsensitiveString1:QWORD,lpszCaseInsensitiveString2:QWORD,qwLengthString:QWORD
    
    lea r8, Cmpi_tbl
    mov rsi, lpszCaseInsensitiveString1               ; src
    mov rdi, lpszCaseInsensitiveString2               ; dst
    sub rax, rax               ; zero eax as index

  align 8
  @@:
    movzx rdx, BYTE PTR [rsi+rax]
    movzx rbx, BYTE PTR [rdi+rax]
    movzx rcx, BYTE PTR [rdx+r8] ;szCmpi_tbl
    add rax, 1
    cmp cl, [rbx+r8] ; szCmpi_tbl
    jne quit
    cmp rax, qwLengthString
    jb @b

    sub rax, rax

  quit:

    ret
String_CompareIEx ENDP


END

