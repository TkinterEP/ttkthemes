# Copyright (C) 2017 by RedFantom
# This file was written to go along with the ttk-themes group of themes for Tcl
# This file provides an interface to easily use the themes with Tkinter in Python
import sys
import os
if sys.version_info.major == 2:
    import Tkinter as tk
else:
    import tkinter as tk


class ThemedTk(tk.Tk):
    def __init__(self, *args, **kwargs):
        tk.Tk.__init__(self, *args, **kwargs)
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
            print("Package Img cannot be called. Skipping theme Arc.")
        self.tk.eval("source themes/pkgIndex.tcl")
        os.chdir(prev_folder)

    def set_theme(self, theme_name):
        self.tk.call("package", "require", "ttkthemes")
        self.tk.call("ttk::setTheme", theme_name)

    def get_themes(self):
        self.tk.call("package", "require", "ttkthemes")
        if self.img_support:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
        return list(self.tk.call("ttk::themes"))
