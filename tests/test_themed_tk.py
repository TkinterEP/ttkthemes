# Copyright (C) 2017 by RedFantom
# Available under the license found in LICENSE
import sys
from ttkthemes.themed_tk import ThemedTk
import unittest
if sys.version_info.major is 2:
    import ttk
else:
    from tkinter import ttk


class TestThemedTk(unittest.TestCase):
    def setUp(self):
        self.tk = ThemedTk()
        self.themes = ["blue", "plastik", "keramik", "aquativo",
                       "clearlooks", "elegance", "kroc", "radiance",
                       "winxpblue", "keramik_alt", "black", "arc"]

    def tearDown(self):
        self.tk.destroy()

    def test_themes_available(self):
        available_themes = self.tk.get_themes()
        for theme in self.themes:
            if theme not in available_themes:
                print("Theme failed:", theme)
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
