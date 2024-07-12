.. _String_CompareIEx:

===================================
String_CompareIEx 
===================================

A case *insensitive* string comparison that compares two zero terminated strings for a difference.
    
::

   String_CompareIEx PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD, qwLengthString:QWORD


**Parameters**

* ``lpszCaseInsensitiveString1`` - The address of the first zero terminated string to compare.
* ``lpszCaseInsensitiveString2`` - The address of the second zero terminated string to compare.
* ``qwLengthString`` - The number of characters to test for, usually the length of the first string.


**Returns**

If the two text sources match as case insensitive, the return value is ``0``, otherwise the return value is non zero.

**Notes**

This function uses a character table and a character count and it can be used on any ``BYTE`` sequence including string. If you need to emulate the characteristics of the case sensitive version, convert both strings to a single case and then do a case sensitive comparison.

**Example**

::

   Invoke String_CompareIEx

**See Also**

:ref:`String_CompareI<String_CompareI>`, :ref:`String_Compare<String_Compare>`

