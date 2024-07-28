.. _Array_TotalMemory:

=================
Array_TotalMemory
=================

Get the total amount of memory to store the whole array and its items.

::

   Array_TotalMemory PROTO pArray:QWORD, lpdwTotalMemory:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``lpdwTotalMemory`` - variable to store the total memory for the array.


**Returns**

The total amount of memory that each array item takes up in total.


**Notes**

This function as based on the MASM32 Library function: arrtotal

**See Also**

:ref:`Array_TotalItems<Array_TotalItems>`
