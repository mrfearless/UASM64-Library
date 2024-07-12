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
; are ncluded with the MASM32 SDK (www.masm32.com)
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
; UASM64 Library is targetted specifically for use with projects that use the 
; UASM assembler x64 (http://www.terraspace.co.uk/uasm.html), but likely other 
; compilers and assemblers can utilize it as well.
;
; All credit and thanks to all the original authors and code contributors of 
; the functions in the MASM32 Library.
;
; The UASM64 library and source code are free to use for anyone, and anyone can 
; contribute to the UASM64 Library project.

;==============================================================================

UASM64_ALIGN            TEXTEQU <ALIGN 16>

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

; String Functions:
String_Append           PROTO lpszDestination:QWORD, lpszSource:QWORD, qwDestinationOffset:QWORD
String_CatStr           PROTO lpszDestination:QWORD, lpszSource:QWORD
String_Compare          PROTO lpszString1:QWORD, lpszString2:QWORD
String_CompareI         PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD
String_CompareIEx       PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD, qwLengthString:QWORD
String_Copy             PROTO lpszSource:QWORD, lpszDestination:QWORD
String_Count            PROTO lpszSource:QWORD, lpszSubString:QWORD
String_InString         PROTO qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD 
String_Left             PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_LeftTrim         PROTO lpszSource:QWORD, lpszDestination:QWORD
String_Length           PROTO lpszString:QWORD
String_Lowercase        PROTO lpszString:QWORD
String_Middle           PROTO lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD
String_MonoSpace        PROTO lpszSource:QWORD
String_MultiCat         PROTO qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG
String_Remove           PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD
String_Replace          PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD
String_Reverse          PROTO lpszSource:QWORD, lpszDestination:QWORD
String_Right            PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD
String_RightTrim        PROTO lpszSource:QWORD, lpszDestination:QWORD
String_Trim             PROTO lpszString:QWORD
String_Uppercase        PROTO lpszString:QWORD
String_WordReplace      PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszWordToReplace:QWORD, lpszReplacementWord:QWORD

; Path, File And Folder Functions:
File_Exists             PROTO lpszFilename:QWORD
File_Size               PROTO lpszFilename:QWORD
File_ReadFileToMemory   PROTO lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD
File_WriteMemoryToFile  PROTO lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD

Path_GetAppPath         PROTO lpszPath:QWORD
Path_GetPathOnly        PROTO lpszFullFilenamePath:QWORD, lpszPath:QWORD
Path_NameFromPath       PROTO lpszFullFilenamePath:QWORD, lpszFilename:QWORD

; Argument Parsing Functions:
Arg_GetArgument         PROTO lpszArgumentList:QWORD, lpszDestination:QWORD, nArgument:QWORD, qwArgumentListReadOffset:QWORD
Arg_GetCommandLine      PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD
Arg_GetCommandLineEx    PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD

; Numeric And Text Conversions
qw2hex                  PROTO :QWORD, :QWORD     ; Convert_QWORDToStringHex
dw2hex                  PROTO :DWORD, :QWORD     ; Convert_DWORDToStringHex2
dwtoa                   PROTO :DWORD, :QWORD     ; Convert_DWORDToStringDec
qwtoa                   PROTO :QWORD, :QWORD     ; Convert_QWORDToStringDec
a2qw                    PROTO :QWORD             ; Convert_StringDecToQWORD
atoqw                   PROTO :QWORD             ; Convert_StringDecToSQWORD
ltoa                    PROTO :DWORD, :QWORD     ; Convert_SDWORDToStringDec
htodw                   PROTO :QWORD             ; Convert_StringHexToDWORD
htoqw                   PROTO :QWORD             ; Convert_StringHexToQWORD

; Random
nrandom                 PROTO base:QWORD
nseed                   PROTO TheSeed:QWORD

;------------------------------------------------------------------------------
; MASM32 library function names to UASM64 library function names:
;------------------------------------------------------------------------------
; MASM32 Function Name   =   UASM64 Function Name
;---------------------  ---  --------------------------------------------------
szappend                EQU <String_Append>
szCatStr                EQU <String_CatStr>
szCmp                   EQU <String_Compare>
Cmpi                    EQU <String_CompareI>
szCmpi                  EQU <String_CompareIEx>
szCopy                  EQU <String_Copy>
szWcnt                  EQU <String_Count>
InString                EQU <String_InString>
szLeft                  EQU <String_Left>
szLtrim                 EQU <String_LeftTrim>
szLen                   EQU <String_Length>
szLower                 EQU <String_Lowercase>
szMid                   EQU <String_Middle>
szMonoSpace             EQU <String_MonoSpace>
szMultiCat              EQU <String_MultiCat>
szRemove                EQU <String_Remove>
szRep                   EQU <String_Replace>
szRev                   EQU <String_Reverse>
szRight                 EQU <String_Right>
szRtrim                 EQU <String_RightTrim>
szTrim                  EQU <String_Trim>
szUpper                 EQU <String_Uppercase>
wordreplace             EQU <String_WordReplace>
szStrLen                EQU <String_Length>

exist                   EQU <File_Exists>
filesize                EQU <File_Size>
read_disk_file          EQU <File_ReadFileToMemory>
write_disk_file         EQU <File_WriteMemoryToFile>

GetAppPath              EQU <Path_GetAppPath>
GetPathOnly             EQU <Path_GetPathOnly>
NameFromPath            EQU <Path_NameFromPath>

ArgByNumber             EQU <Arg_GetArgument>
getcl                   EQU <Arg_GetCommandLine>
getcl_ex                EQU <Arg_GetCommandLineEx>

;atodw                   EQU <Convert_StringDecToDWORD>
;htodw                   EQU <Convert_StringHexToDWORD>
;dwtoa                   EQU <Convert_DWORDToStringDec>
;dw2ah                   EQU <Convert_DWORDToStringHex>
;dw2hex                  EQU <Convert_DWORDToStringHex2>
;udw2str                 EQU <Convert_DWORDToString>
;ustr2dw                 EQU <Convert_StringToDWORD>
;ltoa                    EQU <Convert_SDWORDToStringDec>
;atol 	                 EQU <Convert_StringDecToSDWORD>












