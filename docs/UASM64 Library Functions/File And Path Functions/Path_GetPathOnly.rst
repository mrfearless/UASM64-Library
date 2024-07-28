.. _Path_GetPathOnly:

================
Path_GetPathOnly
================

Reads the path of a complete full filename and path and returns just the path portion in the destination buffer.

::

   Path_GetPathOnly PROTO lpszFullFilenamePath:QWORD, lpszPath:QWORD


**Parameters**

* ``lpszFullFilenamePath`` - Address of zero terminated that contains the full filename and path.

* ``lpszPath`` - Address of buffer to receive the path portion of a complete path.


**Returns**

No return value.


**Notes**

The destination buffer must be large enough to receive the path from the complete full filename and path.


**See Also**

:ref:`Path_GetAppPath<Path_GetAppPath>`, :ref:`Path_NameFromPath<Path_NameFromPath>`
