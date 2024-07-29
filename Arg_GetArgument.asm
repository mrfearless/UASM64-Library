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

.DATA

align 8
abntbl \
      db 2,0,0,0,0,0,0,0,0,1,1,0,0,1,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 1,0,3,0,0,0,0,0,0,0,0,0,1,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
      db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    ; 0 = OK char
    ; 1 = delimiting characters   tab LF CR space ","
    ;
    ; 2 = ASCII zero    This should not be changed in the table
    ; 3 = quotation     This should not be changed in the table



.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Arg_GetArgument
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
; * qwArgumentListReadOffset - The next read offset in the source address.
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
; See Also:
;
; Arg_GetCommandLine, Arg_GetCommandLineEx
; 
;------------------------------------------------------------------------------
Arg_GetArgument PROC FRAME USES RBX RCX RDX RDI RSI lpszArgumentList:QWORD,lpszDestination:QWORD,nArgument:QWORD,qwArgumentListReadOffset:QWORD

; -----------------------------------------------

;        Return values in EAX
;        --------------------
;        >0 = there is a higher nArgumentber argument available
;        0  = end of command line has been found
;        -1 = a non matching quotation error occurred
;
;        conditions of 0 or greater can have argument
;        content which can be tested as follows.
;
;        Test Argument for content
;        -------------------------
;        If the argument is empty, the first BYTE in the
;        destination buffer is set to zero
;
;        mov eax, destbuffer     ; load destination buffer
;        cmp BYTE PTR [eax], 0   ; test its first BYTE
;        je no_arg               ; branch to no arg handler
;        print destbuffer,13,10  ; display the argument
;
;        NOTE : A pair of empty quotes "" returns ascii 0
;               in the destination buffer

; ----------------------------------------------- *

    mov rsi, lpszArgumentList
    add rsi, qwArgumentListReadOffset
    mov rdi, lpszDestination

    mov BYTE PTR [rdi], 0           ; set destination buffer to zero length
    
    xor rbx, rbx

  ; *********
  ; scan args
  ; *********
  bcscan:
    movzx rax, BYTE PTR [rsi]
    add rsi, 1
    lea rcx, abntbl
    cmp BYTE PTR [rcx+rax], 1       ; delimiting character
    je bcscan
    cmp BYTE PTR [rcx+rax], 2       ; ASCII zero
    je quit

    sub rsi, 1
    add rbx, 1
    cmp rbx, nArgument              ; copy next argument if nArgument matches
    je cparg

  gcscan:
    movzx rax, BYTE PTR [rsi]
    add rsi, 1
    lea rcx, abntbl
    cmp BYTE PTR [rcx+rax], 0       ; OK character
    je gcscan
    cmp BYTE PTR [rcx+rax], 2       ; ASCII zero
    je quit
    cmp BYTE PTR [rcx+rax], 3       ; quotation
    je dblquote
    jmp bcscan                      ; return to delimiters

  dblquote:
    add rsi, 1
    cmp BYTE PTR [rsi], 0
    je qterror
    cmp BYTE PTR [rsi], 34
    jne dblquote
    add rsi, 1
    jmp bcscan                      ; return to delimiters

  ; ********
  ; copy arg
  ; ********
  cparg:
    xor rax, rax
    xor rdx, rdx
    cmp BYTE PTR [rsi+rdx], 34      ; if 1st char is a quote
    je cpquote                      ; jump to quote copy
  @@:
    mov al, [rsi+rdx]               ; copy normal argument to buffer
    mov [rdi+rdx], al
    test rax, rax
    jz quit
    add rdx, 1
    lea rcx, abntbl
    cmp BYTE PTR [rcx+rax], 1
    jl @B
    mov BYTE PTR [rdi+rdx-1], 0     ; append terminator
    jmp next_read

  ; ********************
  ; copy quoted argument
  ; ********************
  cpquote:
    add rsi, 1
  @@:
    mov al, [rsi+rdx]               ; strip quotes and copy contents to buffer
    test al, al
    jz qterror
    cmp al, 34
    je write_zero
    mov [rdi+rdx], al
    add rdx, 1
    jmp @B

  write_zero:
    add rdx, 1                      ; correct EDX for final exit position
    mov BYTE PTR [rdi+rdx-1], 0     ; append terminator

    jmp next_read                   ; jump to next read setup
  ; *****************
  ; set return values
  ; *****************
  qterror:
    mov rax, -1                     ; quotation error
    jmp rstack

  quit:
    xor rax, rax                    ; set EAX to zero for end of source buffer
    jmp rstack

  next_read:
    mov rax, rsi
    add rax, rdx
    sub rax, lpszArgumentList

  rstack:

    ret
Arg_GetArgument ENDP


END

