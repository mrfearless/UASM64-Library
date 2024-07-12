.. _String_CompareI:

===================================
String_CompareI 
===================================

A case *insensitive* string comparison that compares two zero terminated strings for a difference.
    
::

   String_CompareI PROTO lpszCaseInsensitiveString1:QWORD, lpszCaseInsensitiveString2:QWORD


**Parameters**

* ``lpszCaseInsensitiveString1`` - The address of the first zero terminated string to compare.
* ``lpszCaseInsensitiveString2`` - The address of the second zero terminated string to compare.


**Returns**

If the two text sources match as case insensitive, the return value is ``0``, otherwise the return value is non zero.

**Notes**

This version differs from :ref:`String_CompareIEx<String_CompareIEx>` in that it detects the zero terminator without the need for the length to be specified as an additional argument.

**Example**

::

   Invoke String_CompareI

**See Also**

:ref:`String_Compare<String_Compare>`, :ref:`String_CompareIEx<String_CompareIEx>` 

