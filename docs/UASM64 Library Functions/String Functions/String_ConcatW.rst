.. _String_ConcatW:

==============
String_ConcatW
==============

Concatenate two strings by appending the second zero terminated string (lpszSource) to the end of the first zero terminated string (lpszDestination) The result is zero terminated.

::

   String_ConcatW PROTO lpszDestination:QWORD, lpszSource:QWORD


**Parameters**

* ``lpszDestination`` - The address of the destination string to be appended to.

* ``lpszSource`` - The address of the string to append to destination string.


**Returns**

No return value.


**Notes**

This function as based on the MASM32 Library function: ucCatStr

**See Also**

:ref:`String_AppendW<String_AppendW>`, :ref:`String_MultiCatW<String_MultiCatW>`
