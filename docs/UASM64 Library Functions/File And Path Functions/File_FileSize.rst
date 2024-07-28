.. _File_FileSize:

=============
File_FileSize
=============

Get the size of an opened file.

::

   File_FileSize PROTO hFile:QWORD


**Parameters**

* ``hFile`` - The handle of the opened file to get the size of.


**Returns**

RAX contains the size of the file in bytes, or -1 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: 

**See Also**

:ref:`File_SizeA<File_SizeA>`, :ref:`File_SizeW<File_SizeW>`, :ref:`File_ExistsA<File_ExistsA>`, :ref:`File_ExistsW<File_ExistsW>`
