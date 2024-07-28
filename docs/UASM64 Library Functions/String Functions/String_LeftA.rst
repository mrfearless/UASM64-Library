.. _String_LeftA:

============
String_LeftA
============

Gets a substring from the left side of a zero terminated string. String_Left reads a set number of characters from the beginning (left) position in the source zero terminated string and writes them to the destination string address. This is the Ansi version of String_LeftA, String_LeftW is the Unicode version.

::

   String_LeftA PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string.

* ``lpszDestination`` - Address of the destination buffer.

* ``qwLengthToRead`` - The number of characters to read from the left side.


**Returns**

Returns a pointer to the destination string in RAX.


**Notes**

This function as based on the MASM32 Library function: szLeft

**See Also**

:ref:`String_RightA<String_RightA>`, :ref:`String_MiddleA<String_MiddleA>`, :ref:`String_SubstringA<String_SubstringA>`
