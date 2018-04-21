"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2018 RedFantom
"""
import sys
if sys.version_info.major == 3:
    import tkinter as tk
    from tkinter import ttk
else:
    import Tkinter as tk
    import ttk
from ttkthemes import ThemedTk
from PIL import Image


class Example(ThemedTk):
    """
    Example that is used to create screenshots for new themes.
    """
    def __init__(self, theme="arc"):
        """
        :param theme: Theme to show off
        """
        ThemedTk.__init__(self)
        self.set_theme(theme)
        # Create widgets
        self.label = ttk.Label(self, text="This is an example label.")
        self.dropdown = ttk.OptionMenu(self, tk.StringVar(), "First value")
        self.entry = ttk.Entry(self, textvariable=tk.StringVar(value="Default entry value."))
        self.button = ttk.Button(self, text="Button")
        self.radio_one = ttk.Radiobutton(self, text="Radio one")
        self.radio_two = ttk.Radiobutton(self, text="Radio two")
        self.scroll = ttk.Scrollbar(self, orient=tk.VERTICAL)
        self.checked = ttk.Checkbutton(self, text="Checked", variable=tk.BooleanVar(value=True))
        self.unchecked = ttk.Checkbutton(self, text="Unchecked")
        self.tree = ttk.Treeview(self, height=4, show=("tree",))
        self.setup_tree()
        # Grid widgets
        self.grid_widgets()
        # Bind screenshot button
        self.bind("<F10>", self.screenshot)

    def setup_tree(self):
        """Setup an example Treeview"""
        self.tree.insert("", tk.END, text="Example 1", iid="1")
        self.tree.insert("", tk.END, text="Example 2", iid="2")
        self.tree.insert("2", tk.END, text="Example Child")

    def grid_widgets(self):
        """Put widgets in the grid"""
        sticky = {"sticky": "nswe"}
        self.label.grid(row=1, column=1, columnspan=2, **sticky)
        self.dropdown.grid(row=2, column=1, **sticky)
        self.entry.grid(row=2, column=2, **sticky)
        self.button.grid(row=3, column=1, columnspan=2, **sticky)
        self.radio_one.grid(row=4, column=1, **sticky)
        self.radio_two.grid(row=4, column=2, **sticky)
        self.checked.grid(row=5, column=1, **sticky)
        self.unchecked.grid(row=5, column=2, **sticky)
        self.tree.grid(row=6, column=1, columnspan=2, **sticky)
        self.scroll.grid(row=1, column=3, rowspan=6, **sticky)

    def screenshot(self, *args):
        """Take a screenshot, crop and save"""
        from mss import mss
        box = {
            "top": self.winfo_y(),
            "left": self.winfo_x(),
            "width": self.winfo_width(),
            "height": self.winfo_height()
        }
        screenshot = mss().grab(box)
        screenshot = Image.frombytes("RGB", screenshot.size, screenshot.rgb)
        screenshot.save("screenshot.png")


if __name__ == '__main__':
    example = Example()
    example.set_theme_advanced("arc", saturation=1.2, hue=1.4, brightness=0.99)
    example.mainloop()
