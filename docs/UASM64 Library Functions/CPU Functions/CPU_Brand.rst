.. _CPU_Brand:

=========
CPU_Brand
=========

Return a string with the CPU brand. 

::

   CPU_Brand PROTO 


**Parameters**


**Returns**

RAX contains a pointer to a string containing the CPU brand or 0 if not supported.


**Notes**

https://en.wikipedia.org/wiki/CPUID#EAX=80000002h,80000003h,80000004h:_Processor_Brand_String

**See Also**

:ref:`CPU_Manufacturer<CPU_Manufacturer>`, :ref:`CPU_ManufacturerID<CPU_ManufacturerID>`, :ref:`CPU_Signature<CPU_Signature>`, :ref:`CPU_CPUID_Supported<CPU_CPUID_Supported>`, :ref:`CPU_Logical_Cores<CPU_Logical_Cores>`
