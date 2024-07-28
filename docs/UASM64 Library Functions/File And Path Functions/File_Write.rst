.. _File_Write:

==========
File_Write
==========

Write the contents of a memory buffer to an opened file.

::

   File_Write PROTO hFile:QWORD, lpMemory:QWORD, qwBytesToWrite:QWORD


**Parameters**

* ``hFile`` - The handle of the opened file to write to.

* ``lpMemory`` - The address of the memory buffer to read the contents of and write them out to the file.

* ``qwBytesToWrite`` - The amount, in bytes, of data in the memory buffer to write into the file.


**Returns**

TRUE if successful, or FALSE otherwise.


**Notes**

This function as based on the MASM32 Library function: 

**See Also**

:ref:`File_Close<File_Close>`, :ref:`File_Flush<File_Flush>`, :ref:`File_Read<File_Read>`
