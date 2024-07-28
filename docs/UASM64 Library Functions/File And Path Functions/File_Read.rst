.. _File_Read:

=========
File_Read
=========

Read the contents of a file into a pre-allocated memory buffer.

::

   File_Read PROTO hFile:QWORD, lpMemory:QWORD, qwBytesToRead:QWORD


**Parameters**

* ``hFile`` - The handle of the opened file to read.

* ``lpMemory`` - The address of the memory buffer to read the file contents into.

* ``qwBytesToRead`` - The amount, in bytes, of data to read into the buffer.


**Returns**

TRUE if successful, or FALSE otherwise.


**Notes**

This function as based on the MASM32 Library function: 

**See Also**

:ref:`File_Close<File_Close>`, :ref:`File_Write<File_Write>`
