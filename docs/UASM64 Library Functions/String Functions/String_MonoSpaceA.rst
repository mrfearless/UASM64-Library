.. _String_MonoSpaceA:

=================
String_MonoSpaceA
=================

Format a string with single spaces and trimmed ends. String_MonoSpace formats a zero terminated string with single spaces only, replacing any tabs with spaces and trimming tabs and spaces from either end of the string. This is the Ansi version of String_MonoSpace, String_MonoSpaceW is the Unicode version.

::

   String_MonoSpaceA PROTO lpszSource:QWORD


**Parameters**

* ``lpszSource`` - The address of the zero terminated string to format.


**Returns**

The return value is the address of the source string.


**Notes**

The algorithm removes any leading tabs and spaces then formats the string with single spaces replacing any tabs in the source with spaces. If there is a trailing space, the string is truncated to remove it.

This function as based on the MASM32 Library function: szMonoSpace 	

**See Also**

:ref:`String_LowercaseA<String_LowercaseA>`, :ref:`String_UppercaseA<String_UppercaseA>`, :ref:`String_LeftTrimA<String_LeftTrimA>`, :ref:`String_RightTrimA<String_RightTrimA>`
