.. _Array_SaveItemsToFile:

=====================
Array_SaveItemsToFile
=====================

Saves all array items to a file.

::

   Array_SaveItemsToFile PROTO pArray:QWORD, lpszFilename:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``lpszFilename`` - filename to save the array items to.


**Returns**

The length of the newly created file, or 0 if an error occurred.


**Notes**

This functions writes each array member directly to a file so that an intermediate buffer does not need to be allocated.

This is designed to allow very large arrays to be written to disk without memory space being a limitation to the array size.

This function as based on the MASM32 Library function: arr2file

**See Also**

:ref:`Array_SaveItemsToMem<Array_SaveItemsToMem>`, :ref:`Array_LoadItemsFromMem<Array_LoadItemsFromMem>`, :ref:`Array_LoadItemsFromFile<Array_LoadItemsFromFile>`
