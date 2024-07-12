.. _String_WordReplace:

===================================
String_WordReplace 
===================================

Globally replace whole words in the source text and write the result to the  destination.
    
::

   String_WordReplace PROTO lpszSource:QWORD, lpszDestination:QWORD, lpszWordToReplace:QWORD, lpszReplacementWord:QWORD


**Parameters**

* ``lpszSource`` - The source text to replace words in.
* ``lpszDestination`` - The destination buffer for the result.
* ``lpszWordToReplace`` - The word to replace.
* ``lpszReplacementWord`` - The words to replace it with.

**Returns**

There is no return value.

**Notes**

This procedure is a table based linear text scanner based on the following allowable characters:

::

   characters     ! # $ % & ? @ _
   numbers        0123456789
   upper case     ABCDEFGHIJKLMNOPQRSTUVWXYZ
   lower case     abcdefghijklmnopqrstuvwxyz



The procedure will recognise whole words made up of the above characters and will replace every instance of that word with the replacement text. It is suited for simple tasks like replacing whole words in text such as in a text editor but it is also fast enough to loop through a number of words and replace all of them in a macro built into a scripting language or similar application.

It is an interim technology for tasks smaller than those normally handled by a far more complex hash table.

**Example**

::

   Invoke String_WordReplace

**See Also**

:ref:`String_Replace<String_Replace>`, :ref:`String_InString<String_InString>`, :ref:`String_Middle<String_Middle>` 

