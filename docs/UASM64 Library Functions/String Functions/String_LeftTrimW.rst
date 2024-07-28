.. _String_LeftTrimW:

================
String_LeftTrimW
================

Trims the leading spaces and tabs from a zero terminated string and places the results in the destination buffer provided.

::

   String_LeftTrimW PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination buffer.


**Returns**

The return value is the length of the trimmed string which can be zero.


**Notes**

If the string is trimmed to zero length if it has no other characters, the first byte of the destination address will be ascii zero. Ensure the destination buffer is big enough to receive the substring, normally it is advisable to make the buffer the same size as the source string. If your design allows for overwriting the string, you can use the same string address for both source and destination.

This function as based on the MASM32 Library function: ucLtrim

**See Also**

:ref:`String_RightTrimW<String_RightTrimW>`, :ref:`String_MonospaceW<String_MonospaceW>`
