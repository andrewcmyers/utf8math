utf8math.sty 1.3
----------------

This LaTeX package makes it possible to use UTF-8 characters directly
in LaTeX documents. It works by turning UTF-8 character sequences into
corresponding macro invocations. It is not integrated with the inputenc
package.

USE:

To use the package, just do the usual:

\usepackage{utf8math}

The file utf8math.sty is generated by a program "makeutf8", which reads from a file
"utf8.table" to determine the mappings it should create.  To (re)build
utf8math.sty, just type "make".

If you switch to some other UTF-8 technology later on, it should not be
a problem for your document.


EXTENDING THE ENCODINGS:

The table in utf8.table can be updated with new mappings from Unicode
characters to TeX symbol macros. The format is in 2-5 columns, separated
with semicolons. A two-column entry means that there is no macro defined
for this character. A four-column entry contains a macro mapping.  A
five-column entry also includes a Vim digraph mapping.

Column 1: Unicode index, in hexadecimal
Column 2: Official Unicode name for the character
Column 3: Either m or t, depending on whether the TeX macro requires
          math mode or not.
Column 4: A TeX macro for rendering the appropriate glyph for the character
Column 5: A Vim digraph mapping to be used to input this character
          in the Vim editor. (optional)

New entries in utf8.table are welcomed by the package author,
Andrew Myers (andru@cs.cornell.edu). Currently the table is up to date with Unicode 6.0.0.

HISTORY

1.1, February 2010: Unicode support above 0x10000 added by Jed Liu
1.2, August 2011: Latin-2 support added
1.3, April 2015: renamed the package.
