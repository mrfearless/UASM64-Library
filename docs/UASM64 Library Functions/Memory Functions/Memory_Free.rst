.. _Memory_Free:

===========
Memory_Free
===========

Frees a block of memory previously allocated through a call to Memory_Alloc. The number of bytes freed equals the number of bytes that were allocated. After the call, the memory block pointed to by pMemoryAddress is invalid and can no longer be used. Note: the pMemoryAddress parameter can be NULL. If so, this method has no effect. 

::

   Memory_Free PROTO pMemoryAddress:QWORD


**Parameters**

* ``pMemoryAddress`` - Address of memory returned by Memory_Alloc when the memory was initially allocated.


**Returns**

There is no return value.


**Notes**

This function as based on the MASM32 Library function: Free

**See Also**

:ref:`Memory_Alloc<Memory_Alloc>`, :ref:`Memory_Realloc<Memory_Realloc>`
