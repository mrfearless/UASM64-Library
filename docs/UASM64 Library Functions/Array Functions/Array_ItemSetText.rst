.. _Array_ItemSetText:

=================
Array_ItemSetText
=================

Write a zero terminated text string to an array item.

::

   Array_ItemSetText PROTO pArray:QWORD, nItemIndex:QWORD, lpszItemText:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemIndex`` - the index of the array item to set the text for.

* ``lpszItemText`` - the text string to set for the specified item index.


**Returns**

*  The written text length.
*  0 if text length or argument is zero.
* -1 bounds error, below 1.
* -2 bounds error, above index.
* -3 out of memory error.


**Notes**

This function as based on the MASM32 Library function: arrset

**See Also**

:ref:`Array_ItemAddress<Array_ItemAddress>`, :ref:`Array_ItemLength<Array_ItemLength>`, :ref:`Array_ItemSetData<Array_ItemSetData>`
