.. _File_WriteMemoryToFile:

===================================
File_WriteMemoryToFile 
===================================

Write the contents of a memory buffer to a disk file.
    
::

   File_WriteMemoryToFile ROTO lpszFilename:QWORD, lpMemory:QWORD, qwMemoryLength:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated file name to write the memory buffer to.
* ``lpMemory`` - The address of the buffer that contains the data to write.
* ``lpqwMemoryLength`` - The number of bytes to write to the file.


**Returns**

The return value is the number of bytes written if the function succeeds or zero if it fails.

**Notes**

This procedure is designed to write a complete disk file each time it is called. It will overwrite an existing file of the same name.

**Example**

::

   Invoke File_WriteMemoryToFile

**See Also**

:ref:`File_ReadFileToMemory<File_ReadFileToMemory>`, :ref:`File_Size<File_Size>`, :ref:`File_Exists<File_Exists>`

