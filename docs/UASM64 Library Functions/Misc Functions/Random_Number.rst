.. _Random_Number:

=============
Random_Number
=============

Generate random number.

::

   Random_Number PROTO base:QWORD


**Parameters**

* ``base`` - Zero based range for random output. If 0 then it used the time stamp counter to generate a value from.


**Returns**

In RAX a random number.


**Notes**

A Park Miller random algorithm written by Jaymeson Trudgen (NaN) and optimised by Rickey Bowers Jr. (bitRAKE).

x64 version now uses RDRAND if available instead.

On a CPU that supports the RDRAND instruction, this is used instead of the original code path ported from the x86 function in the MASM32 Library.

For a CPU that doesnt support RDRAND, we also allow base parameter to be a 0, which will use the time stamp counter to generate a value for us.

nrandom_seed global variable is used to store a seed value generated from the Random_Seed function (or default value of 12345678) that is used for CPU's that dont support RDRAND to generate a random number.


**See Also**

:ref:`CPU_RDRAND_Supported<CPU_RDRAND_Supported>`, :ref:`CPU_RDSEED_Supported<CPU_RDSEED_Supported>`
