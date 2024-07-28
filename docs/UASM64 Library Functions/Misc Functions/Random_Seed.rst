.. _Random_Seed:

===========
Random_Seed
===========

Generate a random seed

::

   Random_Seed PROTO TheSeed:QWORD


**Parameters**

* ``TheSeed`` - seed value to use. If 0 then uses the time stamp counter to generate a value from.


**Returns**

In RAX a random seed.


**Notes**

On a CPU that supports the RDSEED instruction, this is used instead of the original code path ported from the x86 function in the MASM32 Library.

For a CPU that doesnt support RDSEED, we also allow TheSeed parameter to be a 0, which will use the time stamp counter to generate a value for us.

nrandom_seed global variable is used to store that value for use in the Random_Number function, for CPU's that dont support RDSEED.


**See Also**

:ref:`CPU_RDRAND_Supported<CPU_RDRAND_Supported>`, :ref:`CPU_RDSEED_Supported<CPU_RDSEED_Supported>`
