.. _Memory_Zero:

===========
Memory_Zero
===========

Memory_Zero is a fast memory zeroing function that works in QWORD unit sizes It is usually good practice to allocate memory in intervals of eight for alignment purposes and this function is designed to work with memory allocated in this way

::

   Memory_Zero PROTO pMemoryAddress:QWORD, qwMemoryLength:QWORD


**Parameters**

* ``pMemoryAddress`` - The address of the memory block to zero.

* ``qwMemoryLength`` - The buffer length to zero.


**Returns**

There is no return value.


**Notes**

This function as based on: Memory_Fill

**See Also**

:ref:`Memory_Fill<Memory_Fill>`
