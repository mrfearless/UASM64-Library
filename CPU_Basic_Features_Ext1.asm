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
CPU_FEATURES_EXT1_EAX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "SHA-512",          "SHA-512 Extensions">
CPU_FEATURES_RECORD <(1 SHL  1), "SM3",              "ShangMi 3 (SM3) Hash Extensions">
CPU_FEATURES_RECORD <(1 SHL  2), "SM4",              "ShangMì 4 (SM4) Cipher Extensions">
CPU_FEATURES_RECORD <(1 SHL  3), "RAO-INT",          "Remote Atomic Operations on Integers">
CPU_FEATURES_RECORD <(1 SHL  4), "AVX-VNNI",         "AVX Vector Neural Network Instructions">
CPU_FEATURES_RECORD <(1 SHL  5), "AVX512_BF16",      "AVX-512 Instructions for bfloat16 Numbers">
CPU_FEATURES_RECORD <(1 SHL  6), "LASS",             "Linear Address Space Separation">
CPU_FEATURES_RECORD <(1 SHL  7), "CMPccXADD",        "CMPccXADD Instructions">
CPU_FEATURES_RECORD <(1 SHL  8), "ARCHPERFMONEXT",   "Architectural Performance Monitoring Extended Leaf">
CPU_FEATURES_RECORD <(1 SHL  9), "DEDUP",            "dedup">
CPU_FEATURES_RECORD <(1 SHL 10), "FZRM",             "Fast Zero-length REP MOVSB">
CPU_FEATURES_RECORD <(1 SHL 11), "FSRS",             "Fast Short REP STOSB">
CPU_FEATURES_RECORD <(1 SHL 12), "FSRCS",            "Fast Short REP CMPSB and REP SCASB">
CPU_FEATURES_RECORD <(1 SHL 13), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 14), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 15), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 16), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 17), "FRED",             "Flexible Return and Event Delivery">
CPU_FEATURES_RECORD <(1 SHL 18), "LKGS",             "LKGS Instruction">
CPU_FEATURES_RECORD <(1 SHL 19), "WRMSRNS",          "WRMSRNS Instruction">
CPU_FEATURES_RECORD <(1 SHL 20), "NMI_SRC",          "NMI Source Reporting">
CPU_FEATURES_RECORD <(1 SHL 21), "AMX-FP16",         "AMX Instructions for FP16 Numbers">
CPU_FEATURES_RECORD <(1 SHL 22), "HRESET",           "HRESET Instruction">
CPU_FEATURES_RECORD <(1 SHL 23), "AVX-IFMA",         "AVX IFMA Instructions">
CPU_FEATURES_RECORD <(1 SHL 24), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 25), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 26), "LAM",              "Linear Address Masking">
CPU_FEATURES_RECORD <(1 SHL 27), "MSRLIST",          "RDMSRLIST and WRMSRLIST Instructions">
CPU_FEATURES_RECORD <(1 SHL 28), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 29), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 30), "INVD",             "INVD Instruction Execution Prevention after BIOS Done">
CPU_FEATURES_RECORD <(1 SHL 31), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <         0, <0>,           <0>>

CPU_FEATURES_EXT1_EAX_LENGTH  EQU $ - CPU_FEATURES_EXT1_EAX_TABLE
CPU_FEATURES_EXT1_EAX_SIZE    DQ CPU_FEATURES_EXT1_EAX_LENGTH
CPU_FEATURES_EXT1_EAX_RECORDS EQU (CPU_FEATURES_EXT1_EAX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1

CPU_FEATURES_EXT1_EBX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "IPPIN",            "Intel PPIN (Protected Processor Inventory Number)">
CPU_FEATURES_RECORD <(1 SHL  1), "PBNDKB",           "Total Storage Encryption: PBNDKB Instruction">
CPU_FEATURES_RECORD <(1 SHL  2), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  3), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  4), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  5), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  6), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  7), <0>,                <0>> ; "(Reserved)"
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

CPU_FEATURES_EXT1_EBX_LENGTH  EQU $ - CPU_FEATURES_EXT1_EBX_TABLE
CPU_FEATURES_EXT1_EBX_SIZE    DQ CPU_FEATURES_EXT1_EBX_LENGTH
CPU_FEATURES_EXT1_EBX_RECORDS EQU (CPU_FEATURES_EXT1_EBX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1

CPU_FEATURES_EXT1_ECX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  1), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  2), "LEGACY_REDUCED_ISA","Legacy Reduced ISA X86S">
CPU_FEATURES_RECORD <(1 SHL  3), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  4), "SIPI64",           "64-bit SIPI">
CPU_FEATURES_RECORD <(1 SHL  5), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  6), <0>,                <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  7), <0>,                <0>> ; "(Reserved)"
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

CPU_FEATURES_EXT1_ECX_LENGTH  EQU $ - CPU_FEATURES_EXT1_ECX_TABLE
CPU_FEATURES_EXT1_ECX_SIZE    DQ CPU_FEATURES_EXT1_ECX_LENGTH
CPU_FEATURES_EXT1_ECX_RECORDS EQU (CPU_FEATURES_EXT1_ECX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1

CPU_FEATURES_EXT1_EDX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  1), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  2), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  3), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  4), "AVX-VNNI-INT8",        "AVX VNNI INT8 Instructions">
CPU_FEATURES_RECORD <(1 SHL  5), "AVX-NE-CONVERT",       "AVX No-exception FP Conversion Instructions">
CPU_FEATURES_RECORD <(1 SHL  6), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  7), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  8), "AMX-COMPLEX",          "AMX Support for complex tiles (TCMMIMFP16PS and TCMMRLFP16PS)">
CPU_FEATURES_RECORD <(1 SHL  9), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 10), "AVX-VNNI-INT16",       "AVX VNNI INT16 Instructions">
CPU_FEATURES_RECORD <(1 SHL 11), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 12), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 13), "UTMR",                 "User-timer Events">
CPU_FEATURES_RECORD <(1 SHL 14), "PREFETCHI",            "Instruction-cache Prefetch Instructions (PREFETCHIT0 and PREFETCHIT1) ">
CPU_FEATURES_RECORD <(1 SHL 15), "USER_MSR",             "User-mode MSR Access Instructions (URDMSR and UWRMSR) ">
CPU_FEATURES_RECORD <(1 SHL 16), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 17), "UIRET-UIF-FROM-FLAGS", "UIRET (User Interrupt Return) Instruction">
CPU_FEATURES_RECORD <(1 SHL 18), "CET_SSS",              "Control-Flow Enforcement (CET) Supervisor Shadow Stacks (SSS)">
CPU_FEATURES_RECORD <(1 SHL 19), "AVX10",                "AVX10 Converged Vector ISA">
CPU_FEATURES_RECORD <(1 SHL 20), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 21), "APX_F",                "Advanced Performance Extensions, Foundation">
CPU_FEATURES_RECORD <(1 SHL 22), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 23), "MWAIT",                "MWAIT Instruction">
CPU_FEATURES_RECORD <(1 SHL 24), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 25), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 26), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 27), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 28), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 29), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 30), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 31), <0>,   <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <         0, <0>,           <0>>

CPU_FEATURES_EXT1_EDX_LENGTH  EQU $ - CPU_FEATURES_EXT1_EDX_TABLE
CPU_FEATURES_EXT1_EDX_SIZE    DQ CPU_FEATURES_EXT1_EDX_LENGTH
CPU_FEATURES_EXT1_EDX_RECORDS EQU (CPU_FEATURES_EXT1_EDX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1


.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Basic_Features_Ext1
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
; * qwMaskEAX - a QWORD value to mask the features returned in the EAX register
;   so that only the features you are interested in are collected. A mask value 
;   -1 means to include all features that are found. A mask value of 0 means
;   to exclude all features found for EAX feature flags.
;
; * qwMaskEBX - a QWORD value to mask the features returned in the EBX register
;   so that only the features you are interested in are collected. A mask value 
;   -1 means to include all features that are found. A mask value of 0 means
;   to exclude all features found for EBX feature flags.
;
; * qwMaskECX - a QWORD value to mask the features returned in the ECX register
;   so that only the features you are interested in are collected. A mask value 
;   -1 means to include all features that are found. A mask value of 0 means
;   to exclude all features found for ECX feature flags.
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
; CPUID EAX=7,ECX=1: Extended feature bits in EAX, EBX, ECX, and EDX
;
;------------------------------------------------------------------------------
CPU_Basic_Features_Ext1 PROC FRAME USES RBX RCX RDX lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEAX:QWORD, qwMaskEBX:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD
    LOCAL FeatureEAX:QWORD
    LOCAL FeatureEBX:QWORD
    LOCAL FeatureECX:QWORD
    LOCAL FeatureEDX:QWORD
    LOCAL qwEntriesFoundEAX:QWORD
    LOCAL qwEntriesFoundEBX:QWORD
    LOCAL qwEntriesFoundECX:QWORD
    LOCAL qwEntriesFoundEDX:QWORD
    LOCAL lpszAllStrings:QWORD
    LOCAL qwAllStringsLength:QWORD
    LOCAL qwStartOffset:QWORD
    LOCAL bMoreEntries:QWORD
    
    IFDEF DEBUG64
    PrintText 'CPU_Basic_Features_Ext1'
    ENDIF
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Basic_Features_Ext1_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic
    .IF rax == 0 || sqword ptr rax < 7
        jmp CPU_Basic_Features_Ext1_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic_Ext
    .IF rax == -1 || sqword ptr rax < 1
        jmp CPU_Basic_Features_Ext1_Error
    .ENDIF
    
    .IF qwMaskEAX == 0 && qwMaskEBX == 0 && qwMaskECX == 0 && qwMaskEDX == 0
        ; Nothing to check for
        jmp CPU_Basic_Features_Ext1_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 7
    mov ecx, 1
    cpuid
    mov FeatureEAX, rax
    mov FeatureEBX, rbx
    mov FeatureECX, rcx
    mov FeatureEDX, rdx
    
    IFDEF DEBUG64
    PrintDec FeatureEAX
    PrintDec FeatureEBX
    PrintDec FeatureECX
    PrintDec FeatureEDX
    ENDIF
    
    ; Mask values
    mov rax, qwMaskEAX
    and FeatureEAX, rax
    mov rax, qwMaskEBX
    and FeatureEBX, rax
    mov rax, qwMaskECX
    and FeatureECX, rax
    mov rax, qwMaskEDX
    and FeatureEDX, rax
    
    mov qwEntriesFoundEAX, 0
    mov qwEntriesFoundEBX, 0
    mov qwEntriesFoundECX, 0
    mov qwEntriesFoundEDX, 0
    mov qwAllStringsLength, 0
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT1_EAX_TABLE table and AND each BitValue
    ; against the value in FeatureEAX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEAX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT1_EAX_TABLE, CPU_FEATURES_EXT1_EAX_RECORDS, FeatureEAX, qwStringType, qwStringStyle, Addr qwEntriesFoundEAX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT1_EAX_TABLE
            mov rsi, CPU_FEATURES_EXT1_EAX_RECORDS
            mov rdx, FeatureEAX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEAX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext1_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT1_EBX_TABLE table and AND each BitValue
    ; against the value in FeatureEBX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEBX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT1_EBX_TABLE, CPU_FEATURES_EXT1_EBX_RECORDS, FeatureEBX, qwStringType, qwStringStyle, Addr qwEntriesFoundEBX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT1_EBX_TABLE
            mov rsi, CPU_FEATURES_EXT1_EBX_RECORDS
            mov rdx, FeatureEBX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEBX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext1_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT1_ECX_TABLE table and AND each BitValue
    ; against the value in FeatureECX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureECX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT1_ECX_TABLE, CPU_FEATURES_EXT1_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, Addr qwEntriesFoundECX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT1_ECX_TABLE
            mov rsi, CPU_FEATURES_EXT1_ECX_RECORDS
            mov rdx, FeatureECX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundECX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext1_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT1_EDX_TABLE table and AND each BitValue
    ; against the value in FeatureEDX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEDX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT1_EDX_TABLE, CPU_FEATURES_EXT1_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, Addr qwEntriesFoundEDX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT1_EDX_TABLE
            mov rsi, CPU_FEATURES_EXT1_EDX_RECORDS
            mov rdx, FeatureEDX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEDX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext1_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    .IF qwEntriesFoundEAX != 0 || qwEntriesFoundEBX != 0 || qwEntriesFoundECX != 0 || qwEntriesFoundEDX != 0
        IFDEF DEBUG64
        PrintDec qwEntriesFoundEAX
        PrintDec qwEntriesFoundEBX
        PrintDec qwEntriesFoundECX
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
            jmp CPU_Basic_Features_Ext1_Error
        .ENDIF
        mov lpszAllStrings, rax
        
        mov bMoreEntries, TRUE
        mov qwStartOffset, 0
        
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT1_EAX_TABLE table again once more 
        ; and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundEAX != 0
            .IF qwEntriesFoundEBX == 0 && qwEntriesFoundECX == 0 && qwEntriesFoundEDX == 0
                mov bMoreEntries, FALSE
            .ENDIF
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT1_EAX_TABLE, CPU_FEATURES_EXT1_EAX_RECORDS, FeatureEAX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEAX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT1_EAX_TABLE
                mov rsi, CPU_FEATURES_EXT1_EAX_RECORDS
                mov rdx, FeatureEAX
                mov rcx, qwStringType
                mov r8, qwStringStyle
                lea r9, lpszAllStrings
                push qwStartOffset
                push qwEntriesFoundEAX
                push bMoreEntries
                call _CPU_Features_CopyStrings
            ENDIF
            .IF rax == 0
                jmp CPU_Basic_Features_Ext1_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
        
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT1_EBX_TABLE table again once more 
        ; and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundEBX != 0
            .IF qwEntriesFoundECX == 0 && qwEntriesFoundEDX == 0
                mov bMoreEntries, FALSE
            .ENDIF
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT1_EBX_TABLE, CPU_FEATURES_EXT1_EBX_RECORDS, FeatureEBX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEBX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT1_EBX_TABLE
                mov rsi, CPU_FEATURES_EXT1_EBX_RECORDS
                mov rdx, FeatureEBX
                mov rcx, qwStringType
                mov r8, qwStringStyle
                lea r9, lpszAllStrings
                push qwStartOffset
                push qwEntriesFoundEBX
                push bMoreEntries
                call _CPU_Features_CopyStrings
            ENDIF
            .IF rax == 0
                jmp CPU_Basic_Features_Ext1_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
    
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT1_ECX_TABLE table again once more 
        ; and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundECX != 0
            .IF qwEntriesFoundEDX == 0
                mov bMoreEntries, FALSE
            .ENDIF
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT1_ECX_TABLE, CPU_FEATURES_EXT1_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundECX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT1_ECX_TABLE
                mov rsi, CPU_FEATURES_EXT1_ECX_RECORDS
                mov rdx, FeatureECX
                mov rcx, qwStringType
                mov r8, qwStringStyle
                lea r9, lpszAllStrings
                push qwStartOffset
                push qwEntriesFoundECX
                push bMoreEntries
                call _CPU_Features_CopyStrings
            ENDIF
            .IF rax == 0
                jmp CPU_Basic_Features_Ext1_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
    
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT1_EDX_TABLE table again once more 
        ; and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundEDX != 0
            mov bMoreEntries, FALSE
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT1_EDX_TABLE, CPU_FEATURES_EXT1_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEDX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT1_EDX_TABLE
                mov rsi, CPU_FEATURES_EXT1_EDX_RECORDS
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
                jmp CPU_Basic_Features_Ext1_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
    
    .ELSE
        ;------------------------------------------------------------------
        ; Did NOT find any values in any feature table
        ; Could be reserved, or it isnt defined or something else?
        ;------------------------------------------------------------------
        jmp CPU_Basic_Features_Ext1_Error
    .ENDIF
    
    jmp CPU_Basic_Features_Ext1_Exit
    
CPU_Basic_Features_Ext1_Error:
    
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

CPU_Basic_Features_Ext1_Exit:
    
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
CPU_Basic_Features_Ext1 ENDP



END

