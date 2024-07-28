.. _Array_TotalItems:

================
Array_TotalItems
================

Get the total count of all array items in an array.

::

   Array_TotalItems PROTO pArray:QWORD


**Parameters**

* ``pArray`` - pointer to the array.


**Returns**

The count of array items, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrcnt

**See Also**

:ref:`Array_TotalMemory<Array_TotalMemory>`
