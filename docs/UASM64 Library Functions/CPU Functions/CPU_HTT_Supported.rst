.. _CPU_HTT_Supported:

===================================
CPU_HTT_Supported 
===================================

Check if Hyper-Threading Technology (HTT) is supported.
    
::

   CPU_HTT_Supported PROTO


**Parameters**

There are no parameters.


**Returns**

``TRUE`` if the Hyper-threading is supported, or ``FALSE`` otherwise.

**Notes**

`https://en.wikipedia.org/wiki/Hyper-threading <https://en.wikipedia.org/wiki/Hyper-threading>`_

**Example**

::

   Invoke CPU_HTT_Supported

**See Also**

:ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_Logical_Cores<CPU_Logical_Cores>`

