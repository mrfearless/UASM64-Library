.. _Array_ItemSetData:

=================
Array_ItemSetData
=================

Write byte data of a specified length to an array item.

::

   Array_ItemSetData PROTO pArray:QWORD, nItemIndex:QWORD, lpItemData:QWORD, qwItemDataLength:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemIndex`` - the index of the array item to set the data for.

* ``lpItemData`` - the data to set for the specified item index.

* ``qwItemDataLength`` - the length of the data specified by lpItemData. 


**Returns**

*  The written binary data length.
*  0 if length is zero.
* -1 bounds error, below 1.
* -2 bounds error, above index.


**Notes**

This function as based on the MASM32 Library function: arrbin

**See Also**

:ref:`Array_ItemAddress<Array_ItemAddress>`, :ref:`Array_ItemLength<Array_ItemLength>`, :ref:`Array_ItemSetText<Array_ItemSetText>`
