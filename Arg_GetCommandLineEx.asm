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

IF @Platform EQ 1 ; Win x64
    GetCommandLineA PROTO
    includelib kernel32.lib
ENDIF
IF @Platform EQ 3 ; Linux x64
; https://baturin.org/blog/hello-from-a-compiler-free-x86-64-world/
; https://gist.github.com/Gydo194/730c1775f1e05fdca6e9b0c175636f5b
ENDIF

include UASM64.inc

.CODE

IF @Platform EQ 1 ; Win x64
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
; See Also:
;
; Arg_GetCommandLine, Arg_GetArgument
; 
;------------------------------------------------------------------------------
Arg_GetCommandLineEx PROC FRAME USES RCX nArgument:QWORD, lpszArgumentBuffer:QWORD
    LOCAL lpszArgsList:QWORD

 ; 1 = successful operation
 ; 2 = no argument exists at specified arg number
 ; 3 = non matching quotation marks

    add nArgument, 1
    
    Invoke GetCommandLineA
    mov lpszArgsList, rax
    Invoke Arg_GetArgument, lpszArgsList, lpszArgumentBuffer, nArgument, 0

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
ENDIF

IF @Platform EQ 3 ; Linux x64
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
; See Also:
;
; Arg_GetCommandLine, Arg_GetArgument
; 
;------------------------------------------------------------------------------
Arg_GetCommandLineEx PROC FRAME nArgument:QWORD, lpszArgumentBuffer:QWORD
    mov rax, 0 ; maybe we can get command line later with
    ; ; https://baturin.org/blog/hello-from-a-compiler-free-x86-64-world/
    ret
Arg_GetCommandLineEx ENDP
ENDIF

END

