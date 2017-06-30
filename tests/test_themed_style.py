# Copyright (C) 2017 by RedFantom
# Available under the license found in LICENSE
import sys
from ttkthemes.themed_tk import ThemedStyle
import unittest
if sys.version_info.major is 2:
    import Tkinter as tk
else:
    import tkinter as tk


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
        if style.img_support:
            themes.append("arc")
        self.assertListEqual(style.get_themes(), style.themes)
        for item in themes:
            self.assertTrue(item in style.themes)
            style.theme_use(item)
        self.assertEqual(style.theme_use, style.set_theme)
