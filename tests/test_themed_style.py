"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import tkinter as tk
from ttkthemes import ThemedStyle, THEMES
import unittest


class TestThemedStyle(unittest.TestCase):
    def setUp(self):
        self.window = tk.Tk()

    def test_themed_style_init(self):
        ThemedStyle(self.window)

    def test_themed_style_themes(self):
        style = ThemedStyle(self.window)
        for item in THEMES:
            style.theme_use(item)
            self.assertTrue(item in style.themes)
            self.assertEqual(style.theme_use(), item)

    def test_custom_theme(self):
        if not ThemedStyle().png_support:
            return
        for theme in ThemedStyle.pixmap_themes:
            window = tk.Tk()
            style = ThemedStyle(window)
            style.set_theme_advanced(theme, brightness=0.2, saturation=1.3, hue=1.4)
            window.destroy()
        return
