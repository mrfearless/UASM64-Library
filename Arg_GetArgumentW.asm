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
; Arg_GetArgumentW
;
; Return the contents of an argument from an argument list by its number.
;
; Parameters:
; 
; * lpszArgumentList - The address of the zero terminated argument list.
; 
; * lpszDestination - The address of the destination buffer.
; 
; * nArgument - The number of the argument to return.
; 
; * qwNotUsed - Not used, for compatibility with Masm32 ArgByNumber and
;   Arg_GetArgumentA, using same amount of parameters for each.
;
; Returns:
; 
; The return value is the updated next read offset in the source if it is 
; greater than zero.
;
; The three possible return values are:
;   > 1 = The next read offset in the source.
;   0   = The end of the argument list has been reached.
;   -1  = A non matching quotation error has occurred in the source.
; 
; Notes:
;
; This function supports double quoted text and it is delimited by the space 
; character, a tab or a comma or any combination of these three. It may be used
; in two separate modes, single argument mode and streaming mode.
;
; In separate argument mode you specify the argument you wish to obtain with 
; the nArgument parameter and you set the qwArgumentListReadOffset parameter to 
; zero.
;
; In streaming mode you set a variable to zero and pass it as the 4th parameter 
; qwArgumentListReadOffset and save the RAX return value back into this variable 
; for the next call to the function. The nArgument parameter in streaming mode 
; should be set to one "1"
;
; To support the notation of an empty pair of double quotes in an argument list 
; the parser in this algorithm return an empty destination buffer that has an 
; ascii zero as it first character.
;
; This function as based on the MASM32 Library function: ucArgByNum
;
; See Also:
;
; Arg_GetCommandLineW, Arg_GetCommandLineExW
; 
;------------------------------------------------------------------------------
Arg_GetArgumentW PROC FRAME USES RBX RCX RDX RDI RSI lpszArgumentList:QWORD, lpszDestination:QWORD, nArgument:QWORD, qwNotUsed:QWORD

    mov rsi, lpszArgumentList
    mov rcx, 1
    xor rax, rax

    mov rdx, lpszDestination
    mov WORD PTR [rdx], 0

  ; ------------------------------------
  ; handle src as pointer to NULL string
  ; ------------------------------------
    cmp WORD PTR [rsi], 0
    jne next1
    jmp bailout
  next1:
    sub rsi, 2

  ftrim:
    add rsi, 2
    mov ax, WORD PTR [rsi]
    cmp ax, 32
    je ftrim
    cmp ax, 9
    je ftrim
    cmp ax, 0
    je bailout                  ; exit on empty string (only white space)

    cmp WORD PTR [rsi], 34
    je quoted

    sub rsi, 2

  ; ----------------------------

  unquoted:
    add rsi, 2
    mov ax, WORD PTR [rsi]
    test ax, ax
    jz scanout
    cmp ax, 32
    je wordend
    mov WORD PTR [rdx], ax
    add rdx, 2
    jmp unquoted

  wordend:
    cmp rcx, nArgument
    je scanout
    add rcx, 1
    mov rdx, lpszDestination
    mov WORD PTR [rdx], 0
    jmp ftrim

  ; ----------------------------

  quoted:
    add rsi, 2
    mov ax, WORD PTR [rsi]
    test ax, ax
    jz scanout
    cmp ax, 34
    je quoteend
    mov WORD PTR [rdx], ax
    add rdx, 2
    jmp quoted

  quoteend:
    add rdi, 2
    cmp rcx, nArgument
    je scanout
    add rcx, 1
    mov rdx, lpszDestination
    mov WORD PTR [rdx], 0
    jmp ftrim

  ; ----------------------------

  scanout:
    .if nArgument > rcx
    bailout:                        ; error exit
      mov rdx, lpszDestination      ; reload dest address
      mov WORD PTR [rdx], 0         ; zero dest buffer
      xor rax, rax                  ; zero return value
      jmp quit
    .else                           ; normal exit
      mov WORD PTR [rdx], 0         ; terminate output buffer
      mov rax, rcx                  ; set the return value
    .endif

  quit:

    ret
Arg_GetArgumentW ENDP


END

