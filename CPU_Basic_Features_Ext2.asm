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

;GlobalAlloc PROTO uFlags:DWORD, qwBytes:QWORD
;
;IFNDEF GMEM_FIXED
;GMEM_FIXED EQU 0000h
;ENDIF
;IFNDEF GMEM_ZEROINIT
;GMEM_ZEROINIT EQU 0040h
;ENDIF
;
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
CPU_FEATURES_EXT2_EDX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "PSFD",             "Fast Store Forwarding Predictor">
CPU_FEATURES_RECORD <(1 SHL  1), "PRED_CTRL",        "IPRED_DIS controls supported"> ; 
CPU_FEATURES_RECORD <(1 SHL  2), "RRSBA_CTRL",       "RRSBA behavior disable supported">
CPU_FEATURES_RECORD <(1 SHL  3), "DDPD_U",           "Data Dependent Prefetcher disable supported">
CPU_FEATURES_RECORD <(1 SHL  4), "BHI_CTRL",         "BHI_DIS_S behavior enable supported">
CPU_FEATURES_RECORD <(1 SHL  5), "MCDT_NO",          "No MXCSR configuration dependent timing">
CPU_FEATURES_RECORD <(1 SHL  6), "UC_LOCK_CTRL",     "UC-lock disable feature supported">
CPU_FEATURES_RECORD <(1 SHL  7), "MONITOR_MITG_NO",  "MONITOR/UMONITOR instructions are not affected by performance/power issues">
CPU_FEATURES_RECORD <(1 SHL  8), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  9), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 10), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 11), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 12), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 13), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 14), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 15), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 16), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 17), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 18), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 19), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 20), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 21), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 22), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 23), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 24), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 25), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 26), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 27), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 28), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 29), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 30), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 31), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <         0, <0>,           <0>>

CPU_FEATURES_EXT2_EDX_LENGTH  EQU $ - CPU_FEATURES_EXT2_EDX_TABLE
CPU_FEATURES_EXT2_EDX_SIZE    DQ CPU_FEATURES_EXT2_EDX_LENGTH
CPU_FEATURES_EXT2_EDX_RECORDS EQU (CPU_FEATURES_EXT2_EDX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Basic_Features_Ext2
;
; Check which features are supported and return them as in a formatted string 
; as a list separated by space, tab, comma, line-feed, carriage return & line 
; feed or null. The formatted string is terminated by a double null.
; 
; Parameters:
; 
; * lpqwFeaturesString - Pointer to a QWORD variable used to store the pointer
;   to the formatted features string.
; 
; * lpqwFeaturesStringSize - Pointer to a QWORD variable used to store the size
;   of the formatted features string.
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
; * qwMaskEDX - a QWORD value to mask the features returned in the EDX register
;   so that only the features you are interested in are collected. A mask value 
;   -1 means to include all features that are found. A mask value of 0 means
;   to exclude all features found for EDX feature flags.
;
; Returns:
; 
; TRUE if successful, or FALSE otherwise
; 
; Notes:
;
; The variables pointed to by the lpqwFeaturesString parameter and the 
; lpqwFeaturesStringSize parameter will be set to 0 if the function returns
; FALSE. 
;
; The string returned and stoed in the variable pointed to by the 
; lpqwFeaturesString parameter should be freed with a call to GlobalFree when 
; you no longer require it.
; 
; CPUID EAX=7,ECX=2: Extended feature bits in EDX
;
;------------------------------------------------------------------------------
CPU_Basic_Features_Ext2 PROC FRAME USES RBX RCX RDX lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEDX:QWORD
    LOCAL FeatureEDX:QWORD
    LOCAL qwEntriesFoundEDX:QWORD
    LOCAL lpszAllStrings:QWORD
    LOCAL qwAllStringsLength:QWORD
    LOCAL qwStartOffset:QWORD
    LOCAL bMoreEntries:QWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Basic_Features_Ext2_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic
    .IF rax == 0 || sqword ptr rax < 7
        jmp CPU_Basic_Features_Ext2_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic_Ext ;CPU_Highest_Basic
    .IF rax == -1 || sqword ptr rax < 2
        jmp CPU_Basic_Features_Ext2_Error
    .ENDIF
    
    .IF qwMaskEDX == 0
        ; Nothing to check for
        jmp CPU_Basic_Features_Ext2_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 7
    mov ecx, 2
    cpuid
    mov FeatureEDX, rdx
    
    ; Mask values
    mov rax, qwMaskEDX
    and FeatureEDX, rax
    
    mov qwEntriesFoundEDX, 0
    mov qwAllStringsLength, 0
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EDX_TABLE table and AND each BitValue
    ; against the value in FeatureEDX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEDX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT2_EDX_TABLE, CPU_FEATURES_EXT2_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, Addr qwEntriesFoundEDX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT2_EDX_TABLE
            mov rsi, CPU_FEATURES_EXT2_EDX_RECORDS
            mov rdx, FeatureEDX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEDX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext2_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF

    .IF qwEntriesFoundEDX != 0
        IFDEF DEBUG32
        PrintDec qwEntriesFoundEDX
        PrintDec qwAllStringsLength
        ENDIF

        ;------------------------------------------------------------------
        ; Allocate memory to hold all the strings we require
        ; adjust for last entries added terminator sizes
        ;------------------------------------------------------------------
        mov rax, qwStringStyle
        .IF rax == CFSS_NULL      ; null seperated, double null terminated.
            sub qwAllStringsLength, 1
        .ELSEIF rax == CFSS_SPACE ; space seperated, null terminated.
            sub qwAllStringsLength, 1
        .ELSEIF rax == CFSS_COMMA ; comma and space seperated, null terminated.
            sub qwAllStringsLength, 2
        .ELSEIF rax == CFSS_TAB   ; tab seperated, null terminated.
            sub qwAllStringsLength, 1
        .ELSEIF rax == CFSS_LF    ; line feed (LF) seperated, null terminated.
            sub qwAllStringsLength, 1
        .ELSEIF rax == CFSS_CRLF  ; carriage return (CR) and line feed (LF) seperated, null terminated.
            sub qwAllStringsLength, 2
        .ELSEIF rax == CFSS_LIST  ; dash preceeds text and CRLF seperates, null terminated.
            sub qwAllStringsLength, 2
        .ELSE
            sub qwAllStringsLength, 1 ; CFSS_NULL
        .ENDIF
        mov rax, qwAllStringsLength
        add rax, 4 ; just in case
        
        Invoke Memory_Alloc, rax
        ;Invoke GlobalAlloc, GMEM_FIXED or GMEM_ZEROINIT, rax
        .IF rax == 0
            jmp CPU_Basic_Features_Ext2_Error
        .ENDIF
        mov lpszAllStrings, rax

        mov bMoreEntries, TRUE
        mov qwStartOffset, 0
        
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EDX_TABLE table again once more and 
        ; AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        mov bMoreEntries, FALSE
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT2_EDX_TABLE, CPU_FEATURES_EXT2_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEDX, bMoreEntries
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT2_EDX_TABLE
            mov rsi, CPU_FEATURES_EXT2_EDX_RECORDS
            mov rdx, FeatureEDX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, lpszAllStrings
            push qwStartOffset
            push qwEntriesFoundEDX
            push bMoreEntries
            call _CPU_Features_CopyStrings
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext2_Error
        .ENDIF
        
    .ELSE
        ;------------------------------------------------------------------
        ; Did NOT find any values in either feature table
        ; Could be reserved, or it isnt defined or something else?
        ;------------------------------------------------------------------
        jmp CPU_Basic_Features_Ext2_Error
    .ENDIF
    
    jmp CPU_Basic_Features_Ext2_Exit
    
CPU_Basic_Features_Ext2_Error:
    
    .IF lpqwFeaturesString != 0
        mov rbx, lpqwFeaturesString
        mov rax, 0
        mov [rbx], rax
    .ENDIF
    .IF lpqwFeaturesStringSize != 0
        mov rbx, lpqwFeaturesStringSize
        mov rax, 0
        mov [rbx], rax
    .ENDIF
    mov rax, FALSE
    ret

CPU_Basic_Features_Ext2_Exit:
    
    ;------------------------------------------------------------------
    ; Pass back the all strings buffer and size of it.
    ;------------------------------------------------------------------
    .IF lpqwFeaturesString != 0
        mov rbx, lpqwFeaturesString
        mov rax, lpszAllStrings
        mov [rbx], rax
    .ENDIF
    .IF lpqwFeaturesStringSize != 0
        mov rbx, lpqwFeaturesStringSize
        mov rax, qwAllStringsLength
        mov [rbx], rax
    .ENDIF
    mov rax, TRUE
    
    ret
CPU_Basic_Features_Ext2 ENDP


END

