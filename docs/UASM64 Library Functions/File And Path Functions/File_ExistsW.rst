.. _File_ExistsW:

============
File_ExistsW
============

This function tests if a file exists at the path and file name in the zero terminated string.This is the Unicode version of File_Exists, File_ExistsA is the Ansi version.

::

   File_ExistsW PROTO lpszFileName:QWORD


**Parameters**

* ``lpszFileName`` - The zero terminated string that has the path & filename of the file to test if it exists. 


**Returns**

If the return value in RAX is 0, the file does not exist, if it is 1, then it does exist.


**Notes**

This function as based on the MASM32 Library function: existW

**See Also**

:ref:`File_ExistsA<File_ExistsA>`, :ref:`File_SizeA<File_SizeA>`, :ref:`File_SizeW<File_SizeW>`
