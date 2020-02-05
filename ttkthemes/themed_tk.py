"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import tkinter as tk
from tkinter import ttk
from ._widget import ThemedWidget


class ThemedTk(tk.Tk, ThemedWidget):
    """
    Tk child class that supports the themes supplied in this package

    A theme can be set upon initialization or during runtime. Can be
    used as a drop-in replacement for the normal Tk class. Additional
    options:

    - Initial theme ``theme``:
      Sets the initial theme to the theme specified. If the theme is
      not available, fails silently (there is no indication that the
      theme is not set other than it not appearing to the user).

    - Toplevel background color ``toplevel``:
      Hooks into the Toplevel.__init__ function to set a default window
      background color in the options passed. The hook is not removed
      after the window is destroyed, which is by design because creating
      multiple Tk instances should not be done in the first place.

    - Tk background color ``themebg``:
      Set the default background color of a Tk window to the default
      theme background color. For example: The background of windows
      may take on a dark color for dark themes. Backwards-compatible
      with the ``background`` keyword argument of v2.3.0 and earlier.

    - GIF theme override ``gif_override``:
      Forces ttkthemes to load the GIF version of themes that also
      provide a PNG version even if the PNG version can be loaded. Can
      only be set at object initialization. GIF themes may provide a
      higher UI performance than other themes.
    """

    def __init__(self, *args, **kwargs):
        """
        :param theme: Theme to set upon initialization. If theme is not
            available, fails silently.
        :param toplevel: Control Toplevel background color option,
            see class documentation for details.
        :param themebg: Control Tk background color option, see
            class documentation for details.
        """
        theme = kwargs.pop("theme", None)
        self._toplevel = kwargs.pop("toplevel", None)
        self._themebg = kwargs.pop("themebg", None)
        # Backwards compatibility with ttkthemes v2.3.0
        background = kwargs.pop("background", None)
        if isinstance(background, bool):
            self._themebg = self._themebg or background
        gif_override = kwargs.pop("gif_override", False)
        # Initialize as tk.Tk
        tk.Tk.__init__(self, *args, **kwargs)
        # Initialize as ThemedWidget
        ThemedWidget.__init__(self, self.tk, gif_override)
        # Set initial theme
        if theme is not None and theme in self.get_themes():
            self.set_theme(theme, self._toplevel, self._themebg)
        self.__init__toplevel = tk.Toplevel.__init__

    def set_theme(self, theme_name, toplevel=None, themebg=None):
        """Redirect the set_theme call to also set Tk background color"""
        if self._toplevel is not None and toplevel is None:
            toplevel = self._toplevel
        if self._themebg is not None and themebg is None:
            themebg = self._themebg
        ThemedWidget.set_theme(self, theme_name)
        color = self._get_bg_color()
        if themebg is True:
            self.config(background=color)
        if toplevel is True:
            self._setup_toplevel_hook(color)

    def _get_bg_color(self):
        return ttk.Style(self).lookup("TFrame", "background", default="white")

    def _setup_toplevel_hook(self, color):
        """Setup Toplevel.__init__ hook for background color"""
        def __toplevel__(*args, **kwargs):
            kwargs.setdefault("background", color)
            self.__init__toplevel(*args, **kwargs)

        tk.Toplevel.__init__ = __toplevel__

    def config(self, kw=None, **kwargs):
        """configure redirect to support additional options"""
        themebg = kwargs.pop("themebg", self._themebg)
        toplevel = kwargs.pop("toplevel", self._toplevel)
        theme = kwargs.pop("theme", self.current_theme)
        color = self._get_bg_color()
        if themebg != self._themebg:
            if themebg is False:
                self.configure(bg="white")
            else:
                self.configure(bg=color)
            self._themebg = themebg
        if toplevel != self._toplevel:
            if toplevel is True:
                self._setup_toplevel_hook(color)
            else:
                tk.Toplevel.__init__ = self.__init__toplevel
            self._toplevel = toplevel
        if theme != self.current_theme:
            self.set_theme(theme)
        return tk.Tk.config(self, kw, **kwargs)

    def cget(self, k):
        """cget redirect to support additional options"""
        if k == "themebg":
            return self._themebg
        elif k == "toplevel":
            return self._toplevel
        elif k == "theme":
            return self.current_theme
        return tk.Tk.cget(self, k)

    def configure(self, kw=None, **kwargs):
        return self.config(kw, **kwargs)

    def __getitem__(self, k):
        return self.cget(k)

    def __setitem__(self, k, v):
        return self.config(**{k: v})
