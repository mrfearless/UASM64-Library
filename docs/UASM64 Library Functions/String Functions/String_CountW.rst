.. _String_CountW:

=============
String_CountW
=============

Count the number of instances of a specified substring in a zero terminated string.

::

   String_CountW PROTO lpszSource:QWORD, lpszSubString:QWORD


**Parameters**

* ``lpszSource`` - The address of the zero terminated string.

* ``lpszSubString`` - The zero terminated substring to count.


**Returns**

The return value is the number of instances of the substring that was counted in the source string.


**Notes**

This function as based on the MASM32 Library function: ucWcnt

**See Also**

:ref:`String_InStringW<String_InStringW>`, :ref:`String_SubstringW<String_SubstringW>`
