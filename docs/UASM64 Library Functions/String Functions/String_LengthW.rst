.. _String_LengthW:

==============
String_LengthW
==============

Reads the length of a zero terminated string and returns its length in RAX.

::

   String_LengthW PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - Address of zero terminated string.


**Returns**

The length of the zero terminated string without the terminating null in RAX.


**Notes**

This function as based on the MASM32 Library function: ucLen

**See Also**

:ref:`String_CopyW<String_CopyW>`, :ref:`String_ConcatW<String_ConcatW>`
