.. _String_MultiCatW:

================
String_MultiCatW
================

Concatenate multiple strings. String_MultiCat uses a buffer that can be appended with multiple zero terminated strings, which is more efficient when multiple strings need to be concantenated.

::

   String_MultiCatW PROTO qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG


**Parameters**

* ``qwNumberOfStrings`` - The number of zero terminated strings to append.

* ``lpszDestination`` - The address of the buffer to appends the strings to.

* ``StringArgs`` - The comma seperated parameter list, each with the address of a zero terminated string to append to the main destination string.


**Returns**

This function does not return a value.


**Notes**

The allocated buffer pointed to by the lpszDestination parameter must be large enough to accept all of the appended zero terminated strings. The parameter count using StringArgs must match the number of zero terminated strings as specified by the qwNumberOfStrings parameter.

This original algorithm was designed by Alexander Yackubtchik. It was re-written in August 2006.

This function as based on the MASM32 Library function: ucMultiCat

**See Also**

:ref:`String_AppendW<String_AppendW>`, :ref:`String_ConcatW<String_ConcatW>`
