.. _String_CatStr:

===================================
String_CatStr 
===================================

Concatenate two strings by appending the second zero terminated string 
``lpszSource`` to the end of the first zero terminated string ``lpszDestination``
    
::

   String_CatStr PROTO lpszDestination:QWORD, lpszSource:QWORD


**Parameters**

* ``lpszDestination`` - The address of the destination string to be appended to.
* ``lpszSource`` - The address of the string to append to destination string.


**Returns**

No return value.

**Notes**

The result is zero terminated.

**Example**

::

   Invoke String_CatStr

**See Also**

:ref:`String_Append<String_Append>`, :ref:`String_MultiCat<String_MultiCat>` 

