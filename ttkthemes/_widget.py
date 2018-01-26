"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import os
import sys
from platform import architecture
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

    platforms = {
        "win32": "win",
        "linux2": "linux"
    }

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
        self._load_tkimg()
        try:
            self.tk.call("package", "require", "Img")
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
        return list(self.tk.call("ttk::themes"))

    @property
    def themes(self):
        """Property alias of get_themes()"""
        return self.get_themes()

    def _load_tkimg(self):
        """
        Load the TkImg library from the tkimg folder for the current
        tk interpreter. Required for PNG support on Python 2, but also
        used on Python 3 as the theme files have been modified to
        support Img.
        """
        prefix = sys.platform if sys.platform not in self.platforms else self.platforms[sys.platform]
        arch = int(architecture()[0][:2])
        tkimg_folder = os.path.join(os.path.dirname(__file__), "tkimg", "{}{}".format(prefix, arch))
        pkg_index = os.path.join(tkimg_folder, "pkgIndex.tcl")
        prev_folder = os.getcwd()
        os.chdir(tkimg_folder)
        self.tk.call("lappend", "auto_path", "[{}]".format(tkimg_folder))
        try:
            self.tk.eval("source {}".format(os.path.relpath(pkg_index, os.getcwd())))
            self.tk.call("package", "require", "Img")
            success = True
        except tk.TclError:
            success = False
        os.chdir(prev_folder)
        return success


