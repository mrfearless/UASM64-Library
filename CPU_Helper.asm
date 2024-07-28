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

_CPU_Features_CalcStringLength  PROTO lpTable:QWORD, qwRecordCount:QWORD, qwRegValue:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, lpqwCount:QWORD
_CPU_Features_CopyStrings       PROTO lpTable:QWORD, qwRecordCount:QWORD, qwRegValue:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, lpszFeatureString:QWORD, qwStringOffset:QWORD, qwEntriesFound:QWORD, bMore:QWORD

;RtlMoveMemory   PROTO Destination:QWORD, Source:QWORD, qwLength:QWORD
;lstrlen         PROTO lpszStr:QWORD

;includelib kernel32.lib

include UASM64.inc

IFNDEF CPU_FEATURES_RECORD
CPU_FEATURES_RECORD STRUCT
    BitValue        DD ?
    lpszMnemonic    DB 24 DUP (?)
    lpszFeature     DB 80 DUP (?)
CPU_FEATURES_RECORD ENDS
ENDIF

.DATA
szCFSS_NULL              DB 0
qwCFSS_NULL              DQ ($ - szCFSS_NULL)
szCFSS_SPACE             DB 32
qwCFSS_SPACE             DQ ($ - szCFSS_SPACE)
szCFSS_COMMA             DB ', '
qwCFSS_COMMA             DQ ($ - szCFSS_COMMA)
szCFSS_TAB               DB 09
qwCFSS_TAB               DQ ($ - szCFSS_TAB)
szCFSS_LF                DB 10
qwCFSS_LF                DQ ($ - szCFSS_LF)
szCFSS_CRLF              DB 13,10
qwCFSS_CRLF              DQ ($ - szCFSS_CRLF)
szCFSS_LIST              DB '- '
qwCFSS_LIST              DQ ($ - szCFSS_LIST)
szCFST_BOTH              DB ': '
qwCFST_BOTH              DQ ($ - szCFST_BOTH)

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; _CPU_Features_CalcStringLength 
;
; Internal function used by CPU_Basic_Features, CPU_Basic_Features_Ext0,
; CPU_Basic_Features_Ext1, CPU_Basic_Features_Ext2 and CPU_Extended_Features
;
; Go through the CPU_FEATURES table specified by the lpTable parameter and AND 
; each BitValue against the value in the qwRegValue parameter
;
; For each that matches, calculate the length of string (along with string 
; style) and add that to the total for all strings: ; qwAllStringsLength
;
; Parameters:
; 
; * lpTable - Pointer to the CPU_FEATURES table to use.
; 
; * qwRecordCount - Total record count of the specified CPU_FEATURES table.
; 
; * qwRegValue - The register value from CPUID to check against each record.
; 
; * qwStringType - The type of feature string to include, can be one of the 
;   following value:
;
;       * CFST_MNEMONIC - Short form of the feature: "AVX"
;       * CFST_FEATURE - Long form describing the feature: "Advanced Vector Exte.."
;       * CFST_BOTH - "AVX: Advanced Vector Extensions (AVX) Instruction Extensions"
;
; * qwStringStyle - the style of formatting for the feature string, can be one
;   of the following values:
;
;       * CFSS_NULL - null separated.
;       * CFSS_SPACE - space separated.
;       * CFSS_COMMA - comma and space separated.
;       * CFSS_TAB - tab separated.
;       * CFSS_LF - line feed (LF) separated.
;       * CFSS_CRLF - carriage return (CR) and line feed (LF) separated.
;       * CFSS_LIST - dash '- ' precedes text and CRLF separates.
;
; * lpqwCount - Pointer to a QWORD variable to store the count of matching
;   records found whilst calculating the string length for all records.
; 
; Returns:
; 
; Returns in RAX the length of the calculated string to hold all the 
; information from the table specified, that has matching records for the 
; qwRegValue value. 0 if an error occured or no matching records found.
; 
;------------------------------------------------------------------------------
_CPU_Features_CalcStringLength PROC FRAME USES RBX lpTable:QWORD, qwRecordCount:QWORD, qwRegValue:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, lpqwCount:QWORD
    LOCAL pRecord:QWORD
    LOCAL nRecord:QWORD
    LOCAL bRecord:QWORD
    LOCAL BitValue:QWORD
    LOCAL qwEntriesFound:QWORD
    LOCAL lpszString:QWORD
    LOCAL qwStringLength:QWORD
    LOCAL qwStringLengthBoth:QWORD
    LOCAL qwStringLengthFeature:QWORD
    LOCAL qwAllStringsLength:QWORD
    
    IFDEF DEBUG64
    PrintText '_CPU_Features_CalcStringLength'
    ENDIF
    
    .IF lpTable == 0 
        jmp _CPU_Features_CalcStringLength_Error
    .ENDIF
    
    mov qwStringLength, 0
    mov qwAllStringsLength, 0
    
    mov rax, lpTable
    mov pRecord, rax
    mov nRecord, 0
    mov qwEntriesFound, 0
    
    mov rax, 0
    .WHILE rax < qwRecordCount
        mov rbx, pRecord
        mov eax, dword ptr [rbx]
        mov BitValue, rax
        
        ;------------------------------------------------------------------
        ; AND the values, to determine if we have found a match
        ;------------------------------------------------------------------
        mov bRecord, FALSE
        and rax, qwRegValue
        .IF rax == BitValue
            mov bRecord, TRUE
        .ENDIF
    
        ;------------------------------------------------------------------
        ; If we have found a match we calculate length of string and adjust
        ; for the string style required and add to qwAllStringsLength
        ;------------------------------------------------------------------
        .IF bRecord == TRUE
            mov rbx, pRecord
            
            mov rax, qwStringType
            .IF rax == CFST_MNEMONIC    ; Short form of the feature: "AVX"
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                add qwAllStringsLength, rax
            .ELSEIF rax == CFST_FEATURE ; Long form describing the feature: "Advanced Vector Extensions (AVX) Instruction Extensions"
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                add qwAllStringsLength, rax
            .ELSEIF rax == CFST_BOTH    ; Both
                ; first check for the total string length for both
                mov rbx, pRecord
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLengthBoth, rax
                mov rbx, pRecord
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                add qwStringLengthBoth, rax
                
                .IF qwStringLengthBoth != 0
                    mov qwStringLengthFeature, rax ; save lpszFeature length to here
                    mov rbx, pRecord
                    lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                    mov lpszString, rax
                    Invoke String_LengthA, lpszString
                    mov qwStringLength, rax
                    add qwAllStringsLength, rax
                    
                    .IF qwStringLength != 0 && qwStringLengthFeature != 0
                        add qwAllStringsLength, 2 ; for ': '
                    .ENDIF
                    
                    mov rbx, pRecord
                    lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                    mov lpszString, rax
                    Invoke String_LengthA, lpszString
                    mov qwStringLength, rax
                    add qwAllStringsLength, rax
                
                .ELSE
                    mov qwStringLength, 0
                .ENDIF
                
            .ELSE ; same as CFST_MNEMONIC
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                add qwAllStringsLength, rax
            .ENDIF
            
            .IF qwStringLength != 0
                mov rax, qwStringStyle
                .IF rax == CFSS_NULL      ; null seperated, double null terminated.
                    mov rax, 1
                .ELSEIF rax == CFSS_SPACE ; space seperated, null terminated.
                    mov rax, 1
                .ELSEIF rax == CFSS_COMMA ; comma and space seperated, null terminated.
                    mov rax, 2
                .ELSEIF rax == CFSS_TAB   ; tab seperated, null terminated.
                    mov rax, 1
                .ELSEIF rax == CFSS_LF    ; line feed (LF) seperated, null terminated.
                    mov rax, 1
                .ELSEIF rax == CFSS_CRLF  ; carriage return (CR) and line feed (LF) seperated, null terminated.
                    mov rax, 2
                .ELSEIF rax == CFSS_LIST  ; dash preceeds text and CRLF seperates, null terminated.
                    mov rax, 4
                .ELSE
                    mov rax, 1 ; CFSS_NULL
                .ENDIF
                add qwAllStringsLength, rax
                inc qwEntriesFound
            .ENDIF
        .ENDIF
        
        add pRecord, SIZEOF CPU_FEATURES_RECORD
        inc nRecord
        mov rax, nRecord
    .ENDW
    
    IFDEF DEBUG64
    PrintDec qwEntriesFound
    ENDIF
    
    .IF lpqwCount != 0
        mov rbx, lpqwCount
        mov rax, qwEntriesFound
        mov [rbx], rax
    .ENDIF
    mov rax, qwAllStringsLength
    ret
    
_CPU_Features_CalcStringLength_Error:
    .IF lpqwCount != 0
        mov rbx, lpqwCount
        mov rax, 0
        mov [rbx], rax
    .ENDIF
    mov rax, 0
    
    ret
_CPU_Features_CalcStringLength ENDP


UASM64_ALIGN
;------------------------------------------------------------------------------
; _CPU_Features_CopyStrings
;
; Internal function used by CPU_Basic_Features, CPU_Basic_Features_Ext0,
; CPU_Basic_Features_Ext1, CPU_Basic_Features_Ext2 and CPU_Extended_Features
; 
; Go through the CPU_FEATURES table specified by the lpTable parameter and AND 
; each BitValue against the value in the qwRegValue parameter
;
; For each that matches, copy the string for that record (along with string 
; style) and append that to the buffer for all the strings, which is pointed to
; by thge lpszFeatureString parameter.
;
; Parameters:
; 
; * lpTable - Pointer to the CPU_FEATURES table to use.
; 
; * qwRecordCount - Total record count of the specified CPU_FEATURES table.
; 
; * qwRegValue - The register value from CPUID to check against each record.
; 
; * qwStringType - The type of feature string to include, can be one of the 
;   following value:
;
;       * CFST_MNEMONIC - Short form of the feature: "AVX"
;       * CFST_FEATURE - Long form describing the feature: "Advanced Vector Exte.."
;       * CFST_BOTH - "AVX: Advanced Vector Extensions (AVX) Instruction Extensions"
;
; * qwStringStyle - the style of formatting for the feature string, can be one
;   of the following values:
;
;       * CFSS_NULL - null separated.
;       * CFSS_SPACE - space separated.
;       * CFSS_COMMA - comma and space separated.
;       * CFSS_TAB - tab separated.
;       * CFSS_LF - line feed (LF) separated.
;       * CFSS_CRLF - carriage return (CR) and line feed (LF) separated.
;       * CFSS_LIST - dash '- ' precedes text and CRLF separates.
;
; * lpszFeatureString - A pointer to a buffer to store the strings copied from
;   the record that matches the value in the qwRegValue parameter.
; 
; * qwStringOffset - The starting offset in the string pointed to by the 
;   lpszFeatureString parameter to start copying to.
; 
; * qwEntriesFound - Parameter details.
; 
; * bMore - TRUE if more will be added to lpszFeatureString later on, or FALSE.
; 
; Returns:
; 
; In RAX, the current position in the buffer for the string pointed to by the 
; lpszFeatureString parameter, which can be used in subsequent calls to this
; function, by passing the value in via the qwStringOffset parameter.
;
; 0 is returned if an error occurred, no entries to search for or no buffer to
; copy the strings to.
; 
;------------------------------------------------------------------------------
_CPU_Features_CopyStrings PROC FRAME USES RBX lpTable:QWORD, qwRecordCount:QWORD, qwRegValue:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, lpszFeatureString:QWORD, qwStringOffset:QWORD, qwEntriesFound:QWORD, bMore:QWORD
    LOCAL pRecord:QWORD
    LOCAL nRecord:QWORD
    LOCAL bRecord:QWORD
    LOCAL BitValue:QWORD
    LOCAL lpszString:QWORD
    LOCAL qwStringLength:QWORD
    LOCAL qwStringLengthBoth:QWORD
    LOCAL qwStringLengthFeature:QWORD
    LOCAL qwEntry:QWORD
    LOCAL qwFeatureStringPos:QWORD
    
    IFDEF DEBUG64
    PrintText '_CPU_Features_CopyStrings'
    ENDIF
    
    .IF lpTable == 0 || lpszFeatureString == 0 || qwEntriesFound == 0
        jmp _CPU_Features_CopyStrings_Error
    .ENDIF
    
    mov rax, qwStringOffset
    mov qwFeatureStringPos, rax
    
    mov qwEntry, 1
    mov qwStringLength, 0
    
    mov rax, lpTable
    mov pRecord, rax
    mov nRecord, 0
    
    mov rax, 0
    .WHILE rax < qwRecordCount
        mov rbx, pRecord
        mov eax, dword ptr [rbx]
        mov BitValue, rax
        
        ;------------------------------------------------------------------
        ; AND the values, to determine if we have found a match
        ;------------------------------------------------------------------
        mov bRecord, FALSE
        and rax, qwRegValue
        .IF rax == BitValue
            mov bRecord, TRUE
        .ENDIF
    
        IFDEF DEBUG64
        .IF qwEntriesFound == 1
            mov rax, qwRegValue
            .IF rax == BitValue
                PrintDec qwRegValue
                PrintDec BitValue
                PrintDec qwStringOffset
                PrintDec bMore
                mov rbx, pRecord
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                DbgDump rax, 4
            .ENDIF
        .ENDIF    
        ENDIF
        
        ;--------------------------------------------------------------
        ; If we have found a match we copy the string (and add for the 
        ; string style) to the total strings buffer: lpszAllStrings
        ;--------------------------------------------------------------
        .IF bRecord == TRUE
        
            .IF qwStringStyle == CFSS_LIST  ; dash preceeds text and CRLF seperates, null terminated.
                lea rax, szCFSS_LIST
                mov rbx, lpszFeatureString
                add rbx, qwFeatureStringPos
                Invoke Memory_Copy, rax, rbx, qwCFSS_LIST
                ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_LIST
                mov rax, qwCFSS_LIST
                add qwFeatureStringPos, rax
            .ENDIF
            
            mov rbx, pRecord
            
            mov rax, qwStringType
            .IF rax == CFST_MNEMONIC    ; Short form of the feature: "AVX"
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                mov rax, lpszString
                mov rbx, lpszFeatureString
                add rbx, qwFeatureStringPos
                Invoke Memory_Copy, rax, rbx, qwStringLength
                ;Invoke RtlMoveMemory, rdi, rsi, qwStringLength
                mov rax, qwStringLength
                add qwFeatureStringPos, rax  
            .ELSEIF rax == CFST_FEATURE ; Long form describing the feature: "Advanced Vector Extensions (AVX) Instruction Extensions"
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                mov rax, lpszString
                mov rbx, lpszFeatureString
                add rbx, qwFeatureStringPos
                Invoke Memory_Copy, rax, rbx, qwStringLength
                ;Invoke RtlMoveMemory, rdi, rsi, qwStringLength
                mov rax, qwStringLength
                add qwFeatureStringPos, rax  
            .ELSEIF rax == CFST_BOTH    ; Both
                ; first check for the total string length for both
                mov rbx, pRecord
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLengthBoth, rax
                mov rbx, pRecord
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                add qwStringLengthBoth, rax
                
                .IF qwStringLengthBoth != 0
                    mov qwStringLengthFeature, rax ; save lpszFeature length to here
                    mov rbx, pRecord
                    lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                    mov lpszString, rax
                    Invoke String_LengthA, lpszString
                    mov qwStringLength, rax
                    mov rax, lpszString
                    mov rbx, lpszFeatureString
                    add rbx, qwFeatureStringPos
                    Invoke Memory_Copy, rax, rbx, qwStringLength
                    ;Invoke RtlMoveMemory, rdi, rsi, qwStringLength
                    mov rax, qwStringLength
                    add qwFeatureStringPos, rax  
                    
                    .IF qwStringLength != 0 && qwStringLengthFeature != 0
                        ; ': '
                        lea rax, szCFST_BOTH
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFST_BOTH
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFST_BOTH
                        mov rax, qwCFST_BOTH
                        add qwFeatureStringPos, rax
                    .ENDIF
                    
                    mov rbx, pRecord
                    lea rax, [rbx].CPU_FEATURES_RECORD.lpszFeature
                    mov lpszString, rax
                    Invoke String_LengthA, lpszString
                    mov qwStringLength, rax
                    mov rax, lpszString
                    mov rbx, lpszFeatureString
                    add rbx, qwFeatureStringPos
                    Invoke Memory_Copy, rax, rbx, qwStringLength
                    ;Invoke RtlMoveMemory, rdi, rsi, qwStringLength
                    mov rax, qwStringLength
                    add qwFeatureStringPos, rax
                .ELSE
                    mov qwStringLength, 0
                .ENDIF
                
            .ELSE ; same as CFST_MNEMONIC
                lea rax, [rbx].CPU_FEATURES_RECORD.lpszMnemonic
                mov lpszString, rax
                Invoke String_LengthA, lpszString
                mov qwStringLength, rax
                mov rax, lpszString
                mov rbx, lpszFeatureString
                add rbx, qwFeatureStringPos
                Invoke Memory_Copy, rax, rbx, qwStringLength
                ;Invoke RtlMoveMemory, rdi, rsi, qwStringLength
                mov rax, qwStringLength
                add qwFeatureStringPos, rax  
            .ENDIF
            
            mov rax, qwEntry
            .IF rax < qwEntriesFound || (rax == qwEntriesFound && bMore == TRUE)
                .IF qwStringLength != 0
                    mov rax, qwStringStyle
                    .IF rax == CFSS_NULL      ; null seperated, double null terminated.
                        lea rax, szCFSS_NULL
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_NULL
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_NULL
                        mov rax, qwCFSS_NULL
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_SPACE ; space seperated, null terminated.
                        lea rax, szCFSS_SPACE
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_SPACE
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_SPACE
                        mov rax, qwCFSS_SPACE
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_COMMA ; comma and space seperated, null terminated.
                        lea rax, szCFSS_COMMA
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_COMMA
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_COMMA
                        mov rax, qwCFSS_COMMA
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_TAB   ; tab seperated, null terminated.
                        lea rax, szCFSS_TAB
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_TAB
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_TAB
                        mov rax, qwCFSS_TAB
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_LF    ; line feed (LF) seperated, null terminated.
                        lea rax, szCFSS_LF
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_LF
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_LF
                        mov rax, qwCFSS_LF
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_CRLF  ; carriage return (CR) and line feed (LF) seperated, null terminated.
                        lea rax, szCFSS_CRLF
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_CRLF
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_CRLF
                        mov rax, qwCFSS_CRLF
                        add qwFeatureStringPos, rax
                    .ELSEIF rax == CFSS_LIST  ; dash preceeds text and CRLF seperates, null terminated.
                        lea rax, szCFSS_CRLF
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_CRLF
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_CRLF
                        mov rax, qwCFSS_CRLF
                        add qwFeatureStringPos, rax
                    .ELSE
                        lea rax, szCFSS_NULL
                        mov rbx, lpszFeatureString
                        add rbx, qwFeatureStringPos
                        Invoke Memory_Copy, rax, rbx, qwCFSS_NULL
                        ;Invoke RtlMoveMemory, rdi, rsi, qwCFSS_NULL
                        mov rax, qwCFSS_NULL
                        add qwFeatureStringPos, rax
                    .ENDIF
                .ENDIF
            .ENDIF
            
            inc qwEntry
            
        .ENDIF
        
        add pRecord, SIZEOF CPU_FEATURES_RECORD
        inc nRecord
        mov rax, nRecord
    .ENDW
    
    mov rax, qwFeatureStringPos
    ret
    
_CPU_Features_CopyStrings_Error:
    mov rax, 0
    
    ret
_CPU_Features_CopyStrings endp


END

