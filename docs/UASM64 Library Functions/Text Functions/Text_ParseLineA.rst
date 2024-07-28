.. _Text_ParseLineA:

===============
Text_ParseLineA
===============

Parse words in a line of text into an array of zero terminated strings. This is the Ansi version of Text_ParseLine, Text_ParseLineW is the Unicode version

::

   Text_ParseLineA PROTO lpszTextSource:QWORD, pArray:QWORD


**Parameters**

* ``lpszTextSource`` - The address of the zero terminated line of text.

* ``pArray`` - The array to write the words to.


**Returns**

The return value is the number of words written to the array.


**Notes**

The words in the line of text are individually loaded into consecutive array locations. The array address passed to the procedure must be an array of pointers to preallocated memory. The Array_Create function is ideally suited to this task as it allocates the memory and sets the array of pointers to the members of the array.

When you allocate the array of zero terminated strings, you must ensure that the individual buffer size is large enough and there are enough members to handle the maximum number of words on the line of text.

Words are determined by an allowable character table. The function was originally designed to parse lines of assembler code so it supports the following characters:

   upper case            ABCDEFGHIJKLMNOPQRSTUVWXYZ    lower case            abcdefghijklmnopqrstuvwxyz    numbers               0123456789    quotation marks       " "    square brackets       [ ]    address calculation   + - *    label identification  :

The algorithm is flexible enough to do most normal line parsing requirements.

This function as based on the MASM32 Library function: parse_line

**See Also**

:ref:`Text_LineCountA<Text_LineCountA>`, :ref:`Text_LineCountExA<Text_LineCountExA>`, :ref:`Text_ReadLineA<Text_ReadLineA>`, :ref:`Text_TestLineA<Text_TestLineA>`
