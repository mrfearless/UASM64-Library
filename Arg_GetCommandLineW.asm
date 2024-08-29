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
    GetCommandLineW PROTO
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
; Arg_GetCommandLineW
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
; See Also:
;
; Arg_GetCommandLineExW, Arg_GetArgumentW
; 
;------------------------------------------------------------------------------
Arg_GetCommandLineW PROC FRAME USES RCX RDI RSI nArgument:QWORD, lpszArgumentBuffer:QWORD
    LOCAL lpCmdLine      :QWORD
    LOCAL cmdBuffer[384] :BYTE
    LOCAL tmpBuffer[384] :BYTE
    
    Invoke GetCommandLineW
    mov lpCmdLine, rax        ; address command line
    
  ; -------------------------------------------------
  ; count quotation marks to see if pairs are matched
  ; -------------------------------------------------
    xor rcx, rcx            ; zero ecx & use as counter
    mov rsi, lpCmdLine
    
    @@:
      lodsw
      cmp ax, 0
      je @F
      cmp ax, 34            ; [ " ] character
      jne @B
      inc ecx               ; increment counter
      jmp @B
    @@:
    
    push rcx                ; save count
    
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
      cmp ax, 0
      je rtOut
      cmp ax, 9     ; tab
      jne rtIn
      mov ax, 32
    rtIn:
      stosw
      jmp @B
    rtOut:
      stosw         ; write last byte
    
  ; -----------------------------------------------------------
  ; substitute spaces in quoted text with replacement character
  ; -----------------------------------------------------------
    lea rax, cmdBuffer
    mov rsi, rax
    mov rdi, rax
    
    subSt:
      lodsw
      cmp ax, 0
      jne @F
      jmp subOut
    @@:
      cmp ax, 34
      jne subNxt
      stosw
      jmp subSl     ; goto subloop
    subNxt:
      stosw
      jmp subSt
    
    subSl:
      lodsw
      cmp ax, 32    ; space
      jne @F
        mov ax, 254 ; substitute character
      @@:
      cmp ax, 34
      jne @F
        stosw
        jmp subSt
      @@:
      stosw
      jmp subSl

    subOut:
      stosw         ; write last byte
    
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
      lodsw
      cmp ax, 32
      je @B

    l2St:
      cmp rcx, nArgument     ; the number of the required cmdline arg
      je clSubLp2
      lodsw
      cmp ax, 0
      je cl2Out
      cmp ax, 32
      jne cl2Ovr           ; if not space

    @@:
      lodsw
      cmp ax, 32          ; catch consecutive spaces
      je @B

      inc rcx             ; increment arg count
      cmp ax, 0
      je cl2Out

    cl2Ovr:
      jmp l2St

    clSubLp2:
      stosw
    @@:
      lodsw
      cmp ax, 32
      je cl2Out
      cmp ax, 0
      je cl2Out
      stosw
      jmp @B

    cl2Out:
      mov ax, 0
      stosw
    
  ; ------------------------------
  ; exit if arg number not reached
  ; ------------------------------
    .if sqword ptr rcx < nArgument
      mov rdi, lpszArgumentBuffer
      mov ax, 0
      stosw
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
      lodsw
      cmp ax, 0
      je rqOut
      cmp ax, 34    ; dont write [ " ] mark
      je rqStart
      cmp ax, 254
      jne @F
      mov ax, 32    ; substitute space
    @@:
      stosw
      jmp rqStart

  rqOut:
      stosw         ; write zero terminator
   
  ; ------------------
  ; handle empty quote
  ; ------------------
    mov rsi, lpszArgumentBuffer
    lodsw
    cmp ax, 0
    jne @F
    mov rax, 4  ; return value for empty quote
    ret
  @@:

    mov rax, 1  ; return value success
    
    ret
Arg_GetCommandLineW ENDP



END

