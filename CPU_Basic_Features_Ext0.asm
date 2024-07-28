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

CPU_FEATURES_EXT0_EBX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "FSGSBASE",        "Supports RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE">
CPU_FEATURES_RECORD <(1 SHL  1), "A32_TSC_ADJUST",  "A32_TSC_ADJUST MSR Supported">
CPU_FEATURES_RECORD <(1 SHL  2), "SGX",             "Software Guard Extensions (SGX)">
CPU_FEATURES_RECORD <(1 SHL  3), "BMI1",            "Bit Manipulation Instruction Set 1">
CPU_FEATURES_RECORD <(1 SHL  4), "TSX",             "Transactional Synchronization Extensions (TSX)">
CPU_FEATURES_RECORD <(1 SHL  5), "AVX2",            "Advanced Vector Extensions 2">
CPU_FEATURES_RECORD <(1 SHL  6), "FDP_EXCPTN_ONLY", "x87 FPU data pointer register updated on exceptions only">
CPU_FEATURES_RECORD <(1 SHL  7), "SMEP",            "Supervisor-Mode Execution Prevention">
CPU_FEATURES_RECORD <(1 SHL  8), "BMI2",            "Bit Manipulation Instruction Set 2">
CPU_FEATURES_RECORD <(1 SHL  9), "ERMS",            "Enhanced REP MOVSB/STOSB">
CPU_FEATURES_RECORD <(1 SHL 10), "INVPCID",         "INVPCID Instruction">
CPU_FEATURES_RECORD <(1 SHL 11), "RTM",             "TSX Restricted Transactional Memory ">
CPU_FEATURES_RECORD <(1 SHL 12), "RDT-M",           "Intel Resource Director (RDT) Monitoring">
CPU_FEATURES_RECORD <(1 SHL 13), "FPUD",            "FPU CS and FPU DS Deprecated">
CPU_FEATURES_RECORD <(1 SHL 14), "MPX",             "Memory Protection Extensions">
CPU_FEATURES_RECORD <(1 SHL 15), "RDT-A",           "Intel Resource Director Technology (RDT)">
CPU_FEATURES_RECORD <(1 SHL 16), "AVX512F",         "AVX-512 Foundation">
CPU_FEATURES_RECORD <(1 SHL 17), "AVX512DQ",        "AVX-512 Doubleword and Quadword Instructions">
CPU_FEATURES_RECORD <(1 SHL 18), "RDSEED",          "RDSEED instruction">
CPU_FEATURES_RECORD <(1 SHL 19), "ADX",             "Intel ADX (Multi-Precision Add-Carry Instruction Extensions)">
CPU_FEATURES_RECORD <(1 SHL 20), "SMAP",            "Supervisor Mode Access Prevention">
CPU_FEATURES_RECORD <(1 SHL 21), "AVX512_IFMA",     "AVX-512 Integer Fused Multiply-Add Instructions">
CPU_FEATURES_RECORD <(1 SHL 22), "PCOMMIT",         "PCOMMIT Instruction Deprecated">
CPU_FEATURES_RECORD <(1 SHL 23), "CLFLUSHOPT",      "CLFLUSHOPT Instruction">
CPU_FEATURES_RECORD <(1 SHL 24), "CLWB",            "CLWB (Cache Line Writeback) Instruction">
CPU_FEATURES_RECORD <(1 SHL 25), "PT",              "Intel Processor Trace">
CPU_FEATURES_RECORD <(1 SHL 26), "AVX512PF",        "AVX-512 Prefetch Instructions">
CPU_FEATURES_RECORD <(1 SHL 27), "AVX512ER",        "AVX-512 Exponential and Reciprocal Instructions">
CPU_FEATURES_RECORD <(1 SHL 28), "AVX512CD",        "AVX-512 Conflict Detection Instructions ">
CPU_FEATURES_RECORD <(1 SHL 29), "SHA",             "SHA-1 and SHA-256 extensions">
CPU_FEATURES_RECORD <(1 SHL 30), "AVX512BW",        "AVX-512 Byte and Word Instructions ">
CPU_FEATURES_RECORD <(1 SHL 31), "AVX512VL",        "AVX-512 Vector Length Extensions">
CPU_FEATURES_RECORD <         0, <0>,               <0>>

CPU_FEATURES_EXT0_EBX_LENGTH  EQU $ - CPU_FEATURES_EXT0_EBX_TABLE
CPU_FEATURES_EXT0_EBX_SIZE    DQ CPU_FEATURES_EXT0_EBX_LENGTH
CPU_FEATURES_EXT0_EBX_RECORDS EQU (CPU_FEATURES_EXT0_EBX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1


CPU_FEATURES_EXT0_ECX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "PREFETCHWT1",     "PREFETCHWT1 Instruction">
CPU_FEATURES_RECORD <(1 SHL  1), "AVX512_VBMI",     "AVX-512 Vector Bit Manipulation Instructions">
CPU_FEATURES_RECORD <(1 SHL  2), "UMIP",            "User-Mode Instruction Prevention ">
CPU_FEATURES_RECORD <(1 SHL  3), "PKU",             "Memory Protection Keys for User-mode pages">
CPU_FEATURES_RECORD <(1 SHL  4), "OSPKE",           "PKU Enabled by OS ">
CPU_FEATURES_RECORD <(1 SHL  5), "WAITPKG",         "Timed pause and user-level monitor/wait instructions (TPAUSE, UMONITOR, UMWAIT)">
CPU_FEATURES_RECORD <(1 SHL  6), "AVX512_VBMI2",    "AVX-512 Vector Bit Manipulation Instructions 2">
CPU_FEATURES_RECORD <(1 SHL  7), "CET_SS",          "Control Flow Enforcement (CET) Shadow Stack">
CPU_FEATURES_RECORD <(1 SHL  8), "GFNI",            "Galois Field Instructions">
CPU_FEATURES_RECORD <(1 SHL  9), "VAES",            "Vector AES Instruction Set (VEX-256/EVEX)">
CPU_FEATURES_RECORD <(1 SHL 10), "VPCLMULQDQ",      "CLMUL Instruction Set (VEX-256/EVEX)">
CPU_FEATURES_RECORD <(1 SHL 11), "AVX512_VNNI",     "AVX-512 Vector Neural Network Instructions">
CPU_FEATURES_RECORD <(1 SHL 12), "AVX512_BITALG",   "AVX-512 BITALG Instructions">
CPU_FEATURES_RECORD <(1 SHL 13), "TME_EN",          "Total Memory Encryption MSRs available">
CPU_FEATURES_RECORD <(1 SHL 14), "AVX512_VPOPCNTDQ","AVX-512 Vector Population Count Double and Quad-word">
CPU_FEATURES_RECORD <(1 SHL 15), "FZM",             "FZM Reserved">
CPU_FEATURES_RECORD <(1 SHL 16), "LA57",            "Supports 57-bit linear addresses and five-level paging">
CPU_FEATURES_RECORD <(1 SHL 17), "MAWAU",           "MPX Address-Width Adjust Userspace">
CPU_FEATURES_RECORD <(1 SHL 18), <0>,               <0>> ; MPX Address-Width Adjust Userspace 
CPU_FEATURES_RECORD <(1 SHL 19), <0>,               <0>> ; MPX Address-Width Adjust Userspace 
CPU_FEATURES_RECORD <(1 SHL 20), <0>,               <0>> ; MPX Address-Width Adjust Userspace 
CPU_FEATURES_RECORD <(1 SHL 21), <0>,               <0>> ; MPX Address-Width Adjust Userspace 
CPU_FEATURES_RECORD <(1 SHL 22), "RDPID",           "RDPID (Read Processor ID) Instruction">
CPU_FEATURES_RECORD <(1 SHL 23), "KL",              "AES Key Locker">
CPU_FEATURES_RECORD <(1 SHL 24), "BUS_LOCK_DETECT", "Bus Lock Detection">
CPU_FEATURES_RECORD <(1 SHL 25), "CLDEMOTE",        "CLDEMOTE (Cache line demote) Instruction">
CPU_FEATURES_RECORD <(1 SHL 26), "MPRR",            "MPRR Reserved">
CPU_FEATURES_RECORD <(1 SHL 27), "MOVDIRI",         "MOVDIRI instruction">
CPU_FEATURES_RECORD <(1 SHL 28), "MOVDIR64B",       "MOVDIR64B (64-byte direct store) Instruction">
CPU_FEATURES_RECORD <(1 SHL 29), "EMQCMD",          "Enqueue Stores and EMQCMD/EMQCMDS Instructions">
CPU_FEATURES_RECORD <(1 SHL 30), "SGX-LC",          "SGX Launch Configuration ">
CPU_FEATURES_RECORD <(1 SHL 31), "PKS",             "Protection Keys for Supervisor-mode pages ">
CPU_FEATURES_RECORD <         0, <0>,               <0>>

CPU_FEATURES_EXT0_ECX_LENGTH  EQU $ - CPU_FEATURES_EXT0_ECX_TABLE
CPU_FEATURES_EXT0_ECX_SIZE    DQ CPU_FEATURES_EXT0_ECX_LENGTH
CPU_FEATURES_EXT0_ECX_RECORDS EQU (CPU_FEATURES_EXT0_ECX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1


CPU_FEATURES_EXT0_EDX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "SGX-TEM",         "SGX-TEM Reserved">
CPU_FEATURES_RECORD <(1 SHL  1), "SGX-KEYS",        "Attestation Services for Intel SGX">
CPU_FEATURES_RECORD <(1 SHL  2), "AVX512_4VNNIW",   "AVX-512 4-register Neural Network Instructions">
CPU_FEATURES_RECORD <(1 SHL  3), "AVX512_4FMAPS",   "AVX-512 4-register Multiply Accumulation Single precision">
CPU_FEATURES_RECORD <(1 SHL  4), "FSRM",            "Fast Short REP MOV">
CPU_FEATURES_RECORD <(1 SHL  5), "UINTR",           "User Inter-processor Interrupts">
CPU_FEATURES_RECORD <(1 SHL  6), <0>,               <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  7), <0>,               <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL  8), "AVX512_VP2INTERSECT", "AVX-512 vector intersection instructions on 32/64-bit integers">
CPU_FEATURES_RECORD <(1 SHL  9), "SRBDS_CTRL",      "Special Register Buffer Data Sampling Mitigations ">
CPU_FEATURES_RECORD <(1 SHL 10), "MD_CLEAR ",       "VERW instruction clears CPU buffers">
CPU_FEATURES_RECORD <(1 SHL 11), "RTM_ALWAYS_ABORT","All TSX Ttransactions Are Aborted">
CPU_FEATURES_RECORD <(1 SHL 12), <0>,               <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 13), "RTM_FORCE_ABORT", "TSX_FORCE_ABORT MSR">
CPU_FEATURES_RECORD <(1 SHL 14), "SERIALIZE",       "SERIALIZE instruction">
CPU_FEATURES_RECORD <(1 SHL 15), "Hybrid",          "Mixture of CPU types in processor topology">
CPU_FEATURES_RECORD <(1 SHL 16), "TSXLDTRK",        "TSX Load Address Tracking Suspend/Resume Instructions">
CPU_FEATURES_RECORD <(1 SHL 17), <0>,               <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 18), "PCONFIG",         "Platform Configuration (Memory Encryption Technologies Instructions)">
CPU_FEATURES_RECORD <(1 SHL 19), "LBR",             "Architectural Last Branch Records">
CPU_FEATURES_RECORD <(1 SHL 20), "CET_IBT",         "Control Flow Enforcement (CET): Indirect Bbranch Tracking">
CPU_FEATURES_RECORD <(1 SHL 21), <0>,               <0>> ; "(Reserved)"
CPU_FEATURES_RECORD <(1 SHL 22), "AMX-BF16",        "Advanced Matrix Extensions (AMX) Tile Computation on bfloat16 Numbers">
CPU_FEATURES_RECORD <(1 SHL 23), "AVX512_FP16",     "AVX-512 Half-precision Floating-Point Arithmetic Instructions">
CPU_FEATURES_RECORD <(1 SHL 24), "AMX-TILE",        "Advanced Matrix Extensions (AMX) Tile Load/Store Instructions">
CPU_FEATURES_RECORD <(1 SHL 25), "AMX-INT8",        "Advanced Matrix Extensions (AMX) Tile Computation on 8-bit Integers">
CPU_FEATURES_RECORD <(1 SHL 26), "IBRS",            "Indirect Branch Restricted Speculation (IBRS)">
CPU_FEATURES_RECORD <(1 SHL 27), "STIBP",           "Single Thread Indirect Branch Predictor">
CPU_FEATURES_RECORD <(1 SHL 28), "L1D_FLUSH",       "IA32_FLUSH_CMD MSR">
CPU_FEATURES_RECORD <(1 SHL 29), "IA32_ARCH_CAPABILITIES","IA32_ARCH_CAPABILITIES MSR">
CPU_FEATURES_RECORD <(1 SHL 30), "IA32_CORE_CAPABILITIES","IA32_CORE_CAPABILITIES MSR">
CPU_FEATURES_RECORD <(1 SHL 31), "SSBD",            "Speculative Store Bypass Disable">
CPU_FEATURES_RECORD <         0, <0>,               <0>>

CPU_FEATURES_EXT0_EDX_LENGTH  EQU $ - CPU_FEATURES_EXT0_EDX_TABLE
CPU_FEATURES_EXT0_EDX_SIZE    DQ CPU_FEATURES_EXT0_EDX_LENGTH
CPU_FEATURES_EXT0_EDX_RECORDS EQU (CPU_FEATURES_EXT0_EDX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1



.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Basic_Features_Ext0
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
; CPUID EAX=7,ECX=0: Extended feature bits in EBX, ECX and EDX
;
;------------------------------------------------------------------------------
CPU_Basic_Features_Ext0 PROC FRAME USES RBX RCX RDX lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEBX:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD
    LOCAL FeatureEBX:QWORD
    LOCAL FeatureECX:QWORD
    LOCAL FeatureEDX:QWORD
    LOCAL qwEntriesFoundEBX:QWORD
    LOCAL qwEntriesFoundECX:QWORD
    LOCAL qwEntriesFoundEDX:QWORD
    LOCAL lpszAllStrings:QWORD
    LOCAL qwAllStringsLength:QWORD
    LOCAL qwStartOffset:QWORD
    LOCAL bMoreEntries:QWORD
    
    IFDEF DEBUG64
    PrintText 'CPU_Basic_Features_Ext0'
    ENDIF
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Basic_Features_Ext0_Error
    .ENDIF
    
    Invoke CPU_Highest_Basic
    .IF rax == 0 || sqword ptr rax < 7
        jmp CPU_Basic_Features_Ext0_Error
    .ENDIF
    
    .IF qwMaskEBX == 0 && qwMaskECX == 0 && qwMaskEDX == 0
        ; Nothing to check for
        jmp CPU_Basic_Features_Ext0_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 7
    cpuid
    mov FeatureEBX, rbx
    mov FeatureECX, rcx
    mov FeatureEDX, rdx
    
;    ; Returns the maximum ECX value for EAX=7 in lpqwMaxBasicExt
;    .IF lpqwMaxBasicExt != 0
;        mov rbx, lpqwMaxBasicExt
;        mov [rbx], rax
;    .ENDIF
;    IFDEF DEBUG64
;    PrintText 'Maximum ECX value for EAX=7: '
;    PrintDec rax
;    ENDIF
    
    ; Mask values
    mov rax, qwMaskEBX
    and FeatureEBX, rax
    mov rax, qwMaskECX
    and FeatureECX, rax
    mov rax, qwMaskEDX
    and FeatureEDX, rax
    
    mov qwEntriesFoundEBX, 0
    mov qwEntriesFoundECX, 0
    mov qwEntriesFoundEDX, 0
    mov qwAllStringsLength, 0
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT0_EBX_TABLE table and AND each BitValue
    ; against the value in FeatureEBX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEBX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT0_EBX_TABLE, CPU_FEATURES_EXT0_EBX_RECORDS, FeatureEBX, qwStringType, qwStringStyle, Addr qwEntriesFoundEBX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT0_EBX_TABLE
            mov rsi, CPU_FEATURES_EXT0_EBX_RECORDS
            mov rdx, FeatureEBX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEBX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext0_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    IFDEF DEBUG64
    PrintDec qwAllStringsLength
    PrintDec qwEntriesFoundEBX
    ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT0_ECX_TABLE table and AND each BitValue
    ; against the value in FeatureECX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureECX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT0_ECX_TABLE, CPU_FEATURES_EXT0_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, Addr qwEntriesFoundECX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT0_ECX_TABLE
            mov rsi, CPU_FEATURES_EXT0_ECX_RECORDS
            mov rdx, FeatureECX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundECX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext0_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    IFDEF DEBUG64
    PrintDec qwAllStringsLength
    PrintDec qwEntriesFoundECX
    ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_FEATURES_EXT0_EDX_TABLE table and AND each BitValue
    ; against the value in FeatureEDX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEDX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_FEATURES_EXT0_EDX_TABLE, CPU_FEATURES_EXT0_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, Addr qwEntriesFoundEDX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_FEATURES_EXT0_EDX_TABLE
            mov rsi, CPU_FEATURES_EXT0_EDX_RECORDS
            mov rdx, FeatureEDX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEDX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Basic_Features_Ext0_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    IFDEF DEBUG64
    PrintDec qwAllStringsLength
    PrintDec qwEntriesFoundEDX
    ENDIF
    
    .IF qwEntriesFoundEBX != 0 || qwEntriesFoundECX != 0 || qwEntriesFoundEDX != 0
        IFDEF DEBUG64
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
            jmp CPU_Basic_Features_Ext0_Error
        .ENDIF
        mov lpszAllStrings, rax
        
        mov bMoreEntries, TRUE
        mov qwStartOffset, 0
        
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT0_EBX_TABLE table again once more 
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
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT0_EBX_TABLE, CPU_FEATURES_EXT0_EBX_RECORDS, FeatureEBX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEBX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT0_EBX_TABLE
                mov rsi, CPU_FEATURES_EXT0_EBX_RECORDS
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
                jmp CPU_Basic_Features_Ext0_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
        IFDEF DEBUG64
        PrintDec qwStartOffset
        ENDIF
    
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT0_ECX_TABLE table again once more 
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
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT0_ECX_TABLE, CPU_FEATURES_EXT0_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundECX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT0_ECX_TABLE
                mov rsi, CPU_FEATURES_EXT0_ECX_RECORDS
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
                jmp CPU_Basic_Features_Ext0_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
        IFDEF DEBUG64
        PrintDec qwStartOffset
        ENDIF
    
        ;------------------------------------------------------------------
        ; Go through the CPU_FEATURES_EXT0_EDX_TABLE table again once more 
        ; and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundEDX != 0
            mov bMoreEntries, FALSE
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_FEATURES_EXT0_EDX_TABLE, CPU_FEATURES_EXT0_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEDX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_FEATURES_EXT0_EDX_TABLE
                mov rsi, CPU_FEATURES_EXT0_EDX_RECORDS
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
                jmp CPU_Basic_Features_Ext0_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
    
        IFDEF DEBUG64
        PrintStringByAddr lpszAllStrings
        DbgDump lpszAllStrings, qwAllStringsLength
        ENDIF
    
    .ELSE
        ;------------------------------------------------------------------
        ; Did NOT find any values in any feature table
        ; Could be reserved, or it isnt defined or something else?
        ;------------------------------------------------------------------
        jmp CPU_Basic_Features_Ext0_Error
    .ENDIF
    
    jmp CPU_Basic_Features_Ext0_Exit
    
CPU_Basic_Features_Ext0_Error:
    
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

CPU_Basic_Features_Ext0_Exit:
    
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
CPU_Basic_Features_Ext0 ENDP


END

