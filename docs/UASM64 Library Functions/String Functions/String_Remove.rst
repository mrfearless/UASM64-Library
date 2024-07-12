.. _String_Remove:

===================================
String_Remove 
===================================

Removes a substring from a zero terminated source string and writes the result in the destination string address.
    
::

   String_Remove PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.
* ``lpszDestination`` - The address of the destination string, after which it will contain the source string minus the substring specified in the ``lpszSubStringToRemove`` parameter.
* ``lpszSubStringToRemove`` - The address of the substring to remove from the source string.


**Returns**

The destination address is returned in ``RAX``.

**Notes**

The function supports using a single buffer for both the source and destination strings if the original string does not need to be preserved.

**Example**

::

   Invoke String_Remove

**See Also**

:ref:`String_Replace<String_Replace>`, :ref:`String_Left<String_Left>`, :ref:`String_Right<String_Right>`, :ref:`String_Middle<String_Middle>`

