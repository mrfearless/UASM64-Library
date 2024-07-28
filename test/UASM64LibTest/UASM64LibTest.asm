;==============================================================================
;
; UASM64 Library Test (Windows GUI)
;
; fearless - https://github.com/mrfearless/UASM64-Library
;
;==============================================================================
.686
.MMX
.XMM
.x64

option casemap : none
option win64 : 11
option frame : auto
option stackbase : rsp

_WIN64 EQU 1
WINVER equ 0501h

DEBUG64 EQU 1

IFDEF DEBUG64
    PRESERVEXMMREGS equ 1
    includelib \UASM\lib\x64\Debug64.lib
    DBG64LIB equ 1
    DEBUGEXE textequ <'\UASM\bin\DbgWin.exe'>
    include \UASM\include\debug64.inc
    .DATA
    RDBG_DbgWin	DB DEBUGEXE,0
    .CODE
ENDIF

include UASM64LibTest.inc

.CODE

;------------------------------------------------------------------------------
; Startup
;------------------------------------------------------------------------------
WinMainCRTStartup PROC FRAME
	Invoke GetModuleHandle, NULL
	mov hInstance, rax
	Invoke GetCommandLine
	mov CommandLine, rax
	Invoke InitCommonControls
	mov icc.dwSize, sizeof INITCOMMONCONTROLSEX
    mov icc.dwICC, ICC_COOL_CLASSES or ICC_STANDARD_CLASSES or ICC_WIN95_CLASSES
    Invoke InitCommonControlsEx, offset icc
	Invoke WinMain, hInstance, NULL, CommandLine, SW_SHOWDEFAULT
	Invoke ExitProcess, eax
    ret
WinMainCRTStartup ENDP
	

;------------------------------------------------------------------------------
; WinMain
;------------------------------------------------------------------------------
WinMain PROC FRAME hInst:HINSTANCE, hPrev:HINSTANCE, CmdLine:LPSTR, iShow:DWORD
	LOCAL msg:MSG
	LOCAL wcex:WNDCLASSEX
	
	mov wcex.cbSize, sizeof WNDCLASSEX
	mov wcex.style, CS_HREDRAW or CS_VREDRAW
	lea rax, WndProc
	mov wcex.lpfnWndProc, rax
	mov wcex.cbClsExtra, 0
	mov wcex.cbWndExtra, DLGWINDOWEXTRA
	mov rax, hInst
	mov wcex.hInstance, rax
	mov wcex.hbrBackground, COLOR_BTNFACE+1
	mov wcex.lpszMenuName, IDM_MENU ;NULL 
	lea rax, ClassName
	mov wcex.lpszClassName, rax
	Invoke LoadIcon, NULL, IDI_APPLICATION
	;Invoke LoadIcon, hInst, ICO_MAIN ; resource icon for main application icon
	;mov hIcoMain, eax ; main application icon	
	mov wcex.hIcon, rax
	mov wcex.hIconSm, rax
	Invoke LoadCursor, NULL, IDC_ARROW
	mov wcex.hCursor, rax
	Invoke RegisterClassEx, addr wcex
	
	;Invoke CreateWindowEx, 0, addr ClassName, addr szAppName, WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, NULL, NULL, hInstance, NULL
	Invoke CreateDialogParam, hInstance, IDD_DIALOG, 0, Addr WndProc, 0
	mov hWnd, rax
	
	Invoke ShowWindow, hWnd, SW_SHOWNORMAL
	Invoke UpdateWindow, hWnd
	
	.WHILE (TRUE)
		Invoke GetMessage, addr msg, NULL, 0, 0
		.BREAK .IF (!rax)		
		
        Invoke IsDialogMessage, hWnd, addr msg
        .IF rax == 0
            Invoke TranslateMessage, addr msg
            Invoke DispatchMessage, addr msg
        .ENDIF
	.ENDW
	
	mov rax, msg.wParam
	ret	
WinMain ENDP


;------------------------------------------------------------------------------
; WndProc - Main Window Message Loop
;------------------------------------------------------------------------------
WndProc PROC FRAME hWin:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    
    mov eax, uMsg
	.IF eax == WM_INITDIALOG
		; Init Stuff Here
        Invoke InitGUI, hWin
        
		Invoke DoUASM64LibraryTests, hWin
		
	.ELSEIF eax == WM_COMMAND
        mov rax, wParam
		.IF rax == IDM_FILE_EXIT || rax == IDC_BtnExit
			Invoke SendMessage, hWin, WM_CLOSE, 0, 0
			
		.ELSEIF rax == IDM_HELP_ABOUT
			Invoke ShellAbout, hWin, Addr AppName, Addr AboutMsg, NULL
			
		.ENDIF

	.ELSEIF eax == WM_CLOSE
		Invoke DestroyWindow, hWin
		
	.ELSEIF eax == WM_DESTROY
		Invoke PostQuitMessage, NULL
		
	.ELSE
		Invoke DefWindowProc, hWin, uMsg, wParam, lParam ; rcx, edx, r8, r9
		ret
	.ENDIF
	xor rax, rax
	ret
WndProc ENDP

;------------------------------------------------------------------------------
; InitGUI - Initialize GUI stuff
;------------------------------------------------------------------------------
InitGUI PROC FRAME USES RBX hWin:QWORD

    Invoke GetDlgItem, hWin, IDC_EdtTests
    mov hEdtTests, rax
    
    Invoke CreateFont, -14, 0, 0, 0, FW_REGULAR, FALSE, FALSE, FALSE, 0, OUT_TT_PRECIS, 0, PROOF_QUALITY, 0, Addr szCourierNewFont
    mov hCourierNewFont, rax
    Invoke SendMessage, hEdtTests, WM_SETFONT, hCourierNewFont, TRUE
    
    ret
InitGUI ENDP

;------------------------------------------------------------------------------
; DoUASM64LibraryTests - UASM64 Library Tests
;------------------------------------------------------------------------------
DoUASM64LibraryTests PROC FRAME hWin:QWORD
    
    Invoke EditClearText, hEdtTests
    
    ;--------------------------------------------------------------------------
    ; CPU Functions
    ;--------------------------------------------------------------------------
    Invoke EditAppendText, hEdtTests, Addr szSectionCpuFunctions
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUIDSupported
    Invoke CPU_CPUID_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szCPUIDSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szCPUIDSupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUMMXSupported
    Invoke CPU_MMX_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szMMXSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szMMXSupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSESupported
    Invoke CPU_SSE_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSESupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSESupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSE2Supported
    Invoke CPU_SSE2_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSE2SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSE2SupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSE3Supported
    Invoke CPU_SSE3_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSE3SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSE3SupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSSE3Supported
    Invoke CPU_SSSE3_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSSE3SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSSE3SupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSE41Supported
    Invoke CPU_SSE41_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSE41SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSE41SupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSSE42Supported
    Invoke CPU_SSE42_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szSSE42SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szSSE42SupportedNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUAESNISupported
    Invoke CPU_AESNI_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szAESNISupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szAESNISupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUAVXSupported
    Invoke CPU_AVX_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szAVXSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szAVXSupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUAVX2Supported
    Invoke CPU_AVX2_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szAVX2SupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szAVX2SupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPURDRANDSupported
    Invoke CPU_RDRAND_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szRDRANDSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szRDRANDSupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPURDSEEDSupported
    Invoke CPU_RDSEED_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szRDSEEDSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szRDSEEDSupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szHTTSupported
    Invoke CPU_HTT_Supported
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, Addr szHTTSupportedYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szHTTSupportedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szLogicalCores
    Invoke CPU_Logical_Cores
    .IF rax != NULL
        mov qwLogicalCoreCount, rax
        Invoke lstrcpy, Addr szLogicalCoresBuffer, Addr szLogicalCoresYes
        Invoke wsprintf, Addr szLogicalCoreCount, Addr sz64bitIntegerFormat, qwLogicalCoreCount
        Invoke lstrcat, Addr szLogicalCoresBuffer, Addr szLogicalCoreCount
        Invoke EditShowResult, hEdtTests, Addr szLogicalCoresBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szLogicalCoresNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szCPUBrand
    Invoke CPU_Brand
    .IF rax != NULL
        mov lpszCPUBrand, rax
        Invoke lstrcpy, Addr szCPUBrandBuffer, Addr szCPUBrandYes
        Invoke lstrcat, Addr szCPUBrandBuffer, lpszCPUBrand
        Invoke EditShowResult, hEdtTests, Addr szCPUBrandBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szCPUBrandNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUManufacturer
    Invoke CPU_Manufacturer
    .IF rax != NULL
        mov lpszCPUManufacturer, rax
        Invoke lstrcpy, Addr szCPUManufacturerBuffer, Addr szCPUManufacturerYes
        Invoke lstrcat, Addr szCPUManufacturerBuffer, lpszCPUManufacturer
        Invoke EditShowResult, hEdtTests, Addr szCPUManufacturerBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szCPUManufacturerNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUManufacturerID
    Invoke CPU_ManufacturerID
    mov qwManufacturerID, rax
    Invoke wsprintf, Addr szManufacturerID, Addr sz64bitIntegerFormat, qwManufacturerID
    Invoke EditShowResult, hEdtTests, Addr szManufacturerID
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUHighestBasic
    Invoke CPU_Highest_Basic
    mov dwHighestBasic, eax
    .IF rax != NULL
        Invoke lstrcpy, Addr szHighestBasicBuffer, Addr szHighestBasicYes
        Invoke wsprintf, Addr szHighestBasicLevel, Addr sz64bitHexFormat, dwHighestBasic
        Invoke lstrcat, Addr szHighestBasicBuffer, Addr szHighestBasicLevel
        Invoke EditShowResult, hEdtTests, Addr szHighestBasicBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szHighestBasicNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUHighestBasicExt
    Invoke CPU_Highest_Basic_Ext
    mov dwMaxBasicExtended, eax
    .IF rax != -1
        Invoke lstrcpy, Addr szHighestBasicExtBuffer, Addr szHighestBasicExtYes
        Invoke wsprintf, Addr szHighestBasicExtLevel, Addr sz64bitHexFormat, dwMaxBasicExtended
        Invoke lstrcat, Addr szHighestBasicExtBuffer, Addr szHighestBasicExtLevel
        Invoke EditShowResult, hEdtTests, Addr szHighestBasicExtBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szHighestBasicExtNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUHighestExtended
    Invoke CPU_Highest_Extended
    mov dwHighestExtended, eax
    .IF rax != NULL
        Invoke lstrcpy, Addr szHighestExtendedBuffer, Addr szHighestExtendedYes
        Invoke wsprintf, Addr szHighestExtendedLevel, Addr sz64bitHexFormat, dwHighestExtended
        Invoke lstrcat, Addr szHighestExtendedBuffer, Addr szHighestExtendedLevel
        Invoke EditShowResult, hEdtTests, Addr szHighestExtendedBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szHighestExtendedNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUBasicFeatures
    Invoke CPU_Basic_Features, Addr lpqwFeatures, Addr lpqwFeaturesSize, CFST_MNEMONIC, CFSS_COMMA, CPU_BF_ECX_COMMON, CPU_BF_EDX_COMMON
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, lpqwFeatures
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szBasicFeaturesNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUBasicFeaturesExt0
    Invoke CPU_Basic_Features_Ext0, Addr lpqwFeatures, Addr lpqwFeaturesSize, CFST_MNEMONIC, CFSS_COMMA, -1, -1, -1 ;, Addr dwMaxBasicExtended
    .IF rax == TRUE
        Invoke EditShowResult, hEdtTests, lpqwFeatures
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szBasicFeaturesExt0No
    .ENDIF
    
    .IF dwMaxBasicExtended > 0
        Invoke EditShowFunctionName, hEdtTests, Addr szCPUBasicFeaturesExt1
        Invoke CPU_Basic_Features_Ext1, Addr lpqwFeatures, Addr lpqwFeaturesSize, CFST_MNEMONIC, CFSS_COMMA, -1, -1, -1, -1
        .IF rax == TRUE
            Invoke EditShowResult, hEdtTests, lpqwFeatures
        .ELSE
            Invoke EditShowResult, hEdtTests, Addr szBasicFeaturesExt1No
        .ENDIF
    .ENDIF
    
    .IF dwMaxBasicExtended > 1
        Invoke EditShowFunctionName, hEdtTests, Addr szCPUBasicFeaturesExt2
        Invoke CPU_Basic_Features_Ext2, Addr lpqwFeatures, Addr lpqwFeaturesSize, CFST_MNEMONIC, CFSS_COMMA, -1
        .IF rax == TRUE
            Invoke EditShowResult, hEdtTests, lpqwFeatures
        .ELSE
            Invoke EditShowResult, hEdtTests, Addr szBasicFeaturesExt2No
        .ENDIF
    .ENDIF
    
    .IF dwHighestExtended >= 80000000h 
        Invoke EditShowFunctionName, hEdtTests, Addr szCPUExtendedFeatures
        Invoke CPU_Extended_Features, Addr lpqwFeatures, Addr lpqwFeaturesSize, CFST_MNEMONIC, CFSS_COMMA, -1, -1
        .IF eax == TRUE
            Invoke EditShowResult, hEdtTests, lpqwFeatures
        .ELSE
            Invoke EditShowResult, hEdtTests, Addr szExtendedFeaturesNo
        .ENDIF
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szCPUSignature
    Invoke CPU_Signature, Addr qwFamilyID, Addr qwExtFamilyID, Addr qwBaseFamilyID, Addr qwModelID, Addr qwExtModelID, Addr qwBaseModelID, Addr qwStepping
    .IF rax != 0
        mov qwCPUEAX, rax
        Invoke wsprintf, Addr szCPUEAXBuffer, Addr sz64bitAsmFormat, qwCPUEAX
        
        Invoke wsprintf, Addr szFamilyIDBuffer, Addr sz64bitAsmFormat, qwFamilyID
        Invoke wsprintf, Addr szExtFamilyIDBuffer, Addr sz64bitAsmFormat, qwExtFamilyID
        Invoke wsprintf, Addr szBaseFamilyIDBuffer, Addr sz64bitAsmFormat, qwBaseFamilyID
        Invoke wsprintf, Addr szModelIDBuffer, Addr sz64bitAsmFormat, qwModelID
        Invoke wsprintf, Addr szExtModelIDBuffer, Addr sz64bitAsmFormat, qwExtModelID
        Invoke wsprintf, Addr szBaseModelIDBuffer, Addr sz64bitAsmFormat, qwBaseModelID
        Invoke wsprintf, Addr szSteppingBuffer, Addr sz64bitAsmFormat, qwStepping
    
        Invoke lstrcpy, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCPUEAX
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCPUEAXBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szFamilyID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szFamilyIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szExtFamilyID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szExtFamilyIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szBaseFamilyID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szBaseFamilyIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szModelID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szModelIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szExtModelID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szExtModelIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szBaseModelID
        Invoke lstrcat, Addr szSignatureBuffer, Addr szBaseModelIDBuffer
        Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSigPadding
        Invoke lstrcat, Addr szSignatureBuffer, Addr szStepping
        Invoke lstrcat, Addr szSignatureBuffer, Addr szSteppingBuffer
        ;Invoke lstrcat, Addr szSignatureBuffer, Addr szCRLF
        
        Invoke EditShowResult, hEdtTests, Addr szSignatureBuffer
    .ENDIF
    
    ;--------------------------------------------------------------------------
    ; String Functions
    ;--------------------------------------------------------------------------
    Invoke EditAppendText, hEdtTests, Addr szSectionStringFunctions
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringAppend
    Invoke EditShowString, hEdtTests, Addr szTestCatString1
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestCatString1
    Invoke String_Length, Addr szStringBuffer
    Invoke String_Append, Addr szStringBuffer, Addr szTestCatString2, rax
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringConcat
    Invoke EditShowString, hEdtTests, Addr szTestCatString1
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestCatString1
    Invoke String_Concat, Addr szStringBuffer, Addr szTestCatString2
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringCompare
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringCompareI
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringCompareIEx
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringCopy
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Copy, Addr szTestString, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringCount
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Count, Addr szTestString, Addr szTestCountING
    mov qwTestStringCount, rax
    Invoke lstrcpy, Addr szStringBuffer, Addr szStringCountING
    Invoke wsprintf, Addr szStringCountBuffer, Addr sz64bitIntegerFormat, qwTestStringCount
    Invoke lstrcat, Addr szStringBuffer, Addr szStringCountBuffer
    Invoke EditShowResult, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringInString
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_InString, 1, Addr szTestString, Addr szTestInstringSTRing
    .IF rax != 0
        dec rax ; for 1 based index
        mov qwInstringPos, rax
        Invoke lstrcpy, Addr szStringBuffer, Addr szInstringPos
        Invoke wsprintf, Addr szInstringPosBuffer, Addr sz64bitIntegerFormat, qwInstringPos
        Invoke lstrcat, Addr szStringBuffer, Addr szInstringPosBuffer
        Invoke EditShowResult, hEdtTests, Addr szStringBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szInstringPosNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringLeft
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Left, Addr szTestString, Addr szStringBuffer, 17
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringLeftTrim
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_LeftTrim, Addr szTestString, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringLength
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Length, Addr szTestString
    .IF rax != 0
        mov qwTestStringLength, rax
        Invoke lstrcpy, Addr szStringBuffer, Addr szStringLengthYes
        Invoke wsprintf, Addr szTestStringLength, Addr sz64bitIntegerFormat, qwTestStringLength
        Invoke lstrcat, Addr szStringBuffer, Addr szTestStringLength
        Invoke EditShowResult, hEdtTests, Addr szStringBuffer
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szStringLengthNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringLowercase
    Invoke EditShowString, hEdtTests, Addr szTestStringUppercase
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestStringUppercase
    Invoke String_Lowercase, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringMiddle
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Middle, Addr szTestString, Addr szStringBuffer, qwInstringPos, 6
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringMonoSpace
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestString
    Invoke String_MonoSpace, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringMultiCat
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringRemove
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Remove, Addr szTestString, Addr szStringBuffer, Addr szTestRemoveStuff
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringReplace
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Replace, Addr szTestString, Addr szStringBuffer, Addr szTestReplaceStuff, Addr szTestReplaceWith
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringReverse
    Invoke EditShowString, hEdtTests, Addr szTestStringReversed
    Invoke String_Reverse, Addr szTestStringReversed, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringRight
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_Right, Addr szTestString, Addr szStringBuffer, 20
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringRightTrim
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_RightTrim, Addr szTestString, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringTrim
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestString
    Invoke String_Trim, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringUppercase
    Invoke EditShowString, hEdtTests, Addr szTestStringLowercase
    Invoke lstrcpy, Addr szStringBuffer, Addr szTestStringLowercase
    Invoke String_Uppercase, Addr szStringBuffer
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    Invoke EditShowFunctionName, hEdtTests, Addr szStringWordReplace
    Invoke EditShowString, hEdtTests, Addr szTestString
    Invoke String_WordReplace, Addr szTestString, Addr szStringBuffer, Addr szTestWoking, Addr szTestWorking
    Invoke EditShowResultString, hEdtTests, Addr szStringBuffer
    
    ;--------------------------------------------------------------------------
    ; Memory Functions
    ;--------------------------------------------------------------------------
    Invoke EditAppendText, hEdtTests, Addr szSectionMemoryFunctions

    Invoke EditShowFunctionName, hEdtTests, Addr szMemoryAlloc
    Invoke Memory_Alloc, 100
    .IF rax != NULL
        mov pMem, rax
        Invoke EditShowResult, hEdtTests, Addr szMemoryAllocYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szMemoryAllocNo
    .ENDIF

    Invoke EditShowFunctionName, hEdtTests, Addr szMemoryFree
    .IF pMem != NULL
        Invoke Memory_Free, pMem
        Invoke EditShowResult, hEdtTests, Addr szMemoryFreeYes
    .ELSE
        Invoke EditShowResult, hEdtTests, Addr szMemoryFreeNo
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szMemoryFill
    Invoke Memory_Alloc, 100
    .IF rax == 0
        IFDEF DEBUG64
        PrintText 'Memory_Alloc failed pMem1'
        ENDIF
    .ENDIF
    mov pMem1, rax
    Invoke Memory_Alloc, 100
    .IF rax == 0
        IFDEF DEBUG64
        PrintText 'Memory_Alloc failed pMem2'
        ENDIF
    .ENDIF
    mov pMem2, rax
    Invoke Memory_Fill, pMem1, 100, 0ABCDEF00h
    .IF pMem1 != 0
        mov rbx, pMem1
        mov rax, [rbx]
        mov qwMemContents1, rax
    .ENDIF
    Invoke Memory_Fill, pMem2, 100, 12345678h
    .IF pMem2 != 0
        mov rbx, pMem2
        mov rax, [rbx]
        mov qwMemContents2, rax
    .ENDIF
    Invoke wsprintf, Addr szStringBuffer, Addr sz64bitHexFormat, qwMemContents1
    Invoke EditShowResultMsg, hEdtTests, Addr szStringBuffer, Addr szpMem1, FALSE
    Invoke wsprintf, Addr szStringBuffer, Addr sz64bitHexFormat, qwMemContents2
    Invoke EditShowResultMsg, hEdtTests, Addr szStringBuffer, Addr szpMem2, TRUE
    .IF pMem1 != NULL
        Invoke Memory_Free, pMem1
    .ENDIF
    .IF pMem2 != NULL
        Invoke Memory_Free, pMem2
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szMemoryCopy
    Invoke Memory_Alloc, 100
    .IF rax == 0
        IFDEF DEBUG64
        PrintText 'Memory_Alloc failed pMem1'
        ENDIF
    .ENDIF
    mov pMem1, rax
    Invoke Memory_Alloc, 100
    .IF rax == 0
        IFDEF DEBUG64
        PrintText 'Memory_Alloc failed pMem2'
        ENDIF
    .ENDIF
    mov pMem2, rax
    Invoke Memory_Fill, pMem1, 100, 12345678h
    .IF pMem1 != 0
        mov rbx, pMem1
        mov rax, [rbx]
        mov qwMemContents1, rax
    .ENDIF
    Invoke Memory_Fill, pMem2, 100, 0h
    .IF pMem2 != 0
        mov rbx, pMem2
        mov rax, [rbx]
        mov qwMemContents2, rax
    .ENDIF
    Invoke wsprintf, Addr szStringBuffer, Addr sz64bitHexFormat, qwMemContents1
    Invoke EditShowResultMsg, hEdtTests, Addr szStringBuffer, Addr szpMem1, FALSE
    Invoke wsprintf, Addr szStringBuffer, Addr sz64bitHexFormat, qwMemContents2
    Invoke EditShowResultMsg, hEdtTests, Addr szStringBuffer, Addr szpMem2, FALSE
    Invoke Memory_Copy, pMem1, pMem2, 100
    .IF pMem2 != 0
        mov rbx, pMem2
        mov rax, [rbx]
        mov qwMemContents2, rax
    .ENDIF
    Invoke wsprintf, Addr szStringBuffer, Addr sz64bitHexFormat, qwMemContents2
    Invoke EditShowResultMsg, hEdtTests, Addr szStringBuffer, Addr szpMem2AfterCopy, TRUE
    .IF pMem1 != NULL
        Invoke Memory_Free, pMem1
    .ENDIF
    .IF pMem2 != NULL
        Invoke Memory_Free, pMem2
    .ENDIF
    
    Invoke EditShowFunctionName, hEdtTests, Addr szMemoryCompare
    
    ret
DoUASM64LibraryTests ENDP

;------------------------------------------------------------------------------
; EditShowFunctionName - Append function name text to edit control
;------------------------------------------------------------------------------
EditShowFunctionName PROC FRAME hEdit:QWORD, lpszFunctionName:QWORD
    Invoke lstrcpy, Addr szFunctionDisplayBuffer, Addr szFunctionPadding
    Invoke lstrcat, Addr szFunctionDisplayBuffer, Addr szFunction
    .IF lpszFunctionName != 0
        Invoke lstrcat, Addr szFunctionDisplayBuffer, lpszFunctionName
    .ENDIF
    Invoke lstrcat, Addr szFunctionDisplayBuffer, Addr szCRLF
    Invoke EditAppendText, hEdit, Addr szFunctionDisplayBuffer
    ret
EditShowFunctionName ENDP

;------------------------------------------------------------------------------
; EditShowResult - Append result text to edit control
;------------------------------------------------------------------------------
EditShowResult PROC FRAME hEdit:QWORD, lpszResultString:QWORD
    Invoke lstrcpy, Addr szResultDisplayBuffer, Addr szResultPadding
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szResult
    .IF lpszResultString != 0
        Invoke lstrcat, Addr szResultDisplayBuffer, lpszResultString
    .ENDIF
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    Invoke EditAppendText, hEdit, Addr szResultDisplayBuffer
    ret
EditShowResult ENDP

;------------------------------------------------------------------------------
; EditShowResultMsg - Append result text to edit control with a msg
;------------------------------------------------------------------------------
EditShowResultMsg PROC FRAME hEdit:QWORD, lpszResultString:QWORD, lpszMsg:QWORD, bCRLF:QWORD
    Invoke lstrcpy, Addr szResultDisplayBuffer, Addr szResultPadding
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szResult
    Invoke lstrcat, Addr szResultDisplayBuffer, lpszMsg
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szColonSpace
    .IF lpszResultString != 0
        Invoke lstrcat, Addr szResultDisplayBuffer, lpszResultString
    .ENDIF
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    .IF bCRLF == TRUE
        Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    .ENDIF
    Invoke EditAppendText, hEdit, Addr szResultDisplayBuffer
    ret
EditShowResultMsg ENDP

;------------------------------------------------------------------------------
; EditShowResult - Append result "string" text to edit control
;------------------------------------------------------------------------------
EditShowResultString PROC FRAME hEdit:QWORD, lpszResultString:QWORD
    Invoke lstrcpy, Addr szResultDisplayBuffer, Addr szResultPadding
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szResult
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szStringBegin
    .IF lpszResultString != 0
        Invoke lstrlen, lpszResultString
        .IF rax != 0
            Invoke lstrcat, Addr szResultDisplayBuffer, lpszResultString
        .ENDIF
    .ENDIF
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szStringEnd
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    Invoke lstrcat, Addr szResultDisplayBuffer, Addr szCRLF
    Invoke EditAppendText, hEdit, Addr szResultDisplayBuffer
    ret
EditShowResultString ENDP

;------------------------------------------------------------------------------
; EditShowString - Append a "string" to edit control
;------------------------------------------------------------------------------
EditShowString PROC FRAME hEdit:QWORD, lpszStringToShow:QWORD
    Invoke lstrcpy, Addr szTestStringBuffer, Addr szResultPadding
    Invoke lstrcat, Addr szTestStringBuffer, Addr szString
    .IF lpszStringToShow != 0
        Invoke lstrlen, lpszStringToShow
        .IF rax != 0
            Invoke lstrcat, Addr szTestStringBuffer, lpszStringToShow
        .ENDIF
    .ENDIF
    Invoke lstrcat, Addr szTestStringBuffer, Addr szStringEnd
    Invoke lstrcat, Addr szTestStringBuffer, Addr szCRLF
    Invoke EditAppendText, hEdtTests, Addr szTestStringBuffer
    ret
EditShowString ENDP

;------------------------------------------------------------------------------
; EditAppendText - Append text to the end of the edit control
;------------------------------------------------------------------------------
EditAppendText PROC FRAME hEdit:QWORD, lpszMessage:QWORD
    Invoke SendMessage, hEdit, EM_SETSEL, -1, -1
    Invoke SendMessage, hEdit, EM_REPLACESEL, FALSE, lpszMessage
    Invoke SendMessage, hEdit, EM_SCROLLCARET, 0, 0
    ret
EditAppendText ENDP

;------------------------------------------------------------------------------
; EditClearText - Clear text from the edit control
;------------------------------------------------------------------------------
EditClearText PROC FRAME hEdit:QWORD
    Invoke SendMessage, hEdit, WM_SETTEXT, 0, 0
    ret
EditClearText ENDP





end WinMainCRTStartup

