.. _CPU_Logical_Cores:

===================================
CPU_Logical_Cores 
===================================

Return the number of logical cores, if supported.
    
::

   CPU_Logical_Cores PROTO


**Parameters**

There are no parameters.


**Returns**

``RAX`` contains number of logical cores (if supported), or ``0`` otherwise.

**Notes**

`CPUID Core And Cache Topology <https://en.wikipedia.org/wiki/CPUID#EAX=4_and_EAX=Bh:_Intel_thread/core_and_cache_topology>`_

**Example**

::

   Invoke CPU_Logical_Cores

**See Also**

:ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_HT_Supported<CPU_HTT_Supported>` 

