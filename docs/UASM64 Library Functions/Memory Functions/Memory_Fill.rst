.. _Memory_Fill:

===========
Memory_Fill
===========

Memory_Fill is a fast memory filling function that works in QWORD unit sizes It is usually good practice to allocate memory in intervals of eight for alignment purposes and this function is designed to work with memory allocated in this way

::

   Memory_Fill PROTO pMemoryAddress:QWORD, qwMemoryLength:QWORD, qwFill:QWORD


**Parameters**

* ``pMemoryAddress`` - The address of the memory block to fill.

* ``qwMemoryLength`` - The buffer length to fill.

* ``qwFill`` - The fill character(s).


**Returns**

There is no return value.


**Notes**

In most instances the fill character will be ascii zero but the QDWORD value can be arranged in any manner convenient, it also can be loaded as a string which will be repeated at 8 byte intervals.

NOTE that the characters in the string will be reversed so that if you place "12345678" in the QWORD variable, it will be written to the memory filled as "87654321" for the length of the filled memory. Also note that the function will round down the fill to the next interval of 8 if the buffer does not divide equally by eight.

This function as based on the MASM32 Library function: memfill

**See Also**

:ref:`Memory_Zero<Memory_Zero>`
