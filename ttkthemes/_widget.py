"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import os
from ._utils import is_python_3

if is_python_3():
    import tkinter as tk
else:
    import Tkinter as tk


class ThemedWidget(object):
    """
    Provides functions to manipulate themes in order to reduce code
    duplication in the ThemedTk and ThemedStyle classes.
    """
    def __init__(self, tk_interpreter):
        """
        Loads themes into tk interpreter
        :param tk_interpreter: tk interpreter for tk.Widget that is
                               being initialized as ThemedWidget
        """
        self.tk = tk_interpreter
        # Change working directory temporarily to allow Tcl to work
        prev_folder = os.getcwd()
        os.chdir(os.path.dirname(os.path.realpath(__file__)))
        # Load the themes
        self.folder = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
        self.tk.call("lappend", "auto_path", "[%s]" % self.folder + "/themes")
        self.img_support = False
        try:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
            self.img_support = True
        except tk.TclError:
            pass
        self.tk.eval("source themes/pkgIndex.tcl")
        # Change back working directory
        os.chdir(prev_folder)

    def set_theme(self, theme_name):
        """
        Set new theme to use. Uses a direct tk call to allow usage
        of the themes supplied with this package.
        :param theme_name: name of theme to activate
        """
        self.tk.call("package", "require", "ttkthemes")
        self.tk.call("ttk::setTheme", theme_name)

    def get_themes(self):
        """Return a list of names of available themes"""
        self.tk.call("package", "require", "ttkthemes")
        if self.img_support:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
        return list(self.tk.call("ttk::themes"))

    @property
    def themes(self):
        """Property alias of get_themes()"""
        return self.get_themes()


