# UASM64 Library

**UASM64 Library** is a x64 port of the functions from the MASM32 Library that are included with the [MASM32 SDK](https://www.masm32.com).

[![](https://img.shields.io/badge/Assembler-UASM%20v2.xx-green.svg?style=flat-square&logo=visual-studio-code&logoColor=white&colorB=1CC887)](http://www.terraspace.co.uk/uasm.html) [![](https://img.shields.io/badge/RadASM%20-v2.2.2.x%20-red.svg?style=flat-square&colorB=C94C1E&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAgCAYAAAASYli2AAACcklEQVR42tWVXWiPURzHz/FyQZOiVuatuFEoKzfKSCs35EJeCqFcEEa5s2heNrXiApuXFDYveUlKSywlIRfczM0WjZvJlGKTRLb5fHvOU6fT+T/PY3bj1Kff8z8vn+f8znPO+dshihnBYv8L4awRcl2FRTarBy8bQzgEjdbabzl9nxCW2IwOFYTrsBTKEH7PET4lLLYlGpcTrkC5qxqL8HeO8CVhoQ0qRxMOw34Y5TVVIPyYI+whTLVehZ9iWgZAL1mN8G6GbArhA/TZEilqKx2HCbADXkAV0oESwhOEfdChbXOUh1ovxS+wlcH3aNvC82VX3wx7Qyl9NhEugXZEU7ixX8E6Br13nTVDPU927R3QCl0wTX2h2rUNQqUv/ATLkHUGM1hLuBF8pFipZ+zBcIZKpw1O0vjYk24mnIXxEZHGNMIBxgxJ2M2P2PF7DafhGh1/0G8Gzzv1cWASfIZn0EJ7VzpIQqWyUguulFUXiDXwApxhYE9O2ibc2PMJNbAxkp5Oyh3NGvHzQkJPrK/aANtLjNNuOAU3kf/KFTrpGsJtaIdxbu3C0gvn4Dzi3qLCI3Su4/cCnnfDBvcCv/yEW0a7o6gwWI5tJvniMwutYZbQa9elsUqzgun/JKStjKAzvAvmDXuG1M1xqerkTAyG6Cy3FREeM8k2kag6MomvcBGaefG7LOF6k1wK6SUbFl0iOpqt/v+NjYjmEva4NQpPi9K6b5JN/UiXQTg+vbF1nlc4USytPpNcok1Iuk1G0eWgS0Hnd3akXbeIbuqWvP9lXxhOW2k9cOvzMJZWUWG/Sf4/lNbbv5GEwjeSSIaof7iitPwBoSgbVud1Jo0AAAAASUVORK5CYII=)](http://www.softpedia.com/get/Programming/File-Editors/RadASM.shtml) [![readthedocs](https://img.shields.io/badge/readthedocs-available-success.svg?style=flat-square&color=success&logo=read-the-docs)](https://uasm64-library.readthedocs.io/en/latest/index.html)

The functions ported to an x64 version in the **UASM64 Library** aim to match the parameters and features of the original x86 functions from the MASM32 Library where possible. In a few functions that may not be possible, and an alternative approach to achieve the same desired result may be used instead.

The names of the functions and parameter names in the **UASM64 Library** compared to the MASM32 Library have been changed to increase readability. Equates are provided in the `UASM64.inc` file to map to the new function names - which also helps when porting x86 projects to x64 ones.

Additionally, new functions have been added to the **UASM64 Library** to expand and compliment the existing functions.

**UASM64 Library** is targetted specifically for use with projects that use the [UASM](http://www.terraspace.co.uk/uasm.html) assembler (the x64 version), but likely other compilers and assemblers can utilize it as well.

All credit and thanks to all the original authors and code contributors of the functions in the MASM32 Library.

The **UASM64 Library** and source code are free to use for anyone, and anyone can contribute to the **UASM64 Library** project.

# Download

* Download the latest release: [UASM64-Library.zip](https://github.com/mrfearless/UASM64-Library/blob/main/releases/UASM64-Library.zip?raw=true)

# Setup

* Copy `UASM64.inc` to your `Uasm\Include` folder (or wherever your include files are located)

* Copy `UASM64.lib` to your `Uasm\Lib\x64` folder (or wherever your libraries are located)

* Add the following to your project:
  
  ```assembly
  include UASM64.inc
  includelib UASM64.lib
  ```

# Resources

Included with the releases are additional RadASM IDE autocomplete / intellisense type files, along with ones for the WinASM IDE. Each `*.api.txt`, or `*.vaa.txt` file contains instructions as to where to paste their contents. 

Other resources that may be useful:

- [RadASM IDE](http://www.softpedia.com/get/Programming/File-Editors/RadASM.shtml)
- [UASM Assembler](http://www.terraspace.co.uk/uasm.html)
- [UASM-with-RadASM](https://github.com/mrfearless/UASM-with-RadASM)
