.. _String_CopyA:

============
String_CopyA
============

Copies a zero terminated string from the source buffer to the destination buffer. This is the Ansi version of String_Copy, String_CopyW is the Unicode version.

::

   String_CopyA PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination string buffer.


**Returns**

The copied length minus the terminating null is returned in RAX.


**Notes**

The destination buffer must be large enough to hold the source string otherwise a page write fault will occur.

This function as based on the MASM32 Library function: 

**See Also**

:ref:`String_LengthA<String_LengthA>`, :ref:`String_ConcatA<String_ConcatA>`
