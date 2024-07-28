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

.data
  align 8
  ctbl \
    dw 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,1,0,0,0,0,0,0,0,1,1,0,1,0,0
    dw 1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
    dw 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    dw 1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1
    dw 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    dw 1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    ;   allowable character range
    ;   -------------------------
    ;   upper & lower case characters
    ;   numbers
    ;   " "           ; quotation marks
    ;   [ ]           ; address enclosure
    ;   + - *         ; displacement and multiplier calculation
    ;   : @           ; label identification

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; Text_ParseLineW
;
; Parse words in a line of text into an array of zero terminated strings. This 
; is the Unicode version of Text_ParseLine, Text_ParseLineA is the Ansi version
;
; Parameters:
; 
; * lpszTextSource - The address of the zero terminated line of text.
; 
; * pArray - The array to write the words to.
; 
; Returns:
; 
; The return value is the number of words written to the array.
;
; Notes:
;
; The words in the line of text are individually loaded into consecutive array 
; locations. The array address passed to the procedure must be an array of 
; pointers to preallocated memory. The Array_Create function is ideally suited 
; to this task as it allocates the memory and sets the array of pointers to the 
; members of the array.
;
; When you allocate the array of zero terminated strings, you must ensure that 
; the individual buffer size is large enough and there are enough members to 
; handle the maximum number of words on the line of text.
;
; Words are determined by an allowable character table. The function was 
; originally designed to parse lines of assembler code so it supports the 
; following characters:
;
;    upper case            ABCDEFGHIJKLMNOPQRSTUVWXYZ
;    lower case            abcdefghijklmnopqrstuvwxyz
;    numbers               0123456789
;    quotation marks       " "
;    square brackets       [ ]
;    address calculation   + - *
;    label identification  :
;
; The algorithm is flexible enough to do most normal line parsing requirements.
;
; This function as based on the MASM32 Library function: parse_line
;
; See Also:
;
; Text_LineCountW, Text_LineCountExW, Text_ReadLineW, Text_TestLineW
; 
;------------------------------------------------------------------------------
Text_ParseLineW PROC FRAME USES RBX RCX RDX RDI RSI lpszTextSource:QWORD, pArray:QWORD
    mov rsi, lpszTextSource             ; line in ESI
    mov rdi, pArray                     ; word array in EDI
    mov rcx, [rdi]                      ; 1st array member address in ECX
    xor rax, rax                        ; clear EAX
    xor rdx, rdx                        ; set arg counter to zero

  ; ----------------------------------
  align 8
  badchar:
    mov ax, word ptr [rsi]
    add rsi, 2
    test ax, ax                         ; test if byte is terminator
    jz gaout
    lea rbx, ctbl
    cmp WORD PTR [rax+rbx], 1           ; is it a good char ?
    jne badchar
    add rdx, 1                          ; add to arg counter
    jmp writechar
  goodchar:
    mov ax, word ptr [rsi]
    add rsi, 2
    test ax, ax                         ; test if byte is terminator
    jz gaout
    lea rbx, ctbl
    cmp WORD PTR [rax+rbx], 0           ; is it a bad char ?
    je reindex
  writechar:
    cmp ax, "["                         ; test for opening square bracket
    je wsqb                             ; branch to handler if it is
    cmp al, 34                          ; test for opening quotation
    je preq                             ; branch to quote handler if it is
    mov word ptr [rcx], ax              ; write byte to buffer
    add rcx, 1
    jmp goodchar
  ; ----------------------------------
  align 8
  reindex:
    mov WORD PTR [rcx], 0               ; write terminator to array member
    add rdi, 4                          ; index to next array member
    mov rcx, [rdi]                      ; put its address in ECX
    jmp badchar
  ; ----------------------------------
  align 8
  preq:
    mov [rcx], ax                       ; write byte to buffer
    add rcx, 1
  quotes:                               ; quotation handler
    mov ax, word ptr [rsi]
    add rsi, 2
    test ax, ax                         ; test if byte is terminator
    jz qterror                          ; jump to quotation error
 ;     cmp al, 32
 ;     je quotes                        ; uncomment these lines to strip spaces in quotes
  wqot:
    mov word ptr [rcx], ax              ; write byte to buffer
    add rcx, 1
    cmp ax, 34                          ; test for closing quote
    je reindex
    jmp quotes

  align 8
  squareb:                              ; square bracket handler
    mov ax, word ptr [rsi]
    add rsi, 2
    test ax, ax                         ; test if byte is terminator
    jz sberror                          ; jump to square bracket error
    cmp ax, 32
    je squareb
  wsqb:
    mov word ptr [rcx], ax          ; write byte to buffer
    add rcx, 1
    cmp ax, "]"
    je reindex
    jmp squareb
  ; ----------------------------------
  align 8
  qterror:                              ; quotation error
    mov rcx, 2                          ; set ECX as 2
    jmp gaquit                          ; no closing quoation

  align 8
  sberror:                              ; square bracket error
    mov rcx, 1                          ; set ECX to 1
    jmp gaquit                          ; no closing square bracket

  align 8
  gaout:
    mov WORD PTR [rcx], 0               ; terminate last buffer written to.
    add rdi, 8
    mov rcx, [rdi]
    mov WORD PTR [rcx], 0               ; set next buffer with leading zero
    xor rcx, rcx                        ; ECX set to zero is NO ERROR
  gaquit:
    mov rax, rdx                        ; return arg count
    ret
Text_ParseLineW ENDP


END

