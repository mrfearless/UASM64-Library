.. _String_SubstringA:

=================
String_SubstringA
=================

Find a needle in a haystack, or a substring within a string. This is the Ansi version of String_Substring, String_SubstringW is the Unicode version.

::

   String_SubstringA PROTO lpszString:QWORD, lpszSubString:QWORD


**Parameters**

* ``lpszString`` - Address of string to be searched.

* ``lpszSubString`` - Address of substring to search for within the main string.


**Returns**

Pointer to the substring found in lpszString, or start of lpszString.
If lpszString is empty then returns null.


**Notes**

This function is based on strstr by Mael Drapier, EPITECH promo 2021

**See Also**

:ref:`String_LeftA<String_LeftA>`, :ref:`String_RightA<String_RightA>`, :ref:`String_MiddleA<String_MiddleA>`
