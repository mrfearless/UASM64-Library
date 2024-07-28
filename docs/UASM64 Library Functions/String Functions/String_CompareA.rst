.. _String_CompareA:

===============
String_CompareA
===============

A case sensitive string comparison that compares two zero terminated strings for a difference. This is the Ansi version of String_Compare, String_CompareW is the Unicode version.

::

   String_CompareA PROTO lpszString1:QWORD, lpszString2:QWORD


**Parameters**

* ``lpszString1`` - The address of the first zero terminated string to compare.

* ``lpszString2`` - The address of the second zero terminated string to compare.


**Returns**

If the two strings match, the return value is the length of the string. If there is no match, the return value is zero.


**Notes**

The function can be used on strings that may be of uneven length as the terminator will produce the mismatch even if the rest of the characters match.

This function as based on the MASM32 Library function: szCmp

**See Also**

:ref:`String_CompareIA<String_CompareIA>`, :ref:`String_CompareIExA<String_CompareIExA>`
