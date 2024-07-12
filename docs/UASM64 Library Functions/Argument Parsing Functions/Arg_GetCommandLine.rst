.. _Arg_GetCommandLine:

===================================
Arg_GetCommandLine 
===================================

Retrieve the argument specified by the ``nArgument`` parameter and returns it in the buffer specified by the ``lpszArgumentBuffer`` parameter.
    
::

   Arg_GetCommandLine PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD


**Parameters**

* ``nArgument`` - Argument number.
* ``lpszArgumentBuffer`` - Address of buffer to receive the argument if it exists.


**Returns**

* ``1`` = successful operation.
* ``2`` = no argument exists at specified arg number.
* ``3`` = non matching quotation marks.
* ``4`` = empty quotation marks.

**Notes**

Arguments are specified from arg 1 up to the number of command line arguments available. The function supports the retrieval of arguments that are enclosed in quotation marks and will return the argument with the quotation marks removed.

The buffer for the returned argument should be set at ``128`` bytes in length which is the maximum allowable

**Example**

::

   Invoke Arg_GetCommandLine

**See Also**

:ref:`Arg_GetCommandLineEx<Arg_GetCommandLineEx>`, :ref:`Arg_GetArgument<Arg_GetArgument>` 

