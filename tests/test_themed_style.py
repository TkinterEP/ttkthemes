# Copyright (C) 2017 by RedFantom
# Available under the license found in LICENSE
import sys
from ttkthemes.themed_style import ThemedStyle
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
                  "winxpblue", "keramik_alt", "black", "arc"]
        for item in themes:
            style.theme_use(item)
            if item not in style.themes:
                print("Theme failed:", item)
            self.assertTrue(item in style.themes)
            self.assertEqual(style.theme_use(), item)
            print("Theme available:", item)
