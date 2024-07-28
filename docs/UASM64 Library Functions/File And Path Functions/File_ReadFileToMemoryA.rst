.. _File_ReadFileToMemoryA:

======================
File_ReadFileToMemoryA
======================

Reads a disk file into memory and returns the address and length in two QWORD variables. This is the Ansi version of File_ReadFileToMemory, File_ReadFileToMemoryW is the Unicode version.

::

   File_ReadFileToMemoryA PROTO lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated file name to open and read into memory.

* ``lpqwMemory`` - The address of the QWORD variable that receives the starting address of the buffer, for the file contents.

* ``lpqwMemoryLength`` - The address of the QWORD variable that receives the number of bytes written to the memory buffer.


**Returns**

The return value is zero on error, otherwise non-zero.


**Notes**

The memory address written to lpqwMemory must be deallocated using the GlobalFree function, once the memory buffer is no longer required.

This function as based on the MASM32 Library function: read_disk_file

**See Also**

:ref:`File_ReadFileToMemoryW<File_ReadFileToMemoryW>`, :ref:`File_WriteMemoryToFileA<File_WriteMemoryToFileA>`, :ref:`File_WriteMemoryToFileW<File_WriteMemoryToFileW>`, :ref:`File_OpenA<File_OpenA>`, :ref:`File_Read<File_Read>`, :ref:`File_FileSize<File_FileSize>`, :ref:`File_Close<File_Close>`, :ref:`Memory_Alloc<Memory_Alloc>`
