.. _String_MonoSpace:

===================================
String_MonoSpace 
===================================

Format a string with single spaces and trimmed ends. String_MonoSpace formats a zero terminated string with single spaces only, replacing any tabs with spaces and trimming tabs and spaces from either end of the string.
    
::

   String_MonoSpace PROTO lpszSource:QWORD


**Parameters**

* ``lpszSource`` - The address of the zero terminated string to format.


**Returns**

The return value is the address of the source string in ``RAX``.

**Notes**

The algorithm removes any leading tabs and spaces then formats the string with single spaces replacing any tabs in the source with spaces. If there is a trailing space, the string is truncated to remove it.

**Example**

::

   Invoke String_MonoSpace

**See Also**

:ref:`String_LeftTrim<String_LeftTrim>`, :ref:`String_RightTrim<String_RightTrim>`, :ref:`String_Trim<String_Trim>`

