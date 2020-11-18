"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2018 RedFantom
"""
import os
import tkinter as tk
from tkinter import ttk
from ttkthemes import ThemedTk, THEMES
from ttkwidgets import ScaleEntry
from ttkwidgets.autocomplete import AutocompleteCombobox
from PIL import Image


class Example(ThemedTk):
    """
    Example that is used to create screenshots for new themes.
    """
    def __init__(self, theme="arc"):
        """
        :param theme: Theme to show off
        """
        ThemedTk.__init__(self, fonts=True, themebg=True)
        self.set_theme(theme)
        # Create widgets
        self.notebook = ttk.Notebook(self)
        self.notebook.add(ttk.Button(self, text="Hello World"), text="Frame One")
        self.notebook.add(ttk.Button(self, text="Hello Universe"), text="Frame Two")
        self.menu = tk.Menu(self, tearoff=False)
        self.sub_menu = tk.Menu(self.menu, tearoff=False)
        self.sub_menu.add_command(label="Exit", command=self.destroy)
        self.menu.add_cascade(menu=self.sub_menu, label="General")
        self.config(menu=self.menu)
        self.label = ttk.Label(self, text="This is an example label.")
        self.dropdown = ttk.OptionMenu(self, tk.StringVar(), "First value", "Second Value")
        self.entry = ttk.Entry(self, textvariable=tk.StringVar(value="Default entry value."))
        self.button = ttk.Button(self, text="Button")
        self.radio_one = ttk.Radiobutton(self, text="Radio one", value=True)
        self.radio_two = ttk.Radiobutton(self, text="Radio two", value=False)
        self.scroll = ttk.Scrollbar(self, orient=tk.VERTICAL)
        self.checked = ttk.Checkbutton(self, text="Checked", variable=tk.BooleanVar(value=True))
        self.unchecked = ttk.Checkbutton(self, text="Unchecked")
        self.tree = ttk.Treeview(self, height=4, show=("tree", "headings"))
        self.setup_tree()
        self.scale_entry = ScaleEntry(self, from_=0, to=50, orient=tk.HORIZONTAL, compound=tk.RIGHT)
        self.combo = AutocompleteCombobox(self, completevalues=["something", "something else"])
        self.progress = ttk.Progressbar(self, maximum=100, value=50)
        # Grid widgets
        self.grid_widgets()
        # Bind screenshot button
        self.bind("<F10>", self.screenshot)
        self.bind("<F9>", self.screenshot_themes)

    def setup_tree(self):
        """Setup an example Treeview"""
        self.tree.insert("", tk.END, text="Example 1", iid="1")
        self.tree.insert("", tk.END, text="Example 2", iid="2")
        self.tree.insert("2", tk.END, text="Example Child")
        self.tree.heading("#0", text="Example heading")

    def grid_widgets(self):
        """Put widgets in the grid"""
        sticky = {"sticky": "nswe"}
        self.notebook.grid(row=0, column=1, columnspan=2, **sticky)
        self.label.grid(row=1, column=1, columnspan=2, **sticky)
        self.dropdown.grid(row=2, column=1, **sticky)
        self.entry.grid(row=2, column=2, **sticky)
        self.button.grid(row=3, column=1, columnspan=2, **sticky)
        self.radio_one.grid(row=4, column=1, **sticky)
        self.radio_two.grid(row=4, column=2, **sticky)
        self.checked.grid(row=5, column=1, **sticky)
        self.unchecked.grid(row=5, column=2, **sticky)
        self.scroll.grid(row=1, column=3, rowspan=8, padx=5, **sticky)
        self.tree.grid(row=6, column=1, columnspan=2, **sticky)
        self.scale_entry.grid(row=7, column=1, columnspan=2, **sticky)
        self.combo.grid(row=8, column=1, columnspan=2, **sticky)
        self.progress.grid(row=9, column=1, columnspan=2, padx=5, pady=5, **sticky)

    def screenshot(self, *args):
        """Take a screenshot, crop and save"""
        from mss import mss
        if not os.path.exists("screenshots"):
            os.makedirs("screenshots")
        box = {
            "top": self.winfo_y(),
            "left": self.winfo_x(),
            "width": self.winfo_width(),
            "height": self.winfo_height()
        }
        screenshot = mss().grab(box)
        screenshot = Image.frombytes("RGB", screenshot.size, screenshot.rgb)
        screenshot.save("screenshots/{}.png".format(ttk.Style(self).theme_use()))

    def screenshot_themes(self, *args):
        """Take a screenshot for all themes available"""
        from time import sleep
        for theme in THEMES:
            self.set_theme(theme)
            self.update()
            sleep(0.05)
            self.screenshot()


if __name__ == '__main__':
    example = Example()
    example.set_theme("adapta")
    example.mainloop()
