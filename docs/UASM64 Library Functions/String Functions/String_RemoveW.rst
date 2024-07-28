.. _String_RemoveW:

==============
String_RemoveW
==============

Removes a substring from a zero terminated source string and writes the result in the destination string address.

::

   String_RemoveW PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination string, after which it will contain the source string minus the substring specified in the lpszSubStringToRemove parameter.

* ``lpszSubStringToRemove`` - The address of the substring to remove from the source string.


**Returns**

The destination address is returned in the RAX register.


**Notes**

The function supports using a single buffer for both the source and destination strings if the original string does not need to be preserved.

This function as based on the MASM32 Library function: ucRemove

**See Also**

:ref:`String_MiddleW<String_MiddleW>`, :ref:`String_ReplaceW<String_ReplaceW>`, :ref:`String_WordReplaceW<String_WordReplaceW>`
