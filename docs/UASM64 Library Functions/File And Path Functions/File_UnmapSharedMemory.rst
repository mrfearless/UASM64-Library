.. _File_UnmapSharedMemory:

======================
File_UnmapSharedMemory
======================

Closes a shared memory object created by the File_MapSharedMemory function. The memory mapped file handle and memory view pointer returned by the File_MapSharedMemory function are closed.

::

   File_UnmapSharedMemory PROTO qwMemoryViewPointer:QWORD, qwMemoryMapHandle:QWORD


**Parameters**

* ``qwMemoryViewPointer`` - The shared memory's memory map handle. This handle value is returned by the File_MapSharedMemory function.

* ``qwMemoryMapHandle`` - The shared memory's memory view pointer. This value is returned by the File_MapSharedMemory function.


**Returns**

No return value.


**Notes**

When more than one application has opened the same named memory mapped file, the file is not closed until the last application that has opened it closes the file. It is safe to call this procedure even if the memory mapped file is still being used by another application as the operating system will leave it open until the last application using it closes it

**See Also**

:ref:`File_MapSharedMemory<File_MapSharedMemory>`
