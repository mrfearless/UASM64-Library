.. _CPU_Logical_Cores:

=================
CPU_Logical_Cores
=================

Return the number of logical cores, if supported.

::

   CPU_Logical_Cores PROTO 


**Parameters**


**Returns**

RAX contains number of logical cores if supported, or 0 otherwise.


**Notes**

https://en.wikipedia.org/wiki/CPUID#EAX=4_and_EAX=Bh:_Intel_thread/core_and_cache_topology

**See Also**

:ref:`CPU_Basic_Features<CPU_Basic_Features>`, :ref:`CPU_Signature<CPU_Signature>`, :ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_HTT_Supported<CPU_HTT_Supported>`
