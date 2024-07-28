.. _String_MonoSpaceW:

=================
String_MonoSpaceW
=================

Format a string with single spaces and trimmed ends. String_MonoSpace formats a zero terminated string with single spaces only, replacing any tabs with spaces and trimming tabs and spaces from either end of the string.

::

   String_MonoSpaceW PROTO lpszSource:QWORD


**Parameters**

* ``lpszSource`` - The address of the zero terminated string to format.


**Returns**

The return value is the address of the source string.


**Notes**

The algorithm removes any leading tabs and spaces then formats the string with single spaces replacing any tabs in the source with spaces. If there is a trailing space, the string is truncated to remove it.

This function as based on the MASM32 Library function: ucMonoSpace

**See Also**

:ref:`String_LowercaseW<String_LowercaseW>`, :ref:`String_UppercaseW<String_UppercaseW>`, :ref:`String_LeftTrimW<String_LeftTrimW>`, :ref:`String_RightTrimW<String_RightTrimW>`
