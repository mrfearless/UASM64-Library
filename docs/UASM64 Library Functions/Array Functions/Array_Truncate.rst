.. _Array_Truncate:

==============
Array_Truncate
==============

Truncate (shrink) an array and free any excess items.

::

   Array_Truncate PROTO pArray:QWORD, nItemCount:QWORD


**Parameters**

* ``pArray`` - pointer to the array to truncate.

* ``nItemCount`` - the new count of items for the array to shrink to.


**Returns**

A pointer to the newly resized array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrtrunc

**See Also**

:ref:`Array_Extend<Array_Extend>`, :ref:`Array_Resize<Array_Resize>`
