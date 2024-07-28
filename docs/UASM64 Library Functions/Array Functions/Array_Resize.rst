.. _Array_Resize:

============
Array_Resize
============

Resize array (reallocate array memory) to a different item count.

::

   Array_Resize PROTO pArray:QWORD, nItemCount:QWORD


**Parameters**

* ``pArray`` - pointer to the array to resize.

* ``nItemCount`` - the new item count for the array.


**Returns**

A pointer to the newly resized array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrealloc

**See Also**

:ref:`Array_Truncate<Array_Truncate>`, :ref:`Array_Extend<Array_Extend>`
