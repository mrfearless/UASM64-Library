.. _Memory_Realloc:

==============
Memory_Realloc
==============

Re-allocates memory, by resizing and moving an existing memory block that was previously allocated via the Memory_Alloc function.

::

   Memory_Realloc PROTO pMemSource:QWORD, qwBytes:QWORD


**Parameters**

* ``pMemSource`` - The address of memory previously allocated by Memory_Alloc which is now to be resized.

* ``qwBytes`` - The new number of bytes to re-allocate.


**Returns**

A pointer to the allocated memory, or 0 if an error occured.


**Notes**


**See Also**

:ref:`Memory_Alloc<Memory_Alloc>`, :ref:`Memory_Free<Memory_Free>`
