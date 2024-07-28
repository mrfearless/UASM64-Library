.. _String_CountA:

=============
String_CountA
=============

Count the number of instances of a specified substring in a zero terminated string. This is the Ansi version of String_Count, String_CountW is the Unicode version.

::

   String_CountA PROTO lpszSource:QWORD, lpszSubString:QWORD


**Parameters**

* ``lpszSource`` - The address of the zero terminated string.

* ``lpszSubString`` - The zero terminated substring to count.


**Returns**

The return value is the number of instances of the substring that was counted in the source string.


**Notes**

This function as based on the MASM32 Library function: szWcnt

**See Also**

:ref:`String_InStringA<String_InStringA>`, :ref:`String_SubstringA<String_SubstringA>`
