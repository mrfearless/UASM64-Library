.. _File_ExistsA:

============
File_ExistsA
============

This function tests if a file exists at the path and file name in the zero terminated string. This is the Ansi version of File_Exists, File_ExistsW is the Unicode version.

::

   File_ExistsA PROTO lpszFileName:QWORD


**Parameters**

* ``lpszFileName`` - The zero terminated string that has the path & filename of the file to test if it exists. 


**Returns**

If the return value in RAX is 0, the file does not exist, if it is 1, then it does exist.


**Notes**

This function as based on the MASM32 Library function: exist

**See Also**

:ref:`File_ExistsW<File_ExistsW>`, :ref:`File_SizeA<File_SizeA>`, :ref:`File_SizeW<File_SizeW>`
