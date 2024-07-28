.. _String_LeftW:

============
String_LeftW
============

Gets a substring from the left side of a zero terminated string. String_Left reads a set number of characters from the beginning (left) position in the source zero terminated string and writes them to the destination string address.

::

   String_LeftW PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string.

* ``lpszDestination`` - Address of the destination buffer.

* ``qwLengthToRead`` - The number of characters to read from the left side.


**Returns**

Returns a pointer to the destination string in RAX.


**Notes**

This function as based on the MASM32 Library function: ucLeft

**See Also**

:ref:`String_RightW<String_RightW>`, :ref:`String_MiddleW<String_MiddleW>`, :ref:`String_SubstringW<String_SubstringW>`
