.. _File_MapSharedMemory:

====================
File_MapSharedMemory
====================

Creates a shared memory mapped file from the system paging file. The memory allocated (commited) can be shared by other applications in seperate processes.

::

   File_MapSharedMemory PROTO lpszSharedMemoryName:QWORD, qwMemorySize:QWORD, lpqwMemoryMapHandle:QWORD, lpqwMemoryViewPointer:QWORD


**Parameters**

* ``lpszSharedMemoryName`` - The zero terminated string that names the shared memory object.

* ``qwMemorySize`` - The size of the memory to be shared in the memory object.

* ``lpqwMemoryMapHandle`` - The address of a QWORD variable to receive the memory mapped file handle for the shared memory object.

* ``lpqwMemoryViewPointer`` - The address of a QWORD variable to receive the memory view pointer for the shared memory object.


**Returns**

TRUE if successful, or FALSE otherwise.


A memory mapped file backed by the system paging file is effectively allocated memory but it has the attribute of being sharable between applications that call the same file name. This allows applications to share data by reading and writing to the memory mapped file.

NOTE: that a memory mapped file allocate at a specified size cannot be reallocated to a different size. The file must be closed by all applications that access it and then reallocated to a different size.

Use File_UnmapSharedMemory to close the memory mapped file.


**See Also**

:ref:`File_UnmapSharedMemory<File_UnmapSharedMemory>`
