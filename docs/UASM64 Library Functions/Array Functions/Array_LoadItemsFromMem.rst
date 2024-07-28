.. _Array_LoadItemsFromMem:

======================
Array_LoadItemsFromMem
======================

Create an array by loading items array from memory. Each line of the text in memory is set as a new item in the array. 

::

   Array_LoadItemsFromMem PROTO pMemory:QWORD


**Parameters**

* ``pMemory`` - address of memory where array items are stored.


**Returns**

A pointer to the newly created array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrtxt

**See Also**

:ref:`Array_LoadItemsFromFile<Array_LoadItemsFromFile>`, :ref:`Array_SaveItemToFile<Array_SaveItemToFile>`, :ref:`Array_SaveItemsToMem<Array_SaveItemsToMem>`
