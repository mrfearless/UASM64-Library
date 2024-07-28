.. _String_UppercaseW:

=================
String_UppercaseW
=================

Converts any lowercase characters in the supplied zero terminated string to uppercase. String_Uppercase works on the original string and writes it back to the same address.

::

   String_UppercaseW PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to uppercase.


**Returns**

The address of the uppercase string in RAX.


**Notes**

This function as based on the MASM32 Library function: ucUpper

**See Also**

:ref:`String_LowercaseW<String_LowercaseW>`, :ref:`String_MonospaceW<String_MonospaceW>`
