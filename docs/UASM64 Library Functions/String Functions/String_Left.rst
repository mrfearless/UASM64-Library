.. _String_Left:

===================================
String_Left 
===================================

Gets a substring from the left side of a zero terminated string. String_Left reads a set number of characters from the beginning (left) position in the source zero terminated string and writes them to the destination string address.
    
::

   String_Left PROTO lpszSource:QWORD, lpszDestination:QWORD, qwLengthToRead:QWORD


**Parameters**

* ``lpszSource`` - Address of the source string.
* ``lpszDestination`` - Address of the destination buffer.
* ``qwLengthToRead`` - The number of characters to read from the left side.


**Returns**

Returns a pointer to the destination string in ``RAX``.

**Notes**



**Example**

::

   Invoke String_Left

**See Also**

:ref:`String_Right<String_Right>`, :ref:`String_Middle<String_Middle>` 

