.. _Text_LineCountW:

===============
Text_LineCountW
===============

Get the line count of text by counting line feeds. This is the Unicode version of Text_LineCount, Text_LineCountA is the Ansi version.

::

   Text_LineCountW PROTO lpszText:QWORD


**Parameters**

* ``lpszText`` - The address of the text to count line feeds in.


**Returns**

The count of line feeds in the text or 0 if there are none.


**Notes**

This function as based on the MASM32 Library function: lfcnt

**See Also**

:ref:`Text_LineCountExW<Text_LineCountExW>`, :ref:`Text_ParseLineW<Text_ParseLineW>`, :ref:`Text_ReadLineW<Text_ReadLineW>`
