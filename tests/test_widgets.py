"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from __future__ import print_function
from unittest import TestCase
import time
from ttkthemes import ThemedTk
from ttkthemes._utils import is_python_3
if is_python_3():
    from tkinter import ttk
else:
    import ttk


class TestThemedWidgets(TestCase):
    """
    Tkinter may crash if widgets are not configured properly in a theme.
    Therefore, in addition to checking if all files for a theme exist
    by loading it, this Test also tests every core ttk widget to see
    if the widget can be successfully created with the theme data.

    When Tkinter crashes, it keeps the Global Interpreter Lock in place,
    so the program actually has to be terminated with SIGTERM.
    Therefore, this test only executes on UNIX.
    """
    WIDGETS = [
        "Label",
        "Treeview",
        "Button",
        "Frame",
        "Notebook",
        "Progressbar",
        "Scrollbar",
        "Scale",
        "Entry",
        "Combobox"
    ]

    def setUp(self):
        self.window = ThemedTk()
        self.sys_exit = False

    def test_widget_creation(self):
        try:
            import signal
        except ImportError:
            return
        for theme in self.window.themes:
            self.window.set_theme(theme)
            for widget in self.WIDGETS:
                window = ThemedTk(theme=theme)
                signal.alarm(5)
                getattr(ttk, widget)(window).pack()
                window.update()
                window.destroy()
                signal.alarm(0)

    def tearDown(self):
        self.window.destroy()
