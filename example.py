"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2018 RedFantom
"""
import os
import tkinter as tk
from tkinter import ttk
from ttkthemes import ThemedTk, THEMES
from PIL import Image


sticky = {"sticky": "nw", "padx": 5, "pady": 5}


class CheckbuttonFrame(ttk.Labelframe):
    """Frame containing unchecked, checked, alternate, disabled checkbuttons"""

    def __init__(self, *args, **kwargs):
        kwargs.update({"text": "Checkbuttons"})
        ttk.Labelframe.__init__(self, *args, **kwargs)


        _checked = ttk.Checkbutton(self, text="Checked")
        _checked.state(("selected",))

        _tristate = ttk.Checkbutton(self, text="Tristate")
        _tristate.state(("selected", "alternate"))

        _unchecked = ttk.Checkbutton(self, text="Unchecked")

        var = tk.BooleanVar(value=True)
        _disabled = ttk.Checkbutton(self, text="Disabled", variable=var)
        _disabled.update_idletasks()
        _disabled.configure(state="disabled")

        _unchecked.grid(row=0, **sticky)
        _checked.grid(row=1, **sticky)
        _tristate.grid(row=2, **sticky)
        _disabled.grid(row=3, **sticky)


class RadiobuttonFrame(ttk.Labelframe):
    """Frame containing unchecked, checked, alternate, disabled radiobuttons"""

    def __init__(self, *args, **kwargs):
        kwargs.update({"text": "Radiobuttons"})
        ttk.Labelframe.__init__(self, *args, **kwargs)


        _unchecked = ttk.Radiobutton(self, text="Deselected")

        _checked = ttk.Radiobutton(self, text="Selected")
        _checked.state(("selected",))

        _tristate = ttk.Radiobutton(self, text="Tristate")
        _tristate.state(("selected", "alternate"))

        var = tk.BooleanVar(value=True)
        _disabled = ttk.Radiobutton(self, text="Disabled", variable=var)
        _disabled.update_idletasks()
        _disabled.configure(state="disabled")

        _unchecked.grid(row=0, **sticky)
        _checked.grid(row=1, **sticky)
        _tristate.grid(row=2, **sticky)
        _disabled.grid(row=3, **sticky)


class EntryFrame(ttk.Labelframe):
    """Frame with Entry, Spinbox, Combobox"""

    def __init__(self, *args, **kwargs):
        kwargs.update({"text": "Entries"})
        ttk.Labelframe.__init__(self, *args, **kwargs)

        _entry = ttk.Entry(self)
        _entry.insert(tk.END, "Entry")
        _spinbox = ttk.Spinbox(self)
        _spinbox.insert(tk.END, "Spinbox")
        _combobox = ttk.Combobox(self)
        _combobox.insert(tk.END, "Combobox")

        _entry.grid(row=1, **sticky)
        _spinbox.grid(row=2, **sticky)
        _combobox.grid(row=3, **sticky)



class ButtonFrame(ttk.LabelFrame):
    """Frame with Button, Menubutton, Toolbutton, OptionMenu, Switch if available"""

    def __init__(self, *args, **kwargs):
        kwargs.update({"text": "Buttons"})
        ttk.Labelframe.__init__(self, *args, **kwargs)

        _button = ttk.Button(self, text="Button")
        _button.grid(row=1, **sticky)

        _toolbutton = ttk.Button(self, text="Toolbutton", style="Toolbutton")
        _toolbutton.grid(row=2, **sticky)

        _menubutton = ttk.Menubutton(self, text="Menubutton")
        _menubutton.grid(row=3, **sticky)

        _optionmenu = ttk.OptionMenu(self, tk.StringVar(), "OptionMenu", "OptionMenu", "Value 1", "Value 2")
        _optionmenu.grid(row=4, **sticky)

        try:
            _switch = ttk.Checkbutton(self, text="Switch", style="Switch")
            _switch.grid(row=5, **sticky)
        except tk.TclError:
            _label = ttk.Label(self, text="Switch is not available")
            _label.grid(row=5, **sticky)



class TreeExample(ttk.Frame):
    DATA = {
        "Parent 1": {
            "Child 1": None,
            "Child 2": None,
            "Sub-parent 1": {
                "Child 1": None,
                "Child 2": None,
            },
            "Child 3": None
        },
        "Root child": None,
        "Parent 2": {
            "Child 1": {
                "Child 1": {
                    "Child 1": {
                        "Child 1": None
                    }
                }
            }
        }
    }

    def __init__(self, *args, **kwargs):
        ttk.Frame.__init__(self, *args, **kwargs)

        self.scroll = ttk.Scrollbar(self, orient=tk.VERTICAL)
        self.tree = ttk.Treeview(self, columns=(1, 2), height=8,
                                 yscrollcommand=self.scroll.set, show=("tree", "headings"))
        self.scroll.config(command=self.tree.yview)

        self.tree.column("#0", width=100)
        self.tree.column(1, width=100)
        self.tree.column(2, width=100)

        self.tree.heading("#0", text="Treeview")
        self.tree.heading(1, text="Column One")
        self.tree.heading(2, text="Column Two")

        self.insert_data(self.DATA)
        self.expand_all()

        self.tree.grid(row=0, column=0)
        self.scroll.grid(row=0, column=1, sticky="nswe")

    def insert_data(self, data: dict, level="", parent=""):
        """Insert data into the Tree recursively"""
        for i, (key, value) in enumerate(data.items()):
            iid = self.tree.insert(parent=parent, index=tk.END, text=key.split(" ")[0], values=("{}{}".format(level, i),)*2)
            if value is not None:
                self.insert_data(value, level="{}{}.".format(level, i), parent=iid)

    def expand_all(self):
        """Expand all the items in the tree"""
        def expand(parent):
            self.tree.item(parent, open=True)
            for child in self.tree.get_children(parent):
                expand(child)

        expand("")



class ExampleNotebook(ttk.Notebook):

    def __init__(self, *args, **kwargs):
        ttk.Notebook.__init__(self, *args, **kwargs)

        _canvas1 = tk.Canvas(self, width=200, height=100)
        self.add(_canvas1, text="Canvas")

        _frame2 = ttk.Frame(self)
        self.add(_frame2, text="Frame")




class Example(ThemedTk):

    def __init__(self, *args, **kwargs):
        ThemedTk.__init__(self, *args, **kwargs)

        CheckbuttonFrame(self, width=200).grid(row=1, column=1, rowspan=4, padx=10, pady=10, sticky="nswe")
        RadiobuttonFrame(self).grid(row=5, column=1, rowspan=4, padx=10, pady=(0, 10), sticky="nswe")

        EntryFrame(self).grid(row=1, column=2, rowspan=3, padx=(0, 10), pady=10, sticky="nswe")
        ButtonFrame(self).grid(row=4, column=2, rowspan=5, padx=(0, 10), pady=(0, 10), sticky="nswe")

        _scale = ttk.Scale(self, length=200, from_=0, to=100)
        _scale.grid(row=9, column=1, sticky="nswe", padx=10, pady=(0, 10))

        _progress = ttk.Progressbar(self, length=200, value=50)
        _progress.grid(row=9, column=2, sticky="nswe", padx=(0, 10), pady=(0, 10))

        _tree = TreeExample(self)
        _tree.grid(row=1, rowspan=6, column=3, sticky="nswe", padx=(0, 10), pady=10)

        _notebook = ExampleNotebook(self)
        _notebook.grid(row=7, column=3, sticky="nswe", padx=(0, 10), pady=(0, 10))

        self.bind("<F10>", self.screenshot)
        self.bind("<F11>", self.screenshot_themes)

    def screenshot(self, *args):
        """Take a screenshot, crop and save"""
        if not os.path.exists("screenshots"):
            os.makedirs("screenshots")
        box = {
            "top": self.winfo_y(),
            "left": self.winfo_x(),
            "width": self.winfo_width(),
            "height": self.winfo_height()
        }
        screenshot = None
        if getattr(self, "mss", None) is None:
            from mss import mss
            self.mss = mss()

        while screenshot is None:
            screenshot = self.mss.grab(box)
        screenshot = Image.frombytes("RGB", screenshot.size, screenshot.rgb)
        screenshot.save("screenshots/{}.png".format(ttk.Style(self).theme_use()))

    def screenshot_themes(self, *args):
        """Take a screenshot for all themes available"""
        from time import sleep
        for theme in THEMES:
            self.set_theme(theme)
            # Give MSS time
            self.update()
            sleep(0.05)
            try:
                self.screenshot()
            except RuntimeError:
                print("Screenshot of {} failed".format(theme))
                continue


if __name__ == '__main__':
    example = Example(background=True)
    example.set_theme("yaru")
    example.mainloop()
