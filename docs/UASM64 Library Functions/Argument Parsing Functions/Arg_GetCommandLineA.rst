.. _Arg_GetCommandLineA:

===================
Arg_GetCommandLineA
===================

Retrieve the argument specified by the nArgument parameter and returns it in the buffer specified by the lpszArgumentBuffer parameter. Arg_GetCommandLine differs slightly in its implementation in that it treats the path and name of the application making the call as arg 0. 

::

   Arg_GetCommandLineA PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD


**Parameters**

* ``nArgument`` - Argument number.

* ``lpszArgumentBuffer`` - Address of buffer to receive the argument if it exists.


**Returns**

1 = successful operation.
2 = no argument exists at specified arg number.
3 = non matching quotation marks.
4 = empty quotation marks.


**Notes**

Arguments are specified from arg 1 up to the number of command line arguments available. The function supports the retrieval of arguments that are enclosed in quotation marks and will return the argument with the quotation marks removed.

The buffer for the returned argument should be set at 128 bytes in length which is the maximum allowable

**See Also**

:ref:`Arg_GetCommandLineExA<Arg_GetCommandLineExA>`, :ref:`Arg_GetArgumentA<Arg_GetArgumentA>`
