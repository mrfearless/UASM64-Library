.. _String_RemoveA:

==============
String_RemoveA
==============

Removes a substring from a zero terminated source string and writes the result in the destination string address. This is the Ansi version of String_Remove, String_RemoveW is the Unicode version.

::

   String_RemoveA PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszSubStringToRemove:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.

* ``lpszDestination`` - The address of the destination string, after which it will contain the source string minus the substring specified in the lpszSubStringToRemove parameter.

* ``lpszSubStringToRemove`` - The address of the substring to remove from the source string.


**Returns**

The destination address is returned in the RAX register.


**Notes**

The function supports using a single buffer for both the source and destination strings if the original string does not need to be preserved.

This function as based on the MASM32 Library function: szRemove

**See Also**

:ref:`String_MiddleA<String_MiddleA>`, :ref:`String_ReplaceA<String_ReplaceA>`, :ref:`String_WordReplaceA<String_WordReplaceA>`
