.. _Path_NameFromPath:

=================
Path_NameFromPath
=================

Reads the filename from a complete path and returns it in the buffer specified in the lpszFilename parameter.

::

   Path_NameFromPath PROTO lpszFullFilenamePath:QWORD, lpszFilename:QWORD


**Parameters**

* ``lpszFullFilenamePath`` - The address of the full path that has the file name.

* ``lpszFilename`` - The address of the buffer to receive the filename.


**Returns**

The file name is returned in the buffer supplied in the lpszPath parameter.


**Notes**

The buffer to receive the filename must be large enough to accept the filename. For safety reasons if dealing with both long path and file name, the buffer can be made the same length as the source buffer. 

**See Also**

:ref:`Path_GetAppPath<Path_GetAppPath>`, :ref:`Path_GetPathOnly<Path_GetPathOnly>`
