.. _Memory_Compare:

==============
Memory_Compare
==============

Compare two memory addresses of the same known length.

::

   Memory_Compare PROTO pMemoryAddress1:QWORD, pMemoryAddress2:QWORD, qwMemoryLength:QWORD


**Parameters**

* ``pMemoryAddress1`` - The first memory location to test.

* ``pMemoryAddress2`` - The second memory location to test against the first.

* ``qwMemoryLength`` - The length of the buffers in BYTES.


**Returns**

0 = different. non 0 = byte identical.


**Notes**

This function as based on the MASM32 Library function: cmpmem

