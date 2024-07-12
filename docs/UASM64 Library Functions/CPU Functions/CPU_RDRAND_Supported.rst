.. _CPU_RDRAND_Supported:

===================================
CPU_RDRAND_Supported 
===================================

Check if the ``RDRAND`` instruction is supported.
    
::

   CPU_RDRAND_Supported PROTO


**Parameters**

There are no parameters.


**Returns**

``TRUE`` if ``RDRAND`` instruction is supported, or ``FALSE`` otherwise.

**Notes**

`https://en.wikipedia.org/wiki/RDRAND <https://en.wikipedia.org/wiki/RDRAND>`_

**Example**

::

   Invoke CPU_RDRAND_Supported

**See Also**

:ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_RDSEED_Supported<CPU_RDSEED_Supported>` 

