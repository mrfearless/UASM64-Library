.. _String_RightA:

=============
String_RightA
=============

Gets a substring from the right side of a zero terminated string. String_Right reads a set number of characters from the end (right) position in the source zero terminated string and writes them to the destination string address. This is the Ansi version of String_Right, String_RightW is the Unicode version.

::

   String_RightA PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string

* ``lpszDestination`` - Address of the destination buffer.

* ``qwLengthToRead`` - The number of characters to read from the right side.


**Returns**

Returns a pointer to the destination string in RAX.


**Notes**

This function as based on the MASM32 Library function: szRight

**See Also**

:ref:`String_LeftA<String_LeftA>`, :ref:`String_MiddleA<String_MiddleA>`, :ref:`String_SubstringA<String_SubstringA>`
