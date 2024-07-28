.. _Text_LineCountExA:

=================
Text_LineCountExA
=================

Get the line count of text by counting line feeds. This is the Ansi version of Text_LineCountEx, Text_LineCountExW is the Unicode version.

::

   Text_LineCountExA PROTO lpszText:QWORD, qwTextLength:QWORD


**Parameters**

* ``lpszText`` - The address of the text to count line feeds in.

* ``qwTextLength`` - the length of the text string pointed to by lpszText.


**Returns**

The count of line feeds in the text or 0 if there are none.


**Notes**

This function will add an additional CRLF pair at the end of the text if it previously did not have one.

This function as based on the MASM32 Library function: get_line_count

**See Also**

:ref:`Text_LineCountA<Text_LineCountA>`, :ref:`Text_ParseLineA<Text_ParseLineA>`, :ref:`Text_ReadLineA<Text_ReadLineA>`
