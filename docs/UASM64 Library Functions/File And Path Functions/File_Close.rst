.. _File_Close:

==========
File_Close
==========

Closes and open file.

::

   File_Close PROTO hFile:QWORD


**Parameters**

* ``hFile`` - handle of the opened file to close.


**Returns**

TRUE if successful, or FALSE otherwise.


**Notes**

This function as based on the MASM32 Library macro: fclose

**See Also**

:ref:`File_OpenA<File_OpenA>`, :ref:`File_OpenW<File_OpenW>`, :ref:`File_CreateA<File_CreateA>`, :ref:`File_CreateW<File_CreateW>`
