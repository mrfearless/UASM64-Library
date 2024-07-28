.. _Text_LineCountExW:

=================
Text_LineCountExW
=================

Get the line count of text by counting line feeds. This is the Unicode version of Text_LineCountEx, Text_LineCountExA is the Ansi version.

::

   Text_LineCountExW PROTO lpszText:QWORD, qwTextLength:QWORD


**Parameters**

* ``lpszText`` - The address of the text to count line feeds in.

* ``qwTextLength`` - the length of the text string pointed to by lpszText.


**Returns**

The count of line feeds in the text or 0 if there are none.


**Notes**

This function will add an additional CRLF pair at the end of the text if it previously did not have one.

This function as based on the MASM32 Library function: get_line_count

**See Also**

:ref:`Text_LineCountW<Text_LineCountW>`, :ref:`Text_ParseLineW<Text_ParseLineW>`, :ref:`Text_ReadLineW<Text_ReadLineW>`
