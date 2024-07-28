.. _File_SizeA:

==========
File_SizeA
==========

This function returns the size of a file if it exists.

::

   File_SizeA PROTO lpszFileName:QWORD


**Parameters**

* ``lpszFileName`` - The zero terminated string that has the path & filename of the file to return the size of. 


**Returns**

If the return value is minus one (-1) then the file does not exist, otherwise RAX contains the size of the file in bytes.


**Notes**

This function will return the size of a file without opening it.

This function as based on the MASM32 Library function: filesize

**See Also**

:ref:`File_SizeW<File_SizeW>`, :ref:`File_ExistsA<File_ExistsA>`, :ref:`File_ExistsW<File_ExistsW>`, :ref:`File_FileSize<File_FileSize>`
