.. _String_Right:

===================================
String_Right 
===================================

Gets a substring from the right side of a zero terminated string. String_Right reads a set number of characters from the end (right) position in the source zero terminated string and writes them to the destination string address.
    
::

   String_Right PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string
* ``lpszDestination`` - Address of the destination buffer.
* ``qwLengthToRead`` - The number of characters to read from the right side.


**Returns**

Returns a pointer to the destination string in ``RAX``.

**Notes**



**Example**

::

   Invoke String_Right

**See Also**

:ref:`String_Left<String_Left>`, :ref:`String_Middle<String_Middle>` 

