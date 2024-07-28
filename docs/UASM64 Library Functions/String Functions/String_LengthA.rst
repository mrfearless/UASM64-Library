.. _String_LengthA:

==============
String_LengthA
==============

Reads the length of a zero terminated string and returns its length in RAX. This is the Ansi version of String_Length, String_LengthW is the Unicode version.

::

   String_LengthA PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - Address of zero terminated string.


**Returns**

The length of the zero terminated string without the terminating null in RAX.


**Notes**

This function as based on the MASM32 Library function: szLen

**See Also**

:ref:`String_CopyA<String_CopyA>`, :ref:`String_ConcatA<String_ConcatA>`
