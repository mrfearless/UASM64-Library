.. _Memory_Alloc:

============
Memory_Alloc
============

Allocate a block of memory. The Alloc method allocates a memory block in essentially the same way that the C Library malloc function does. The initial contents of the returned memory block are undefined there is no guarantee that the block has been initialized, so you should initialize it in your code. The allocated block may be larger than cb bytes because of the space required for alignment and for maintenance information. If qwBytes is zero, Memory_Alloc allocates a zero-length item and returns a valid pointer to that item. If there is insufficient memory available, Memory_Alloc returns 0. Note applications should always check the return value from this method, even when requesting small amounts of memory, because there is no guarantee the memory will be allocated

::

   Memory_Alloc PROTO qwBytes:QWORD


**Parameters**

* ``qwBytes`` - The number of bytes to allocate.


**Returns**

A pointer to the allocated memory, or 0 if an error occured.


**Notes**

This function as based on the MASM32 Library function: Alloc

**See Also**

:ref:`Memory_Realloc<Memory_Realloc>`, :ref:`Memory_Free<Memory_Free>`
