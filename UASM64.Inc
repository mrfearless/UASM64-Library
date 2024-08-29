;==============================================================================
;
; UASM64 Library
;
; https://github.com/mrfearless/UASM64-Library
;
; This software is provided 'as-is', without any express or implied warranty. 
; In no event will the author(s) be held liable for any damages arising from 
; the use of this software.
;
; The UASM64 Library is a port of the functions from the MASM32 Library that 
; are included with the MASM32 SDK (www.masm32.com)
; 
; The functions ported to an x64 version in the UASM64 Library aim to match the 
; parameters and features of the original x86 functions from the MASM32 Library 
; where possible. In a few functions that may not be possible, and an 
; alternative approach to achieve the same desired result may be used instead.
;
; The names of the functions and parameter names in the UASM64 Library compared 
; to the MASM32 Library have been changed to increase readability. Equates are
; provided in the UASM64.inc file to map to the new function names - which also
; helps when porting x86 projects to x64 ones.
;
; Additionally, new functions have been added to the UASM64 Library to expand
; and compliment the existing functions.
;
; UASM64 Library is targeted specifically for use with projects that use the 
; UASM assembler x64 (http://www.terraspace.co.uk/uasm.html), but likely other 
; compilers and assemblers can utilize it as well.
;
; All credit and thanks to all the original authors and code contributors of 
; the functions in the MASM32 Library.
;
; The UASM64 library and source code are free to use for anyone, and anyone can 
; contribute to the UASM64 Library project.

;==============================================================================


;------------------------------------------------------------------------------
; UASM64 Prototypes
;------------------------------------------------------------------------------
; CPU Functions:
CPU_CPUID_Supported     PROTO
CPU_MMX_Supported       PROTO
CPU_SSE_Supported       PROTO
CPU_SSE2_Supported      PROTO
CPU_SSE3_Supported      PROTO
CPU_SSSE3_Supported     PROTO
CPU_SSE41_Supported     PROTO
CPU_SSE42_Supported     PROTO
CPU_AESNI_Supported     PROTO
CPU_AVX_Supported       PROTO
CPU_AVX2_Supported      PROTO
CPU_RDRAND_Supported    PROTO
CPU_RDSEED_Supported    PROTO
CPU_HTT_Supported       PROTO
CPU_Logical_Cores       PROTO
CPU_Brand               PROTO
CPU_Manufacturer        PROTO
CPU_ManufacturerID      PROTO
CPU_Highest_Basic       PROTO
CPU_Highest_Basic_Ext   PROTO
CPU_Highest_Extended    PROTO
CPU_Signature           PROTO lpqwFamilyID:QWORD, lpqwExtFamilyID:QWORD, lpqwBaseFamilyID:QWORD, lpqwModelID:QWORD, lpqwExtModelID:QWORD, lpqwBaseModelID:QWORD, lpqwStepping:QWORD 
CPU_Basic_Features      PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD ; CPUID EAX=1
CPU_Basic_Features_Ext0 PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEBX:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD ; CPUID EAX=7, ECX=0
CPU_Basic_Features_Ext1 PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEAX:QWORD, qwMaskEBX:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD ; CPUID EAX=7, ECX=1
CPU_Basic_Features_Ext2 PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskEDX:QWORD ; CPUID EAX=7, ECX=2
CPU_Extended_Features   PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD ; CPUID EAX=80000001h

; String Functions:
String_AppendA          PROTO lpszDestination:QWORD, lpszSource:QWORD, qwDestinationOffset:QWORD
String_AppendW          PROTO lpszDestination:QWORD, lpszSource:QWORD, qwDestinationOffset:QWORD
String_ConcatA          PROTO lpszDestination:QWORD, lpszSource:QWORD
String_ConcatW          PROTO lpszDestination:QWORD, lpszSource:QWORD
String_CompareA         PROTO lpszString1:QWORD, lpszString2:QWORD
String_CompareW         PROTO lpszString1:QWORD, lpszString2:QWORD
String_CompareIA        PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD
String_CompareIW        PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD
String_CompareIExA      PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD, qwLengthString:QWORD
String_CompareIExW      PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD, qwLengthString:QWORD
String_CopyA            PROTO lpszSource:QWORD, lpszDestination:QWORD
String_CopyW            PROTO lpszSource:QWORD, lpszDestination:QWORD
String_CountA           PROTO lpszSource:QWORD, lpszSubString:QWORD
String_CountW           PROTO lpszSource:QWORD, lpszSubString:QWORD
String_InStringA        PROTO qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD
String_InStringW        PROTO qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD
String_LeftA            PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_LeftW            PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_LeftTrimA        PROTO lpszSource:QWORD, lpszDestination:QWORD
String_LeftTrimW        PROTO lpszSource:QWORD, lpszDestination:QWORD
String_LengthA          PROTO lpszString:QWORD
String_LengthW          PROTO lpszString:QWORD
String_LowercaseA       PROTO lpszString:QWORD
String_LowercaseW       PROTO lpszString:QWORD
String_MiddleA          PROTO lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD
String_MiddleW          PROTO lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD
String_MonoSpaceA       PROTO lpszSource:QWORD
String_MonoSpaceW       PROTO lpszSource:QWORD
String_MultiCatA        PROTO qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG
String_MultiCatW        PROTO qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG
String_RemoveA          PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD
String_RemoveW          PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD
String_ReplaceA         PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD
String_ReplaceW         PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD
String_ReverseA         PROTO lpszSource:QWORD, lpszDestination:QWORD
String_ReverseW         PROTO lpszSource:QWORD, lpszDestination:QWORD
String_RightA           PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_RightW           PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_RightTrimA       PROTO lpszSource:QWORD, lpszDestination:QWORD
String_RightTrimW       PROTO lpszSource:QWORD, lpszDestination:QWORD
String_SubstringA       PROTO lpszString:QWORD, lpszSubString:QWORD
String_SubstringW       PROTO lpszString:QWORD, lpszSubString:QWORD
String_TrimA            PROTO lpszString:QWORD
String_TrimW            PROTO lpszString:QWORD
String_UppercaseA       PROTO lpszString:QWORD
String_UppercaseW       PROTO lpszString:QWORD
String_WordReplaceA     PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszWordToReplace:QWORD, lpszReplacementWord:QWORD
String_WordReplaceW     PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszWordToReplace:QWORD, lpszReplacementWord:QWORD

IFDEF __UNICODE__
    String_Append       EQU <String_AppendW>
    String_Concat       EQU <String_ConcatW>
    String_Compare      EQU <String_CompareW>
    String_CompareI     EQU <String_CompareIW>      ; need
    String_CompareIEx   EQU <String_CompareIExW>    ; need
    String_Copy         EQU <String_CopyW>
    String_Count        EQU <String_CountW>
    String_InString     EQU <String_InStringW>
    String_Left         EQU <String_LeftW>
    String_LeftTrim     EQU <String_LeftTrimW>
    String_Length       EQU <String_LengthW>
    String_Lowercase    EQU <String_LowercaseW>
    String_Middle       EQU <String_MiddleW>
    String_MonoSpace    EQU <String_MonoSpaceW>
    String_MultiCat     EQU <String_MultiCatW>
    String_Remove       EQU <String_RemoveW>
    String_Replace      EQU <String_ReplaceW>
    String_Reverse      EQU <String_ReverseW>
    String_Right        EQU <String_RightW>
    String_RightTrim    EQU <String_RightTrimW>
    String_Substring    EQU <String_SubstringW>
    String_Trim         EQU <String_TrimW>          ; need
    String_Uppercase    EQU <String_UppercaseW>
    String_WordReplace  EQU <String_WordReplaceW>   ; need
ELSE ; ANSI
    String_Append       EQU <String_AppendA>
    String_Concat       EQU <String_ConcatA>
    String_Compare      EQU <String_CompareA>
    String_CompareI     EQU <String_CompareIA>
    String_CompareIEx   EQU <String_CompareIExA>
    String_Copy         EQU <String_CopyA>
    String_Count        EQU <String_CountA>
    String_InString     EQU <String_InStringA>
    String_Left         EQU <String_LeftA>
    String_LeftTrim     EQU <String_LeftTrimA>
    String_Length       EQU <String_LengthA>
    String_Lowercase    EQU <String_LowercaseA>
    String_Middle       EQU <String_MiddleA>
    String_MonoSpace    EQU <String_MonoSpaceA>
    String_MultiCat     EQU <String_MultiCatA>
    String_Remove       EQU <String_RemoveA>
    String_Replace      EQU <String_ReplaceA>
    String_Reverse      EQU <String_ReverseA>
    String_Right        EQU <String_RightA>
    String_RightTrim    EQU <String_RightTrimA>
    String_Substring    EQU <String_SubstringA>
    String_Trim         EQU <String_TrimA>
    String_Uppercase    EQU <String_UppercaseA>
    String_WordReplace  EQU <String_WordReplaceA>
ENDIF

; Path, File And Folder Functions:
File_CreateA            PROTO lpszFilename:QWORD
File_CreateW            PROTO lpszFilename:QWORD
File_Close              PROTO hFile:QWORD
File_ExistsA            PROTO lpszFilename:QWORD
File_ExistsW            PROTO lpszFilename:QWORD
File_FileSize           PROTO hFile:QWORD
File_Flush              PROTO hFile:QWORD
File_MapSharedMemory    PROTO lpszSharedMemoryName:QWORD, qwMemorySize:QWORD, lpqwMemoryMapHandle:QWORD, lpqwMemoryViewPointer:QWORD ; CreateMMF
File_OpenA              PROTO lpszFilename:QWORD
File_OpenW              PROTO lpszFilename:QWORD
File_Read               PROTO hFile:QWORD, lpMemory:QWORD, qwBytesToRead:QWORD
File_SizeA              PROTO lpszFilename:QWORD
File_SizeW              PROTO lpszFilename:QWORD
File_ReadFileToMemoryA  PROTO lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD ; read_disk_file
File_ReadFileToMemoryW  PROTO lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD ; read_disk_file
File_UnmapSharedMemory  PROTO qwMemoryViewPointer:QWORD, qwMemoryMapHandle:QWORD ; CloseMMF
File_Write              PROTO hFile:QWORD, lpMemory:QWORD, qwBytesToWrite:QWORD
File_WriteMemoryToFileA PROTO lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD ; write_disk_file
File_WriteMemoryToFileW PROTO lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD ; write_disk_file

IFDEF __UNICODE__
    File_Create         EQU <File_CreateW>
    File_Exists         EQU <File_ExistsW>
    File_Open           EQU <File_OpenW>
    File_Size           EQU <File_SizeW>
    File_ReadFileToMemory EQU <File_ReadFileToMemoryW>
    File_WriteMemoryToFile EQU <File_WriteMemoryToFileW>
ELSE ; ANSI
    File_Create         EQU <File_CreateA>
    File_Exists         EQU <File_ExistsA>
    File_Open           EQU <File_OpenA>
    File_Size           EQU <File_SizeA>
    File_ReadFileToMemory EQU <File_ReadFileToMemoryA>
    File_WriteMemoryToFile EQU <File_WriteMemoryToFileA>
ENDIF

Path_GetAppPath         PROTO lpszPath:QWORD
Path_GetPathOnly        PROTO lpszFullFilenamePath:QWORD, lpszPath:QWORD
Path_NameFromPath       PROTO lpszFullFilenamePath:QWORD, lpszFilename:QWORD

; Argument Parsing Functions:
Arg_GetArgumentA        PROTO lpszArgumentList:QWORD, lpszDestination:QWORD, nArgument:QWORD, qwArgumentListReadOffset:QWORD
Arg_GetCommandLineA     PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD
Arg_GetCommandLineExA   PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD

Arg_GetArgumentW        PROTO lpszArgumentList:QWORD, lpszDestination:QWORD, nArgument:QWORD, qwNotUsed:QWORD
Arg_GetCommandLineW     PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD
Arg_GetCommandLineExW   PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD

IFDEF __UNICODE__
    Arg_GetArgument             EQU <Arg_GetArgumentW>
    Arg_GetCommandLine          EQU <Arg_GetCommandLineW>
    Arg_GetCommandLineEx        EQU <Arg_GetCommandLineExW>
ELSE ; ANSI
    Arg_GetArgument             EQU <Arg_GetArgumentA>
    Arg_GetCommandLine          EQU <Arg_GetCommandLineA>
    Arg_GetCommandLineEx        EQU <Arg_GetCommandLineExA>
ENDIF


; Numeric And Text Conversions:

;Convert_DWORDToString       ; dwtoa
;Convert_StringToDWORD       ; 
;
;Convert_SDWORDToString      ; ltoa
;Convert_StringToSDWORD      ; atol
;
;Convert_QWORDToString       ; qwtoa
;Convert_StringToQWORD       ; a2qw
;
;Convert_SQWORDToString      ; 
;Convert_StringToSQWORD      ; atoqw
;
;Convert_DWORDToHex          ; dw2hex
;Convert_HexToDWORD          ; htodw
;
;Convert_SDWORDToHex         ; 
;Convert_HexToSDWORD         ; 
;
;Convert_QWORDToHex          ; qw2hex
;Convert_HexToQWORD          ; htoqw
;
;Convert_SQWORDToHex         ; 
;Convert_HexToSQWORD         ; 
;
;Convert_RawDataToHex        ; bin2hex
;Convert_HexToRawData        ; hex2bin 


qw2hex                  PROTO :QWORD, :QWORD     ; Convert_QWORDToHexString
dw2hex                  PROTO :DWORD, :QWORD     ; Convert_DWORDToHexString2
dwtoa                   PROTO :DWORD, :QWORD     ; Convert_DWORDToString
qwtoa                   PROTO :QWORD, :QWORD     ; Convert_SQWORDToString
a2qw                    PROTO :QWORD             ; Convert_StringToQWORD
atoqw                   PROTO :QWORD             ; Convert_StringToSQWORD
ltoa                    PROTO lValue:QWORD, lpBuffer:QWORD   ; Convert_SDWORDToString
htodw                   PROTO :QWORD             ; Convert_HexStringToDWORD
htoqw                   PROTO :QWORD             ; Convert_HexStringToQWORD

; Random
Random_Number           PROTO base:QWORD
Random_Seed             PROTO TheSeed:QWORD

; Array Functions:
Array_Create            PROTO nItemCount:QWORD                              ; arralloc
Array_CreateEx          PROTO nItemCount:QWORD,nItemSize:QWORD              ; create_array
Array_Count             EQU <Array_TotalItems>
Array_Destroy           PROTO pArray:QWORD                                  ; arrfree
Array_Resize            PROTO pArray:QWORD,nItemCount:QWORD                 ; arrealloc
Array_Truncate          PROTO pArray:QWORD,nItemCount:QWORD                 ; arrtrunc
Array_Extend            PROTO pArray:QWORD,nItemCount:QWORD                 ; arrextnd
Array_ItemAddress       PROTO pArray:QWORD,nItemIndex:QWORD                 ; arrget
Array_ItemSetText       PROTO pArray:QWORD,nItemIndex:QWORD,lpszItemText:QWORD ; arrset
Array_ItemSetData       PROTO pArray:QWORD,nItemIndex:QWORD,lpItemData:QWORD,qwItemDataLength:QWORD ;arrbin
Array_ItemLength        PROTO pArray:QWORD,nItemIndex:QWORD                 ; arrlen
Array_LoadItemsFromFile PROTO lpszFilename:QWORD                            ; arrfile
Array_LoadItemsFromMem  PROTO pMemory:QWORD                                 ; arrtxt
Array_SaveItemsToFile   PROTO pArray:QWORD,lpszFilename:QWORD               ; arr2file
Array_SaveItemsToMem    PROTO pArray:QWORD,pMemory:QWORD                    ; arr2text 
Array_TotalItems        PROTO pArray:QWORD                                  ; arrcnt    
Array_TotalMemory       PROTO pArray:QWORD,lpdwTotalMemory:QWORD            ; arrtotal
Array_ItemsAddValue     PROTO pArray:QWORD,nItemCount:QWORD,qwValue:QWORD   ; arr_add
Array_ItemsMulValue     PROTO pArray:QWORD,nItemCount:QWORD,qwValue:QWORD   ; arr_mul
Array_ItemsSubValue     PROTO pArray:QWORD,nItemCount:QWORD,qwValue:QWORD   ; arr_sub

; Text Functions:
Text_ReadLineA          PROTO lpszTextSource:QWORD, lpszTextLineBuffer:QWORD, qwTextSourceOffset:QWORD ; readline
Text_ReadLineW          PROTO lpszTextSource:QWORD, lpszTextLineBuffer:QWORD, qwTextSourceOffset:QWORD ; readline
Text_WriteLineA         PROTO lpszTextLineBuffer:QWORD, lpszTextDestination:QWORD, qwTextDestinationOffset:QWORD, bNoCRLF:QWORD ; writeline
Text_WriteLineW         PROTO lpszTextLineBuffer:QWORD, lpszTextDestination:QWORD, qwTextDestinationOffset:QWORD, bNoCRLF:QWORD ; writeline
Text_TestLineA          PROTO lpszTextSource:QWORD                          ; tstline
Text_TestLineW          PROTO lpszTextSource:QWORD                          ; tstline
Text_LineCountA         PROTO lpszText:QWORD                                ; lfcnt
Text_LineCountW         PROTO lpszText:QWORD                                ; lfcnt
Text_LineCountExA       PROTO lpszText:QWORD, qwTextLength:QWORD            ; get_line_count
Text_LineCountExW       PROTO lpszText:QWORD, qwTextLength:QWORD            ; get_line_count
Text_ParseLineA         PROTO lpszTextSource:QWORD, pArray:QWORD            ; parse_line
Text_ParseLineW         PROTO lpszTextSource:QWORD, pArray:QWORD            ; parse_line

IFDEF __UNICODE__
    Text_ReadLine       EQU <Text_ReadLineW>
    Text_WriteLine      EQU <Text_WriteLineW>
    Text_TestLine       EQU <Text_TestLineW>
    Text_LineCount      EQU <Text_LineCountW>
    Text_LineCountEx    EQU <Text_LineCountExW>
    Text_ParseLine      EQU <Text_ParseLineW>
ELSE ; ANSI
    Text_ReadLine       EQU <Text_ReadLineA>
    Text_WriteLine      EQU <Text_WriteLineA>
    Text_TestLine       EQU <Text_TestLineA>
    Text_LineCount      EQU <Text_LineCountA>
    Text_LineCountEx    EQU <Text_LineCountExA>
    Text_ParseLine      EQU <Text_ParseLineA>
ENDIF

; Memory Functions:
Memory_Alloc            PROTO qwBytes:QWORD
Memory_Compare          PROTO pMemoryAddress1:QWORD, pMemoryAddress2:QWORD, qwMemoryLength:QWORD
Memory_Copy             PROTO pMemSource:QWORD, pMemDestination:QWORD, qwAmount:QWORD
Memory_Fill             PROTO pMemoryAddress:QWORD, qwMemoryLength:QWORD, qwFill:QWORD
Memory_Free             PROTO pMemoryAddress:QWORD
Memory_Move             PROTO pMemSource:QWORD, pMemDestination:QWORD, qwAmount:QWORD
Memory_Realloc          PROTO pMemSource:QWORD, qwBytes:QWORD
Memory_Zero             PROTO pMemoryAddress:QWORD, qwMemoryLength:QWORD

;------------------------------------------------------------------------------
; MASM32 library function names to UASM64 library function names:
;------------------------------------------------------------------------------
; MASM32 Function Name   =   UASM64 Function Name
;---------------------  ---  --------------------------------------------------
szappend                EQU <String_AppendA>
szCatStr                EQU <String_ConcatA>
szCmp                   EQU <String_CompareA>
Cmpi                    EQU <String_CompareIA>
szCmpi                  EQU <String_CompareIExA>
szCopy                  EQU <String_CopyA>
szWcnt                  EQU <String_CountA>
InString                EQU <String_InStringA>
szLeft                  EQU <String_LeftA>
szLtrim                 EQU <String_LeftTrimA>
szLen                   EQU <String_LengthA>
szLower                 EQU <String_LowercaseA>
szMid                   EQU <String_MiddleA>
szMonoSpace             EQU <String_MonoSpaceA>
szMultiCat              EQU <String_MultiCatA>
szRemove                EQU <String_RemoveA>
szRep                   EQU <String_ReplaceA>
szRev                   EQU <String_ReverseA>
szRight                 EQU <String_RightA>
szRtrim                 EQU <String_RightTrimA>
szTrim                  EQU <String_TrimA>
szUpper                 EQU <String_UppercaseA>
szWcnt                  EQU <String_CountA>
wordreplace             EQU <String_WordReplaceA>
szStrLen                EQU <String_LengthA>

ucappend                EQU <String_AppendW
ucCatStr                EQU <String_ConcatW
ucCopy                  EQU <String_CopyW
ucCmp                   EQU <String_CompareW
; ?                     EQU <String_CompareIW>
; ?                     EQU <String_CompareIExW>
ucFind                  EQU <String_InStringW
ucLen                   EQU <String_LengthW
ucLeft                  EQU <String_LeftW
ucLower                 EQU <String_LowercaseW
ucLtrim                 EQU <String_LeftTrimW
ucMid                   EQU <String_MiddleW
ucMonoSpace             EQU <String_MonoSpaceW
ucMultiCat              EQU <String_MultiCatW
ucRemove                EQU <String_RemoveW
ucRep                   EQU <String_ReplaceW
ucRev                   EQU <String_ReverseW
ucRight                 EQU <String_RightW
ucRtrim                 EQU <String_RightTrimW
; ?                     EQU <String_TrimW>
ucUpper                 EQU <String_UppercaseW
ucWcnt                  EQU <String_CountW>
; ?                     EQU <String_WordReplaceW>

exist                   EQU <File_ExistsA>
filesize                EQU <File_SizeA>
read_disk_file          EQU <File_ReadFileToMemoryA>
write_disk_file         EQU <File_WriteMemoryToFileA>
CloseMMF                EQU <File_UnmapSharedMemory>
CreateMMF               EQU <File_MapSharedMemory>

GetAppPath              EQU <Path_GetAppPath>
GetPathOnly             EQU <Path_GetPathOnly>
NameFromPath            EQU <Path_NameFromPath>

ArgByNumber             EQU <Arg_GetArgumentA>
getcl                   EQU <Arg_GetCommandLineA>
getcl_ex                EQU <Arg_GetCommandLineExA>
ucArgByNum              EQU <Arg_GetArgumentW>


;ucArgByNum
;ucGetCL
;ucCmdTail

nrandom                 EQU <Random_Number>
nseed                   EQU <Random_Seed>

readline                EQU <Text_ReadLineA>
writeline               EQU <Text_WriteLineA> 
tstline                 EQU <Text_TestLineA>
lfcnt                   EQU <Text_LineCountA>
get_line_count          EQU <Text_LineCountExA>
;ucgetline
parse_line              EQU <Text_ParseLineA>

;atodw                   EQU <Convert_StringDecToDWORD>
;htodw                   EQU <Convert_StringHexToDWORD>
;dwtoa                   EQU <Convert_DWORDToStringDec>
;dw2ah                   EQU <Convert_DWORDToStringHex>
;dw2hex                  EQU <Convert_DWORDToStringHex2>
;udw2str                 EQU <Convert_DWORDToString>
;ustr2dw                 EQU <Convert_StringToDWORD>
;ltoa                    EQU <Convert_SDWORDToStringDec>
;atol                    EQU <Convert_StringDecToSDWORD>

create_array            EQU <Array_CreateEx>
arralloc                EQU <Array_Create>
arrealloc               EQU <Array_Resize>
arrfree                 EQU <Array_Destroy>
arrset                  EQU <Array_ItemSetText>
arrget                  EQU <Array_ItemAddress>
arrcnt                  EQU <Array_TotalItems>
arrlen                  EQU <Array_ItemLength>
arrtrunc                EQU <Array_Truncate>
arrextnd                EQU <Array_Extend>
arrtotal                EQU <Array_TotalMemory>
arr2file                EQU <Array_SaveItemsToFile>
arr2mem                 EQU <Array_SaveItemsToMem>
arr2text                EQU <Array_SaveItemsToMem>
arrtxt                  EQU <Array_LoadItemsFromMem>
arrfile                 EQU <Array_LoadItemsFromFile>
arrbin                  EQU <Array_ItemSetData>
arr_add                 EQU <Array_ItemsAddValue>
arr_mul                 EQU <Array_ItemsMulValue>
arr_sub                 EQU <Array_ItemsSubValue>

Alloc                   EQU <Memory_Alloc>
cmpmem                  EQU <Memory_Compare>
MemCopy                 EQU <Memory_Copy>
memfill                 EQU <Memory_Fill>
Free                    EQU <Memory_Free>


.CONST
UASM64_ALIGN            TEXTEQU <ALIGN 16>
Platform_Windows_x64    TEXTEQU <@Platform EQ 1> ; for conditional assembly
Platform_Linux_x64      TEXTEQU <@Platform EQ 3> ; for conditional assembly

IFNDEF FALSE
FALSE EQU 0
ENDIF
IFNDEF TRUE
TRUE EQU 1
ENDIF


; CPU Features & CPU Extended Features String Types:
CFST_MNEMONIC                   EQU 0 ; Short form of the feature: "AVX"
CFST_FEATURE                    EQU 1 ; Long form describing the feature: "Advanced Vector Extensions (AVX) Instruction Extensions"
CFST_BOTH                       EQU 2 ; "AVX: Advanced Vector Extensions (AVX) Instruction Extensions"

; CPU Features & CPU Extended Features String Styles:
CFSS_NULL                       EQU 0 ; null seperated, double null terminated.
CFSS_SPACE                      EQU 1 ; space seperated, null terminated.
CFSS_COMMA                      EQU 2 ; comma and space seperated, null terminated.
CFSS_TAB                        EQU 3 ; tab seperated, null terminated.
CFSS_LF                         EQU 4 ; line feed (LF) seperated, null terminated.
CFSS_CRLF                       EQU 5 ; carriage return (CR) and line feed (LF) seperated, null terminated.
CFSS_LIST                       EQU 6 ; dash preceeds text and CRLF seperates, null terminated.

; Manufacturer ID: Return value from CPU_ManufacturerID
CPU_MANUFACTURER_NONE           EQU  0 ; Not supported, Unknown, or Error
CPU_MANUFACTURER_INTEL          EQU  1 ; "GenuineIntel"
CPU_MANUFACTURER_IOTEL          EQU  2 ; "GenuineIotel"
CPU_MANUFACTURER_AMD            EQU  3 ; "AuthenticAMD"
CPU_MANUFACTURER_CYRIX          EQU  4 ; "CyrixInstead"
CPU_MANUFACTURER_CENTAUR        EQU  5 ; "CentaurHauls"
CPU_MANUFACTURER_IDTWINCHIP     EQU  5 ; "CentaurHauls"
CPU_MANUFACTURER_TRANSMETACPU   EQU  6 ; "TransmetaCPU"
CPU_MANUFACTURER_TRANSMETA      EQU  7 ; "GenuineTMx86"
CPU_MANUFACTURER_NATSEMI        EQU  8 ; "Geode by NSC"
CPU_MANUFACTURER_NEXGEN         EQU  9 ; "NexGenDriven"
CPU_MANUFACTURER_RISE           EQU 10 ; "RiseRiseRise"
CPU_MANUFACTURER_SIS            EQU 11 ; "SiS SiS SiS "
CPU_MANUFACTURER_UMC            EQU 12 ; "UMC UMC UMC "
CPU_MANUFACTURER_VORTEX         EQU 13 ; "Vortex86 SoC"
CPU_MANUFACTURER_ZHAOXIN        EQU 14 ; "  Shanghai  "
CPU_MANUFACTURER_HYGON          EQU 15 ; "HygonGenuine"
CPU_MANUFACTURER_RDCSEMI        EQU 16 ; "Genuine  RDC"
CPU_MANUFACTURER_ELBRUS         EQU 17 ; "E2K MACHINE"
CPU_MANUFACTURER_VIA            EQU 18 ; "VIA VIA VIA "
CPU_MANUFACTURER_AMDSAMPLE      EQU 19 ; "AMD ISBETTER" - early engineering samples of AMD K5 
CPU_MANUFACTURER_AO486          EQU 20 ; "GenuineAO486" - open source soft CPU cores
CPU_MANUFACTURER_MISTER         EQU 21 ; "MiSTer AO486" - open source soft CPU cores
CPU_MANUFACTURER_V586S          EQU 22 ; "GenuineIntel" - open source soft CPU cores
CPU_MANUFACTURER_MSX86TOARM     EQU 23 ; "MicrosoftXTA" - virtual machine
CPU_MANUFACTURER_APPLEROSETTA2  EQU 24 ; "GenuineIntel" - virtual machine
CPU_MANUFACTURER_VIRTUALAPPLE   EQU 25 ; "VirtualApple" - virtual machine

; CPU Basic Features EDX Flags:
CPU_BF_EDX_ALL                  EQU -1
CPU_BF_EDX_NONE                 EQU 0
CPU_BF_EDX_FPU                  EQU 1 SHL  0 ; Floating-Point Unit On-Chip
CPU_BF_EDX_VME                  EQU 1 SHL  1 ; Virtual 8086 Mode Enhancements
CPU_BF_EDX_DE                   EQU 1 SHL  2 ; Debugging Extensions
CPU_BF_EDX_PSE                  EQU 1 SHL  3 ; Page Size Extension
CPU_BF_EDX_TSC                  EQU 1 SHL  4 ; Time Stamp Counter
CPU_BF_EDX_MSR                  EQU 1 SHL  5 ; Model Specific Registers RDMSR and WRMSR Instructions
CPU_BF_EDX_PAE                  EQU 1 SHL  6 ; Physical Address Extension
CPU_BF_EDX_MCE                  EQU 1 SHL  7 ; Machine Check Exception
CPU_BF_EDX_CX8                  EQU 1 SHL  8 ; CMPXCHG8B Instruction
CPU_BF_EDX_APIC                 EQU 1 SHL  9 ; Advanced Programmable Interrupt Controller
CPU_BF_EDX_RESERVED             EQU 1 SHL 10 ; Reserved
CPU_BF_EDX_SEP                  EQU 1 SHL 11 ; SYSENTER and SYSEXIT Instructions
CPU_BF_EDX_MTRR                 EQU 1 SHL 12 ; Memory Type Range Registers
CPU_BF_EDX_PGE                  EQU 1 SHL 13 ; Page Global Enable
CPU_BF_EDX_MCA                  EQU 1 SHL 14 ; Machine Check Architecture
CPU_BF_EDX_CMOV                 EQU 1 SHL 15 ; Conditional Move Instructions
CPU_BF_EDX_PAT                  EQU 1 SHL 16 ; Page Attribute Table
CPU_BF_EDX_PSE36                EQU 1 SHL 17 ; 36-Bit Page Size Extension
CPU_BF_EDX_PSN                  EQU 1 SHL 18 ; Processor Serial Number
CPU_BF_EDX_CLFSH                EQU 1 SHL 19 ; CLFLUSH Instruction
CPU_BF_EDX_NX                   EQU 1 SHL 20 ; No-execute (NX)
CPU_BF_EDX_DS                   EQU 1 SHL 21 ; Debug Store
CPU_BF_EDX_ACPI                 EQU 1 SHL 22 ; Thermal Monitor and Software Controlled Clock Facilitie
CPU_BF_EDX_MMX                  EQU 1 SHL 23 ; Intel MMX Technology
CPU_BF_EDX_FXSR                 EQU 1 SHL 24 ; FXSAVE and FXRSTOR Instructions
CPU_BF_EDX_SSE                  EQU 1 SHL 25 ; Streaming SIMD Extensions (SSE)
CPU_BF_EDX_SSE2                 EQU 1 SHL 26 ; Streaming SIMD Extensions 2 (SSE2)
CPU_BF_EDX_SS                   EQU 1 SHL 27 ; Self Snoop
CPU_BF_EDX_HTT                  EQU 1 SHL 28 ; Max APIC IDs reserved field is Valid
CPU_BF_EDX_TM                   EQU 1 SHL 29 ; Thermal Monitor
CPU_BF_EDX_IA64                 EQU 1 SHL 30 ; IA64 Processor Emulating x86
CPU_BF_EDX_PBE                  EQU 1 SHL 31 ; Pending Break Enable
CPU_BF_EDX_SIMD                 EQU CPU_BF_EDX_MMX or CPU_BF_EDX_SSE or CPU_BF_EDX_SSE2
CPU_BF_EDX_COMMON               EQU CPU_BF_EDX_SIMD or CPU_BF_EDX_FPU 

; CPU Basic Features ECX Flags:
CPU_BF_ECX_ALL                  EQU -1
CPU_BF_ECX_NONE                 EQU 0
CPU_BF_ECX_SSE3                 EQU 1 SHL  0 ; Streaming SIMD Extensions 3 (SSE3)
CPU_BF_ECX_PCLMULQDQ            EQU 1 SHL  1 ; PCLMULQDQ Instruction
CPU_BF_ECX_DTES64               EQU 1 SHL  2 ; 64-bit Debug Store Area
CPU_BF_ECX_MONITOR              EQU 1 SHL  3 ; MONITOR and MWAIT Instructions
CPU_BF_ECX_DSCPL                EQU 1 SHL  4 ; CPL Qualified Debug Store
CPU_BF_ECX_VMX                  EQU 1 SHL  5 ; Virtual Machine Extensions
CPU_BF_ECX_SMX                  EQU 1 SHL  6 ; Safer Mode Extensions
CPU_BF_ECX_EIST                 EQU 1 SHL  7 ; Enhanced Intel SpeedStep® technology
CPU_BF_ECX_TM2                  EQU 1 SHL  8 ; Thermal Monitor 2
CPU_BF_ECX_SSSE3                EQU 1 SHL  9 ; Supplemental Streaming SIMD Extensions 3 (SSSE3)
CPU_BF_ECX_CNXTID               EQU 1 SHL 10 ; L1 Context ID
CPU_BF_ECX_SDBG                 EQU 1 SHL 11 ; Silicon Debug Interface
CPU_BF_ECX_FMA                  EQU 1 SHL 12 ; Fused Multiply Add Extensions
CPU_BF_ECX_CMPXCHG16B           EQU 1 SHL 13 ; CMPXCHG16B Instruction
CPU_BF_ECX_xTPR                 EQU 1 SHL 14 ; xTPR Update Control
CPU_BF_ECX_PDCM                 EQU 1 SHL 15 ; Perfmon and Debug Capability
CPU_BF_ECX_RESERVED             EQU 1 SHL 16 ; Reserved
CPU_BF_ECX_PCID                 EQU 1 SHL 17 ; Process-Context Identifiers
CPU_BF_ECX_DCA                  EQU 1 SHL 18 ; Direct Cache Access
CPU_BF_ECX_SSE41                EQU 1 SHL 19 ; Streaming SIMD Extensions 4.1 (SSE4.1)
CPU_BF_ECX_SSE42                EQU 1 SHL 20 ; Streaming SIMD Extensions 4.2 (SSE4.2)
CPU_BF_ECX_x2APIC               EQU 1 SHL 21 ; Enhanced APIC
CPU_BF_ECX_MOVBE                EQU 1 SHL 22 ; MOVBE Instruction
CPU_BF_ECX_POPCNT               EQU 1 SHL 23 ; POPCNT Instruction
CPU_BF_ECX_TSCDeadline          EQU 1 SHL 24 ; APIC implements one-shot operation using a TSC deadline value
CPU_BF_ECX_AESNI                EQU 1 SHL 25 ; Advanced Encryption Standard New Instructions (AES-NI) Instruction Extension
CPU_BF_ECX_XSAVE                EQU 1 SHL 26 ; Extensible Processor State Save/Restore Instructions
CPU_BF_ECX_OSXSAVE              EQU 1 SHL 27 ; XSAVE enabled by OS
CPU_BF_ECX_AVX                  EQU 1 SHL 28 ; Advanced Vector Extensions (AVX) Instruction Extensions
CPU_BF_ECX_F16C                 EQU 1 SHL 29 ; 16-bit floating-point conversion instructions
CPU_BF_ECX_RDRAND               EQU 1 SHL 30 ; RDRAND Instruction
CPU_BF_ECX_HYPERVISOR           EQU 1 SHL 31 ; Hypervisor present
CPU_BF_ECX_SIMD                 EQU CPU_BF_ECX_SSE3 or CPU_BF_ECX_SSSE3 or CPU_BF_ECX_SSE41 or CPU_BF_ECX_SSE42 or CPU_BF_ECX_AVX
CPU_BF_ECX_JUSTAVX              EQU CPU_BF_ECX_AVX
CPU_BF_ECX_COMMON               EQU CPU_BF_ECX_SIMD or CPU_BF_ECX_VMX or CPU_BF_ECX_SMX or CPU_BF_ECX_FMA or CPU_BF_ECX_AESNI

; CPU Basic Features Extended 0 EBX Flags:
CPU_BFE0_EBX_ALL                EQU -1
CPU_BFE0_EBX_NONE               EQU 0
CPU_BFE0_EBX_FSGSBASE           EQU 1 SHL  0 ; Supports RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE
CPU_BFE0_EBX_A32_TSC_ADJUS      EQU 1 SHL  1 ; A32_TSC_ADJUST MSR Supported
CPU_BFE0_EBX_SGX                EQU 1 SHL  2 ; Software Guard Extensions (SGX)
CPU_BFE0_EBX_BMI1               EQU 1 SHL  3 ; Bit Manipulation Instruction Set 1
CPU_BFE0_EBX_TSX                EQU 1 SHL  4 ; Transactional Synchronization Extensions (TSX)
CPU_BFE0_EBX_AVX2               EQU 1 SHL  5 ; Advanced Vector Extensions 2
CPU_BFE0_EBX_FDP_EXCPTN_ON      EQU 1 SHL  6 ; x87 FPU data pointer register updated on exceptions only
CPU_BFE0_EBX_SMEP               EQU 1 SHL  7 ; Supervisor-Mode Execution Prevention
CPU_BFE0_EBX_BMI2               EQU 1 SHL  8 ; Bit Manipulation Instruction Set 2
CPU_BFE0_EBX_ERMS               EQU 1 SHL  9 ; Enhanced REP MOVSB/STOSB
CPU_BFE0_EBX_INVPCID            EQU 1 SHL 10 ; INVPCID Instruction
CPU_BFE0_EBX_RTM                EQU 1 SHL 11 ; TSX Restricted Transactional Memory 
CPU_BFE0_EBX_RDTM               EQU 1 SHL 12 ; Intel Resource Director (RDT) Monitoring
CPU_BFE0_EBX_FPUD               EQU 1 SHL 13 ; FPU CS and FPU DS Deprecated
CPU_BFE0_EBX_MPX                EQU 1 SHL 14 ; Memory Protection Extensions
CPU_BFE0_EBX_RDTA               EQU 1 SHL 15 ; Intel Resource Director Technology (RDT)
CPU_BFE0_EBX_AVX512F            EQU 1 SHL 16 ; AVX-512 Foundation
CPU_BFE0_EBX_AVX512DQ           EQU 1 SHL 17 ; AVX-512 Doubleword and Quadword Instructions
CPU_BFE0_EBX_RDSEED             EQU 1 SHL 18 ; RDSEED instruction
CPU_BFE0_EBX_ADX                EQU 1 SHL 19 ; Intel ADX (Multi-Precision Add-Carry Instruction Extension
CPU_BFE0_EBX_SMAP               EQU 1 SHL 20 ; Supervisor Mode Access Prevention
CPU_BFE0_EBX_AVX512_IFMA        EQU 1 SHL 21 ; AVX-512 Integer Fused Multiply-Add Instructions
CPU_BFE0_EBX_PCOMMIT            EQU 1 SHL 22 ; PCOMMIT Instruction Deprecated
CPU_BFE0_EBX_CLFLUSHOPT         EQU 1 SHL 23 ; CLFLUSHOPT Instruction
CPU_BFE0_EBX_CLWB               EQU 1 SHL 24 ; CLWB (Cache Line Writeback) Instruction
CPU_BFE0_EBX_PT                 EQU 1 SHL 25 ; Intel Processor Trace
CPU_BFE0_EBX_AVX512PF           EQU 1 SHL 26 ; AVX-512 Prefetch Instructions
CPU_BFE0_EBX_AVX512ER           EQU 1 SHL 27 ; AVX-512 Exponential and Reciprocal Instructions
CPU_BFE0_EBX_AVX512CD           EQU 1 SHL 28 ; AVX-512 Conflict Detection Instructions 
CPU_BFE0_EBX_SHA                EQU 1 SHL 29 ; SHA-1 and SHA-256 extensions
CPU_BFE0_EBX_AVX512BW           EQU 1 SHL 30 ; AVX-512 Byte and Word Instructions 
CPU_BFE0_EBX_AVX512VL           EQU 1 SHL 31 ; AVX-512 Vector Length Extensions
CPU_BFE0_EBX_SIMD               EQU CPU_BFE0_EBX_AVX2 or CPU_BFE0_EBX_AVX512F or CPU_BFE0_EBX_AVX512DQ or CPU_BFE0_EBX_AVX512_IFMA or CPU_BFE0_EBX_AVX512PF or CPU_BFE0_EBX_AVX512ER or CPU_BFE0_EBX_AVX512CD or CPU_BFE0_EBX_AVX512BW or CPU_BFE0_EBX_AVX512VL
CPU_BFE0_EBX_JUSTAVX            EQU CPU_BFE0_EBX_SIMD
CPU_BFE0_EBX_COMMON             EQU CPU_BFE0_EBX_AVX2 or CPU_BFE0_EBX_SGX or CPU_BFE0_EBX_SHA

; CPU Basic Features Extended 0 ECX Flags:
CPU_BFE0_ECX_ALL                EQU -1
CPU_BFE0_ECX_NONE               EQU 0
CPU_BFE0_ECX_PREFETCHWT1        EQU 1 SHL  0 ; PREFETCHWT1 Instruction
CPU_BFE0_ECX_AVX512_VBMI        EQU 1 SHL  1 ; AVX-512 Vector Bit Manipulation Instructions
CPU_BFE0_ECX_UMIP               EQU 1 SHL  2 ; User-Mode Instruction Prevention 
CPU_BFE0_ECX_PKU                EQU 1 SHL  3 ; Memory Protection Keys for User-mode pages
CPU_BFE0_ECX_OSPKE              EQU 1 SHL  4 ; PKU Enabled by OS 
CPU_BFE0_ECX_WAITPKG            EQU 1 SHL  5 ; Timed pause and user-level monitor/wait instructions (TPAUSE, UMONITOR, UMWAIT)
CPU_BFE0_ECX_AVX512_VBMI2       EQU 1 SHL  6 ; AVX-512 Vector Bit Manipulation Instructions 2
CPU_BFE0_ECX_CET_SS             EQU 1 SHL  7 ; Control Flow Enforcement (CET) Shadow Stack
CPU_BFE0_ECX_GFNI               EQU 1 SHL  8 ; Galois Field Instructions
CPU_BFE0_ECX_VAES               EQU 1 SHL  9 ; Vector AES Instruction Set (VEX-256/EVEX)
CPU_BFE0_ECX_VPCLMULQDQ         EQU 1 SHL 10 ; CLMUL Instruction Set (VEX-256/EVEX)
CPU_BFE0_ECX_AVX512_VNNI        EQU 1 SHL 11 ; AVX-512 Vector Neural Network Instructions
CPU_BFE0_ECX_AVX512_BITALG      EQU 1 SHL 12 ; AVX-512 BITALG Instructions
CPU_BFE0_ECX_TME_EN             EQU 1 SHL 13 ; Total Memory Encryption MSRs available
CPU_BFE0_ECX_AVX512_VPOPCNT     EQU 1 SHL 14 ; AVX-512 Vector Population Count Double and Quad-word
CPU_BFE0_ECX_FZM                EQU 1 SHL 15 ; FZM Reserved
CPU_BFE0_ECX_LA57               EQU 1 SHL 16 ; Supports 57-bit linear addresses and five-level paging
CPU_BFE0_ECX_MAWAU              EQU 1 SHL 17 ; MPX Address-Width Adjust Userspace
CPU_BFE0_ECX_MAWAU1             EQU 1 SHL 18 ; MPX Address-Width Adjust Userspac
CPU_BFE0_ECX_MAWAU2             EQU 1 SHL 19 ; MPX Address-Width Adjust Userspac
CPU_BFE0_ECX_MAWAU3             EQU 1 SHL 20 ; MPX Address-Width Adjust Userspac
CPU_BFE0_ECX_MAWAU4             EQU 1 SHL 21 ; MPX Address-Width Adjust Userspac
CPU_BFE0_ECX_RDPID              EQU 1 SHL 22 ; RDPID (Read Processor ID) Instruction
CPU_BFE0_ECX_KL                 EQU 1 SHL 23 ; AES Key Locker
CPU_BFE0_ECX_BUS_LOCK_DETEC     EQU 1 SHL 24 ; Bus Lock Detection
CPU_BFE0_ECX_CLDEMOTE           EQU 1 SHL 25 ; CLDEMOTE (Cache line demote) Instruction
CPU_BFE0_ECX_MPRR               EQU 1 SHL 26 ; MPRR Reserved
CPU_BFE0_ECX_MOVDIRI            EQU 1 SHL 27 ; MOVDIRI instruction
CPU_BFE0_ECX_MOVDIR64B          EQU 1 SHL 28 ; MOVDIR64B (64-byte direct store) Instruction
CPU_BFE0_ECX_EMQCMD             EQU 1 SHL 29 ; Enqueue Stores and EMQCMD/EMQCMDS Instructions
CPU_BFE0_ECX_SGXLC              EQU 1 SHL 30 ; SGX Launch Configuration 
CPU_BFE0_ECX_PKS                EQU 1 SHL 31 ; Protection Keys for Supervisor-mode pages 
CPU_BFE0_ECX_SIMD               EQU CPU_BFE0_ECX_AVX512_VBMI or CPU_BFE0_ECX_AVX512_VBMI2 or CPU_BFE0_ECX_AVX512_VNNI or CPU_BFE0_ECX_AVX512_BITALG or CPU_BFE0_ECX_AVX512_VPOPCNT
CPU_BFE0_ECX_JUSTAVX            EQU CPU_BFE0_ECX_SIMD

; CPU Basic Features Extended 0 EDX Flags:
CPU_BFE0_EDX_ALL                EQU -1
CPU_BFE0_EDX_NONE               EQU 0
CPU_BFE0_EDX_SGXTEM             EQU 1 SHL  0 ; SGX-TEM Reserved
CPU_BFE0_EDX_SGXKEYS            EQU 1 SHL  1 ; Attestation Services for Intel SGX
CPU_BFE0_EDX_AVX512_4VNNIW      EQU 1 SHL  2 ; AVX-512 4-register Neural Network Instructions
CPU_BFE0_EDX_AVX512_4FMAPS      EQU 1 SHL  3 ; AVX-512 4-register Multiply Accumulation Single precision
CPU_BFE0_EDX_FSRM               EQU 1 SHL  4 ; Fast Short REP MOV
CPU_BFE0_EDX_UINTR              EQU 1 SHL  5 ; User Inter-processor Interrupts
CPU_BFE0_EDX_RESERVED1          EQU 1 SHL  6 ; Reserved
CPU_BFE0_EDX_RESERVED2          EQU 1 SHL  7 ; Reserved
CPU_BFE0_EDX_AVX512_VP2INTERSECT EQU 1 SHL  8 ; AVX-512 vector intersection instructions on 32/64-bit integers
CPU_BFE0_EDX_SRBDS_CTRL         EQU 1 SHL  9 ; Special Register Buffer Data Sampling Mitigations 
CPU_BFE0_EDX_MD_CLEAR           EQU 1 SHL 10 ; VERW instruction clears CPU buffers
CPU_BFE0_EDX_RTM_ALWAYS_ABORT   EQU 1 SHL 11 ; All TSX Ttransactions Are Aborted
CPU_BFE0_EDX_RESERVED3          EQU 1 SHL 12 ; Reserved
CPU_BFE0_EDX_RTM_FORCE_ABORT    EQU 1 SHL 13 ; TSX_FORCE_ABORT MSR
CPU_BFE0_EDX_SERIALIZE          EQU 1 SHL 14 ; SERIALIZE instruction
CPU_BFE0_EDX_Hybrid             EQU 1 SHL 15 ; Mixture of CPU types in processor topology
CPU_BFE0_EDX_TSXLDTRK           EQU 1 SHL 16 ; TSX Load Address Tracking Suspend/Resume Instructions
CPU_BFE0_EDX_RESERVED4          EQU 1 SHL 17 ; Reserved
CPU_BFE0_EDX_PCONFIG            EQU 1 SHL 18 ; Platform Configuration (Memory Encryption Technologies Instructions)
CPU_BFE0_EDX_LBR                EQU 1 SHL 19 ; Architectural Last Branch Records
CPU_BFE0_EDX_CET_IBT            EQU 1 SHL 20 ; Control Flow Enforcement (CET): Indirect Bbranch Tracking
CPU_BFE0_EDX_RESERVED5          EQU 1 SHL 21 ; Reserved
CPU_BFE0_EDX_AMXBF16            EQU 1 SHL 22 ; Advanced Matrix Extensions (AMX) Tile Computation on bfloat16 Numbers
CPU_BFE0_EDX_AVX512_FP16        EQU 1 SHL 23 ; AVX-512 Half-precision Floating-Point Arithmetic Instructions
CPU_BFE0_EDX_AMXTILE            EQU 1 SHL 24 ; Advanced Matrix Extensions (AMX) Tile Load/Store Instructions
CPU_BFE0_EDX_AMXINT8            EQU 1 SHL 25 ; Advanced Matrix Extensions (AMX) Tile Computation on 8-bit Integers
CPU_BFE0_EDX_IBRS               EQU 1 SHL 26 ; Indirect Branch Restricted Speculation (IBRS)
CPU_BFE0_EDX_STIBP              EQU 1 SHL 27 ; Single Thread Indirect Branch Predictor
CPU_BFE0_EDX_L1D_FLUSH          EQU 1 SHL 28 ; IA32_FLUSH_CMD MSR
CPU_BFE0_EDX_IA32_ARCH_CAPABILITIES EQU 1 SHL 29 ; IA32_ARCH_CAPABILITIES MSR
CPU_BFE0_EDX_IA32_CORE_CAPABILITIES EQU 1 SHL 30 ; "IA32_CORE_CAPABILITIES MSR
CPU_BFE0_EDX_SSBD               EQU 1 SHL 31 ; Speculative Store Bypass Disable
CPU_BFE0_EDX_JUSTAVX            EQU CPU_BFE0_EDX_AVX512_4VNNIW or CPU_BFE0_EDX_AVX512_4FMAPS or CPU_BFE0_EDX_AVX512_VP2INTERSECT or CPU_BFE0_EDX_AVX512_FP16

; CPU Basic Features Extended 1 EAX Flags:
CPU_BFE1_EAX_ALL                EQU -1
CPU_BFE1_EAX_NONE               EQU 0
CPU_BFE1_EAX_SHA512             EQU 1 SHL  0 ; SHA-512 Extensions
CPU_BFE1_EAX_SM3                EQU 1 SHL  1 ; ShangMi 3 (SM3) Hash Extensions
CPU_BFE1_EAX_SM4                EQU 1 SHL  2 ; ShangMì 4 (SM4) Cipher Extensions
CPU_BFE1_EAX_RAOINT             EQU 1 SHL  3 ; Remote Atomic Operations on Integers
CPU_BFE1_EAX_AVXVNNI            EQU 1 SHL  4 ; AVX Vector Neural Network Instructions
CPU_BFE1_EAX_AVX512_BF16        EQU 1 SHL  5 ; AVX-512 Instructions for bfloat16 Numbers
CPU_BFE1_EAX_LASS               EQU 1 SHL  6 ; Linear Address Space Separation
CPU_BFE1_EAX_CMPCCXADD          EQU 1 SHL  7 ; CMPccXADD Instructions
CPU_BFE1_EAX_ARCHPERFMONEXT     EQU 1 SHL  8 ; Architectural Performance Monitoring Extended Leaf
CPU_BFE1_EAX_DEDUP              EQU 1 SHL  9 ; dedup
CPU_BFE1_EAX_FZRM               EQU 1 SHL 10 ; Fast Zero-length REP MOVSB
CPU_BFE1_EAX_FSRS               EQU 1 SHL 11 ; Fast Short REP STOSB
CPU_BFE1_EAX_FSRCS              EQU 1 SHL 12 ; Fast Short REP CMPSB and REP SCASB
CPU_BFE1_EAX_RESERVED1          EQU 1 SHL 13 ; Reserved
CPU_BFE1_EAX_RESERVED2          EQU 1 SHL 14 ; Reserved
CPU_BFE1_EAX_RESERVED3          EQU 1 SHL 15 ; Reserved
CPU_BFE1_EAX_RESERVED4          EQU 1 SHL 16 ; Reserved
CPU_BFE1_EAX_FRED               EQU 1 SHL 17 ; Flexible Return and Event Delivery
CPU_BFE1_EAX_LKGS               EQU 1 SHL 18 ; LKGS Instruction
CPU_BFE1_EAX_WRMSRNS            EQU 1 SHL 19 ; WRMSRNS Instruction
CPU_BFE1_EAX_NMI_SRC            EQU 1 SHL 20 ; NMI Source Reporting
CPU_BFE1_EAX_AMXFP16            EQU 1 SHL 21 ; AMX Instructions for FP16 Numbers
CPU_BFE1_EAX_HRESET             EQU 1 SHL 22 ; HRESET Instruction
CPU_BFE1_EAX_AVXIFMA            EQU 1 SHL 23 ; AVX IFMA Instructions
CPU_BFE1_EAX_RESERVED5          EQU 1 SHL 24 ; Reserved
CPU_BFE1_EAX_RESERVED6          EQU 1 SHL 25 ; Reserved
CPU_BFE1_EAX_LAM                EQU 1 SHL 26 ; Linear Address Masking
CPU_BFE1_EAX_MSRLIST            EQU 1 SHL 27 ; RDMSRLIST and WRMSRLIST Instructions
CPU_BFE1_EAX_RESERVED7          EQU 1 SHL 28 ; Reserved
CPU_BFE1_EAX_RESERVED8          EQU 1 SHL 29 ; Reserved
CPU_BFE1_EAX_INVD               EQU 1 SHL 30 ; INVD Instruction Execution Prevention after BIOS Done
CPU_BFE1_EAX_RESERVED9          EQU 1 SHL 31 ; Reserved
CPU_BFE1_EAX_JUSTAVX            EQU CPU_BFE1_EAX_AVXVNNI or CPU_BFE1_EAX_AVX512_BF16 or CPU_BFE1_EAX_AVXIFMA
CPU_BFE1_EAX_COMMON             EQU CPU_BFE1_EAX_SHA512

; CPU Basic Features Extended 1 EBX Flags:
CPU_BFE1_EBX_ALL                EQU -1
CPU_BFE1_EBX_NONE               EQU 0
CPU_BFE1_EBX_IPPIN              EQU 1 SHL  0 ; Intel PPIN (Protected Processor Inventory Number)
CPU_BFE1_EBX_PBNDKB             EQU 1 SHL  1 ; Total Storage Encryption: PBNDKB Instruction

; CPU Basic Features Extended 1 ECX Flags:
CPU_BFE1_ECX_ALL                EQU -1
CPU_BFE1_ECX_NONE               EQU 0
CPU_BFE1_ECX_LEGACY_REDUCED_ISA EQU 1 SHL  2 ; Legacy Reduced ISA X86S
CPU_BFE1_ECX_SIPI64             EQU 1 SHL  4 ; 64-bit SIPI

; CPU Basic Features Extended 1 EDX Flags:
CPU_BFE1_EDX_ALL                EQU -1
CPU_BFE1_EDX_NONE               EQU 0
CPU_BFE1_EDX_AVX_VNNI_INT8      EQU 1 SHL  4 ; AVX VNNI INT8 Instructions
CPU_BFE1_EDX_AVX_NE_CONVERT     EQU 1 SHL  5 ; AVX No-exception FP Conversion Instructions
CPU_BFE1_EDX_AMX_COMPLEX        EQU 1 SHL  8 ; AMX Support for complex tiles (TCMMIMFP16PS and TCMMRLFP16PS)
CPU_BFE1_EDX_AVX_VNNI_INT16     EQU 1 SHL 10 ; AVX VNNI INT16 Instructions
CPU_BFE1_EDX_UTMR               EQU 1 SHL 13 ; User-timer Events
CPU_BFE1_EDX_PREFETCHI          EQU 1 SHL 14 ; Instruction-cache Prefetch Instructions (PREFETCHIT0 and PREFETCHIT1)
CPU_BFE1_EDX_USER_MSR           EQU 1 SHL 15 ; User-mode MSR Access Instructions (URDMSR and UWRMSR) 
CPU_BFE1_EDX_UIRETUIF_FROMFLAGS EQU 1 SHL 17 ; UIRET (User Interrupt Return) Instruction
CPU_BFE1_EDX_CET_SSS            EQU 1 SHL 18 ; Control-Flow Enforcement (CET) Supervisor Shadow Stacks (SSS)
CPU_BFE1_EDX_AVX10              EQU 1 SHL 19 ; AVX10 Converged Vector ISA
CPU_BFE1_EDX_APX_F              EQU 1 SHL 21 ; Advanced Performance Extensions, Foundation
CPU_BFE1_EDX_MWAIT              EQU 1 SHL 23 ; MWAIT Instruction
CPU_BFE1_EDX_JUSTAVX            EQU CPU_BFE1_EDX_AVX_VNNI_INT8 or CPU_BFE1_EDX_AVX_NE_CONVERT or CPU_BFE1_EDX_AVX_VNNI_INT16 or CPU_BFE1_EDX_AVX10

; CPU Basic Features Extended 2 EDX Flags:
CPU_BFE2_EDX_ALL                EQU -1
CPU_BFE2_EDX_NONE               EQU 0
CPU_BFE2_EDX_PSFD               EQU 1 SHL  0 ; Fast Store Forwarding Predictor
CPU_BFE2_EDX_PRED_CTRL          EQU 1 SHL  1 ; IPRED_DIS controls supported"> 
CPU_BFE2_EDX_RRSBA_CTRL         EQU 1 SHL  2 ; RRSBA behavior disable supported
CPU_BFE2_EDX_DDPD_U             EQU 1 SHL  3 ; Data Dependent Prefetcher disable supported
CPU_BFE2_EDX_BHI_CTRL           EQU 1 SHL  4 ; BHI_DIS_S behavior enable supported
CPU_BFE2_EDX_MCDT_NO            EQU 1 SHL  5 ; No MXCSR configuration dependent timing
CPU_BFE2_EDX_UC_LOCK_CTRL       EQU 1 SHL  6 ; UC-lock disable feature supported
CPU_BFE2_EDX_MONITOR_MITG_NO    EQU 1 SHL  7 ; MONITOR/UMONITOR instructions are not affected by performance/power issues

; CPU Extended Features EDX Flags:
CPU_EF_EDX_ALL                  EQU -1
CPU_EF_EDX_NONE                 EQU 0
CPU_EF_EDX_FPU                  EQU 1 SHL  0 ; Floating-Point Unit On-Chip
CPU_EF_EDX_VME                  EQU 1 SHL  1 ; Virtual 8086 Mode Enhancements
CPU_EF_EDX_DE                   EQU 1 SHL  2 ; Debugging Extensions
CPU_EF_EDX_PSE                  EQU 1 SHL  3 ; Page Size Extension
CPU_EF_EDX_TSC                  EQU 1 SHL  4 ; Time Stamp Counter
CPU_EF_EDX_MSR                  EQU 1 SHL  5 ; Model Specific Registers RDMSR and WRMSR Instructions
CPU_EF_EDX_PAE                  EQU 1 SHL  6 ; Physical Address Extension
CPU_EF_EDX_MCE                  EQU 1 SHL  7 ; Machine Check Exception
CPU_EF_EDX_CX8                  EQU 1 SHL  8 ; CMPXCHG8B Instruction
CPU_EF_EDX_APIC                 EQU 1 SHL  9 ; Advanced Programmable Interrupt Controller
CPU_EF_EDX_SYSAMD               EQU 1 SHL 10 ; SYSCALL and SYSRET Instructions ; K6 only
CPU_EF_EDX_SYSCALL              EQU 1 SHL 11 ; SYSCALL and SYSRET Instructions
CPU_EF_EDX_MTRR                 EQU 1 SHL 12 ; Memory Type Range Registers
CPU_EF_EDX_PGE                  EQU 1 SHL 13 ; Page Global Enable
CPU_EF_EDX_MCA                  EQU 1 SHL 14 ; Machine Check Architecture
CPU_EF_EDX_CMOV                 EQU 1 SHL 15 ; Conditional Move Instructions
CPU_EF_EDX_PAT                  EQU 1 SHL 16 ; Page Attribute Table
CPU_EF_EDX_PSE36                EQU 1 SHL 17 ; 36-Bit Page Size Extension
CPU_EF_EDX_RESERVED1            EQU 1 SHL 18 ; Reserved
CPU_EF_EDX_ECC                  EQU 1 SHL 19 ; AuthenticAMD Family 6 CPU Brand Identification
CPU_EF_EDX_NX                   EQU 1 SHL 20 ; No-execute (NX)
CPU_EF_EDX_RESERVED2            EQU 1 SHL 21 ; Reserved
CPU_EF_EDX_MMXEXT               EQU 1 SHL 22 ; Extended MMX
CPU_EF_EDX_MMX                  EQU 1 SHL 23 ; Intel MMX Technology
CPU_EF_EDX_FXSR                 EQU 1 SHL 24 ; FXSAVE and FXRSTOR Instructions
CPU_EF_EDX_FXSR_OPT             EQU 1 SHL 25 ; FXSAVE/FXRSTOR Optimizations
CPU_EF_EDX_PDPE1GB              EQU 1 SHL 26 ; Gigabyte pages 
CPU_EF_EDX_RDTSCP               EQU 1 SHL 27 ; RDTSCP instruction
CPU_EF_EDX_RESERVED3            EQU 1 SHL 28 ; Reserved
CPU_EF_EDX_X86_64               EQU 1 SHL 29 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_LM                   EQU CPU_EF_EDX_X86_64 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_LONGMODE             EQU CPU_EF_EDX_X86_64 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_INTEL64              EQU CPU_EF_EDX_X86_64 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_AMD64                EQU CPU_EF_EDX_X86_64 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_X64                  EQU CPU_EF_EDX_X86_64 ; 64bit CPU: Intel64 on Intel CPU, Long Mode on AMD CPU
CPU_EF_EDX_3DNOWEXT             EQU 1 SHL 30 ; Extended 3DNow!
CPU_EF_EDX_3DNOW                EQU 1 SHL 31 ; 3DNow!

; CPU Extended Features ECX Flags:
CPU_EF_ECX_ALL                  EQU -1
CPU_EF_ECX_NONE                 EQU 0
CPU_EF_ECX_LAHF_LM              EQU 1 SHL  0 ; LAHF/SAHF in long mode
CPU_EF_ECX_CMP_LEGACY           EQU 1 SHL  1 ; Hyperthreading not valid 
CPU_EF_ECX_SVM                  EQU 1 SHL  2 ; Secure Virtual Machine
CPU_EF_ECX_EXTAPIC              EQU 1 SHL  3 ; Extended APIC space 
CPU_EF_ECX_CR8_LEGACY           EQU 1 SHL  4 ; CR8 in 32-bit mode 
CPU_EF_ECX_ABM_LZCNT            EQU 1 SHL  5 ; Advanced bit manipulation (LZCNT and POPCNT) 
CPU_EF_ECX_SSE4A                EQU 1 SHL  6 ; Streaming SIMD Extensions 4a (SSE4a)
CPU_EF_ECX_MISALIGNSSE          EQU 1 SHL  7 ; Misaligned SSE mode 
CPU_EF_ECX_3DNOWPREFETCH        EQU 1 SHL  8 ; "PREFETCH and PREFETCHW instructions 
CPU_EF_ECX_OSVW                 EQU 1 SHL  9 ; OS Visible Workaround
CPU_EF_ECX_IBS                  EQU 1 SHL 10 ; Instruction Based Sampling
CPU_EF_ECX_XOP                  EQU 1 SHL 11 ; XOP instruction set
CPU_EF_ECX_SKINIT               EQU 1 SHL 12 ; SKINIT/STGI instructions 
CPU_EF_ECX_WDT                  EQU 1 SHL 13 ; Watchdog timer
CPU_EF_ECX_RESERVED1            EQU 1 SHL 14 ; Reserved
CPU_EF_ECX_LWP                  EQU 1 SHL 15 ; Light Weight Profiling
CPU_EF_ECX_FMA4                 EQU 1 SHL 16 ; 4-operand fused multiply-add instructions
CPU_EF_ECX_TCE                  EQU 1 SHL 17 ; Translation Cache Extension 
CPU_EF_ECX_RESERVED2            EQU 1 SHL 18 ; Reserved
CPU_EF_ECX_NODEID_MSR           EQU 1 SHL 19 ; NodeID MSR
CPU_EF_ECX_RESERVED3            EQU 1 SHL 20 ; Reserved
CPU_EF_ECX_TBM                  EQU 1 SHL 21 ; Trailing Bit Manipulation
CPU_EF_ECX_TOPOEXT              EQU 1 SHL 22 ; Topology Extensions 
CPU_EF_ECX_PERFCTR_CORE         EQU 1 SHL 23 ; Core performance counter extensions 
CPU_EF_ECX_PERFCTR_NB           EQU 1 SHL 24 ; Northbridge performance counter extensions 
CPU_EF_ECX_STREAMPERFMO         EQU 1 SHL 25 ; Streaming performance monitor architecture
CPU_EF_ECX_DBX                  EQU 1 SHL 26 ; Data breakpoint extensions 
CPU_EF_ECX_PERFTSC              EQU 1 SHL 27 ; Performance timestamp counter (PTSC)
CPU_EF_ECX_PCX_L2I              EQU 1 SHL 28 ; L2I perf counter extensions 
CPU_EF_ECX_MONITORX             EQU 1 SHL 29 ; MONITORX and MWAITX instructions
CPU_EF_ECX_ADDR_MASK_EXT        EQU 1 SHL 30 ; Address mask extension to 32 bits for instruction breakpoints
CPU_EF_ECX_RESERVED4            EQU 1 SHL 31 ; Reserved




