.. _String_AppendW:

==============
String_AppendW
==============

Appends a zero terminated string to the end of an existing zero terminated string. This is the Unicode version of String_Append, String_AppendA is the Ansi version.

::

   String_AppendW PROTO lpszDestination:QWORD,lpszSource:QWORD,qwDestinationOffset:QWORD


**Parameters**

* ``lpszDestination`` - The main string buffer to append the extra string to.

* ``lpszSource `` - The string to append to the main string buffer.

* ``qwDestinationOffset `` - The location offset to begin the append at.


**Returns**

The location of the end of the source buffer which can be used for the next call to String_Append as the qwDestinationOffset parameter.


**Notes**

This algorithm is designed to repeatedly append zero terminated string data to the end of a user defined buffer. It uses a location pointer to save repeatedly scanning the buffer for the end position. With a new buffer, the first byte should be set to ascii zero, with an existing zero terminated string in a buffer, you should supply the length and set the location parameter to that length.
The return value is the buffer end position which you pass back to the function for the next appended data.

NOTE that qwDestinationOffset is a BYTE counter. To get the UNICODE character count, divide qwDestinationOffset by 2.

This function as based on the MASM32 Library function: ucappend

**See Also**

:ref:`String_ConcatW<String_ConcatW>`, :ref:`String_MultiCatW<String_MultiCatW>`
