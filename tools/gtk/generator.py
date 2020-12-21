"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2020 RedFantom
"""
# Standard Library
from base64 import b64encode, b64decode
import io
import os
from PIL import Image
import shutil
import tempfile
import textwrap
from tkinter import ttk
from typing import Any, Dict, List, Tuple, Union
# Package
from ttkthemes._utils import temporary_chdir


def wrap(string, width=68):
    return "\n".join(textwrap.wrap(string, width))


def indent(string: str) -> str:
    return "\n".join("\t{}".format(s.rstrip()) for s in string.split("\n"))


class ThemeError(Exception):
    pass


def trim_image(data: str) -> str:
    """Trim base64 encoded image to contents"""
    temp = os.path.join(tempfile.gettempdir(), "temp.png")
    with io.BytesIO(b64decode(data)) as fi:
        img = Image.open(fi)
        if img.getbbox() is not None and img.getbbox()[2:3] == img.size:
            return data
        # TODO: Figure out why writing to BytesIO doesn't work
        img.crop(img.getbbox()).save(temp, format="PNG")
    with open(temp, "rb") as fi:
        return b64encode(fi.read()).decode()


class ThemeGenerator(object):
    """Class to generate theme files given instructions"""

    MUST_BE_CROPPED = [
        "Horizontal.Scale.slider",
        "Vertical.Scale.slider",
    ]

    def __init__(self, name: str, output_dir=".", version="1.0"):
        """
        :param name: Name of the theme that is to be defined, will
            carry on to folder and file names
        :param output_dir: The location to generate the theme files in
        :param version: Version number for the theme
        """
        self._name = name.lower()
        self._output_dir = output_dir
        self._version = version

        self._elements = list()
        self._layouts = list()
        self._images = list()
        self._colors = dict()
        self._options = dict()
        self._layout_options = dict()
        self._layout_maps = dict()

    def option(self, name: str, option: str):
        """Define a global style option by its name"""
        self._options[name] = option

    def color(self, name: str, color: str):
        """Define a color of the theme by its name"""
        self._colors[name] = color

    def element(self, name: str, images: List[Union[str, Tuple[str, ...]]], options: Dict[str, str]):
        """
        Add an element in the theme to be created

        :param name: Name of the style element, like 'Button.button'
        :param images: List of options. Assumes a pixmap theme, so
            given as ``[base_img, (*state_spec, state_img), ...]``
        :param options: Dictionary of string options
        """
        if name in self.element_names:
            raise ThemeError("This element has already been created: '{}'.".format(name))
        if not isinstance(images, list) and len(images) >= 1 and isinstance(images[0], str):
            raise ThemeError("Invalid type for arg images")
        if len(images) > 1 and not \
                all(isinstance(spec, tuple) and all(isinstance(x, str) for x in spec) for spec in images[1:]):
            print("WARNING: Cutting off excess images")
            images = images[0:images[1:].index(images[0])]
        if len(images) >= 1 and isinstance(images[0], tuple):
            state_spec, image = images[0][:-1], images[0][-1]
            print("WARNING: Assuming image for {}, state {} is default".format(name, state_spec))
            images = (image,) + tuple(images[1:] if len(images) > 1 else ())
        self._elements.append((name, images, options))

    def layout(self, style: str, layout: List[Tuple[str, Dict[str, Any]]]):
        """
        Add a layout to the theme to be created

        :param style: Style name to define the layout of
        :param layout: Tkinter-style layout list, so defined as:
            [("Button.button", {"children": [], **options}), ...]
        """
        if style in self.layout_names:
            raise ThemeError("This layout has already been created: '{}'.".format(style))
        if not all(isinstance(e, tuple) and isinstance(e[0], str) and isinstance(e[1], Dict) and
                   all(isinstance(k, str) for k in e[1].keys()) for e in layout):
            raise ThemeError("Invalid type for arg layout")
        self._layouts.append((style, layout))

    def image(self, name: str, data: str, trim=False):
        """
        Add an image to the theme that is to be created

        All images in Tk must be identified by a unique name. If the
        name is already in use, creation will fail.

        :param name: Name of the image that belongs in the theme
        :param data: base64 encoded data string for the image
        :param trim: Boolean indicative of whether to trim image to
            contents only
        """
        if not isinstance(name, str):
            raise ThemeError("Cannot create image by name that is not string")
        if name in self._images:
            raise ThemeError("This image has already been created: '{}'.".format(name))
        if not isinstance(data, str) or os.path.exists(data):
            raise ThemeError("Given string is not valid for a base64 encoded image: '{}'".format(data))
        if trim is True:
            data = trim_image(data)
        print("[ThemeGenerator] {}".format(name))
        self._images.append((name, data))

    def image_file(self, name: str, file: str):
        """
        Add an image to the theme by its file path

        :param name: Name of the image as it is referenced in the theme
        :param file: Valid path from the working directory to the file
        """
        with open(file, "rb") as fi:
            data = b64encode(fi.read())
        self.image(name, data)

    @property
    def element_names(self) -> List[str]:
        """Return a list of already defined elements in this theme"""
        return [n for n, _, _ in self._elements]

    @property
    def layout_names(self) -> List[str]:
        """Return a list of already defined layouts in this theme"""
        return [n for n, _ in self._layouts]

    @property
    def image_names(self) -> List[str]:
        """Return a list of already defined images in this theme"""
        return [n for n, _ in self._images]

    def generate(self):
        """
        Generate a theme in a subdirectory from the given instructions

        Performs various verifications before generating the files.
        Generates the following directory structure:
        - output_dir/theme_name
          - theme_name.tcl
          - images.tcl
        """
        self.verify()

        return self.generate_theme_file()

    def generate_images_file(self) -> str:
        """Generate the file that contains the images in the working dir"""
        return ("# images.tcl, generated by ThemeGenerator\n"
                "# License: GNU GPLv3\n"
                "# Copyright (c) 2020 RedFantom\n\n" + "".join(
                "set images({}) [image create photo -data {{\n{}\n}}]\n\n".format(
                    name, indent(wrap(data))
                ) for name, data in self._images))

    def generate_theme_file(self, write_file: bool=False):
        """Generate the file that contains the ttk theme"""
        return (
            "# {}.tcl, generated by ThemeGenerator\n".format(self._name) +
            "# License: GNU GPLv3\n"
            "# Copyright (c) 2020 RedFantom\n\n"

            "package require Tk 8.6\n"
            "namespace eval ttk::theme::{} {{\n".format(self._name) +
            indent(
                "set dir [file dirname [info script]]\n" +
                ("set image_file [file join $dir \"images.tcl\"]\n" if write_file else "") +
                "\n" +
                ("{}\n".format(self.generate_images_file()) if not write_file else "source $image_file") +
                "\n"
                "ttk::style theme create {} -parent default -settings {{\n".format(self._name) +
                indent(
                    ("ttk::style configure . \\\n" + indent(
                        ("".join("-{} {} \\\n".format(name, color) for name, color in self._colors.items()) +
                         "".join("-{} {} \\\n".format(name, option) for name, option in self._options.items()))
                        .strip("\\\n") + "\n"
                    ) if len(self._colors) != 0 or len(self._options) != 0 else "\n") +
                    "\n\n".join(self.generate_layout_string(layout) for layout in self._layouts) +
                    "\n\n".join(self.generate_element_string(element) for element in self._elements) + "\n"
                                                                                                       "\n".join(
                        self.generate_configure_string(layout, config) for layout, config in
                        self._layout_options.items()) + "\n" +
                    "\n".join(self.generate_map_string(layout, maps) for layout, maps in self._layout_maps.items())
                    ) +
                    "\n}\n"
                ) +
                "\n}\n" +
                "package provide ttk::theme::{} {}\n".format(self._name, self._version)
            )

    def write_files(self):
        if not os.path.exists(self._name):
            os.makedirs(self._name)
        with temporary_chdir(self._name):
            with open("{}.tcl".format(self._name, "w")) as fo:
                fo.write(self.generate_theme_file(True))
            with open("images.tcl", "w") as fo:
                fo.write(self.generate_images_file())

    @staticmethod
    def generate_layout_string(layout):
        name, options = layout
        print(options)
        return "\nttk::style layout {} {{\n{}\n}}\n".format(
            name, indent(ttk._format_layoutlist(options, indent_size=4)[0]))

    def generate_element_string(self, element):
        """ttk._format_elemcreate is unsuitable, so this exists"""
        name, args, kwargs = element
        if len(args) == 0:
            print("[ThemeGenerator] WARNING: Invalid args given for element {}".format(name))
            return ""
        string = (
                "ttk::style element create {} image [list $images({}) \\\n".format(name, args[0]) + indent(indent(
            "\n".join("{} $images({}) \\".format(
                self.generate_state_string(state[:-1]), state[-1]
            ) for state in self.sort_states(args[1:]))
        )) + "\n" +
                indent("] {}\n".format(" ".join("-{} {}".format(option, self.generate_option_string(value))
                                                for option, value in kwargs.items())))
        )
        return string

    @staticmethod
    def generate_configure_string(layout: str, options: dict):
        if len(options) == 0:
            return ""
        return "ttk::style configure {} ".format(layout) + \
               indent("\n".join("-{} {}\\".format(
                   option, ThemeGenerator.generate_option_string(value)
               ) for option, value in options.items()).strip("\\\n").strip()).strip()

    @staticmethod
    def generate_map_string(layout: str, maps: dict):
        if len(maps) == 0:
            return ""
        return "ttk::style map {}".format(layout) + \
               indent("\n".join("-{} {}\\".format(
                   option, ThemeGenerator.generate_option_string(value)
               ) for option, value in maps.items())).strip("\\\n").strip()

    @staticmethod
    def generate_option_string(option_value: Any) -> str:
        """Generate a string from a given option value"""
        if isinstance(option_value, tuple):
            return "{{{}}}".format(" ".join(str(e) for e in option_value))
        elif isinstance(option_value, list):
            return "[list {}]".format(" ".join(map(ThemeGenerator.generate_option_string, option_value)))
        else:
            return str(option_value)

    @staticmethod
    def generate_state_string(state: Union[str, Tuple[str]]) -> str:
        """Generate a Tk state string from a given state spec"""
        if isinstance(state, str):
            return state
        elif len(state) == 1:
            return state[0]
        else:
            return "{{{}}}".format(" ".join(state))

    def configure(self, layout: str, options: dict):
        """Configure a layout with specific options"""
        if layout not in self._layout_options:
            self._layout_options[layout] = dict()
        self._layout_options[layout].update(options)

    def map(self, layout: str, options: dict):
        """Map settings to a widget"""
        if layout not in self._layout_maps:
            self._layout_maps[layout] = dict()
        self._layout_maps[layout].update(options)

    @staticmethod
    def sort_states(states):
        return sorted(states, key=lambda t: len(t), reverse=True)

    def verify(self):
        """
        Perform various verifications on the given instructions

        :raises: ThemeError if something is wrong
        """
        for name, spec, options in self._elements:
            for state in spec:
                if isinstance(state, tuple):
                    state = state[-1]
                if state not in self.image_names:
                    raise ThemeError("'{}' requires image '{}', but it is not defined.".format(name, state))
