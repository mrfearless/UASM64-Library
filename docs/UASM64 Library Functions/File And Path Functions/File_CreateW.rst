.. _File_CreateW:

============
File_CreateW
============

Create a new file with read / write access and return the file handle. This is the Unicode version of File_Create, File_CreateA is the Ansi version.

::

   File_CreateW PROTO lpszFilename:QWORD


**Parameters**

* ``lpszFilename`` - Parameter details.


**Returns**

A file handle if successful or INVALID_HANDLE_VALUE if an error occurred.


**Notes**

This function as based on the MASM32 Library macro: fcreateW

**See Also**

:ref:`File_CreateA<File_CreateA>`, :ref:`File_OpenA<File_OpenA>`, :ref:`File_OpenW<File_OpenW>`, :ref:`File_Close<File_Close>`, :ref:`File_Read<File_Read>`, :ref:`File_Write<File_Write>`
