.. _Array_ItemLength:

================
Array_ItemLength
================

Get the stored length of an array item.

::

   Array_ItemLength PROTO pArray:QWORD, nItemIndex:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemIndex`` - the index of the array item to return the length for.


**Returns**

Returns the length of the array item, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrlen

**See Also**

:ref:`Array_ItemAddress<Array_ItemAddress>`, :ref:`Array_ItemSetData<Array_ItemSetData>`, :ref:`Array_ItemSetText<Array_ItemSetText>`
