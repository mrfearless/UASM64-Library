.. _String_UppercaseA:

=================
String_UppercaseA
=================

Converts any lowercase characters in the supplied zero terminated string to uppercase. String_Uppercase works on the original string and writes it back to the same address. This is the Ansi version of String_Uppercase, String_UppercaseW is the Unicode version.

::

   String_UppercaseA PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to uppercase.


**Returns**

The address of the uppercase string in RAX.


**Notes**

This function as based on the MASM32 Library function: szUpper

**See Also**

:ref:`String_LowercaseA<String_LowercaseA>`, :ref:`String_MonospaceA<String_MonospaceA>`
