# Copyright (C) 2017 by RedFantom
# This file was written to go along with the ttk-themes group of themes for Tcl
# This file provides an interface to easily use the themes with Tkinter in Python
import sys
import os
if sys.version_info.major == 2:
    import Tkinter as tk
    import ttk
else:
    import tkinter as tk
    from tkinter import ttk


class ThemedTk(tk.Tk):
    def __init__(self, *args, **kwargs):
        tk.Tk.__init__(self, *args, **kwargs)
        self.style = ttk.Style()
        self.folder = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
        self.tk.call("lappend", "auto_path", "[%s]" % self.folder + "/themes")
        self.img_support = False
        try:
            self.tk.call("package", "require", "Img")
            self.img_support = True
        except tk._tkinter.TclError:
            print("Package Img cannot be called. Skipping.")
        self.tk.eval("source themes/pkgIndex.tcl")
        self.tk.call("package", "require", "ttk-themes")

    def set_theme(self, theme_name):
        self.style.theme_use(theme_name)

    def get_themes(self):
        return list(self.tk.call("ttk::themes"))


if __name__ == "__main__":
    import unittest

    class TestThemedTk(unittest.TestCase):
        if sys.version_info.major == 2:
            themes = ["blue", "plastik", "keramik", "keramik_alt",
                      "clearlooks", "elegance", "kroc", "radiance",
                      "winxpblue"]
        else:
            themes = ["blue", "plastik", "keramik", "keramik_alt",
                      "clearlooks", "elegance", "kroc", "radiance",
                      "winxpblue", "arc", "aquativo"]

        def setUp(self):
            self.tk = ThemedTk()

        def tearDown(self):
            self.tk.destroy()

        def test_themes_available(self):
            available_themes = self.tk.get_themes()
            for theme in self.themes:
                print(theme)
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
