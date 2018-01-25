"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from ttkthemes.themed_style import ThemedStyle
import unittest
from ttkthemes._utils import is_python_3
if is_python_3():
    import tkinter as tk
else:
    import Tkinter as tk


class TestThemedStyle(unittest.TestCase):
    def setUp(self):
        self.window = tk.Tk()

    def test_themed_style_init(self):
        ThemedStyle(self.window)

    def test_themed_style_themes(self):
        style = ThemedStyle(self.window)
        themes = ["blue", "plastik", "keramik", "aquativo",
                  "clearlooks", "elegance", "kroc", "radiance",
                  "winxpblue", "keramik_alt", "black"]
        if style.check_img_support():
            themes.append("arc")
        self.assertListEqual(style.get_themes(), style.themes)
        for item in themes:
            self.assertTrue(item in style.themes)
            style.theme_use(item)
            self.assertEqual(style.theme_use(), item)

    def test_custom_theme(self):
        if not ThemedStyle().check_img_support():
            return
        for theme in ThemedStyle.pixmap_themes:
            window = tk.Tk()
            style = ThemedStyle(window)
            print("Testing theme:", theme, flush=True)
            style.set_theme_advanced(theme, brightness=0.2, saturation=1.3, hue=1.4)
        return
