.. _String_Copy:

===================================
String_Copy 
===================================

Copies a zero terminated string from the source buffer to the destination buffer.
    
::

   String_Copy PROTO lpszSource:QWORD, lpszDestination:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.
* ``lpszDestination`` - The address of the destination string buffer.


**Returns**

The copied length minus the terminating null is returned in ``RAX``.

**Notes**

The destination buffer must be large enough to hold the source string otherwise a page write fault will occur.

**Example**

::

   Invoke String_Copy

**See Also**

:ref:`String_CatStr<String_CatStr>`, :ref:`String_Length<String_Length>` 

