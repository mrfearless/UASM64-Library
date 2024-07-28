.. _CPU_Highest_Extended:

====================
CPU_Highest_Extended
====================

Returns the highest value for extended processor information available.

::

   CPU_Highest_Extended PROTO 


**Parameters**


**Returns**

0 if CPUID is not supported, otherwise the highest extended information (the value used in eax for CPUID to obtain extended information from a particular leaf = 80000000h upwards)

