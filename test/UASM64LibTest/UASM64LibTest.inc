;==============================================================================
;
; UASM64 Library Test (Windows GUI)
;
; fearless - https://github.com/mrfearless/UASM64
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
;------------------------------------------------------------------------------
; WinUASM64LibTest Initialized Data
;------------------------------------------------------------------------------
align 01
szClass					DB 'Win64class', 0
szAppName				DB 'UASM64 Library Tests', 0

ClassName				DB 'DLGCLASS',0
AppName					DB 'UASM64 Library Tests',0
AboutMsg				DB 'https://github.com/mrfearless/UASM64',0
szCourierNewFont        DB "Courier New",0

; Function Section
szSectionCpuFunctions           DB 13,10,'[*] CPU Functions',13,10,13,10,0
szSectionStringFunctions        DB 13,10,'[*] String Functions',13,10,13,10,0
szSectionPathFunctions          DB 13,10,'[*] File & Path Functions',13,10,13,10,0
szSectionArgFunctions           DB 13,10,'[*] Argument Parsing Functions',13,10,13,10,0
szSectionConversionFunctions    DB 13,10,'[*] Conversion Functions',13,10,13,10,0

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

szStringAppend          DB 'String_Append',0
szStringCatStr          DB 'String_CatStr',0
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

; Buffers
szInstringPosBuffer     DB 16 DUP (0)
szTestStringLength      DB 16 DUP (0)
szStringCountBuffer     DB 16 DUP (0)
szLogicalCoreCount      DB 8 DUP (0)
szLogicalCoresBuffer    DB 128 DUP (0)
szCPUBrandBuffer        DB 128 DUP (0)
szFunctionDisplayBuffer DB 128 DUP (0)
szResultDisplayBuffer   DB 512 DUP (0)
szTestStringBuffer      DB 512 DUP (0)
dwTestStringBuffer      DD 510
szStringBuffer          DB 512 DUP (0)
szNullString            DB 0,0

; Misc
szFunction              DB "[i] Function: ",0
szResult                DB "[=] ",0
szString                DB '[','"','] "',0
szStringBegin           DB '"',0
szStringEnd             DB '"',0
szFunctionPadding       DB "    ",0
szResultPadding         DB "    ",0
szCRLF                  DB 13,10,0
sz64bitIntegerFormat    DB '%I64d',0
lpszCPUBrand            DQ 0
qwLogicalCoreCount      DQ 0
qwTestStringLength      DQ 0
qwTestStringCount       DQ 0
qwInstringPos           DQ 0


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



