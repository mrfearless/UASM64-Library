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

include UASM64.inc

.CODE

UASM64_ALIGN
;------------------------------------------------------------------------------
; CPU_ManufacturerID
;
; Return a constant value that is a reference to the CPU manufacturer. 
; 
; Parameters:
; 
; There are no parameters.
; 
; Returns:
; 
; EAX contains a a constant value that is a reference to the CPU manufacturer
; or 0 (CPU_MANUFACTURER_NONE) if not supported, unknown or an error occurred.
; 
; One of the following values if successful:
;
; * CPU_MANUFACTURER_INTEL
; * CPU_MANUFACTURER_IOTEL
; * CPU_MANUFACTURER_AMD
; * CPU_MANUFACTURER_CYRIX
; * CPU_MANUFACTURER_CENTAUR
; * CPU_MANUFACTURER_IDTWINCHIP
; * CPU_MANUFACTURER_TRANSMETACPU
; * CPU_MANUFACTURER_TRANSMETA
; * CPU_MANUFACTURER_NATSEMI
; * CPU_MANUFACTURER_NEXGEN
; * CPU_MANUFACTURER_RISE
; * CPU_MANUFACTURER_SIS
; * CPU_MANUFACTURER_UMC
; * CPU_MANUFACTURER_VORTEX
; * CPU_MANUFACTURER_ZHAOXIN
; * CPU_MANUFACTURER_HYGON
; * CPU_MANUFACTURER_RDCSEMI
; * CPU_MANUFACTURER_ELBRUS
; * CPU_MANUFACTURER_VIA
; * CPU_MANUFACTURER_AMDSAMPLE
; * CPU_MANUFACTURER_AO486
; * CPU_MANUFACTURER_MISTER
; * CPU_MANUFACTURER_V586s
; * CPU_MANUFACTURER_MSX86TOARM
; * CPU_MANUFACTURER_APPLEROSETTA2
; * CPU_MANUFACTURER_VIRTUALAPPLE
;
; See Also:
;
; CPU_Manufacturer, CPU_Brand
; 
;------------------------------------------------------------------------------
CPU_ManufacturerID PROC FRAME USES RBX RCX RDX RDI
    LOCAL lpszCPUManufacturer:DWORD
    
    Invoke CPU_CPUID_Supported
    .IF rax == FALSE
        jmp CPU_ManufacturerID_Error
    .ENDIF
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    
    mov eax, 0
    cpuid
    
    .IF ebx == 'uneG' && edx == 'Ieni' && ecx == 'letn'     ; Genu ineI ntel
        mov rax, CPU_MANUFACTURER_INTEL
    .ELSEIF ebx == 'uneG' && edx == 'Ieni' && ecx == 'leto' ; Genu ineI otel
        mov rax, CPU_MANUFACTURER_IOTEL
    .ELSEIF ebx == 'htuA' && edx == 'itne' && ecx == 'DMAc' ; Auth enti cAMD
        mov rax, CPU_MANUFACTURER_AMD
    .ELSEIF ebx == 'iryC' && edx == 'snIx' && ecx == 'daet' ; Cyri xIns tead
        mov rax, CPU_MANUFACTURER_CYRIX
    .ELSEIF ebx == 'tneC' && edx == 'Hrua' && ecx == 'slua' ; Cent aurH auls
        mov rax, CPU_MANUFACTURER_CENTAUR
    .ELSEIF ebx == 'narT' && edx == 'tems' && ecx == 'UPCa' ; Tran smet aCPU
        mov rax, CPU_MANUFACTURER_TRANSMETACPU
    .ELSEIF ebx == 'uneG' && edx == 'Teni' && ecx == '68xM' ; Genu ineT Mx86
        mov rax, CPU_MANUFACTURER_TRANSMETA
    .ELSEIF ebx == 'doeG' && edx == 'yb e' && ecx == 'CSN ' ; Geod e by  NSC
        mov rax, CPU_MANUFACTURER_NATSEMI
    .ELSEIF ebx == 'GxeN' && edx == 'rDne' && ecx == 'nevi' ; NexG enDr iven
        mov rax, CPU_MANUFACTURER_NEXGEN
    .ELSEIF ebx == 'esiR' && edx == 'esiR' && ecx == 'esiR' ; Rise Rise Rise
        mov rax, CPU_MANUFACTURER_RISE
    .ELSEIF ebx == ' SiS' && edx == ' SiS' && ecx == ' SiS' ; SiS  SiS  SiS
        mov rax, CPU_MANUFACTURER_SIS
    .ELSEIF ebx == ' CMU' && edx == ' CMU' && ecx == ' CMU' ; UMC  UMC  UMC
        mov rax, CPU_MANUFACTURER_UMC
    .ELSEIF ebx == 'troV' && edx == '68xe' && ecx == 'CoS ' ; Vort ex86  SoC
        mov rax, CPU_MANUFACTURER_VORTEX
    .ELSEIF ebx == 'hS  ' && edx == 'hgna' && ecx == '  ia' ;   Sh angh ai
        mov rax, CPU_MANUFACTURER_ZHAOXIN
    .ELSEIF ebx == 'ogyH' && edx == 'neGn' && ecx == 'eniu' ; Hygo nGen uine
        mov rax, CPU_MANUFACTURER_HYGON
    .ELSEIF ebx == 'uneG' && edx == ' eni' && ecx == 'CDR ' ; Genu ine   RDC
        mov rax, CPU_MANUFACTURER_RDCSEMI
    .ELSEIF ebx == ' K2E' && edx == 'HCAM' && ecx == ' ENI' ; E2K  MACH INE
        mov rax, CPU_MANUFACTURER_ELBRUS
    .ELSEIF ebx == ' AIV' && edx == ' AIV' && ecx == ' AIV' ; VIA  VIA  VIA
        mov rax, CPU_MANUFACTURER_VIA
    .ELSEIF ebx == ' DMA' && edx == 'EBSI' && ecx == 'RETT' ; AMD  ISBE TTER
        mov rax, CPU_MANUFACTURER_AMDSAMPLE
    .ELSEIF ebx == 'uneG' && edx == 'Aeni' && ecx == '6840' ; Genu ineA O486
        mov rax, CPU_MANUFACTURER_AO486
    .ELSEIF ebx == 'TSiM' && edx == 'A re' && ecx == '6840' ; MiST er A O486
        mov rax, CPU_MANUFACTURER_MISTER
    .ELSEIF ebx == 'rciM' && edx == 'foso' && ecx == 'ATXt' ; Micr osof tXTA
        mov rax, CPU_MANUFACTURER_MSX86TOARM
    .ELSEIF ebx == 'triV' && edx == 'Alau' && ecx == 'elpp' ; Virt ualA pple
        mov rax, CPU_MANUFACTURER_VIRTUALAPPLE
    .ELSE
        mov rax, CPU_MANUFACTURER_NONE
    .ENDIF
    

    jmp CPU_ManufacturerID_Exit
    
CPU_ManufacturerID_Error:
    
    mov rax, 0

CPU_ManufacturerID_Exit:
    
    ret
CPU_ManufacturerID ENDP


END

