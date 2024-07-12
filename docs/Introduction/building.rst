.. _Building:

========
Building
========

The UASM64 Library comes with a RadASM project to help you build the sources. However if you wish to build the library manually, here are the command line options you should use.


.. _Building the UASM64 Library:

Building the UASM64 Library
---------------------------

The UASM64 Library source consists of the following files:

* ``UASM64.inc``
* ``*.asm``

**Building with UASM** (``UASM64.EXE``):

::

   UASM64.EXE /c -win64 -Zp8 /win64 /D_WIN64 /Cp /nologo /W2 /I"X:\UASM\Include" *.asm


.. note:: ``X`` is the drive letter where the `UASM <http://www.terraspace.co.uk/uasm.html>`_ assembler has been installed to.


**Linking with Microsoft Library Manager** (``LIB.EXE``):

::

   LIB *.obj /out:UASM64.lib


.. _Building the UASM64 Library Debug Build:

Building the UASM64 Library Debug Build
---------------------------------------------

To build the UASM64 Library with debug information, supply the additional flag options ``/Zi /Zd`` on the command line for UASM (``UASM64.EXE``) like so:

::
    
   UASM64.EXE /c -win64 -Zp8 /Zi /Zd /win64 /D_WIN64 /Cp /nologo /W2 /I"X:\UASM\Include" *.asm



.. note:: ``X`` is the drive letter where the `UASM <http://www.terraspace.co.uk/uasm.html>`_ assembler has been installed to.