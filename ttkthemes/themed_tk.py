"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from ._tkinter import tk, ttk
from ._widget import ThemedWidget


class ThemedTk(tk.Tk, ThemedWidget):
    """
    Tk child class that supports the themes supplied in this package

    A theme can be set upon initialization or during runtime. Can be
    used as a drop-in replacement for the normal Tk class. Additional
    options:

    - Toplevel background color: toplevel
      If True, ``ThemedTk`` hooks into the Toplevel.__init__ function
      to set a default window background color in the options passed.
      The hook is not removed after the window is destroyed, which is by
      design because creating multiple Tk instances should not be done
      in the first place.

    - Tk background color: background
      If True, sets the background color of the Tkinter window to the
      default TFrame background color specified by the theme. For a
      custom background color, the ``bg`` alias can still be used.
    """

    def __init__(self, *args, **kwargs):
        """
        :param theme: Theme to set upon initialization. If theme is not
            available, fails silently.
        :type theme: str
        :param toplevel: Control Toplevel background color option
        :type toplevel: bool
        :param background: Control Tk background color option
        :type background: bool
        """
        theme = kwargs.pop("theme", None)
        toplevel = kwargs.pop("toplevel", False)
        background = kwargs.pop("background", False)
        gif_override = kwargs.pop("gif_override", False)
        # Initialize as tk.Tk
        tk.Tk.__init__(self, *args, **kwargs)
        # Initialize as ThemedWidget
        ThemedWidget.__init__(self, self.tk, gif_override)
        # Set initial theme
        self.__init__toplevel = tk.Toplevel.__init__
        if theme is not None and theme in self.get_themes():
            self.set_theme(theme, toplevel, background)

    def set_theme(self, theme_name, toplevel=False, background=False):
        """Redirect the set_theme call to also set Tk background color"""
        ThemedWidget.set_theme(self, theme_name)
        color = ttk.Style(self).lookup("TFrame", "background", default="white")
        if background is True:
            self.config(background=color)
        if toplevel is True:
            self._setup_toplevel_hook(color)
        else:
            tk.Toplevel.__init__ = self.__init__toplevel

    def _setup_toplevel_hook(self, color):
        """Setup Toplevel.__init__ hook for background color"""
        def __toplevel__(*args, **kwargs):
            kwargs.setdefault("background", color)
            self.__init__toplevel(*args, **kwargs)

        tk.Toplevel.__init__ = __toplevel__
