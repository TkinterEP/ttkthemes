"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import tkinter as tk
from tkinter import ttk
from ttkthemes import ThemedTk, THEMES
import unittest


class TestThemedTk(unittest.TestCase):

    def setUp(self):
        self.tk = ThemedTk()

    def tearDown(self):
        self.tk.destroy()

    def test_themes_available(self):
        available_themes = self.tk.get_themes()
        for theme in THEMES:
            if theme not in available_themes:
                raise AssertionError("Theme {} not available".format(theme))

    def test_theme_setting(self):
        for theme in self.tk.get_themes():
            window = ThemedTk()
            button = ttk.Button(window)
            label = ttk.Label(window)
            button.pack()
            label.pack()
            window.set_theme(theme)
            window.update()
            window.destroy()

    def test_custom_theme(self):
        if not self.tk.png_support:
            return
        for theme in self.tk.pixmap_themes:
            tk = ThemedTk()
            tk.set_theme_advanced(theme, brightness=0.2, saturation=1.4, hue=1.8)
            tk.destroy()
        return

    def test_toplevel_hook(self):
        __init__toplevel = tk.Toplevel.__init__
        self.tk.set_theme("black", True, False)
        self.assertNotEqual(__init__toplevel, tk.Toplevel.__init__)
        top = tk.Toplevel(self.tk)
        color = ttk.Style(self.tk).lookup("TFrame", "background")
        self.assertIsNotNone(color)
        self.assertEqual(top.cget("background"), color)
        top.destroy()

    def test_tk_background(self):
        self.tk.config(background="white")
        self.tk.set_theme("black", False, True)
        self.assertNotEqual(self.tk.cget("background"), "white")

    def test_config_cget(self):
        self.tk.config(theme="equilux")
        self.assertEqual(self.tk.cget("theme"), self.tk.current_theme)
        self.assertEqual(self.tk.cget("theme"), "equilux")

        self.tk.config(themebg=True)
        self.assertTrue(self.tk.cget("themebg"))
        before = self.tk.cget("bg")
        self.tk.config(themebg=False)
        self.assertFalse(self.tk.cget("themebg"))
        after = self.tk["bg"]
        self.assertNotEqual(before, after)

        self.tk.config(toplevel=False)
        self.assertFalse(self.tk.cget("toplevel"))
        orig = tk.Toplevel.__init__
        self.tk["toplevel"] = True
        self.assertTrue(self.tk.cget("toplevel"))
        self.assertNotEqual(orig, tk.Toplevel.__init__)

        self.tk.configure(toplevel=False)
        self.assertEqual(tk.Toplevel.__init__, orig)

    def test_background_on_init(self):
        w = ThemedTk(theme="black", toplevel=True)
        tk.Toplevel(w)  # Issue #74, RecursionError
