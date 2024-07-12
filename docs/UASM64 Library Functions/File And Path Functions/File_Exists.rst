.. _File_Exists:

===================================
File_Exists 
===================================

Tests if a file exists at the path and file name in the zero terminated string.
    
::

   File_Exists PROTO lpszFilename:QWORD


**Parameters**

* ``lpszFilename`` - The zero terminated string that has the path & filename of the file to test if it exists.


**Returns**

If the return value in ``RAX`` is ``0``, the file does not exist, if it is ``1``, then it does exist.

**Notes**



**Example**

::

   Invoke File_Exists, 

**See Also**

:ref:`File_Size<File_Size>` 

