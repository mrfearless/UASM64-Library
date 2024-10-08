.. _Arg_GetArgumentW:

================
Arg_GetArgumentW
================

Return the contents of an argument from an argument list by its number.

::

   Arg_GetArgumentW PROTO lpszArgumentList:QWORD,lpszDestination:QWORD,nArgument:QWORD,qwArgumentListReadOffset:QWORD


**Parameters**

* ``lpszArgumentList`` - The address of the zero terminated argument list.

* ``lpszDestination`` - The address of the destination buffer.

* ``nArgument`` - The number of the argument to return.

* ``qwNotUsed`` - Not used - parameter retained for compatibility.


**Returns**

The return value is the updated next read offset in the source if it is greater than zero.

The three possible return values are:
  -1  = A non matching quotation error has occurred in the source.


**Notes**

This function supports double quoted text and it is delimited by the space character, a tab or a comma or any combination of these three. It may be used in two separate modes, single argument mode and streaming mode.

In separate argument mode you specify the argument you wish to obtain with the nArgument parameter and you set the qwArgumentListReadOffset parameter to zero.

In streaming mode you set a variable to zero and pass it as the 4th parameter qwArgumentListReadOffset and save the RAX return value back into this variable for the next call to the function. The nArgument parameter in streaming mode should be set to one "1"
To support the notation of an empty pair of double quotes in an argument list the parser in this algorithm return an empty destination buffer that has an ascii zero as it first character.


**See Also**

:ref:`Arg_GetCommandLineW<Arg_GetCommandLineW>`, :ref:`Arg_GetCommandLineExW<Arg_GetCommandLineExW>`
