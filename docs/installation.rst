Installation
============

The installation of ``ttkthemes`` is very simple. There are a few ways
to install ``ttkthemes``.

PyPI
----
Installation from PyPI is easiest. Simply use ``pip`` to fetch the
package and install it:

.. code-block:: python

   python3 -m pip install ttkthemes

There is a single installation option available for ``ttkthemes``. In
order to use the high-quality PNG-themes instead of the GIF-themes,
an extension is required under Python 2 and some earlier distributions
of Python 3. Simply install the extension with ``pip`` as well.

.. code-block:: python

   python3 -m pip install ttkthemes[tkimg]

This option installs the separate package ``tkimg``, for which more
information is available from here_.

.. _here : https://www.github.com/RedFantom/python-tkimg

Source
------
Installation from git is also possible:

.. code-block:: python

   python3 -m pip install git+https://github.com/RedFantom/ttkthemes

