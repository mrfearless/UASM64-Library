.. _String_ConcatA:

==============
String_ConcatA
==============

Concatenate two strings by appending the second zero terminated string (lpszSource) to the end of the first zero terminated string (lpszDestination) This is the Ansi version of String_Concat, String_ConcatW is the Unicode version. The result is zero terminated.

::

   String_ConcatA PROTO lpszDestination:QWORD, lpszSource:QWORD


**Parameters**

* ``lpszDestination`` - The address of the destination string to be appended to.

* ``lpszSource`` - The address of the string to append to destination string.


**Returns**

No return value.


**Notes**

This function as based on the MASM32 Library function: szCatStr

**See Also**

:ref:`String_AppendA<String_AppendA>`, :ref:`String_MultiCatA<String_MultiCatA>`
