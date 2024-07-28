.. _String_CompareIA:

================
String_CompareIA
================

A case insensitive string comparison that compares two zero terminated strings for a difference. This is the Ansi version of String_CompareI, String_CompareIW is the Unicode version.

::

   String_CompareIA PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD


**Parameters**

* ``lpszCaseInsensitiveString1`` - The address of the first zero terminated string to compare.

* ``lpszCaseInsensitiveString2`` - The address of the second zero terminated string to compare.


**Returns**

If the two text sources match as case insensitive, the return value is 0, otherwise the return value is non zero.


**Notes**

This version differs from String_CompareIEx in that it detects the zero terminator without the need for the length to be specified as an additional argument.

This function as based on the MASM32 Library function: Cmpi

**See Also**

:ref:`String_CompareA<String_CompareA>`, :ref:`String_CompareIExA<String_CompareIExA>`
