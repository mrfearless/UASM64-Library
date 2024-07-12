.. _String_Replace:

===================================
String_Replace 
===================================

Replaces text in a zero terminated string.
    
::

   String_Replace PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszTextToReplace:QWORD, lpszReplacementText:QWORD


**Parameters**

* ``lpszSource`` - The address of the source to replace text in.
* ``lpszDestination`` - The address of the destination string for the results.
* ``lpszTextToReplace`` - The address of the substring text to replace in the source string.
* ``lpszReplacementText`` - The address of the replacement text to use in place of the text in the ``lpszTextToReplace`` parameter in the source string.

**Returns**

No return value.

**Notes**



**Example**

::

   Invoke String_Replace

**See Also**

:ref:`String_Remove<String_Remove>`, :ref:`String_WordReplace<String_WordReplace>`, :ref:`String_Middle<String_Middle>` 

