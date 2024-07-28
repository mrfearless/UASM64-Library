.. _Text_TestLineW:

==============
Text_TestLineW
==============

This function tests the first character after any tabs or spaces to determine if the line has usable text or not. If the text has the first non-white space below ascii 32, which includes ascii zero (0), CR (13) and LF (10), it returns zero otherwise it returns the zero extended first character in EAX for testing by the caller. This can be used to test if the first character is a comment so that the caller can bypass the contents of the line. The return value can be tested either as a QWORD with a numeric value with RAX or directly as a BYTE in AL. This is the Unicode version of Text_TestLine, Text_TestLineA is the Ansi version.

::

   Text_TestLineW PROTO lpszTextSource:QWORD


**Parameters**

* ``lpszTextSource`` - the address of the source text to test.


**Returns**

If the return value is ZERO, the line of text has no useful content.
If the return value is not ZERO, it is the ascii number of the first character zero extended into RAX.


**Notes**

This function as based on the MASM32 Library function: tstline

**See Also**

:ref:`Text_LineCountW<Text_LineCountW>`, :ref:`Text_LineCountExW<Text_LineCountExW>`, :ref:`Text_ParseLineW<Text_ParseLineW>`
