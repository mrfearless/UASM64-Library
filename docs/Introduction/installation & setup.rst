.. _Installation & Setup:

====================
Installation & Setup
====================

.. _UASM for 64bit assembler:

UASM for 64bit assembler
------------------------

- Download and install the `UASM <http://www.terraspace.co.uk/uasm.html>`_ assembler. Ideally you will have a setup that mimics the MASM32 setup, where you create manually folders for ``bin``, ``include`` and ``lib``

- Download the UASM64 Library: `UASM64-Library.zip <https://github.com/mrfearless/UASM64-Library/blob/master/releases/UASM64-Library.zip?raw=true>`_

- Copy the ``UASM64.inc`` file to ``X:\UASM\Include`` folder overwriting any previous versions.

- Copy the ``UASM64.lib`` file to ``X:\UASM\Lib\x64`` folder overwriting any previous versions.

.. note:: ``X`` is the drive letter where the `UASM <http://www.terraspace.co.uk/uasm.html>`_ package has been installed to.


**Adding UASM64 Library to your UASM project**

You are now ready to begin using the UASM64 library in your Uasm projects. Simply add the following lines to your project:

::

   include UASM64.inc
   includelib UASM64.lib



.. note:: See the following for more details on setting up UASM to work with RadASM and other details that may be useful in creating a development environment that mimics the MASM32 SDK: `UASM-with-RadASM <https://github.com/mrfearless/UASM-with-RadASM>`_, `UASM-SDK <https://github.com/mrfearless/UASM-SDK>`_

.. tip:: `UASM <http://www.terraspace.co.uk/uasm.html>`_ can be used as a x86 32 bit assembler as well.