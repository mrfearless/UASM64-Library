.. _File_Size:

===================================
File_Size 
===================================

Returns the size of a file if it exists.
    
::

   File_Size PROTO lpszFilename:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated string that has the path & filename of the file to return the size of.


**Returns**

If the return value is minus one (``-1``) then the file does not exist, otherwise ``RAX`` contains the size of the file in bytes.

**Notes**

This function will return the size of a file without opening it.

**Example**

::

   Invoke File_Size

**See Also**

:ref:`File_Exists<File_Exists>` 

