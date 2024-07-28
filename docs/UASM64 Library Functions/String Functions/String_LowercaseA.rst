.. _String_LowercaseA:

=================
String_LowercaseA
=================

Converts any uppercase characters in the supplied zero terminated string to lowercase. String_Lowercase works on the original string and writes it back to the same address. This is the Ansi version of String_Lowercase, String_LowercaseW is the Unicode version.

::

   String_LowercaseA PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to lowercase.


**Returns**

The address of the lowercase string in RAX.


**Notes**

This function as based on the MASM32 Library function: szLower

**See Also**

:ref:`String_UppercaseA<String_UppercaseA>`, :ref:`String_MonospaceA<String_MonospaceA>`
