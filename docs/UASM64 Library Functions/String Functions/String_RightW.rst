.. _String_RightW:

=============
String_RightW
=============

Gets a substring from the right side of a zero terminated string. String_Right reads a set number of characters from the end (right) position in the source zero terminated string and writes them to the destination string address.

::

   String_RightW PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string

* ``lpszDestination`` - Address of the destination buffer.

* ``qwLengthToRead`` - The number of characters to read from the right side.


**Returns**

Returns a pointer to the destination string in RAX.


**Notes**

This function as based on the MASM32 Library function: ucRight

**See Also**

:ref:`String_LeftW<String_LeftW>`, :ref:`String_MiddleW<String_MiddleW>`, :ref:`String_SubstringW<String_SubstringW>`
