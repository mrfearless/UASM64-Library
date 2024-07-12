.. _String_Count:

===================================
String_Count 
===================================

Count the number of instances of a specified substring in a zero terminated string.
    
::

   String_Count PROTO lpszSource:QWORD, lpszSubString:QWORD


**Parameters**

* ``lpszSource`` - The address of the source string.
* ``lpszDestination`` - The zero terminated substring to count.


**Returns**

The return value is the number of instances of the substring that was counted in the source string.

**Notes**



**Example**

::

   Invoke String_Count

**See Also**

:ref:`String_InString<String_InString>`, :ref:`String_Middle<String_Middle>` 

