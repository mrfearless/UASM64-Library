.. _Path_GetAppPath:

===============
Path_GetAppPath
===============

Returns the address of the running application's path as a zero terminated string with the filename removed. The last character in the string is a trailing backslash "\" to facilitate parsing different filenames to the path.

::

   Path_GetAppPath PROTO lpszPath:QWORD


**Parameters**

* ``lpszPath`` - The address of the buffer that will receive the application path.


**Returns**

There is no return value.


**See Also**

:ref:`Path_GetPathOnly<Path_GetPathOnly>`, :ref:`Path_NameFromPath<Path_NameFromPath>`
