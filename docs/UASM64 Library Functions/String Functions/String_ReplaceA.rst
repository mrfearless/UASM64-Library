.. _String_ReplaceA:

===============
String_ReplaceA
===============

Replaces text in a zero terminated string. This is the Ansi version of String_Replace, String_ReplaceW is the Unicode version.

::

   String_ReplaceA PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD


**Parameters**

* ``lpszSource`` - The address of the source to replace text in.

* ``lpszDestination`` - The address of the destination string for the results.

* ``lpszTextToReplace`` - The address of the substring text to replace in the source string.

* ``lpszReplacementText`` - The address of the replacement text to use in place of the text in the lpszTextToReplace parameter in the source string.


**Returns**

No return value.


**Notes**

This function as based on the MASM32 Library function: szRep

**See Also**

:ref:`String_RemoveA<String_RemoveA>`, :ref:`String_WordReplaceA<String_WordReplaceA>`, :ref:`String_MiddleA<String_MiddleA>`
