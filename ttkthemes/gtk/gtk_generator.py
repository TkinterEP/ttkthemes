"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2020 RedFantom
"""
# Standard Library
from base64 import b64encode
import os
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


class GtkThemeError(Exception):
    pass


class GtkThemeGenerator(ThemeGenerator):
    GTK_FUNCTIONS = {
        "ARROW": "Arrow",
        "HANDLE": "Scrollbar.through",
        "OPTION": "Radiobutton.indicator",
        "CHECK": "Checkbutton.indicator",
        "SHADOW": "Entry.field",
        "BOX": ("Button", "Progressbar.pbar"),
        "SLIDER": "Scale.slider"
    }

    GTK_DETAILS = {
        "\"entry\"": "Entry.field",
        "\"bar\"": "Progressbar.pbar",
        "\"vscale\"": "Scale.slider",
        "\"hscale\"": "Scale.slider"
    }

    GTK_CLASSES = {
        'class "GtkButton"': "Button.button",
        'widget_class "*<GtkButtonBox>*<GtkButton>*<GtkLabel>"': "Toolbutton.button",
        'class "GtkEntry"': "Entry",
        'class "GtkProgressbBar"': "Progressbar",
        'class "GtkRange"': "Scale",
        'class "GtkScrollbar"': "Scrollbar",
        'class "GtkSpinButton"': "SpinBox",
        'class "GtkNotebook"': "Notebook",
    }

    GTK_COLORS = {
        "text_color": "foreground",
        "base_color": "background",
        "selected_fg_color": "selectforeground",
        "selected_bg_color": "selectbackground",

    }

    GTK_STATES: Dict[Tuple[str, ...], Dict[Tuple[str, str], Tuple[str, ...]]] = {
        ("",): {  # Default
            # (state, shadow): tk_state
        },
        ("Scrollbar",): {
            ("insensitive", "out"): ("disabled",),
            ("active", "in"): ("pressed",),
            ("prelight", "out"): ("active",),
        },
        ("Button", "Toolbutton"): {
            ("normal", ""): ("",),
            ("prelight", "out"): ("hover",),
            ("prelight", "in"): ("pressed", "active"),
            ("active", ""): (None,),
            ("insensitive", ""): ("disabled",),
        },
        ("Checkbutton", "Radiobutton"): {
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
        ("Entry",): {
            ("active", ""): ("focus",),
            ("", ""): ("",),
            ("insensitive", ""): ("disabled",),
        },
        ("Progressbar.pbar",): {
            ("", ""): ("",),
        },
        ("Scale",): {
            ("normal", ""): ("",),
            ("prelight", ""): ("hover",),
            ("active", ""): ("active",),
            ("insensitive", ""): ("disabled",),
        }
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

        ThemeGenerator.__init__(self, theme, output_dir)
        self._parse_theme()

    def _parse_theme(self):
        """Parse the theme from the entry point"""
        theme_file = self.get_theme_file(os.path.join(self._directory, self._theme_name))
        with temporary_chdir(os.path.dirname(theme_file)):
            self._parse_theme_file(theme_file)

        self.layout("TButton", [
            ("Button.button", {"children": [
                ("Button.focus", {"children": [
                    ("Button.padding", {"children": [
                        ("Button.label", {
                            "side": "left",
                            "expand": "true"
                        })
                    ]})
            ]})]})])

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

        for key, value in self.GTK_CLASSES.items():
            style_string = None
            for result in search_dict_recursive(gnome_settings, key):
                style_string = result
                break
            if style_string is None:
                continue
            else:
                style_dict = None
                for result in search_dict_recursive(gnome_settings, style_string):
                    style_dict = result
                    break
                if style_dict is None:
                    continue
                self._parse_style_dictionary(value, style_dict)
        images = []
        for result in search_dict_recursive(gnome_settings, "image"):
            if isinstance(result, list):
                images.extend(result)

        images = list(filter(lambda d: "function" in d and d["function"] in self.GTK_FUNCTIONS, images))
        self.parse_unreferenced_images(images)

    def _parse_style_dictionary(self, widget: str, style_dict: dict):
        """
        Parse a Gtk style dictionary into a ttk image element

        If a widget is built with this function it is explicitly not
        built using the unreferenced style of building.

        :param widget: Name of the widget
        :param style_dict: Gtk style dictionary
        """
        elements = dict()
        if 'engine "pixmap"' in style_dict:
            images: List[dict] = style_dict['engine "pixmap"']["image"]
            for image in images:
                element, state, image, kwargs = self.process_image_dict(widget, image)
                if element is None:
                    continue
                name, data = image
                name = name.replace("--", "-")

                self.image(name, data)

                if element not in elements:
                    elements[element] = ([], {})

                identifier = state + (name,)
                if len(identifier) == 1:
                    identifier = identifier[0]

                elements[element][0].append(identifier)
                elements[element][1].update(kwargs)

        for element, (args, kwargs) in elements.items():
            self.element(element, args, kwargs)

    def parse_unreferenced_images(self, images: List[dict]):
        """
        Parse the Gtk image dictionaries that are not referenced

        Not referenced means they are not used in any of the widgets
        of which elements have explicitly been defined to exist. This
        includes the Radiobutton and Checkbutton widgets.
        """
        elements = dict()
        for image in images:
            print("Parsing {}".format(image))
            if "function" not in image or image["function"] not in self.GTK_FUNCTIONS:
                continue
            widget = self.GTK_FUNCTIONS[image["function"]]
            if "file" not in image:
                if "overlay_file" in image:
                    image["file"] = image["overlay_file"]
                else:
                    continue
            if "detail" in image:
                if image["detail"].startswith(("v", "h")) and "orientation" not in image:
                    print("Setting orientation of image")
                    image["orient"] = "HORIZONTAL" if image["detail"].startswith("h") else "VERTICAL"
                if image["detail"] not in self.GTK_DETAILS:
                    continue
                if self.GTK_DETAILS[image["detail"]] not in widget:
                    continue
                widget = self.GTK_DETAILS[image["detail"]]
                if "direction" in image:
                    continue
            elif isinstance(widget, tuple):
                widget = widget[0]

            element, state, image, kwargs = self.process_image_dict(widget, image)
            if element is None:
                continue

            name, data = image
            name = name.replace("--", "-")

            if name in self.image_names:
                print("Duplicate image: {}".format(image))
                continue
            self.image(name, data)

            if element not in elements:
                elements[element] = ([], {})

            identifier = state + (name,)
            if len(identifier) == 1:
                identifier = identifier[0]

            if identifier not in elements[element][0]:
                elements[element][0].append(identifier)
            elements[element][1].update(kwargs)

        for element, (args, kwargs) in elements.items():
            options = kwargs.copy()
            if element in self.DEFAULT_OPTIONS:
                options = self.DEFAULT_OPTIONS[element].copy()
                options.update(kwargs)
            for e in args.copy():
                if isinstance(e, str) and args.index(e) != 0:
                    args.remove(e)
                    args.insert(0, e)
            print("Creating element: {}".format((element, args, options)))
            self.element(element, args, options)

    def process_image_dict(self, widget: str, image: dict) -> Tuple[str, Tuple, Tuple, dict]:
        """
        Process an image dictionary into a usable UI image

        :param widget: Name of the Tkinter widget that this belongs to
        :param image: Dictionary like {
                "file": "path_to_file",
                "function": gtk_specific_thing,
                "state": gtk_state_specifier,
                "shadow": widget_option,
            }
        """
        if "state" not in image:
            print("Corrected state", image)
            image["state"] = ""

        image["file"] = image["file"].strip("\"")
        path = os.path.abspath(image["file"])
        if not path.endswith((".png", ".gif")):
            return None, None, None, None

        with open(path, "rb") as fi:
            data = b64encode(fi.read()).decode()

        image["state"] = image["state"].lower()
        image["shadow"] = image["shadow"].lower() if "shadow" in image else ""
        gtk_state = (image["state"], image["shadow"])

        state_dicts = (d for k, d in self.GTK_STATES.items()
                       if any(w in widget for w in k))
        states = dict()
        for state_dict in state_dicts:
            states.update(state_dict)
        if gtk_state not in states:
            print("Unable to find '{}' for {}".format(gtk_state, widget))
            return None, None, None, None
        state = list(states[gtk_state])
        if None in state:
            return None, None, None, None

        widget_name = widget.split(".")[0].lower()
        layout = widget
        if "orientation" in image:
            layout = "{}.{}".format(image["orientation"].lower().capitalize(), layout)
        if "through" in state:
            layout = "{}.{}".format(layout, "through")
        if "thumb" in state:
            layout = "{}.{}".format(layout, "thumb")

        image_name = "{}-{}".format(widget_name, "-".join(state)).strip("-")

        kwargs = dict()
        if "border" in image:
            kwargs["border"] = tuple(map(int, map(lambda x: x.strip(" {},"), image["border"].split(","))))

        while "" in state:
            state.remove("")
        print("Parsed {} for {}".format((layout, state, (image_name,), kwargs), image["file"]))
        return layout, tuple(state), (image_name, data), kwargs

    @staticmethod
    def _build_dictionary(lines: List[str]) -> Tuple[Dict[str, Any], int]:
        """
        Recursively parse the lines of a gnome theme file into dictionary

        :param lines: List of pre-processed theme file lines
        :return: Tuple of dictionary produced and the level of building
            used in recursive algorithm.
        """
        result = dict()
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
    generator = GtkThemeGenerator("Materia")
    generator.generate()

    from example import Example

    window = Example()

    with temporary_chdir("materia"):
        window.tk.eval("source materia.tcl")
        window.tk.eval("package require materia 1.0")
        window.tk.eval("ttk::setTheme materia")

    window.mainloop()
