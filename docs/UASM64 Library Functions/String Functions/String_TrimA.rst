.. _String_TrimA:

============
String_TrimA
============

Trims the leading and trailing spaces and tabs from a zero terminated string. This is the Ansi version of String_Trim, String_TrimW is the Unicode version.

::

   String_TrimA PROTO lpszSource:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.


**Returns**

The return value is the length of the trimmed string which can be zero.


**Notes**

If the string is trimmed to zero length if it has no other characters, the first byte of the destination address will be ascii zero. This procedure acts on the original source string and overwrites it with the result. 
This function as based on the MASM32 Library function: szTrim

**See Also**

:ref:`String_LeftTrimA<String_LeftTrimA>`, :ref:`String_RightTrimA<String_RightTrimA>`, :ref:`String_MonospaceA<String_MonospaceA>`
