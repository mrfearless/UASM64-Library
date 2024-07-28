.. _Array_CreateEx:

==============
Array_CreateEx
==============

Create a new array with a specified number of empty items of a specified size (in bytes) of each item.

::

   Array_CreateEx PROTO nItemCount:QWORD, nItemSize:QWORD


**Parameters**

* ``nItemCount`` - Number of items that the array created will hold.

* ``nItemSize`` - byte count for each item.


**Returns**

In RAX a pointer to the newly created array, which is used with the other array functions. In RCX a pointer to the string memory address. If an error occurs, both RAX and RCX will be set to 0.


**Notes**

deallocate both of the returned memory handles when the array is no longer required.

This function as based on the MASM32 Library function: create_array

**See Also**

:ref:`Array_Create<Array_Create>`, :ref:`Array_Destroy<Array_Destroy>`, :ref:`Array_Resize<Array_Resize>`
