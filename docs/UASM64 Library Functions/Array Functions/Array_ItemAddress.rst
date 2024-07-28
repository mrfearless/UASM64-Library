.. _Array_ItemAddress:

=================
Array_ItemAddress
=================

Get the address of an array item specified by the item index.

::

   Array_ItemAddress PROTO pArray:QWORD, nItemIndex:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemIndex`` - the index of the array item to return the address for.


**Returns**

The address of the array item, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrget

**See Also**

:ref:`Array_ItemLength<Array_ItemLength>`, :ref:`Array_ItemSetData<Array_ItemSetData>`, :ref:`Array_ItemSetText<Array_ItemSetText>`
