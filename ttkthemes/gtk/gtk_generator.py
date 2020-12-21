"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2020 RedFantom
"""
# Standard Library
import ast
from base64 import b64encode
from collections import defaultdict
import os
import tkinter as tk
from tkinter import ttk
import shutil
import subprocess as sp
import textwrap
from typing import Any, Dict, Generator, List, Optional, Tuple, Union
# Package
from ttkthemes._utils import temporary_chdir
from ttkthemes.gtk.generator import ThemeGenerator


def split_string_with_literal(string: str, char) -> Tuple[Optional[str], Optional[str]]:
    """
    Helper function: Split a string but ignore characters within string literals

    ``Hello World`` split by `` `` -> [``Hello``, ``World``]
    ``"Hello World"`` split by `` `` -> [``"Hello World"``]
    """
    quoted = False
    for i, c in enumerate(string):
        if c in "\"\'":
            quoted = not quoted
        if c == char and not quoted:
            return tuple(map(str.strip, (string[:i], string[i + 1:])))
    return None, None


def search_dict_recursive(dictionary: dict, key: str) -> Generator[Union[List, Dict, str], None, None]:
    """
    Helper function: Recursively search a dictionary for a key

    Searches the given dictionary for a specific key and yields its
    value. If the dictionary contains a
    - dict: Search in this dictionary in the same way, unless its key
            is the specified key.
    - list or tuple: Search in this iterable for dictionaries that can
            then be searched in the same way, unless its key is the
            specified key.
    """
    if isinstance(dictionary, dict):
        for k, v in dictionary.items():
            if k == key:
                yield v
            elif isinstance(v, dict) or isinstance(v, list):
                yield from search_dict_recursive(v, key)
    elif isinstance(dictionary, (list, tuple)):
        for item in dictionary:
            if isinstance(item, dict):
                yield from search_dict_recursive(item, key)


def issubdict(full: dict, sub: dict) -> bool:
    """Test whether the sub is a subdictionary of the full dict"""
    return all(key in full and full[key] == value for key, value in sub.items())


class GtkThemeError(Exception):
    pass


# Constants
FUNCTION = "function"
STATE = "state"
SHADOW = "shadow"
DETAIL = "detail"
LTR = "LTR"
ORIENTATION = "orientation"


class GtkThemeGenerator(ThemeGenerator):

    # ttk.Scale cannot handle slider handles with white- or alphaspace
    # around the actual indicator. Therefore, these images must be
    # trimmed. AFAIK there is no option to compensate for the whitespace
    # in the widget itself.
    TRIM_REQUIRED = [
        # "Vertical.Scale.slider",
        # "Horizontal.Scale.slider"
    ]

    GTK_STATE_MAPS = defaultdict(dict, {
        "default": {
            ("", ""): ("",),
            ("normal", ""): ("",),
            ("active", ""): ("active",),
            ("insensitive", ""): ("disabled",),
            ("prelight", ""): ("hover",),
        },
        "Checkbutton.indicator": {
            ("normal", "in"): ("selected",),
            ("normal", "out"): ("",),
            ("active", "in"): ("active", "selected"),
            ("active", "out"): ("active",),
            ("normal", "etched_in"): ("alternate",),
            ("prelight", "etched_in"): ("hover", "alternate"),
            ("active", "etched_in"): ("active", "alternate"),
            ("selected", "etched_in"): ("active", "alternate"),
            ("insensitive", "etched_in"): ("disabled", "alternate"),
        },
        "Radiobutton.indicator": {
            ("normal", "in"): ("selected",),
            ("normal", "out"): ("",),
            ("active", "in"): ("active", "selected"),
            ("active", "out"): ("active",),
            ("normal", "etched_in"): ("alternate",),
            ("prelight", "etched_in"): ("hover", "alternate"),
            ("active", "etched_in"): ("active", "alternate"),
            ("selected", "etched_in"): ("active", "alternate"),
            ("insensitive", "etched_in"): ("disabled", "alternate"),
        },
        "Entry.field": {
            ("active", "\"entry\""): ("focus",),
            ("", "\"entry\""): ("",),
            ("insensitive", "\"entry\""): ("disabled",),
        },
        "Horizontal.Progressbar.pbar": {
            ("", "\"bar\""): ("",)
        },
        "Vertical.Progressbar.pbar": {
            ("", "\"bar\""): ("",)
        },
        "Horizontal.Progressbar.trough": {
            ("", ""): ("",),
        },
        "Vertical.Progressbar.trough": {
            ("", ""): ("",),
        },
        "Horizontal.Scale.trough": {
            ("", "\"trough-upper\""): ("",),
            ("", "\"trough-lower\""): ("active",),
        },
        "Vertical.Scale.trough": {
            ("", "\"trough-upper\""): ("",),
            ("", "\"trough-lower\""): ("active",),
        },
        "Button.button": {
            ("normal", ""): ("",),
            ("prelight", "out"): ("hover",),
            ("prelight", "in"): ("pressed", "active"),
            ("active", ""): (None,),
            ("insensitive", ""): ("disabled",),
        },
        "Toolbutton.button": {
            ("insensitive", "out"): ("disabled",),
            ("insensitive", "in"): ("pressed", "disabled"),
        },
        "Notebook.tab": {
            ("normal", ""): ("selected",)
        },
        "Top.Notebook.tab": {
            ("normal", ""): ("selected",)
        },
        "Bottom.Notebook.tab": {
            ("normal", ""): ("selected",)
        },
        "Left.Notebook.tab": {
            ("normal", ""): ("selected",)
        },
        "Right.Notebook.tab": {
            ("normal", ""): ("selected",)
        },
        "Treeitem.indicator": {
            ("normal", "expanded"): ("user1", "!user2"),
            ("prelight", "expanded"): ("user1", "!user2", "hover"),
            ("active", "expanded"): ("user1", "!user2", "active"),
            ("insensitive", "expanded"): ("user1", "!user2", "disabled"),
            ("normal", "collapsed"): ("!user1", "!user2",),
            ("prelight", "collapsed"): ("!user1", "!user2", "hover",),
            ("active", "collapsed"): ("!user1", "!user2", "active",),
            ("insensitive", "collapsed"): ("!user1", "!user2", "disabled"),
        },
    })

    GTK_STYLES = {
        "": [  # For images without a style
            # Options
            ({"GtkButton::inner-border": "padding"}, ("Button.button", "Toolbutton.button")),
            # TODO: Why is this not working properly?
            # ({"GtkRange::slider-width": "width"}, ("Vertical.Scale.slider", "Horizontal.Scale.slider")),
            ({"GtkProgressBar::xspacing": "padding_x", "GtkProgressBar::yspacing": "padding_y"}, ("Vertical.Progressbar.pbar", "Horizontal.Progressbar.pbar")),
            ({"GtkNotebook::tab-overlap": ("tabmargins", "(0, {}, 0, 0)")}, "configure TNotebook"),
            # Checkbutton
            ({FUNCTION: "CHECK"}, "Checkbutton.indicator"),
            # Radiobutton
            ({FUNCTION: "OPTION"}, "Radiobutton.indicator"),
            # Entry
            ({FUNCTION: "SHADOW"}, "Entry.field"),
            ({"GtkEntry::inner-border": "padding"}, "Entry.field"),
            # Progressbars
            ({FUNCTION: "BOX", DETAIL: "\"bar\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Progressbar.pbar"),
            ({FUNCTION: "BOX", DETAIL: "\"bar\"", ORIENTATION: "VERTICAL"}, "Vertical.Progressbar.pbar"),
            # Separators
            ({FUNCTION: "VLINE"}, "Vertical.Separator"),
            ({FUNCTION: "HLINE"}, "Horizontal.Separator"),
            # Notebook
            # ({FUNCTION: "EXTENSION", "gap_side": "TOP"}, "Notebook.tab"),
            # Scrollbars
            ({FUNCTION: "BOX", DETAIL: "\"trough\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Scrollbar.trough"),
            ({FUNCTION: "BOX", DETAIL: "\"trough\"", ORIENTATION: "VERTICAL"}, "Vertical.Scrollbar.trough"),
            ({FUNCTION: "SLIDER", DETAIL: "\"slider\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Scrollbar.thumb"),
            ({FUNCTION: "SLIDER", DETAIL: "\"slider\"", ORIENTATION: "VERTICAL"}, "Vertical.Scrollbar.thumb"),
            # Scales
            ({FUNCTION: "SLIDER", DETAIL: "\"hscale\""}, "Horizontal.Scale.slider"),
            ({FUNCTION: "SLIDER", DETAIL: "\"vscale\""}, "Vertical.Scale.slider"),
            ({FUNCTION: "BOX", DETAIL: "\"trough-upper\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Scale.trough"),
            ({FUNCTION: "BOX", DETAIL: "\"trough-lower\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Scale.trough"),
            ({FUNCTION: "BOX", DETAIL: "\"trough-upper\"", ORIENTATION: "VERTICAL"}, "Vertical.Scale.trough"),
            ({FUNCTION: "BOX", DETAIL: "\"trough-lower\"", ORIENTATION: "VERTICAL"}, "Vertical.Scale.trough"),
            # Support overriding of arrow
            ({FUNCTION: "ARROW", DETAIL: "\"vscrollbar\""}, ("Scrollbar.uparrow", "Scrollbar.downarrow")),
            ({FUNCTION: "ARROW", DETAIL: "\"hscrollbar\""}, ("Scrollbar.leftarrow", "Scrollbar.rightarrow")),
            # Arrows
            ({FUNCTION: "ARROW", "arrow_direction": "UP"}, "uparrow"),
            ({FUNCTION: "ARROW", "arrow_direction": "DOWN"}, ("downarrow", "Menubutton.indicator")),
            ({FUNCTION: "ARROW", "arrow_direction": "LEFT"}, "leftarrow"),
            ({FUNCTION: "ARROW", "arrow_direction": "RIGHT"}, "rightarrow"),
            # Expander arrows
            ({FUNCTION: "EXPANDER", "direction": LTR}, "Treeitem.indicator"),
            ({FUNCTION: "EXPANDER", "direction": "RTL"}, "expander_rtl"),
            ({FUNCTION: "EXPANDER"}, ("Treeitem.indicator", "expander_rtl")),
            # Spinbox
            ({FUNCTION: "ARROW", DETAIL: "\"spinbutton\""}, ("Spinbox.symuparrow", "Spinbox.symdownarrow")),
            ({FUNCTION: "BOX", DETAIL: "\"spinbutton_up\"", "direction": "LTR"}, "Spinbox.uparrow"),
            ({FUNCTION: "BOX", DETAIL: "\"spinbutton_down\"", "direction": "LTR"}, "Spinbox.downarrow"),
            # Notebook
            ({FUNCTION: "EXTENSION", "gap_side": "BOTTOM"}, ("Top.Notebook.tab", "Notebook.tab")),
            ({FUNCTION: "BOX_GAP", "gap_side": "BOTTOM", DETAIL: "\"notebook\""}, ("Top.Notebook.client", "Notebook.client")),
            ({FUNCTION: "EXTENSION", "gap_side": "TOP"}, "Bottom.Notebook.tab"),
            ({FUNCTION: "BOX_GAP", "gap_side": "TOP", DETAIL: "\"notebook\""}, "Bottom.Notebook.client"),
            ({FUNCTION: "EXTENSION", "gap_side": "LEFT"}, "Right.Notebook.tab"),
            ({FUNCTION: "BOX_GAP", "gap_side": "LEFT", DETAIL: "\"notebook\""}, "Right.Notebook.client"),
            ({FUNCTION: "EXTENSION", "gap_side": "RIGHT"}, "Left.Notebook.tab"),
            ({FUNCTION: "BOX_GAP", "gap_side": "RIGHT", DETAIL: "\"notebook\""}, "Left.Notebook.client")

        ],
        'class "GtkButton"': [
            ({FUNCTION: "BOX"}, ("Button.button", "Menubutton.button"))
        ],
        'class "GtkNotebook"': [
            ({"xthickness": "padding_x", "ythickness": "padding_y"}, "Notebook.tab"),
        ],
        'class "*<GtkNotebook>.<GtkLabel>"': {},
        'class "*<GtkNotebook>.<GtkHBox>.<GtkLabel>"': {},
        'class "*<GtkNotebook>.<GtkEntry>"': {},
        'class "GtkEntry"': [
            ({FUNCTION: "SHADOW"}, "Entry.field")
        ],
        'class "GtkProgressBar"': [
            ({FUNCTION: "BOX", DETAIL: "\"trough\"", ORIENTATION: "HORIZONTAL"}, "Horizontal.Progressbar.trough"),
            ({FUNCTION: "BOX", DETAIL: "\"trough\"", ORIENTATION: "VERTICAL"}, "Vertical.Progressbar.trough")
        ],
        'class "GtkHScale"': [
            ({FUNCTION: "BOX"}, "Horizontal.Scale.trough")
        ],
        'class "GtkVScale"': [
            ({FUNCTION: "BOX"}, "Vertical.Scale.trough")
        ],
        'class "*<GtkToolButton>*<GtkButton>"': [
            ({FUNCTION: "BOX"}, "Toolbutton.button")
        ],
        'class "*<GtkOptionMenu>"': [
            ({FUNCTION: "BOX"}, "Combobox.field")
        ],
        'class "*<GtkTreeView>*<GtkButton>*"': [
            ({FUNCTION: "BOX", "direction": LTR}, "Treeheading.cell")
        ],
        'class "*<GtkComboBoxEntry>*"': [
            ({FUNCTION: "SHADOW", "direction": LTR, DETAIL: "\"entry\""}, "Spinbox.field")
        ],
        'class "*<GtkCombo>.<GtkButton>"': [
            ({"GtkButton::inner-border": "padding"}, ("Spinbox.uparrow", "Spinbox.downarrow"))
        ]
    }

    GTK_COLORS = {
        "text_color": "foreground",
        "base_color": "background",
        "selected_fg_color": "selectforeground",
        "selected_bg_color": "selectbackground",

    }

    DEFAULT_OPTIONS = {
        "Checkbutton.indicator": {
            "width": "22", "sticky": "w"
        }
    }

    def __init__(self, theme: str = None, directory: str = None, output_dir: str = "."):
        """
        :param theme: Name of the theme to generate for ttk. Uses system
            theme if None is given. This name is capital-sensitive!
        :param directory: Path to the directory to find themes in.
        :param output_dir: Path to generate the new theme in.
        """
        self._directory = directory or self.get_themes_directory()
        self._theme_name = theme or self.get_gnome_theme()

        self.__elements = defaultdict(lambda: (set(), dict()))

        ThemeGenerator.__init__(self, theme, output_dir)
        self._parse_theme()

    def _parse_theme(self):
        """Parse the theme from the entry point"""
        theme_file = self.get_theme_file(os.path.join(self._directory, self._theme_name))
        with temporary_chdir(os.path.dirname(theme_file)):
            self._parse_theme_file(theme_file)

        for element, (args, kwargs) in self.__elements.items():
            options = kwargs.copy()
            if element in self.DEFAULT_OPTIONS:
                options = self.DEFAULT_OPTIONS[element].copy()
                options.update(kwargs)
            args = list(args)
            for e in args.copy():
                if isinstance(e, str) and args.index(e) != 0:
                    args.remove(e)
                    args.insert(0, e)
            print("Creating element: {}".format((element, args, options)))
            self.element(element, args, options)

        self._build_layouts()

    def _parse_theme_file(self, theme_file: str):
        """Parse a theme file"""
        with open(theme_file) as fi:
            lines = [l.replace("\\n", "\n").strip().replace("  ", " ")
                     for l in fi.readlines()
                     if len(l.strip()) != 0 and
                     not l.startswith("#")]

        for line in lines:
            if line.startswith("gtk-color-scheme"):
                self._parse_line_color_scheme(line)
            elif line.startswith("include"):
                file = line.strip().split(" ")[1].strip("\"")
                self._parse_theme_file(file)

        self._parse_lines_generic(lines)

    def _parse_line_color_scheme(self, line: str):
        """Parse a line of the color scheme"""
        color_string = split_string_with_literal(line, "=")[1].strip(" \"")
        defined = color_string.split("\n")
        for color in defined:
            name, color = color.split(":")
            print(name, color)
            if name in self.GTK_COLORS:
                self.color(self.GTK_COLORS[name], color)

    def _parse_lines_generic(self, lines: List[str]):
        """
        Parse a list of theme file lines into instructions

        :param lines: A list of pre-processed lines in the theme file.
        """
        gnome_settings, _ = self._build_dictionary(lines)

        for key, value in gnome_settings.items():
            for widget_class, detail in self.GTK_STYLES.items():
                if "class" in widget_class and widget_class in key:
                    self._parse_options(detail, gnome_settings[value])

                    # Process images
                    images = gnome_settings[value]["engine \"pixmap\""]
                    if "image" not in images:
                        print("Invalid {}".format((widget_class, detail, key)), value)
                        continue
                    images = images["image"]
                    print("Matched {} to {}, {}".format(widget_class, key, (value, images)))
                    self._process_images(widget_class, images)

        if "engine \"pixmap\"" in gnome_settings["style \"default\""]:
            images = gnome_settings["style \"default\""]["engine \"pixmap\""]["image"]
            self._process_images("", images)
        self._parse_options(self.GTK_STYLES[""], gnome_settings["style \"default\""])

    def _parse_options(self, options: dict, style_dict: dict):
        # Process options
        for option_dict, elements in options:
            if FUNCTION in option_dict:  # Actually an image dict spec
                continue

            if "configure" in elements:  # Configure settings
                layout = elements.split(" ")[-1]
                for gtk_opt, (tk_opt, template) in option_dict.items():
                    if gtk_opt in style_dict:
                        value = style_dict[gtk_opt]
                        self.configure(layout, {tk_opt: ast.literal_eval(template.format(value))})
                        # self.map("TNotebook.Tab", {"expand": "[list selected {1 2 4 2}]"})

            elif "map" in elements:  # Map options
                pass
            else:  # Element creation keyword arguments
                kwargs = {k: style_dict[n] for n, k in option_dict.items() if n in style_dict}
                if "padding" in kwargs and isinstance(kwargs["padding"], str) and not kwargs["padding"].isdigit():
                    left, right, top, bottom = map(int, map(str.strip, kwargs["padding"].strip("{}").split(",")))
                    kwargs["padding"] = (left, top, right, bottom)
                elif "padding_x" in kwargs and "padding_y" in kwargs:
                    padx, pady = kwargs["padding_x"], kwargs["padding_y"]
                    kwargs["padding"] = (padx, pady, padx, pady)
                    del kwargs["padding_x"], kwargs["padding_y"]
                elif "padding_x" in kwargs or "padding_y" in kwargs:
                    raise ValueError(option_dict, elements)  # Either both or neither must be present

                print("Parsed {} for {}".format(kwargs, option_dict))
                for element in (elements if isinstance(elements, tuple) else (elements,)):
                    self.__elements[element][1].update(kwargs)

    def _process_images(self, _class: str, images: List[dict]):
        for img in images:
            matching = filter(lambda sub: issubdict(img, sub[0]), self.GTK_STYLES[_class])
            best_match = max(matching, key=lambda sub: len(sub[0]), default=None)
            if best_match is None:  # This image is not implemented or not used
                print(_class, "did not match", img)
                continue
            print(_class, "matched", img, best_match)
            _, elements = best_match
            if isinstance(elements, str):
                elements = (elements,)
            for element in elements:
                self.process_image_dict(element, img, self.GTK_STATE_MAPS[element])

    def process_image_dict(self, widget: str, img: dict, state_map: dict):
        """
        Process an image dictionary into a usable UI image

        :param widget: Name of the Tkinter widget that this belongs to
        :param img: Dictionary like {
                "file": "path_to_file",
                "function": gtk_specific_thing,
                "state": gtk_state_specifier,
                "shadow": widget_option,
            }
        :param state_map:
        """
        if "state" not in img:
            img["state"] = ""
        if "file" not in img and "overlay_file" in img:
            img["file"] = img["overlay_file"]
        if "file" not in img:
            img["file"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "empty.png")
        img["file"] = img["file"].strip("\"")
        path = os.path.abspath(img["file"])
        if not path.endswith((".png", ".gif")):
            return None

        with open(path, "rb") as fi:
            img_data = b64encode(fi.read()).decode()

        img["state"] = img["state"].lower()
        if "shadow" not in img and "detail" not in img and img[FUNCTION] != "EXPANDER":
            gtk_state = (img["state"], "")
        elif "shadow" not in img and "detail" not in img and img[FUNCTION] == "EXPANDER":
            gtk_state = (img["state"], img["expander_style"])
        elif "shadow" not in img and "detail" in img:
            gtk_state = (img["state"], img["detail"])
        else:
            gtk_state = (img["state"], img["shadow"])
        gtk_state = tuple(map(str.lower, gtk_state))

        default_state_map = self.GTK_STATE_MAPS["default"].copy()
        if "detail" in img:
            for (state, _), tk_state in default_state_map.copy().items():
                default_state_map[(state, img["detail"])] = tk_state
        default_state_map.update(state_map)
        state_map = default_state_map.copy()

        if gtk_state not in state_map:
            print("Unable to find '{}' for {}".format(gtk_state, widget))
            return None
        state = list(state_map[gtk_state])
        if None in state:
            print("Ignored state image")
            return None

        widget_name = "-".join(map(str.lower, widget.split(".")))
        img_name = "{}-{}".format(widget_name, "-".join(state)).strip("-")

        kwargs = dict()
        if "border" in img:
            left, right, top, bottom = tuple(map(int, map(lambda x: x.strip(" {},"), img["border"].split(","))))
            kwargs["border"] = (left, top, right, bottom)

        while "" in state:
            state.remove("")
        while "--" in img_name:
            img_name = img_name.replace("--", "-")

        if img_name not in self.image_names:
            self.image(img_name, img_data, trim=widget in self.TRIM_REQUIRED)  # Register image

        # Add image to layout element
        identifier = tuple(state) + (img_name,)
        identifier = identifier if len(identifier) > 1 else identifier[0]

        self.__elements[widget][0].add(identifier)
        self.__elements[widget][1].update(kwargs)

        # TODO: Move this dirty solution elsewhere
        if widget == "Treeitem.indicator" and ("user2", "empty") not in self.__elements[widget][0]:
            # A custom Treeitem indicator is in the theme
            self.__elements[widget][0].add(("user2", "empty"))
            with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "empty.png"), "rb") as fi:
                img_data = b64encode(fi.read()).decode()
            self.image("empty", img_data)

    def _build_layouts(self):
        """Build the layouts for the GTK theme based on available elements"""
        self.layout("TButton", [
            ("Button.button", {"children": [
                ("Button.focus", {"children": [
                    ("Button.padding", {"children": [
                        ("Button.label", {})
                    ]})
                ]})
            ]})
        ])

        self.layout("Treeview.item", [
            ("Treeitem.padding", {"sticky": "nswe", "children": [
                ("Treeitem.indicator", {"side": "left"}),
                ("Treeitem.image", {"side": "left"}),
                ("Treeitem.focus", {"side": "left", "children": [
                    ("Treeitem.text", {"side": "left"})
                ]})
            ]})
        ])

        self.layout("TSpinbox", [
            ("Spinbox.field", {"side": "left", "sticky": "nswe", "children": [
                ("Spinbox.padding", {"side": "left", "sticky": "nswe", "children": [
                    ("Spinbox.textarea", {"side": "left", "sticky": "nswe"})
                ]})
            ]}),
            ("Spinbox.buttons", {"side": "right", "children": [
                ("null", {"side": "right", "children": [
                    ("Spinbox.uparrow", {"side": "top", "sticky": "nse", "children": [
                        ("uparrow", {"side": "right", "sticky": "e"})
                    ]}),
                    ("Spinbox.downarrow", {"side": "bottom", "sticky": "nse", "children": [
                        ("downarrow", {"side": "right", "sticky": "e"})
                    ]})
                ]})
            ]}),
        ])

        self.layout("Tab", [
            ("Notebook.tab", {"side": "left", "children": [
                ("Notebook.padding", {"side": "top", "expand": True, "children": [
                    ("Notebook.focus", {"side": "top", "expand": True, "children": [
                        ("Notebook.label", {"side": "top"})
                    ]})
                ]})
            ]}),
        ])

        self.layout("TMenubutton", [
            ("Menubutton.button", {"children": [
                ("Menubutton.focus", {"children": [
                    ("Menubutton.padding", {"children": [
                        ("Menubutton.indicator", {"side": "right"}),
                        ("Menubutton.label", {"side": "right", "expand": True})
                    ]})
                ]})
            ]})
        ])

        self.configure("Left.TNotebook", {"tabposition": "wn"})
        self.layout("Left.TNotebook", [
            ("Left.Tab", {"side": "left", "expand": True, "children": [
                ("Left.Notebook.padding", {"side": "left", "expand": True, "children": [
                    ("Left.Notebook.focus", {"side": "left", "expand": True, "children": [
                        ("Left.Notebook.label", {"side": "left"})
                    ]})
                ]})
            ]})
        ])
        self.configure("Right.TNotebook", {"tabposition": "en"})
        self.configure("Bottom.TNotebook", {"tabposition": "sw"})
        self.configure("Top.TNotebook", {"tabposition": "nw"})

        self.configure("TNotebook", {"tabmargins": (0, 2, 0, 0)})
        self.configure("TNotebook.Tab", {"expand": (0, 0, 1)})
        self.map("TNotebook.Tab", {"expand": ["selected", (1, 1, 2, 1)]})

    @staticmethod
    def _build_dictionary(lines: List[str]) -> Tuple[Dict[str, Any], int]:
        """
        Recursively parse the lines of a gnome theme file into dictionary

        :param lines: List of pre-processed theme file lines
        :return: Tuple of dictionary produced and the level of building
            used in recursive algorithm.
        """
        result: Dict[str, Union[list, dict, str]] = defaultdict(dict)
        to_skip = 0
        for i, line in enumerate(lines):

            if to_skip != 0:
                to_skip -= 1
                continue
            if "{" in line and "}" not in line:  # Start of a new dictionary
                name = line.split("{")[0].strip()
                r, to_skip = GtkThemeGenerator._build_dictionary(lines[i + 1:])
                if name in result:
                    if not isinstance(result[name], list):
                        result[name] = [result[name], r]
                    else:
                        result[name].append(r)
                else:
                    result[name] = r
            elif "}" in line and "{" not in line:  # This dictionary has now closed
                return result, i + 1
            else:
                if "=" in line:
                    key, value = split_string_with_literal(line, "=")
                    if key is None:
                        continue
                    result[key] = value
                elif "class" in line.lower():
                    key, value = list(e for e in map(str.strip, line.split(" style")) if e != "")
                    value = "style {}".format(value)
                    result[key] = value
        return result, -1

    @staticmethod
    def get_gnome_theme() -> str:
        """Return the string name of the currently active theme"""
        p = sp.Popen(["gsettings", "get", "org.gnome.desktop.interface", "gtk-theme"], stdout=sp.PIPE)
        stdout, stderr = p.communicate()
        return stdout.decode().strip().strip("'")

    @staticmethod
    def get_gnome_themes(directory=None) -> List[str]:
        """Return a list of installed Gnome themes"""
        directory = directory or GtkThemeGenerator.get_themes_directory()
        themes = list()
        for x in os.listdir(directory):
            x_dir = os.path.join(directory, x)
            if not os.path.isdir(x_dir) or not GtkThemeGenerator.is_theme_directory(x_dir):
                continue
            themes.append(x)
        return themes

    @staticmethod
    def get_themes_directory() -> str:
        """Return the path to the default themes directory"""
        return os.path.join("/", "usr", "share", "themes")

    @staticmethod
    def get_theme_file(theme_dir: str) -> str:
        """Return the path to the main theme file or raise an error"""
        if not os.path.exists(theme_dir):
            raise GtkThemeError("This folder does not exist: '{}'".format(theme_dir))
        for subdir in ("gtk-2.0", "gtk"):
            for file in ("gtkrc", "gnomerc", ".gtkrc", ".gnomerc"):
                path = os.path.join(theme_dir, subdir, file)
                if os.path.exists(path):
                    return path
        raise GtkThemeError("Could not find a suitable theme file in this directory: '{}'".format(theme_dir))

    @staticmethod
    def is_theme_directory(dir: str) -> bool:
        """Validate whether a theme can be parsed from this directory"""
        try:
            GtkThemeGenerator.get_theme_file(dir)
            return True
        except GtkThemeError:
            return False


if __name__ == '__main__':
    generator = GtkThemeGenerator("Adwaita")
    generator.generate()

    from example import Example as MainWindow

    window = MainWindow()

    with temporary_chdir("adwaita"):
        window.tk.eval("source adwaita.tcl")
        window.tk.eval("package require adwaita 1.0")
        window.tk.eval("ttk::setTheme adwaita")

    window.mainloop()
