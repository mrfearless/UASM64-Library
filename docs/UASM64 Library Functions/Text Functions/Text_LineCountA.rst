.. _Text_LineCountA:

===============
Text_LineCountA
===============

Get the line count of text by counting line feeds. This is the Ansi version of Text_LineCount, Text_LineCountW is the Unicode version.

::

   Text_LineCountA PROTO lpszText:QWORD


**Parameters**

* ``lpszText`` - The address of the text to count line feeds in.


**Returns**

The count of line feeds in the text or 0 if there are none.


**Notes**

This function as based on the MASM32 Library function: lfcnt

**See Also**

:ref:`Text_LineCountExA<Text_LineCountExA>`, :ref:`Text_ParseLineA<Text_ParseLineA>`, :ref:`Text_ReadLineA<Text_ReadLineA>`
