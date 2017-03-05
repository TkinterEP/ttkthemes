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
        self.folder = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
        self.tk.call("lappend", "auto_path", "[%s]" % self.folder + "/themes")
        self.img_support = False
        try:
            self.tk.call("package", "require", "Img")
            self.img_support = True
        except tk.TclError:
            print("Package Img cannot be called. Skipping theme Arc.")
        self.tk.eval("source themes/pkgIndex.tcl")

    def set_theme(self, theme_name):
        self.tk.call("package", "require", "ttk-themes")
        self.tk.call("ttk::setTheme", theme_name)

    def get_themes(self):
        return list(self.tk.call("ttk::themes"))


if __name__ == "__main__":
    import unittest
    if sys.version_info.major == 2:
        import ttk
    else:
        from tkinter import ttk

    class TestThemedTk(unittest.TestCase):
        def setUp(self):
            if sys.version_info.major == 2:
                self.themes = ["blue", "plastik", "keramik", "winxpblue",
                               "clearlooks", "elegance", "kroc", "radiance",
                               "keramik_alt"]
            else:
                try:
                    tk.Tk().call("package", "require", "Img")
                    self.themes = ["blue", "plastik", "keramik", "arc",
                                   "clearlooks", "elegance", "kroc", "radiance",
                                   "winxpblue", "aquativo", "keramik_alt"]
                except tk.TclError:
                    self.themes = ["blue", "plastik", "keramik", "aquativo",
                                   "clearlooks", "elegance", "kroc", "radiance",
                                   "winxpblue", "keramik_alt"]
            self.tk = ThemedTk()

        def tearDown(self):
            self.tk.destroy()

        def test_themes_available(self):
            available_themes = self.tk.get_themes()
            for theme in self.themes:
                self.assertTrue(theme in available_themes)

        def test_theme_setting(self):
            button = ttk.Button(self.tk)
            label = ttk.Label(self.tk)
            button.pack()
            label.pack()
            self.tk.update()
            for theme in self.tk.get_themes():
                self.tk.set_theme(theme)
                self.tk.update()


    unittest.main()
