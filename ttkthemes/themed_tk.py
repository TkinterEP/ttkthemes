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

    - Initial theme ``theme``:
      Sets the initial theme to the theme specified. If the theme is
      not available, fails silenty (there is no indication that the
      theme is not set other than

    - Toplevel background color ``toplevel``:
      Hooks into the Toplevel.__init__ function to set a default window
      background color in the options passed. The hook is not removed
      after the window is destroyed, which is by design because creating
      multiple Tk instances should not be done in the first place.

    - Tk background color ``themebg``:
      Simply sets the background color of the Tkinter window to the
      default TFrame background color specified by the theme.
    """

    def __init__(self, *args, **kwargs):
        """
        :param theme: Theme to set upon initialization. If theme is not
            available, fails silently.
        :param toplevel: Control Toplevel background color option
        :param background: Control Tk background color option
        """
        theme = kwargs.pop("theme", None)
        self._toplevel = kwargs.pop("toplevel", None)
        self._themebg = kwargs.pop("themebg", None)
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
        """Configure redirect to support additional options"""
        background = kwargs.pop("themebg", self._themebg)
        toplevel = kwargs.pop("toplevel", self._toplevel)
        theme = kwargs.pop("theme", self.current_theme)
        color = self._get_bg_color()
        if background != self._themebg:
            self.configure(bg="white")
        if toplevel != self._toplevel:
            if toplevel is True:
                self._setup_toplevel_hook(color)
            else:
                tk.Toplevel.__init__ = self.__init__toplevel
        if theme != self.current_theme:
            self.set_theme(theme)
        return tk.Tk.config(self, kw, **kwargs)

    def configure(self, kw=None, **kwargs):
        return self.config(kw, **kwargs)

    def cget(self, k):
        """cget redirect to support additional options"""
        if k == "themebg":
            return self._themebg
        elif k == "toplevel":
            return self._toplevel
        elif k == "theme":
            return self.current_theme
        return tk.Tk.cget(self, k)
