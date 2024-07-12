.. _String_Trim:

===================================
String_Trim 
===================================

Trims the leading and trailing spaces and tabs from a zero terminated string.
    
::

   String_Trim PROTO lpszString:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.
* ``lpszDestination`` -  The address of the destination buffer.


**Returns**

The return value is the length of the trimmed string which can be zero.

**Notes**

If the string is trimmed to zero length if it has no other characters, the first byte of the destination address will be ascii zero. This procedure acts on the original source string and overwrites it with the result. 

**Example**

::

   Invoke String_Trim

**See Also**

:ref:`String_LeftTrim<String_LeftTrim>`, :ref:`String_RightTrim<String_RightTrim>`, :ref:`String_MonoSpace<String_MonoSpace>`

