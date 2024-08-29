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

UASM64_ALIGN
;------------------------------------------------------------------------------
; Arg_GetCommandLineA
;
; Retrieve the argument specified by the nArgument parameter and returns it in 
; the buffer specified by the lpszArgumentBuffer parameter. 
;
; Arg_GetCommandLine differs slightly in its implementation in that it treats 
; the path and name of the application making the call as arg 0. 
;
; Parameters:
; 
; * nArgument - Argument number.
; 
; * lpszArgumentBuffer - Address of buffer to receive the argument if it exists.
; 
; Returns:
; 
; 1 = successful operation.
; 2 = no argument exists at specified arg number.
; 3 = non matching quotation marks.
; 4 = empty quotation marks.
;
; Notes:
;
; Arguments are specified from arg 1 up to the number of command line arguments 
; available. The function supports the retrieval of arguments that are enclosed 
; in quotation marks and will return the argument with the quotation marks 
; removed.
;
; The buffer for the returned argument should be set at 128 bytes in length 
; which is the maximum allowable
;
; This function as based on the MASM32 Library function: getcl
;
; See Also:
;
; Arg_GetCommandLineExA, Arg_GetArgumentA
; 
;------------------------------------------------------------------------------
Arg_GetCommandLineA PROC FRAME USES RCX RDI RSI nArgument:QWORD, lpszArgumentBuffer:QWORD
  ; -------------------------------------------------
  ; arguments returned in "lpszArgumentBuffer"
  ;
  ; arg 0 = program name
  ; arg 1 = 1st arg
  ; arg 2 = 2nd arg etc....
  ; -------------------------------------------------
  ; Return values in eax
  ;
  ; 1 = successful operation
  ; 2 = no argument exists at specified arg number
  ; 3 = non matching quotation marks
  ; 4 = empty quotation marks
  ; -------------------------------------------------

    LOCAL lpCmdLine      :QWORD
    LOCAL cmdBuffer[192] :BYTE
    LOCAL tmpBuffer[192] :BYTE

    IF @Platform EQ 3 ; Linux x64
        mov rax, 0 ; maybe we can get command line later with
        ; ; https://baturin.org/blog/hello-from-a-compiler-free-x86-64-world/
        ret
    ENDIF
    
    IF @Platform EQ 1 ; Win x64
        Invoke GetCommandLineA
    ENDIF
    mov lpCmdLine, rax        ; address command line

  ; -------------------------------------------------
  ; count quotation marks to see if pairs are matched
  ; -------------------------------------------------
    xor rcx, rcx            ; zero ecx & use as counter
    mov rsi, lpCmdLine
    
    @@:
      lodsb
      cmp al, 0
      je @F
      cmp al, 34            ; [ " ] character
      jne @B
      inc rcx               ; increment counter
      jmp @B
    @@:

    push rcx                ; save count

    shr rcx, 1              ; integer divide ecx by 2
    shl rcx, 1              ; multiply ecx by 2 to get dividend

    pop rax                 ; put count in eax
    cmp rax, rcx            ; check if they are the same
    je @F
      mov rax, 3            ; return 3 in eax = non matching quotation marks
      ret
    @@:

  ; ------------------------
  ; replace tabs with spaces
  ; ------------------------
    mov rsi, lpCmdLine
    lea rdi, cmdBuffer

    @@:
      lodsb
      cmp al, 0
      je rtOut
      cmp al, 9     ; tab
      jne rtIn
      mov al, 32
    rtIn:
      stosb
      jmp @B
    rtOut:
      stosb         ; write last byte

  ; -----------------------------------------------------------
  ; substitute spaces in quoted text with replacement character
  ; -----------------------------------------------------------
    lea rax, cmdBuffer
    mov rsi, rax
    mov rdi, rax

    subSt:
      lodsb
      cmp al, 0
      jne @F
      jmp subOut
    @@:
      cmp al, 34
      jne subNxt
      stosb
      jmp subSl     ; goto subloop
    subNxt:
      stosb
      jmp subSt

    subSl:
      lodsb
      cmp al, 32    ; space
      jne @F
        mov al, 254 ; substitute character
      @@:
      cmp al, 34
      jne @F
        stosb
        jmp subSt
      @@:
      stosb
      jmp subSl

    subOut:
      stosb         ; write last byte

  ; ----------------------------------------------------
  ; the following code determines the correct arg number
  ; and writes the arg into the destination buffer
  ; ----------------------------------------------------
    lea rax, cmdBuffer
    mov rsi, rax
    lea rdi, tmpBuffer

    mov rcx, 0          ; use ecx as counter

  ; ---------------------------
  ; strip leading spaces if any
  ; ---------------------------
    @@:
      lodsb
      cmp al, 32
      je @B

    l2St:
      cmp rcx, nArgument     ; the number of the required cmdline arg
      je clSubLp2
      lodsb
      cmp al, 0
      je cl2Out
      cmp al, 32
      jne cl2Ovr           ; if not space

    @@:
      lodsb
      cmp al, 32          ; catch consecutive spaces
      je @B

      inc rcx             ; increment arg count
      cmp al, 0
      je cl2Out

    cl2Ovr:
      jmp l2St

    clSubLp2:
      stosb
    @@:
      lodsb
      cmp al, 32
      je cl2Out
      cmp al, 0
      je cl2Out
      stosb
      jmp @B

    cl2Out:
      mov al, 0
      stosb

  ; ------------------------------
  ; exit if arg number not reached
  ; ------------------------------
    .if rcx < nArgument
      mov rdi, lpszArgumentBuffer
      mov al, 0
      stosb
      mov rax, 2  ; return value of 2 means arg did not exist
      ret
    .endif

  ; -------------------------------------------------------------
  ; remove quotation marks and replace the substitution character
  ; -------------------------------------------------------------
    lea rax, tmpBuffer
    mov rsi, rax
    mov rdi, lpszArgumentBuffer

    rqStart:
      lodsb
      cmp al, 0
      je rqOut
      cmp al, 34    ; dont write [ " ] mark
      je rqStart
      cmp al, 254
      jne @F
      mov al, 32    ; substitute space
    @@:
      stosb
      jmp rqStart

  rqOut:
      stosb         ; write zero terminator

  ; ------------------
  ; handle empty quote
  ; ------------------
    mov rsi, lpszArgumentBuffer
    lodsb
    cmp al, 0
    jne @F
    mov rax, 4  ; return value for empty quote
    ret
  @@:

    mov rax, 1  ; return value success
    ret
Arg_GetCommandLineA ENDP


END

