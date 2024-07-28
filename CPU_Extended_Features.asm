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

; Many of the bits in EDX are duplicates of EDX from the EAX=1 leaf (These duplicated bits are present on AMD but not Intel CPUs.) 
CPU_EXTENDED_FEATURES_EDX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "FPU",         "Floating-Point Unit On-Chip">
CPU_FEATURES_RECORD <(1 SHL  1), "VME",         "Virtual 8086 Mode Enhancements">
CPU_FEATURES_RECORD <(1 SHL  2), "DE",          "Debugging Extensions">
CPU_FEATURES_RECORD <(1 SHL  3), "PSE",         "Page Size Extension">
CPU_FEATURES_RECORD <(1 SHL  4), "TSC",         "Time Stamp Counter">
CPU_FEATURES_RECORD <(1 SHL  5), "MSR",         "Model Specific Registers RDMSR and WRMSR Instructions">
CPU_FEATURES_RECORD <(1 SHL  6), "PAE",         "Physical Address Extension">
CPU_FEATURES_RECORD <(1 SHL  7), "MCE",         "Machine Check Exception">
CPU_FEATURES_RECORD <(1 SHL  8), "CX8",         "CMPXCHG8B Instruction">
CPU_FEATURES_RECORD <(1 SHL  9), "APIC",        "Advanced Programmable Interrupt Controller">
CPU_FEATURES_RECORD <(1 SHL 10), "SYSCALL",     "SYSCALL and SYSRET Instructions"> ; K6 only
CPU_FEATURES_RECORD <(1 SHL 11), "SYSCALL",     "SYSCALL and SYSRET Instructions">
CPU_FEATURES_RECORD <(1 SHL 12), "MTRR",        "Memory Type Range Registers">
CPU_FEATURES_RECORD <(1 SHL 13), "PGE",         "Page Global Enable">
CPU_FEATURES_RECORD <(1 SHL 14), "MCA",         "Machine Check Architecture">
CPU_FEATURES_RECORD <(1 SHL 15), "CMOV",        "Conditional Move Instructions">
CPU_FEATURES_RECORD <(1 SHL 16), "PAT",         "Page Attribute Table">
CPU_FEATURES_RECORD <(1 SHL 17), "PSE-36",      "36-Bit Page Size Extension">
CPU_FEATURES_RECORD <(1 SHL 18), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 19), "ECC",         "AuthenticAMD Family 6 CPU Brand Identification">
CPU_FEATURES_RECORD <(1 SHL 20), "NX",          "No-execute (NX)">
CPU_FEATURES_RECORD <(1 SHL 21), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 22), "MMXEXT",      "Extended MMX">
CPU_FEATURES_RECORD <(1 SHL 23), "MMX",         "Intel MMX Technology">
CPU_FEATURES_RECORD <(1 SHL 24), "FXSR",        "FXSAVE and FXRSTOR Instructions">
CPU_FEATURES_RECORD <(1 SHL 25), "FXSR_OPT",    "FXSAVE/FXRSTOR Optimizations">
CPU_FEATURES_RECORD <(1 SHL 26), "PDPE1GB",     "Gigabyte pages">
CPU_FEATURES_RECORD <(1 SHL 27), "RDTSCP",      "RDTSCP instruction">
CPU_FEATURES_RECORD <(1 SHL 28), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 29), "x86-64",      "64bit CPU (Intel64 for Intel, Long Mode for AMD)"> ; 64 bit: Intel64 for Intel, or Long mode for AMD
CPU_FEATURES_RECORD <(1 SHL 30), "3DNOWEXT",    "Extended 3DNow!">
CPU_FEATURES_RECORD <(1 SHL 31), "3DNOW",       "3DNow!">
CPU_FEATURES_RECORD <         0, <0>,           <0>>

CPU_EXTENDED_FEATURES_EDX_LENGTH  EQU $ - CPU_EXTENDED_FEATURES_EDX_TABLE
CPU_EXTENDED_FEATURES_EDX_SIZE    DQ CPU_EXTENDED_FEATURES_EDX_LENGTH
CPU_EXTENDED_FEATURES_EDX_RECORDS EQU (CPU_EXTENDED_FEATURES_EDX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1

CPU_EXTENDED_FEATURES_ECX_TABLE \
CPU_FEATURES_RECORD <(1 SHL  0), "LAHF_LM",     "LAHF/SAHF in long mode">
CPU_FEATURES_RECORD <(1 SHL  1), "CMP_LEGACY",  "Hyperthreading not valid">
CPU_FEATURES_RECORD <(1 SHL  2), "SVM",         "Secure Virtual Machine">
CPU_FEATURES_RECORD <(1 SHL  3), "EXTAPIC",     "Extended APIC space">
CPU_FEATURES_RECORD <(1 SHL  4), "CR8_LEGACY",  "CR8 in 32-bit mode">
CPU_FEATURES_RECORD <(1 SHL  5), "ABM/LZCNT",   "Advanced bit manipulation (LZCNT and POPCNT)">
CPU_FEATURES_RECORD <(1 SHL  6), "SSE4A",       "Streaming SIMD Extensions 4a (SSE4a)">
CPU_FEATURES_RECORD <(1 SHL  7), "MISALIGNSSE", "Misaligned SSE mode">
CPU_FEATURES_RECORD <(1 SHL  8), "3DNOWPREFETCH","PREFETCH and PREFETCHW instructions">
CPU_FEATURES_RECORD <(1 SHL  9), "OSVW",        "OS Visible Workaround">
CPU_FEATURES_RECORD <(1 SHL 10), "IBS",         "Instruction Based Sampling">
CPU_FEATURES_RECORD <(1 SHL 11), "XOP",         "XOP instruction set">
CPU_FEATURES_RECORD <(1 SHL 12), "SKINIT",      "SKINIT/STGI instructions">
CPU_FEATURES_RECORD <(1 SHL 13), "WDT",         "Watchdog timer">
CPU_FEATURES_RECORD <(1 SHL 14), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 15), "LWP",         "Light Weight Profiling">
CPU_FEATURES_RECORD <(1 SHL 16), "FMA4",        "4-operand fused multiply-add instructions">
CPU_FEATURES_RECORD <(1 SHL 17), "TCE",         "Translation Cache Extension">
CPU_FEATURES_RECORD <(1 SHL 18), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 19), "NODEID_MSR",  "NodeID MSR ">
CPU_FEATURES_RECORD <(1 SHL 20), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <(1 SHL 21), "TBM",         "Trailing Bit Manipulation">
CPU_FEATURES_RECORD <(1 SHL 22), "TOPOEXT",     "Topology Extensions ">
CPU_FEATURES_RECORD <(1 SHL 23), "PERFCTR_CORE","Core performance counter extensions">
CPU_FEATURES_RECORD <(1 SHL 24), "PERFCTR_NB",  "Northbridge performance counter extensions">
CPU_FEATURES_RECORD <(1 SHL 25), "STREAMPERFMON","Streaming performance monitor architecture">
CPU_FEATURES_RECORD <(1 SHL 26), "DBX",         "Data breakpoint extensions">
CPU_FEATURES_RECORD <(1 SHL 27), "PERFTSC",     "Performance timestamp counter (PTSC)">
CPU_FEATURES_RECORD <(1 SHL 28), "PCX_L2I",     "L2I perf counter extensions">
CPU_FEATURES_RECORD <(1 SHL 29), "MONITORX",    "MONITORX and MWAITX instructions">
CPU_FEATURES_RECORD <(1 SHL 30), "ADDR_MASK_EXT","Address mask extension to 32 bits for instruction breakpoints">
CPU_FEATURES_RECORD <(1 SHL 31), <0>,           <0>> ; Reserved
CPU_FEATURES_RECORD <         0, <0>,           <0>>

CPU_EXTENDED_FEATURES_ECX_LENGTH  EQU $ - CPU_EXTENDED_FEATURES_ECX_TABLE
CPU_EXTENDED_FEATURES_ECX_SIZE    DQ CPU_EXTENDED_FEATURES_ECX_LENGTH
CPU_EXTENDED_FEATURES_ECX_RECORDS EQU (CPU_EXTENDED_FEATURES_ECX_LENGTH / SIZEOF CPU_FEATURES_RECORD) -1



.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_Extended_Features
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
; CPUID EAX=80000001h: Feature bits in EDX and ECX
;
; Many of the bits in EDX are duplicates of EDX from the EAX=1 leaf 
; (These duplicated bits are present on AMD but not Intel CPUs.)
;
;------------------------------------------------------------------------------
CPU_Extended_Features PROC FRAME USES RBX RCX RDX lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD
    LOCAL FeatureECX:QWORD
    LOCAL FeatureEDX:QWORD
    LOCAL qwEntriesFoundECX:QWORD
    LOCAL qwEntriesFoundEDX:QWORD
    LOCAL lpszAllStrings:QWORD
    LOCAL qwAllStringsLength:QWORD
    LOCAL qwStartOffset:QWORD
    LOCAL bMoreEntries:QWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_Extended_Features_Error
    .ENDIF
    
    Invoke CPU_Highest_Extended ;CPU_Highest_Basic
    .IF rax == 0 || sqword ptr rax < 080000001h
        jmp CPU_Extended_Features_Error
    .ENDIF
    
    .IF qwMaskEDX == 0 && qwMaskECX == 0 
        ; Nothing to check for
        jmp CPU_Extended_Features_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 080000001h
    cpuid
    mov FeatureECX, rcx
    mov FeatureEDX, rdx
    
    ; Mask values
    mov rax, qwMaskEDX
    and FeatureEDX, rax
    mov rax, qwMaskECX
    and FeatureECX, rax
    
    mov qwEntriesFoundECX, 0
    mov qwEntriesFoundEDX, 0
    mov qwAllStringsLength, 0
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_EXTENDED_FEATURES_EDX_TABLE table and AND each 
    ; BitValue against the value in FeatureEDX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureEDX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_EXTENDED_FEATURES_EDX_TABLE, CPU_EXTENDED_FEATURES_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, Addr qwEntriesFoundEDX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_EXTENDED_FEATURES_EDX_TABLE
            mov rsi, CPU_EXTENDED_FEATURES_EDX_RECORDS
            mov rdx, FeatureEDX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundEDX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Extended_Features_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    ;----------------------------------------------------------------------
    ; Go through the CPU_EXTENDED_FEATURES_ECX_TABLE table and AND each 
    ; BitValue against the value in FeatureECX
    ; 
    ; For each that matches, calculate the length of string (along with 
    ; string style) and add that to the total for all strings: 
    ; qwAllStringsLength
    ;----------------------------------------------------------------------
    .IF FeatureECX != 0
        IF @Platform EQ 1 ; Win x64
            Invoke _CPU_Features_CalcStringLength, Addr CPU_EXTENDED_FEATURES_ECX_TABLE, CPU_EXTENDED_FEATURES_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, Addr qwEntriesFoundECX
        ENDIF
        IF @Platform EQ 3 ; Linux x64
            lea rdi, CPU_EXTENDED_FEATURES_ECX_TABLE
            mov rsi, CPU_EXTENDED_FEATURES_ECX_RECORDS
            mov rdx, FeatureECX
            mov rcx, qwStringType
            mov r8, qwStringStyle
            lea r9, qwEntriesFoundECX
            call _CPU_Features_CalcStringLength
        ENDIF
        .IF rax == 0
            jmp CPU_Extended_Features_Error
        .ENDIF
        add qwAllStringsLength, rax
    .ENDIF
    
    .IF qwEntriesFoundEDX != 0 || qwEntriesFoundECX != 0
        IFDEF DEBUG32
        PrintDec qwEntriesFoundEDX
        PrintDec qwEntriesFoundECX
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
            jmp CPU_Extended_Features_Error
        .ENDIF
        mov lpszAllStrings, rax

        mov bMoreEntries, TRUE
        mov qwStartOffset, 0
        
        ;------------------------------------------------------------------
        ; Go through the CPU_EXTENDED_FEATURES_EDX_TABLE table again once 
        ; more and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundEDX != 0
            .IF qwEntriesFoundECX == 0
                mov bMoreEntries, FALSE
            .ENDIF
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_EXTENDED_FEATURES_EDX_TABLE, CPU_EXTENDED_FEATURES_EDX_RECORDS, FeatureEDX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundEDX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_EXTENDED_FEATURES_EDX_TABLE
                mov rsi, CPU_EXTENDED_FEATURES_EDX_RECORDS
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
                jmp CPU_Extended_Features_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
        
        ;------------------------------------------------------------------
        ; Go through the CPU_EXTENDED_FEATURES_ECX_TABLE table again once 
        ; more and AND each value against BitValue. 
        ;
        ; For each that matches, copy the string (along with string style) 
        ; to the total strings buffer: lpszAllStrings
        ;------------------------------------------------------------------
        .IF qwEntriesFoundECX != 0
            mov bMoreEntries, FALSE
            IF @Platform EQ 1 ; Win x64
                Invoke _CPU_Features_CopyStrings, Addr CPU_EXTENDED_FEATURES_ECX_TABLE, CPU_EXTENDED_FEATURES_ECX_RECORDS, FeatureECX, qwStringType, qwStringStyle, lpszAllStrings, qwStartOffset, qwEntriesFoundECX, bMoreEntries
            ENDIF
            IF @Platform EQ 3 ; Linux x64
                lea rdi, CPU_EXTENDED_FEATURES_ECX_TABLE
                mov rsi, CPU_EXTENDED_FEATURES_ECX_RECORDS
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
                jmp CPU_Extended_Features_Error
            .ENDIF
            mov qwStartOffset, rax
        .ENDIF
        
        IFDEF DEBUG32
        PrintStringByAddr lpszAllStrings
        DbgDump lpszAllStrings, qwAllStringsLength
        ENDIF
        
    .ELSE
        ;------------------------------------------------------------------
        ; Did NOT find any values in either feature table
        ; Could be reserved, or it isnt defined or something else?
        ;------------------------------------------------------------------
        jmp CPU_Extended_Features_Error
    .ENDIF
    
    jmp CPU_Extended_Features_Exit
    
CPU_Extended_Features_Error:
    
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

CPU_Extended_Features_Exit:
    
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
CPU_Extended_Features ENDP

END

