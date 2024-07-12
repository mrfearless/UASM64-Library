.. _String_MultiCat:

===================================
String_MultiCat 
===================================

Concatenate multiple strings.
    
::

   String_MultiCat PROTO qwNumberOfStrings:QWORD, lpszDestination:QWORD, StringArgs:VARARG


**Parameters**

* ``qwNumberOfStrings`` - The number of zero terminated strings to append.
* ``lpszDestination`` - The address of the buffer to appends the strings to.
* ``StringArgs`` - The comma seperated parameter list, each with the address of a zero terminated string to append to the main destination string.


**Returns**

This function does not return a value.

**Notes**

The allocated buffer pointed to by the lpszDestination parameter must be large enough to accept all of the appended zero terminated strings. 

The parameter count using ``StringArgs`` must match the number of zero terminated strings as specified by the ``qwNumberOfStrings`` parameter.
 
This original algorithm was designed by Alexander Yackubtchik. It was re-written in August 2006.

**Example**

::

   Invoke String_MultiCat

**See Also**

:ref:`String_CatStr<String_CatStr>`, :ref:`String_Append<String_Append>` 

