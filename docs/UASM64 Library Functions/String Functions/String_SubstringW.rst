.. _String_SubstringW:

=================
String_SubstringW
=================

Find a needle in a haystack, or a substring within a string. This is the Unicode version of String_Substring, String_SubstringA is the Ansi version.

::

   String_SubstringW PROTO lpszString:QWORD, lpszSubString:QWORD


**Parameters**

* ``lpszString`` - Address of string to be searched.

* ``lpszSubString`` - Address of substring to search for within the main string.


**Returns**

Pointer to the substring found in lpszString, or start of lpszString.
If lpszString is empty then returns null.


**Notes**

This function is based on strstr by Mael Drapier, EPITECH promo 2021

**See Also**

:ref:`String_LeftW<String_LeftW>`, :ref:`String_RightW<String_RightW>`, :ref:`String_MiddleW<String_MiddleW>`
