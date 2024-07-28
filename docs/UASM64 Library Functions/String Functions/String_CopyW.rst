.. _String_CopyW:

============
String_CopyW
============

Copies a zero terminated string from the source buffer to the destination buffer.

::

   String_CopyW PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination string buffer.


**Returns**

The copied length minus the terminating null is returned in RAX.


**Notes**

The destination buffer must be large enough to hold the source string otherwise a page write fault will occur.

This function as based on the MASM32 Library function: ucCopy

**See Also**

:ref:`String_LengthW<String_LengthW>`, :ref:`String_ConcatW<String_ConcatW>`
