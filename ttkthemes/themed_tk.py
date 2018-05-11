"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from ._tkinter import tk, ttk
from ._widget import ThemedWidget


class ThemedTk(tk.Tk, ThemedWidget):
    """
    Tk child class that supports the themes supplied in this package.
    A theme can be set upon initialization or during runtime. Can be
    used as a drop-in replacement for the normal Tk class.
    """
    def __init__(self, *args, **kwargs):
        """
        :param theme: Theme to set upon initialization. If theme is not
            available, will fails silently.
        """
        theme = kwargs.pop("theme", None)
        # Initialize as tk.Tk
        tk.Tk.__init__(self, *args, **kwargs)
        # Initialize as ThemedWidget
        ThemedWidget.__init__(self, self.tk)
        # Set initial theme
        if theme is not None and theme in self.get_themes():
            self.set_theme(theme)
        self.__init__toplevel = tk.Toplevel.__init__

    def set_theme(self, theme_name):
        """Redirect the set_theme call to also set Tk background color"""
        color = ttk.Style(self).lookup("TFrame", "background", default="white")
        
        def __toplevel__(*args, **kwargs):
            kwargs.setdefault("background", color)
            self.__init__toplevel(*args, **kwargs)

        tk.Toplevel.__init__ = __toplevel__
        ThemedWidget.set_theme(self, theme_name)
        self.config(background=color)
