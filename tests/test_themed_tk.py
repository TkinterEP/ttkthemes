"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from ttkthemes.themed_tk import ThemedTk
import unittest
from ttkthemes._utils import is_python_3
if is_python_3():
    from tkinter import ttk
else:
    import ttk


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

    def test_custom_theme(self):
        if not self.tk.img_support:
            return
        for theme in self.tk.pixmap_themes:
            tk = ThemedTk()
            tk.set_theme_advanced(theme, brightness=0.2, saturation=1.4, hue=1.8)
            tk.destroy()
        return
