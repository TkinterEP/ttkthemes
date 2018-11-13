Theme Loading
=============
Tkinter for Python runs a ``Tcl``-interpreter with the ``Tk`` package.
The actual UI is drawn and controlled by this ``Tcl``-interpreter. In
order to load themes into ``Tkinter``, it must be done through this
``Tcl``-interpreter. This page describes how this is done, and what the
limitations per Python version are.

Loading
-------
Each theme is a ``Tcl``-package in itself. In order to load the theme,
the package has to be loaded. Usually, stand-alone packages come with
a ``pkgIndex.tcl`` file, which checks the dependencies of the package
and then provides a ``package ifneeded {name} {version}`` line.

Then, in order to execute the code that creates the package, a
``package require {name} {version}`` is executed. Subsequently, the
code provided after the ``package ifneeded`` is executed, and thus the
files for the package are executed.

The code files that are executed to create the package then provide a
``package provide {name} {version}`` line, which creates the package.
Then loading the package is complete, and the theme is available.

In the case of ``ttkthemes``, there is a big difference. The themes
are split into PNG-themes (which also have a GIF-version) and GIF-only
themes. The appropriate ``pkgIndex.tcl`` files in the right folders
are evaluated depending on whether the PNG-dependencies have been met.
Instead of using ``package ifneeded`` with a ``pkgIndex.tcl`` file for
each theme, ``ttkthemes`` loads all the themes instantly upon evaluation
of the ``pkgIndex.tcl`` file of the whole folder of themes.

This is done so as to limit the amount of Tcl-code in the ``ttkthemes``
package. While the ``ttkthemes`` package could still be used with
``Tcl`` directly, it is intended for use within Python, and Tkinter's
error reporting facilities are extremely limited (no full tracebacks
are available), and thus the amount of ``Tcl``-code is best minimized.
All work that can be performed in Python is performed in Python.

For more information on packages and loading them, check the tcl-lang_
wiki website.

Limitations
-----------
All themes are available on all platforms that support ``Tk 8.4`` or
higher. ``Tk 8.4`` is available with all Python distributions of ``2.7``
or higher. Python-distributions may be created with higher versions of
``Tk`` as well.
In order to load the higher quality PNG version of themes for which it
is available, either ``Tk 8.6`` is required, or ``TkImg``. ``Tk 8.6`` is
available with Python 3.6 in most Python binary distributions, including
the Windows binaries and the Ubuntu PPA-version. However, it may be
possible that there are binary distributions compiled with a different
version of ``Tk`` out in the wild.
In order to use the PNG version of themes on older Python versions,
including Python 2.7, ``TkImg`` is required. While formerly provided
with ``ttkthemes``, the ``Tk``-extension ``TkImg`` is now available for
Python in a separate package: tkimg_.

Tcl-loading
-----------
The ``ttkthemes`` themes can be loaded from a ``Tcl``-interpreter
directly. In fact, this is what the ``_Widget``-class does for the
``ttkthemes`` Python-package. In this section, from this point onwards,
``ttkthemes`` will refer to the ``Tcl``-package instead.

The themes provided are divided into two categories: themes with a
PNG and GIF version and themes with only a GIF version. The GIF-only
themes are provided in the folder ``/ttkthemes/themes``. The
``pkgIndex.tcl`` file in this folder loads all themes in the folder when
executed and provides the ``ttkthemes`` package.

For the other category of themes, *only* the GIF or PNG version can be
loaded, as loading a second package with a name which is already used by
another package is not possible.

Depending on whether the PNG or GIF version of themes should be loaded,
the ``pkgIndex.tcl`` in the ``ttkthemes/gif`` or ``ttkthemes/png`` can
be evaluated. The PNG themes can only be loaded if Tk is version 8.6 or
TkImg is available.

.. code-block:: tcl

    package require Tk 8.6
    source ttkthemes/themes/pkgIndex.tcl
    source ttkthemes/png/pkgIndex.tcl
    package require ttkthemes 1.0
    ttk::setTheme plastik

.. _tcl-lang: https://wiki.tcl-lang.org/page/package
.. _tkimg: https://github.com/RedFantom/python-tkimg