# Copyright (C) 2017 by RedFantom
# This file was written to go along with the ttk-themes group of themes for Tcl
# This file provides an interface to easily use the themes with Tkinter in Python
import sys
import os
if sys.version_info.major is 2:
    import Tkinter as tk
    import ttk
else:
    import tkinter as tk
    from tkinter import ttk


class ThemedStyle(ttk.Style):
    def __init__(self, *args, **kwargs):
        self.__debug = kwargs.pop("debug", False)
        ttk.Style.__init__(self, *args, **kwargs)
        prev_folder = os.getcwd()
        os.chdir(os.path.dirname(os.path.realpath(__file__)))
        self.folder = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
        self.tk.call("lappend", "auto_path", "[%s]" % self.folder + "/themes")
        self.img_support = False
        try:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
            self.img_support = True
        except tk.TclError:
            if self.__debug:
                print("Package Img cannot be called. Skipping theme Arc.")
        self.tk.eval("source themes/pkgIndex.tcl")
        os.chdir(prev_folder)

        self.theme_names = self.get_themes

    def theme_use(self, theme_name=None):
        if theme_name is None:
            # return currently used theme
            # this also works on python 2 because ttk.Style inherits
            # from object
            return super(ThemedStyle, self).theme_use()

        self.set_theme(theme_name)
        return None

    def set_theme(self, theme_name):
        self.tk.call("package", "require", "ttkthemes")
        self.tk.call("ttk::setTheme", theme_name)

    def get_themes(self):
        self.tk.call("package", "require", "ttkthemes")
        if self.img_support:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
        return list(self.tk.call("ttk::themes"))

    @property
    def themes(self):
        return self.get_themes()
