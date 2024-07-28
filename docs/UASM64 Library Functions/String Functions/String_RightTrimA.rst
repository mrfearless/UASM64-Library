.. _String_RightTrimA:

=================
String_RightTrimA
=================

Trims the trailing spaces and tabs from a zero terminated string and places the results in the destination buffer provided. This is the Ansi version of String_RightTrim, String_RightTrimW is the Unicode version.

::

   String_RightTrimA PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination buffer.


**Returns**

The return value is the length of the trimmed string which can be zero.


**Notes**

If the string is trimmed to zero length if it has no other characters, the first byte of the destination address will be ascii zero. Ensure the destination buffer is big enough to receive the substring, normally it is advisable to make the buffer the same size as the source string. If your design allows for overwriting the string, you can use the same string address for both source and destination.

This function as based on the MASM32 Library function: szRtrim

**See Also**

:ref:`String_LeftTrimA<String_LeftTrimA>`, :ref:`String_MonospaceA<String_MonospaceA>`, :ref:`String_TrimA<String_TrimA>`
