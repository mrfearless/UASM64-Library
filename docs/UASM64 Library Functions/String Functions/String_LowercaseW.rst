.. _String_LowercaseW:

=================
String_LowercaseW
=================

Converts any uppercase characters in the supplied zero terminated string to lowercase. String_Lowercase works on the original string and writes it back to the same address.

::

   String_LowercaseW PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to lowercase.


**Returns**

The address of the lowercase string in RAX.


**Notes**

This function as based on the MASM32 Library function: ucLower

**See Also**

:ref:`String_UppercaseW<String_UppercaseW>`, :ref:`String_MonospaceW<String_MonospaceW>`
