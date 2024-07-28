.. _CPU_Signature:

=============
CPU_Signature
=============

Read the processor family, model and stepping (the cpu signature) and return the values in the QWORD variables pointed to by the parameters.

::

   CPU_Signature PROTO lpqwFamilyID:QWORD, lpqwExtFamilyID:QWORD, lpqwBaseFamilyID:QWORD, lpqwModelID:QWORD, lpqwExtModelID:QWORD, lpqwBaseModelID:QWORD, lpqwStepping:QWORD


**Parameters**

* ``lpqwFamilyID`` - Returns a combination of the Extended Family ID and Family ID

* ``lpqwExtFamilyID`` - Returns the Extended Family ID (corresponds to bits 20-27)

* ``lpqwBaseFamilyID`` - Returns the base Family ID (corresponds to bits 8-11) 

* ``lpqwModelID`` - Returns a combination of the Extended Model ID and Model ID

* ``lpqwExtModelID`` - Returns the Extended Model ID (corresponds to bits 16-19)

* ``lpqwBaseModelID`` - Returns the base Model ID (corresponds to bits 4-7) 

* ``lpqwStepping`` - Returns the Stepping ID (corresponds to bits 0-3)


**Returns**

In EAX the raw CPUID EAX value if successful, or 0 otherwise.


**Notes**

The parameters passed can be NULL if you do not require that particular info returned. 

