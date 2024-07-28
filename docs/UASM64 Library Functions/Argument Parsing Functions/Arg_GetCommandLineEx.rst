.. _Arg_GetCommandLineEx:

====================
Arg_GetCommandLineEx
====================

Extended version of Arg_GetCommandLine. This Arg_GetCommandLineEx function uses the Arg_GetArgument function to obtain the selected argument from a command line. It differs from the original version in that it will read a command line of any length and the arguments can be delimited by spaces, tabs, commas or any combination of the three. It is also faster but as the Arg_GetArgument function is table driven, it is also larger.

::

   Arg_GetCommandLineEx PROTO nArgument:QWORD, lpszArgumentBuffer:QWORD


**Parameters**

* ``nArgument`` - The argument number to return from a command line.

* ``lpszArgumentBuffer`` - The buffer to receive the selected argument.


**Returns**

There are three (3) possible return values:
	1 = successful operation 	2 = no argument exists at specified arg number 	3 = non matching quotation marks

**See Also**

:ref:`Arg_GetCommandLine<Arg_GetCommandLine>`, :ref:`Arg_GetArgument<Arg_GetArgument>`
