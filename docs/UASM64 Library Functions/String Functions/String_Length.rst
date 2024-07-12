.. _String_Length:

===================================
String_Length 
===================================

Reads the length of a zero terminated string and returns its length in ``RAX``.
    
::

   String_Length PROTO lpszString:QWORD


**Parameters**

* ``lpszString`` - Address of zero terminated string.


**Returns**

The length of the zero terminated string without the terminating null in ``RAX``.

**Notes**



**Example**

::

   Invoke String_Length

**See Also**

:ref:`String_Count<String_Count>`, :ref:`String_InString<String_InString>` 

