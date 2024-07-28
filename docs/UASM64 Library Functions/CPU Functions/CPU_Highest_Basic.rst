.. _CPU_Highest_Basic:

=================
CPU_Highest_Basic
=================

Returns the highest value for basic processor information available.

::

   CPU_Highest_Basic PROTO 


**Parameters**


**Returns**

0 if CPUID is not supported, otherwise the highest basic information (the value used in eax for CPUID to obtain information from a particular leaf)

