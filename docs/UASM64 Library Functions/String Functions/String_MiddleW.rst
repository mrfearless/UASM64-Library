.. _String_MiddleW:

==============
String_MiddleW
==============

Gets a substring from the middle of a zero terminated string. String_Middle reads a set number of characters from a set starting position in the source zero terminated string and writes them to the destination string address.

::

   String_MiddleW PROTO lpszSource:QWORD, lpszSubString:QWORD, qwStartPosition:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string to read from.

* ``lpszSubString`` - Address of the destination string to receive the substring.

* ``qwStartPosition`` - Start position of first character in the source string.

* ``qwLengthToRead`` - The number of bytes to read in the source string.


**Returns**

There is no return value.


**Notes**

It is the users responsibility to ensure that the length of the substring is fully contained within the source string. Failure to do so will result in either a read or write page fault.

This function as based on the MASM32 Library function: ucMid

**See Also**

:ref:`String_LeftW<String_LeftW>`, :ref:`String_RightW<String_RightW>`, :ref:`String_MiddleW<String_MiddleW>`
