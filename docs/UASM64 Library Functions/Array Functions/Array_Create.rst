.. _Array_Create:

============
Array_Create
============

Create a new array with a specified number of empty items.

::

   Array_Create PROTO nItemCount:QWORD


**Parameters**

* ``nItemCount`` - Number of items that the array created will hold.


**Returns**

A pointer to the newly created array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arralloc

**See Also**

:ref:`Array_CreateEx<Array_CreateEx>`, :ref:`Array_Destroy<Array_Destroy>`, :ref:`Array_Resize<Array_Resize>`
