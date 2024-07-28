.. _File_WriteMemoryToFileA:

=======================
File_WriteMemoryToFileA
=======================

Write the contents of a memory buffer to a disk file. This is the Ansi version of File_WriteMemoryToFile, File_WriteMemoryToFileW is the Unicode version.

::

   File_WriteMemoryToFileA PROTO lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated file name to write the memory buffer to.

* ``lpMemory`` - The address of the buffer that contains the data to write.

* ``qwMemoryLength`` - The number of bytes to write to the file.


**Returns**

The return value is the number of bytes written if the function succeeds or zero if it fails.


**Notes**

This procedure is designed to write a complete disk file each time it is called. It will overwrite an existing file of the same name.

This function as based on the MASM32 Library function: write_disk_file

**See Also**

:ref:`File_WriteMemoryToFileW<File_WriteMemoryToFileW>`, :ref:`File_ReadFileToMemoryA<File_ReadFileToMemoryA>`, :ref:`File_ReadFileToMemoryW<File_ReadFileToMemoryW>`, :ref:`File_OpenA<File_OpenA>`, :ref:`File_Write<File_Write>`, :ref:`File_Flush<File_Flush>`, :ref:`File_Close<File_Close>`
