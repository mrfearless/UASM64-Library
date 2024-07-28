.. _Text_ReadLineW:

==============
Text_ReadLineW
==============

Read a line of text. This is the Unicode version of Text_ReadLine, Text_ReadLineA is the Ansi version.

::

   Text_ReadLineW PROTO lpszTextSource:QWORD, lpszTextLineBuffer:QWORD, qwTextSourceOffset:QWORD


**Parameters**

* ``lpszTextSource`` - the address of the memory to read the text from.

* ``lpszTextLineBuffer`` - the destination buffer to write the line of text to.

* ``qwTextSourceOffset`` - the current source location pointer.


**Returns**

In RAX the updated offset in the source text.
In RCX the line length not including the terminating 0 or carriage return.


**Notes**

Text_ReadLine copies a line of text from the source (lpszTextSource) to the buffer (lpszTextLineBuffer) starting from the offset set in the qwTextSourceOffset parameter. Initially qwTextSourceOffset should be set to 0
The return value from Text_ReadLine should be used to update the qwTextSourceOffset parameter to start again at the following line of text.

RAX returns ZERO if the end of the source is on the curent line.

The length of the line not including ascii 0 and 13 is returned in RCX. 
You should test the buffer if ZERO is returned in RAX as it may contain the last line of text that is zero terminated.

Conditions to test for:

- End of source returns zero in RAX.
- blank line has 1st byte in buffer set to zero and a line length in RCX of 0 - Line length is returned in RCX.

This function as based on the MASM32 Library function: readline

**See Also**

:ref:`Text_LineCountW<Text_LineCountW>`, :ref:`Text_LineCountExW<Text_LineCountExW>`, :ref:`Text_ParseLineW<Text_ParseLineW>`, :ref:`Text_TestLineW<Text_TestLineW>`, :ref:`Text_WriteLineW<Text_WriteLineW>`
