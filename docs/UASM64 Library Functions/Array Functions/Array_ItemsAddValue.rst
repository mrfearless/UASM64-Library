.. _Array_ItemsAddValue:

===================
Array_ItemsAddValue
===================

Add an integer value for every item of a QWORD array.

::

   Array_ItemsAddValue PROTO pArray:QWORD, nItemCount:QWORD, qwValue:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemCount`` - the number of members of the array.

* ``qwValue`` - The integer value to add for every array item.


**Returns**

None. 

**Notes**

This function as based on the MASM32 Library function: arr_add

**See Also**

:ref:`Array_ItemMulValue<Array_ItemMulValue>`, :ref:`Array_ItemSubValue<Array_ItemSubValue>`, :ref:`Array_ItemSetText<Array_ItemSetText>`, :ref:`Array_ItemSetData<Array_ItemSetData>`
