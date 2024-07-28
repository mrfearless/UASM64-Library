.. _CPU_Extended_Features:

=====================
CPU_Extended_Features
=====================

Check which features are supported and return them as in a formatted string as a list seperated by space, tab, comma, line-feed, carriage return & line feed or null. The formatted string is terminated by a double null.

::

   CPU_Extended_Features PROTO lpqwFeaturesString:QWORD, lpqwFeaturesStringSize:QWORD, qwStringType:QWORD, qwStringStyle:QWORD, qwMaskECX:QWORD, qwMaskEDX:QWORD


**Parameters**

* ``lpqwFeaturesString`` - Pointer to a QWORD variable used to store the pointer to the formatted features string.

* ``lpqwFeaturesStringSize`` - Pointer to a QWORD variable used to store the size of the formatted features string.

* ``qwStringType`` - The type of feature string to include, can be one of the following value:

    * ``CFST_MNEMONIC`` - Short form of the feature: "AVX" 
    * ``CFST_FEATURE`` - Long form describing the feature: "Advanced Vector Exte.." 
    * ``CFST_BOTH`` - "AVX: Advanced Vector Extensions (AVX) Instruction Extensions"

* ``qwStringStyle`` - the style of formatting for the feature string, can be one of the following values:

    * ``CFSS_NULL`` - null separated.
    * ``CFSS_SPACE`` - space separated.
    * ``CFSS_COMMA`` - comma and space separated.
    * ``CFSS_TAB`` - tab separated.
    * ``CFSS_LF`` - line feed (LF) separated.
    * ``CFSS_CRLF`` - carriage return (CR) and line feed (LF) separated.
    * ``CFSS_LIST`` - dash '- ' precedes text and CRLF separates.

* ``qwMaskECX`` - a QWORD value to mask the features returned in the ECX register so that only the features you are interested in are collected. A mask value -1 means to include all features that are found. A mask value of 0 means to exclude all features found for ECX feature flags.

* ``qwMaskEDX`` - a QWORD value to mask the features returned in the EDX register so that only the features you are interested in are collected. A mask value -1 means to include all features that are found. A mask value of 0 means to exclude all features found for EDX feature flags.


**Returns**

TRUE if successful, or FALSE otherwise

**Notes**

The variables pointed to by the lpqwFeaturesString parameter and the lpqwFeaturesStringSize parameter will be set to 0 if the function returns FALSE. 
The string returned and stoed in the variable pointed to by the lpqwFeaturesString parameter should be freed with a call to GlobalFree when you no longer require it.

CPUID EAX=80000001h: Feature bits in EDX and ECX
Many of the bits in EDX are duplicates of EDX from the EAX=1 leaf (These duplicated bits are present on AMD but not Intel CPUs.)

