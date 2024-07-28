.. _String_ReplaceW:

===============
String_ReplaceW
===============

Replaces text in a zero terminated string.

::

   String_ReplaceW PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD


**Parameters**

* ``lpszSource`` - The address of the source to replace text in.

* ``lpszDestination`` - The address of the destination string for the results.

* ``lpszTextToReplace`` - The address of the substring text to replace in the source string.

* ``lpszReplacementText`` - The address of the replacement text to use in place of the text in the lpszTextToReplace parameter in the source string.


**Returns**

No return value.


**Notes**

This function as based on the MASM32 Library function: ucRep

**See Also**

:ref:`String_RemoveW<String_RemoveW>`, :ref:`String_WordReplaceW<String_WordReplaceW>`, :ref:`String_MiddleW<String_MiddleW>`
