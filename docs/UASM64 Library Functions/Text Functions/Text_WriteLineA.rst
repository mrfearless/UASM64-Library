.. _Text_WriteLineA:

===============
Text_WriteLineA
===============

Writes a line of text to a memory buffer and updates the last write position. This is the Ansi version of Text_WriteLine, Text_WriteLineW is the Unicode version.

::

   Text_WriteLineA PROTO lpszTextLineBuffer:QWORD, lpszTextDestination:QWORD, qwTextDestinationOffset:QWORD, bNoCRLF:QWORD


**Parameters**

* ``lpszTextLineBuffer`` - The address of the text line to write to the buffer.

* ``lpszTextDestination`` - The address of the destination buffer to write to.

* ``qwTextDestinationOffset`` - The current destination location pointer.

* ``bNoCRLF`` - TRUE = no CRLF appended, FALSE = CRLF is appended.


**Returns**

In RAX the updated offset in the desintation buffer.
In RCX the number of BYTES written.


**Notes**

This algorithm is useful for writing text files directly to memory so the result can be written in one disk write. Normally the qwTextDestinationOffset  variable is allocated before the procedure is called, initialised to zero and  updated each time the procedure returns with the new value.

This function as based on the MASM32 Library function: writeline

**See Also**

:ref:`Text_LineCountA<Text_LineCountA>`, :ref:`Text_LineCountExA<Text_LineCountExA>`, :ref:`Text_ReadLineA<Text_ReadLineA>`
