;==============================================================================
;
; UASM64 Library Test (Windows GUI)
;
; fearless - https://github.com/mrfearless/UASM64-Library
;
;==============================================================================
include windows.inc
include CommCtrl.inc
include shellapi.inc

includelib user32.lib
includelib kernel32.lib
includelib gdi32.lib
includelib comctl32.lib
includelib shell32.lib

include UASM64.inc
includelib UASM64.lib

;------------------------------------------------------------------------------
; WinUASM64LibTest Prototypes
;------------------------------------------------------------------------------
InitGUI                 PROTO hWin:QWORD

DoUASM64LibraryTests    PROTO hWin:QWORD

EditShowFunctionName    PROTO hEdit:QWORD, lpszFunctionName:QWORD
EditShowResult          PROTO hEdit:QWORD, lpszResultString:QWORD
EditShowResultMsg       PROTO hEdit:QWORD, lpszResultString:QWORD, lpszMsg:QWORD, bCRLF:QWORD
EditShowString          PROTO hEdit:QWORD, lpszStringToShow:QWORD
EditShowResultString    PROTO hEdit:QWORD, lpszResultString:QWORD

EditClearText           PROTO hEdit:QWORD
EditAppendText          PROTO hEdit:QWORD, lpszMessage:QWORD



.CONST
;------------------------------------------------------------------------------
; WinUASM64LibTest Constants
;------------------------------------------------------------------------------
; Main Dialog
IDD_DIALOG			    EQU 1000
IDC_EdtTests		    EQU 1001
IDC_SBR1			    EQU 1002
IDC_LblTests		    EQU 1003
IDC_BtnExit			    EQU 1004

; Main Menu 
IDM_MENU				EQU 10000
IDM_FILE_EXIT			EQU 10001
IDM_HELP_ABOUT			EQU 10101



.DATA

EXTERNDEF Alloc_pIMalloc:QWORD

;------------------------------------------------------------------------------
; WinUASM64LibTest Initialized Data
;------------------------------------------------------------------------------
align 01
szClass					DB 'Win64class', 0
szAppName				DB 'UASM64 Library Tests', 0

ClassName				DB 'DLGCLASS',0
AppName					DB 'UASM64 Library Tests',0
AboutMsg				DB 'https://github.com/mrfearless/UASM64-Library',0
szCourierNewFont        DB "Courier New",0

; Function Section
szSectionCpuFunctions           DB 13,10,'[*] CPU Functions',13,10,13,10,0
szSectionStringFunctions        DB 13,10,'[*] String Functions',13,10,13,10,0
szSectionPathFunctions          DB 13,10,'[*] File & Path Functions',13,10,13,10,0
szSectionArgFunctions           DB 13,10,'[*] Argument Parsing Functions',13,10,13,10,0
szSectionConversionFunctions    DB 13,10,'[*] Conversion Functions',13,10,13,10,0
szSectionArrayFunctions         DB 13,10,'[*] Array Functions',13,10,13,10,0
szSectionFileFunctions          DB 13,10,'[*] File And Path Functions',13,10,13,10,0
szSectionMemoryFunctions        DB 13,10,'[*] Memory Functions',13,10,13,10,0
szSectionTextFunctions          DB 13,10,'[*] Text Functions',13,10,13,10,0

; Function Names
szCPUIDSupported        DB 'CPU_CPUID_Supported',0
szCPUMMXSupported       DB 'CPU_MMX_Supported',0
szCPUSSESupported       DB 'CPU_SSE_Supported',0
szCPUSSE2Supported      DB 'CPU_SSE2_Supported',0
szCPUSSE3Supported      DB 'CPU_SSE3_Supported',0
szCPUSSSE3Supported     DB 'CPU_SSSE3_Supported',0
szCPUSSE41Supported     DB 'CPU_SSE41_Supported',0
szCPUSSE42Supported     DB 'CPU_SSE42_Supported',0
szCPUAESNISupported     DB 'CPU_AESNI_Supported',0
szCPUAVXSupported       DB 'CPU_AVX_Supported',0
szCPUAVX2Supported      DB 'CPU_AVX2_Supported',0
szCPURDRANDSupported    DB 'CPU_RDRAND_Supported',0
szCPURDSEEDSupported    DB 'CPU_RDSEED_Supported',0
szHTTSupported          DB 'CPU_HTT_Supported',0
szLogicalCores          DB 'CPU_Logical_Cores',0
szCPUBrand              DB 'CPU_Brand',0
szCPUManufacturer       DB 'CPU_Manufacturer',0
szCPUManufacturerID     DB 'CPU_ManufacturerID',0
szCPUHighestBasic       DB 'CPU_Highest_Basic',0
szCPUHighestBasicExt    DB 'CPU_Highest_Basic_Ext',0
szCPUHighestExtended    DB 'CPU_Highest_Extended',0
szCPUBasicFeatures      DB 'CPU_Basic_Features',0
szCPUBasicFeaturesExt0  DB 'CPU_Basic_Features_Ext0',0
szCPUBasicFeaturesExt1  DB 'CPU_Basic_Features_Ext1',0
szCPUBasicFeaturesExt2  DB 'CPU_Basic_Features_Ext2',0
szCPUExtendedFeatures   DB 'CPU_Extended_Features',0
szCPUSignature          DB 'CPU_Signature',0

szStringAppend          DB 'String_Append',0
szStringConcat          DB 'String_Concat',0
szStringCompare         DB 'String_Compare',0
szStringCompareI        DB 'String_CompareI',0
szStringCompareIEx      DB 'String_CompareIEx',0
szStringCopy            DB 'String_Copy',0
szStringCount           DB 'String_Count',0
szStringInString        DB 'String_InString',0
szStringLeft            DB 'String_Left',0
szStringLeftTrim        DB 'String_LeftTrim',0
szStringLength          DB 'String_Length',0
szStringLowercase       DB 'String_Lowercase',0
szStringMiddle          DB 'String_Middle',0
szStringMonoSpace       DB 'String_MonoSpace',0
szStringMultiCat        DB 'String_MultiCat',0
szStringRemove          DB 'String_Remove',0
szStringReplace         DB 'String_Replace',0
szStringReverse         DB 'String_Reverse',0
szStringRight           DB 'String_Right',0
szStringRightTrim       DB 'String_RightTrim',0
szStringTrim            DB 'String_Trim',0
szStringUppercase       DB 'String_Uppercase',0
szStringWordReplace     DB 'String_WordReplace',0

szMemoryAlloc           DB 'Memory_Alloc',0
szMemoryCompare         DB 'Memory_Compare',0
szMemoryCopy            DB 'Memory_Copy',0
szMemoryFill            DB 'Memory_Fill',0
szMemoryFree            DB 'Memory_Free',0

szTextReadLine          DB 'Text_ReadLine',0
szTextWriteLine         DB 'Text_WriteLine',0
szTextTestLine          DB 'Text_TestLine',0
szTextLineCount         DB 'Text_LineCount',0
szTextLineCountEx       DB 'Text_LineCountEx',0
szTextParseLine         DB 'Text_ParseLine',0

szArrayCreate           DB 'Array_Create',0
szArrayCreateEx         DB 'Array_CreateEx',0
szArrayCount            DB 'Array_Count',0
szArrayDestroy          DB 'Array_Destroy',0
szArrayResize           DB 'Array_Resize',0
szArrayTruncate         DB 'Array_Truncate',0
szArrayExtend           DB 'Array_Extend',0
szArrayItemAddress      DB 'Array_ItemAddress',0
szArrayItemSetText      DB 'Array_ItemSetText',0
szArrayItemSetData      DB 'Array_ItemSetData',0
szArrayItemLength       DB 'Array_ItemLength',0
szArrayLoadItemsFromFile DB 'Array_LoadItemsFromFile',0
szArrayLoadItemsFromMem DB 'Array_LoadItemsFromMem',0
szArraySaveItemsToFile  DB 'Array_SaveItemsToFile',0
szArraySaveItemsToMem   DB 'Array_SaveItemsToMem',0
szArrayTotalItems       DB 'Array_TotalItems',0 
szArrayTotalMemory      DB 'Array_TotalMemory',0
szArrayItemsAddValue    DB 'Array_ItemsAddValue',0
szArrayItemsMulValue    DB 'Array_ItemsMulValue',0
szArrayItemsSubValue    DB 'Array_ItemsSubValue',0

szFileClose             DB 'File_Close',0
szFileCreate            DB 'File_Create',0
szFileExists            DB 'File_Exists',0
szFileMapSharedMemory   DB 'File_MapSharedMemory',0
szFileOpen              DB 'File_Open',0
szFileSize              DB 'File_Size',0
szFileReadFileToMemory  DB 'File_ReadFileToMemory',0
szFileUnmapSharedMemory DB 'File_UnmapSharedMemory',0
szFileWriteMemoryToFile DB 'File_WriteMemoryToFile',0
szPathGetAppPath        DB 'Path_GetAppPath',0
szPathGetPathOnly       DB 'Path_GetPathOnly',0
szPathNameFromPath      DB 'Path_NameFromPath',0



; Function Results
szCPUIDSupportedYes     DB 'CPUID Support: Yes',0
szCPUIDSupportedNo      DB 'CPUID Support: No',0
szMMXSupportedYes       DB 'MMX Support: Yes',0
szMMXSupportedNo        DB 'MMX Support: No',0
szSSESupportedYes       DB 'SSE Support: Yes',0
szSSESupportedNo        DB 'SSE Support: No',0
szSSE2SupportedYes      DB 'SSE2 Support: Yes',0
szSSE2SupportedNo       DB 'SSE2 Support: No',0
szSSE3SupportedYes      DB 'SSE3 Support: Yes',0
szSSE3SupportedNo       DB 'SSE3 Support: No',0
szSSSE3SupportedYes     DB 'SSSE3 Support: Yes',0
szSSSE3SupportedNo      DB 'SSSE3 Support: No',0
szSSE41SupportedYes     DB 'SSE41 Support: Yes',0
szSSE41SupportedNo      DB 'SSE41 Support: No',0
szSSE42SupportedYes     DB 'SSE42 Support: Yes',0
szSSE42SupportedNo      DB 'SSE42 Support: No',0
szAESNISupportedYes     DB 'AES-NI Support: Yes',0
szAESNISupportedNo      DB 'AES-NI Support: No',0
szAVXSupportedYes       DB 'AVX Support: Yes',0
szAVXSupportedNo        DB 'AVX Support: No',0
szAVX2SupportedYes      DB 'AVX2 Support: Yes',0
szAVX2SupportedNo       DB 'AVX2 Support: No',0
szRDRANDSupportedYes    DB 'RDRAND Support: Yes',0
szRDRANDSupportedNo     DB 'RDRAND Support: No',0
szRDSEEDSupportedYes    DB 'RDSEED Support: Yes',0
szRDSEEDSupportedNo     DB 'RDSEED Support: No',0
szHTTSupportedYes       DB 'Hyper-threading Support: Yes',0
szHTTSupportedNo        DB 'Hyper-threading Support: No',0
szLogicalCoresYes       DB 'CPU Logical Cores: ',0
szLogicalCoresNo        DB 'CPU Logical Cores: (0) - Not supported',0
szCPUBrandYes           DB 'CPU Brand: ',0 
szCPUBrandNo            DB 'CPU Brand: No',0
szCPUManufacturerYes    DB 'CPU Manufacturer: ',0 
szCPUManufacturerNo     DB 'CPU Manufacturer: No',0
szHighestBasicYes       DB 'CPU Highest Basic Level: ',0
szHighestBasicNo        DB 'CPU Highest Basic Level: (0) - Not supported',0
szHighestBasicExtYes    DB 'CPU Highest Basic Ext Level: ',0
szHighestBasicExtNo     DB 'CPU Highest Basic Ext Level: (0) - Not supported',0
szHighestExtendedYes    DB 'CPU Highest Extended Level: ',0
szHighestExtendedNo     DB 'CPU Highest Extended Level: (0) - Not supported',0
szBasicFeaturesNo       DB 'CPU Features: No',0
szBasicFeaturesExt0No   DB 'CPU Basic Features Ext0: No',0
szBasicFeaturesExt1No   DB 'CPU Basic Features Ext1: No',0
szBasicFeaturesExt2No   DB 'CPU Basic Features Ext2: No',0
szExtendedFeaturesNo    DB 'CPU Extended Features: No',0
szFamilyID              DB 'Family: ',0
szExtFamilyID           DB 'Ext FamilyID: ',0
szBaseFamilyID          DB 'Base FamilyID: ',0
szModelID               DB 'Model: ',0
szExtModelID            DB 'Ext ModelID: ',0
szBaseModelID           DB 'Base ModelID: ',0
szStepping              DB 'Stepping: ',0
szCPUEAX                DB 'CPU EAX: ',0

szStringLengthNo        DB 'String Length: 0',0
szStringLengthYes       DB 'String Length: ',0
szStringCountING        DB "String Count of 'ing': ",0
szInstringPos           DB "String Position of 'STRing': ",0
szInstringPosNo         DB "String Position: 0 - Not found",0

; Test String Strings
;szTestString            DB '   This is a TEST string, to tset that teh string functions are woking correctly.   ',0 ; 84 bytes long
szTestString            DB '    Test that the STRing functions ARE woking corRECTly.   ',0 ; 58 bytes long
szTestStringUppercase   DB 'TEST THAT THE STRING FUNCTIONS ARE WORKING CORRECTLY',0
szTestStringLowercase   DB 'test that the string functions are working correctly',0
szTestStringReversed    DB 'yltcerroC gnikroW erA snoitcnuF gnirtS ehT tahT tseT',0
szTestWoking            DB 'woking',0
szTestWorking           DB 'working',0
szTestTeh               DB 'teh',0
szTestTset              DB 'tset',0
szTestARE               DB 'ARE',0
szTestCatString1        DB '   test that the string functions',0
szTestCatString2        DB ' are woking correctly.   ',0
szTestCountING          DB 'ing',0
szTestRemoveStuff       DB '    Test that ',0
szTestReplaceStuff      DB ' ARE woking corRECTly.',0
szTestReplaceWith       DB ' are working correctly.',0

szTestReplaceWordStuff  DB 'ARE',0
szTestReplaceWordWith   DB 'are',0

szTestInstringSTRing    DB 'STRing',0

; Memory Results
szMemoryAllocYes        DB 'Memory Allocation: Success',0
szMemoryAllocNo         DB 'Memory Allocation: Failed!',0
szMemoryFreeYes         DB 'Memory Free: Success',0
szMemoryFreeNo          DB 'Memory Free: N/A',0
szpMem1                 DB 'pMem1 First QWORD',0
szpMem2                 DB 'pMem2 First QWORD',0
szpMem                  DB 'pMem',0
szpMem2AfterCopy        DB 'pMem2 First QWORD After Copying From pMem1',0

; Buffers
szSignatureBuffer       DB 256 DUP (0)
szInstringPosBuffer     DB 16 DUP (0)
szTestStringLength      DB 16 DUP (0)
szStringCountBuffer     DB 16 DUP (0)
szLogicalCoreCount      DB 8 DUP (0)
szHighestBasicLevel     DB 16 DUP (0)
szHighestBasicExtLevel  DB 16 DUP (0)
szHighestExtendedLevel  DB 16 DUP (0)
szManufacturerID        DB 16 DUP (0)
szLogicalCoresBuffer    DB 128 DUP (0)
szCPUBrandBuffer        DB 128 DUP (0)
szCPUManufacturerBuffer DB 128 DUP (0)
szHighestBasicBuffer    DB 128 DUP (0)
szHighestBasicExtBuffer DB 128 DUP (0)
szHighestExtendedBuffer DB 128 DUP (0)
szFunctionDisplayBuffer DB 128 DUP (0)
szResultDisplayBuffer   DB 512 DUP (0)
szTestStringBuffer      DB 512 DUP (0)
dwTestStringBuffer      DD 510
szStringBuffer          DB 512 DUP (0)
szNullString            DB 0,0
szFamilyIDBuffer        DB 16 DUP (0)
szExtFamilyIDBuffer     DB 16 DUP (0)
szBaseFamilyIDBuffer    DB 16 DUP (0)
szModelIDBuffer         DB 16 DUP (0)
szExtModelIDBuffer      DB 16 DUP (0)
szBaseModelIDBuffer     DB 16 DUP (0)
szSteppingBuffer        DB 16 DUP (0)
szCPUEAXBuffer          DB 16 DUP (0)

; Misc
szFunction              DB "[i] Function: ",0
szResult                DB "[=] ",0
szString                DB '[','"','] "',0
szStringBegin           DB '"',0
szStringEnd             DB '"',0
szFunctionPadding       DB "    ",0
szResultPadding         DB "    ",0
szSigPadding            DB "        ",0
szColonSpace            DB ": ",0
szCRLF                  DB 13,10,0
sz64bitIntegerFormat    DB '%I64d',0
sz64bitHexFormat        DB '0x%08X',0
sz64bitAsmFormat        DB '%08Xh',0
lpszCPUBrand            DQ 0
lpszCPUManufacturer     DQ 0
dwHighestBasic          DD 0
dwHighestExtended       DD 0
dwMaxBasicExtended      DD 0
qwLogicalCoreCount      DQ 0
qwTestStringLength      DQ 0
qwTestStringCount       DQ 0
qwInstringPos           DQ 0
lpqwFeatures            DQ 0
lpqwFeaturesSize        DQ 0
qwManufacturerID        DQ 0
qwFamilyID              DQ 0 
qwExtFamilyID           DQ 0
qwBaseFamilyID          DQ 0
qwModelID               DQ 0
qwExtModelID            DQ 0
qwBaseModelID           DQ 0
qwStepping              DQ 0
qwCPUEAX                DQ 0
ALIGN 8
pMem                    DQ 0
pMem1                   DQ 0
pMem2                   DQ 0
pIMalloc                DQ 0
qwMemContents1          DQ 0
qwMemContents2          DQ 0

.DATA?
;------------------------------------------------------------------------------
; WinUASM64LibTest Uninitialized Data
;------------------------------------------------------------------------------
align 08
icc 					INITCOMMONCONTROLSEX <>
hInstance				HINSTANCE ?
CommandLine				LPSTR ?
hWnd					HWND ?
hEdtTests               QWORD ?
hCourierNewFont         QWORD ?



