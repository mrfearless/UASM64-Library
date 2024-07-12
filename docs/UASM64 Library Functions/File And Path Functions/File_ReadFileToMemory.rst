.. _File_ReadFileToMemory:

===================================
File_ReadFileToMemory 
===================================

Reads a disk file into memory and returns the address and length in two ``QWORD`` variables.
    
::

   File_ReadFileToMemory PROTO lpszFilename:QWORD, lpqwMemory:QWORD, lpqwMemoryLength:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated file name to open and read into memory.
* ``lpqwMemory`` - The address of the ``QWORD`` variable that receives the starting address of the buffer, for the file contents.
* ``lpqwMemoryLength`` - The address of the ``QWORD`` variable that receives the number of bytes written to the memory buffer.


**Returns**

The return value is zero on error, otherwise non-zero.

**Notes**

The memory address written to lpqwMemory must be deallocated using the GlobalFree function, once the memory buffer is no longer required.

**Example**

::

   Invoke File_ReadFileToMemory

**See Also**

:ref:`File_WriteMemoryToFile<File_WriteMemoryToFile>`, :ref:`File_Size<File_Size>`, :ref:`File_Exists<File_Exists>`

