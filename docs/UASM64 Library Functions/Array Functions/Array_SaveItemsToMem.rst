.. _Array_SaveItemsToMem:

====================
Array_SaveItemsToMem
====================

Write the array items, separated with a carriage return and line feed (CRLF), to a pre-allocated memory buffer. 

::

   Array_SaveItemsToMem PROTO pArray:QWORD, pMemory:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``pMemory`` - pointer to pre-allocated memory buffer.


**Returns**

Number of array items written to memory buffer.


**Notes**

This function as based on the MASM32 Library function: arr2text

**See Also**

:ref:`Array_SaveItemsToFile<Array_SaveItemsToFile>`, :ref:`Array_LoadItemsFromMem<Array_LoadItemsFromMem>`, :ref:`Array_LoadItemsFromFile<Array_LoadItemsFromFile>`
