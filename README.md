emacs-global-replace
====================

GNU Emacs extension to do replacements on all open buffers

Author: Sebastian Riese <sebastian.riese.mail@web.de>

License: GNU GPLv3, see LICENSE for the full text.

Defined Commands
----------------

The package defines four interactive commands:

1. `global-query-replace`
2. `global-replace-string`
3. `global-replace-regexp`
4. `global-query-replace-regexp`

These behave as their counterparts without the `global` prefix (except
for not restricting replacement to the marked region), but apply the
command to all open buffers, that are not read-only and are associated
with a file (this excludes special buffers such as `*Messages*`).

Installation
------------

Just load the files explicitely from your .emacs

    (load "path/to/global-replace.el")

or put it in the search path and load it with

    (require 'global-replace)

Caveat
------

This has only been tested against GNU Emacs 23.3 and uses the internals
provided by `replace.el` from the GNU Emacs standard library. Therefore
it might not work with other versions.
