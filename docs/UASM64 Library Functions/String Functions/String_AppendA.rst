.. _String_AppendA:

==============
String_AppendA
==============

Appends a zero terminated string to the end of an existing zero terminated string. This is the Ansi version of String_Append, String_AppendW is the Unicode version.

::

   String_AppendA PROTO lpszDestination:QWORD, lpszSource:QWORD, qwDestinationOffset:QWORD


**Parameters**

* ``lpszDestination`` - The main string buffer to append the extra string to.

* ``lpszSource`` - The string to append to the main string buffer.

* ``qwDestinationOffset`` - The location offset to begin the append at.


**Returns**

The location of the end of the source buffer which can be used for the next call to String_Append as the qwDestinationOffset parameter.


**Notes**

This algorithm is designed to repeatedly append zero terminated string data to the end of a user defined buffer. It uses a location pointer to save repeatedly scanning the buffer for the end position. With a new buffer, the first byte should be set to ascii zero, with an existing zero terminated string in a buffer, you should supply the length and set the location parameter to that length.
The return value is the buffer end position which you pass back to the function for the next appended data.

This function as based on the MASM32 Library function: szappend

**See Also**

:ref:`String_ConcatA<String_ConcatA>`, :ref:`String_MultiCatA<String_MultiCatA>`
