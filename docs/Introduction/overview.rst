.. _Overview:

============
Overview
============

UASM64 Library is a x64 port of the functions from the MASM32 Library that are included with the `MASM32 SDK <https://www.masm32.com>`_.

The functions ported to an x64 version in the UASM64 Library aim to match the parameters and features of the original x86 functions from the MASM32 Library where possible. In a few functions that may not be possible, and an alternative approach to achieve the same desired result may be used instead.

The names of the functions and parameter names in the UASM64 Library compared to the MASM32 Library have been changed to increase readability. Equates are provided in the ``UASM64.inc`` file to map to the new function names - which also helps when porting x86 projects to x64 ones.
 
Additionally, new functions have been added to the UASM64 Library to expand and compliment the existing functions.

UASM64 Library is targeted specifically for use with projects that use the `UASM <http://www.terraspace.co.uk/uasm.html>`_ assembler (the x64 version), but likely other compilers and assemblers can utilize it as well.

All credit and thanks to all the original authors and code contributors of the functions in the MASM32 Library.

The UASM64 library and source code are free to use for anyone, and anyone can contribute to the UASM64 Library project.

.. _Download_Overview:

Download
--------

The UASM64 Library is available to download from the github repository at `github.com/mrfearless/UASM64-Library <https://github.com/mrfearless/UASM64-Library>`_


.. _Features_Overview:

Features
--------

* String manipulation functions
* File & filepath functions
* Conversion functions
* Argument parsing functions
* CPU functions
* And more...


.. _Installation_Overview:

Installation
------------

The UASM64 Library is available for x64 development only. For x86 development, please see the MASM32 Library included with the `MASM32 SDK <https://www.masm32.com>`_.

See the :ref:`Installation & Setup<Installation & Setup>` section for more details.


.. _Contribute_Overview:

Contribute
----------

If you wish to contribute, please follow the :ref:`Contributing<Contributing>` guide for details on how to add or edit, the UASM64 Library source or documentation.


.. _FAQ_Overview:

Frequently Asked Questions
--------------------------

Please visit the :ref:`Frequently Asked Questions<FAQ>` section for details.

