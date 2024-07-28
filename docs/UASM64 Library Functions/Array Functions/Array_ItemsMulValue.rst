.. _Array_ItemsMulValue:

===================
Array_ItemsMulValue
===================

Multiply an integer value for every item of a QWORD array.

::

   Array_ItemsMulValue PROTO pArray:QWORD, nItemCount:QWORD, qwValue:QWORD


**Parameters**

* ``pArray`` - pointer to the array.

* ``nItemCount`` - the number of members of the array.

* ``qwValue`` - The integer value to multiply for every array item.


**Returns**

None.


**Notes**

This function as based on the MASM32 Library function: arr_mul

**See Also**

:ref:`Array_ItemAddValue<Array_ItemAddValue>`, :ref:`Array_ItemSubValue<Array_ItemSubValue>`, :ref:`Array_ItemSetText<Array_ItemSetText>`, :ref:`Array_ItemSetData<Array_ItemSetData>`
