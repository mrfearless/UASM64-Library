.. _Memory_Move:

===========
Memory_Move
===========

Copy a specified amount of bytes of memory from the source buffer to the destination buffer.

::

   Memory_Move PROTO pMemSource:QWORD, pMemDestination:QWORD, qwAmount:QWORD


**Parameters**

* ``pMemSource`` - source address of memory to copy from.

* ``pMemDestination`` - destination address of memory to copy to.

* ``qwAmount`` - the amount of bytes to copy from pMemSource to pMemDestination.


**Returns**

No return value.


**Notes**

The destination buffer must be at least as large as the source buffer otherwise a page fault will be generated.

This function as based on: Memory_Copy

**See Also**

:ref:`Memory_Copy<Memory_Copy>`
