.. _String_Uppercase:

===================================
String_Uppercase 
===================================

Converts any lowercase characters in the supplied zero terminated string to uppercase. String_Uppercase works on the original string and writes it back to the same address.
    
::

   String_Uppercase PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to uppercase.


**Returns**

The address of the uppercase string in ``RAX``.

**Notes**



**Example**

::

   Invoke String_Uppercase

**See Also**

:ref:`String_Lowercase<String_Lowercase>`, :ref:`String_MonoSpace<String_MonoSpace>`, :ref:`String_Reverse<String_Reverse>` 

