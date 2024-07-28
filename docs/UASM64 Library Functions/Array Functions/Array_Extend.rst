.. _Array_Extend:

============
Array_Extend
============

Extend (grow) an array and add new empty items.

::

   Array_Extend PROTO pArray:QWORD, nItemCount:QWORD


**Parameters**

* ``pArray`` - pointer to the array to extend.

* ``nItemCount`` - the new count of items for the array to grow to.


**Returns**

A pointer to the newly resized array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrextnd

**See Also**

:ref:`Array_Truncate<Array_Truncate>`, :ref:`Array_Resize<Array_Resize>`
