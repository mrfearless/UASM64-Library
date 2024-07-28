.. _Array_Destroy:

=============
Array_Destroy
=============

Deallocates and frees all array items and the array itself.

::

   Array_Destroy PROTO pArray:QWORD


**Parameters**

* ``pArray`` - pointer to the array to destroy/free.


**Returns**

The count of items deallocated/freed or 0 if an error occured.


**Notes**

This function as based on the MASM32 Library function: arrfree

**See Also**

:ref:`Array_Create<Array_Create>`, :ref:`Array_CreateEx<Array_CreateEx>`, :ref:`Array_Resize<Array_Resize>`
