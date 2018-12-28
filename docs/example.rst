Example
=======

Using ``ttkthemes`` is easiest through the usage of ``ThemedTk``. The
following example is written for Python 3.

.. code-block:: python

   from tkinter import ttk  # Normal Tkinter.* widgets are not themed!
   from ttkthemes import ThemedTk

   window = ThemedTk(theme="arc")
   ttk.Button(window, text="Quit", command=window.destroy).pack()
   window.mainloop()
