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
includelib kernel32.lib

;EXTERNDEF ArgByNumber :PROTO ,,,:QWORD

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Arg_GetCommandLineEx
;
; Extended version of Arg_GetCommandLine. This Arg_GetCommandLineEx function 
; uses the Arg_GetArgument function to obtain the selected argument from a 
; command line. It differs from the original version in that it will read a 
; command line of any length and the arguments can be delimited by spaces, tabs, 
; commas or any combination of the three.

; It is also faster but as the Arg_GetArgument function is table driven, it is 
; also larger.
;
; Parameters:
; 
; * nArgument - The argument number to return from a command line.
; 
; * lpszArgumentBuffer - The buffer to receive the selected argument.
;
; Returns:
; 
; There are three (3) possible return values:
; 	1 = successful operation
; 	2 = no argument exists at specified arg number
; 	3 = non matching quotation marks
; 
;------------------------------------------------------------------------------
Arg_GetCommandLineEx PROC FRAME nArgument:QWORD, lpszArgumentBuffer:QWORD

 ; 1 = successful operation
 ; 2 = no argument exists at specified arg number
 ; 3 = non matching quotation marks

    add nArgument, 1
    Invoke GetCommandLine
    Invoke Arg_GetArgument, rax, lpszArgumentBuffer, nArgument, 0

    .if rax >= 0
      mov rcx, lpszArgumentBuffer
      .if BYTE PTR [rcx] != 0
        mov rax, 1                      ; successful operation
      .else
        mov rax, 2                      ; no argument at specified number
      .endif
    .elseif rax == -1
      mov rax, 3                        ; non matching quotation marks
    .endif

    ret

Arg_GetCommandLineEx ENDP


END

