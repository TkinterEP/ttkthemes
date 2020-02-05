"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import sys
from unittest import TestCase
from ttkthemes import ThemedTk
from tkinter import ttk


def printf(string, end="\n"):
    sys.__stdout__.write(string + end)
    sys.__stdout__.flush()


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

    def test_widget_creation(self):
        try:
            import signal
        except ImportError:
            pass
        if "signal" not in locals() or not hasattr(signal, "alarm"):
            return
        for theme in self.window.themes:
            self.window.set_theme(theme)
            for widget in self.WIDGETS:
                window = ThemedTk(theme=theme)
                signal.alarm(5)
                printf("Testing {}: {}".format(theme, widget), end=" - ")
                getattr(ttk, widget)(window).pack()
                window.update()
                window.destroy()
                signal.alarm(0)
                printf("SUCCESS")

    def tearDown(self):
        self.window.destroy()
