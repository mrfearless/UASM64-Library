.. _String_ReverseW:

===============
String_ReverseW
===============

Reverses a zero terminated string in lpszSource and places it in the string buffer pointed to by the lpszDestination parameter.

::

   String_ReverseW PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination string buffer.


**Returns**

Returns a pointer to the destination string in RAX.


**Notes**

The destination string buffer must be at least the size of the source string buffer, otherwise a read page fault will occur. String_Reverse can reverses a string in a single memory buffer, so it can accept the same address as both the source and destination string.

This function as based on the MASM32 Library function: ucRev

**See Also**

:ref:`String_LowercaseW<String_LowercaseW>`, :ref:`String_UppercaseW<String_UppercaseW>`
