.. _String_Lowercase:

===================================
String_Lowercase 
===================================

Converts any uppercase characters in the supplied zero terminated string to lowercase. String_Lowercase works on the original string and writes it back to the same address.
    
::

   String_Lowercase PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - The address of the text to convert to lowercase.


**Returns**

The address of the lowercase string in ``RAX``.

**Notes**



**Example**

::

   Invoke String_Lowercase

**See Also**

:ref:`String_Uppercase<String_Uppercase>`, :ref:`String_MonoSpace<String_MonoSpace>`, :ref:`String_Reverse<String_Reverse>` 

