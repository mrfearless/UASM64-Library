.. _String_InStringW:

================
String_InStringW
================

Find a substring in a zero terminated source string. InString searches for a substring (lpszSubString) in a larger string (lpszString) and if it is found, it returns its starting position in RAX. It uses a one (1) based character index (1st character is 1, 2nd is 2 etc...) for both the qwStartPosition parameter and the returned character position.

::

   String_InStringW PROTO qwStartPosition:QWORD, lpszString:QWORD, lpszSubString:QWORD


**Parameters**

* ``qwStartPosition`` - Starting position to search for the substring.

* ``lpszString`` - Address of string to be searched.

* ``lpszSubString`` - Address of substring to search for within the main string.


**Returns**

If the function succeeds, it returns the 1 based index of the start of the substring or 0 if no match is found.


**Notes**

If the function fails, the following error values apply:

-1 = substring same length or longer than main string.
-2 = qwStartPosition parameter out of range (less than 1 or greater than      main string length)
This function as based on the MASM32 Library function: ucFind

**See Also**

:ref:`String_CountW<String_CountW>`, :ref:`String_SubstringW<String_SubstringW>`
