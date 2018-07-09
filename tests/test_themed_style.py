"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from ttkthemes._tkinter import tk
from ttkthemes.themed_style import ThemedStyle
import unittest


class TestThemedStyle(unittest.TestCase):
    def setUp(self):
        self.window = tk.Tk()

    def test_themed_style_init(self):
        ThemedStyle(self.window)

    def test_themed_style_themes(self):
        style = ThemedStyle(self.window)
        themes = ["blue", "plastik", "keramik", "aquativo",
                  "clearlooks", "elegance", "kroc", "radiance",
                  "winxpblue", "keramik_alt", "black", "arc"]
        for item in themes:
            style.theme_use(item)
            self.assertTrue(item in style.themes)
            self.assertEqual(style.theme_use(), item)

    def test_custom_theme(self):
        for theme in ThemedStyle.pixmap_themes:
            window = tk.Tk()
            style = ThemedStyle(window)
            style.set_theme_advanced(theme, brightness=0.2, saturation=1.3, hue=1.4)
            window.destroy()
        return
