.. _Array_LoadItemsFromFile:

=======================
Array_LoadItemsFromFile
=======================

Create an array by loading a text file. Each line of the text file is set as a new item in the array. 

::

   Array_LoadItemsFromFile PROTO lpszFilename:QWORD


**Parameters**

* ``lpszFilename`` - filename to load and create an array from.


**Returns**

A pointer to the newly created array, which is used with the other array functions, or 0 if an error occurred.


**Notes**

This function as based on the MASM32 Library function: arrfile

**See Also**

:ref:`Array_LoadItemsFromMem<Array_LoadItemsFromMem>`, :ref:`Array_SaveItemToFile<Array_SaveItemToFile>`, :ref:`Array_SaveItemsToMem<Array_SaveItemsToMem>`
