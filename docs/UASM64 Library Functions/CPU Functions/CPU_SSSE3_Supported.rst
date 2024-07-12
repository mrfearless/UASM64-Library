.. _CPU_SSSE3_Supported:

===================================
CPU_SSSE3_Supported 
===================================

Check if Supplemental Streaming SIMD Extensions 3 (SSSE3 or SSE3S) instructions are supported.
    
::

   CPU_SSSE3_Supported PROTO


**Parameters**

There are no parameters.


**Returns**

``TRUE`` if SSSE3 instructions are supported, or ``FALSE`` otherwise.

**Notes**

`https://en.wikipedia.org/wiki/SSSE3 <https://en.wikipedia.org/wiki/SSSE3>`_

**Example**

::

   Invoke CPU_SSSE3_Supported

**See Also**

:ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_SSE_Supported<CPU_SSE_Supported>`, :ref:`CPU_SSE2_Supported<CPU_SSE2_Supported>`, :ref:`CPU_SSE3_Supported<CPU_SSE3_Supported>`

