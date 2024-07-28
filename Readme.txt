==============================================================================

 UASM64 Library

 https://github.com/mrfearless/UASM64-Library

==============================================================================

This software is provided 'as-is', without any express or implied warranty. 
In no event will the author(s) be held liable for any damages arising from 
the use of this software.

The UASM64 Library is a port of the functions from the MASM32 Library that are
included with the MASM32 SDK (www.masm32.com)
 
The functions ported to an x64 version in the UASM64 Library aim to match the 
parameters and features of the original x86 functions from the MASM32 Library 
where possible. In a few functions that may not be possible, and an 
alternative approach to achieve the same desired result may be used instead.

UASM64 Library is targeted specifically for use with projects that use the 
UASM assembler x64 (http://www.terraspace.co.uk/uasm.html), but likely other 
compilers and assemblers can utilize it as well.

All credit and thanks to all the original authors and code contributors of 
the functions in the MASM32 Library.

The UASM64 library and source code are free to use for anyone, and anyone can 
contribute to the UASM64 Library project.


Download
--------

* Download the latest release from: 
https://github.com/mrfearless/UASM64-Library

Setup
-----

- Copy `UASM64.inc` to your `Uasm\Include` folder (or wherever your include 
  files are located)

- Copy `UASM64.lib` to your `Uasm\Lib\x64` folder (or wherever your libraries 
  are located)

- Add the following to your project:
  
  include UASM64.inc
  includelib UASM64.lib


Resources
---------

Included with the releases are additional RadASM IDE intellisense type files, 
along with ones for the WinASM IDE. Each `*.api.txt`, or `*.vaa.txt` file 
contains instructions as to where to paste their contents. 

Other resources that may be useful:

- RadASM IDE: 
  http://www.softpedia.com/get/Programming/File-Editors/RadASM.shtml

- UASM Assembler
  http://www.terraspace.co.uk/uasm.html

- UASM-with-RadASM
  https://github.com/mrfearless/UASM-with-RadASM





