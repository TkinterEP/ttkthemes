"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
# Standard library
import os
from shutil import copytree, rmtree, copyfile
# Packages
from PIL import Image, ImageEnhance
import ttkthemes._imgops as imgops
# Own modules
from ttkthemes import _utils as utils
# Tkinter
if utils.is_python_3():
    import tkinter as tk
else:
    import Tkinter as tk


class ThemedWidget(object):
    """
    Provides functions to manipulate themes in order to reduce code
    duplication in the ThemedTk and ThemedStyle classes.
    """

    png_themes = ["arc"]

    def __init__(self, tk_interpreter):
        """
        Loads themes into tk interpreter
        :param tk_interpreter: tk interpreter for tk.Widget that is
                               being initialized as ThemedWidget
        """
        self.tk = tk_interpreter
        # Change working directory temporarily to allow Tcl to work
        prev_folder = os.getcwd()
        os.chdir(utils.get_file_directory())
        # Load the themes
        self.tk.call("lappend", "auto_path", "[{}]".format(utils.get_themes_directory()))
        self.img_support = False
        try:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
            self.img_support = True
        except tk.TclError:
            pass
        self.tk.eval("source themes/pkgIndex.tcl")
        # Change back working directory
        os.chdir(prev_folder)

    def set_theme(self, theme_name):
        """
        Set new theme to use. Uses a direct tk call to allow usage
        of the themes supplied with this package.
        :param theme_name: name of theme to activate
        """
        self.tk.call("package", "require", "ttkthemes")
        self.tk.call("ttk::setTheme", theme_name)

    def get_themes(self):
        """Return a list of names of available themes"""
        self.tk.call("package", "require", "ttkthemes")
        if self.img_support:
            self.tk.call("package", "require", "Img")
            self.tk.call("package", "require", "Tk", "8.6")
        return list(self.tk.call("ttk::themes"))

    @property
    def themes(self):
        """Property alias of get_themes()"""
        return self.get_themes()

    def set_theme_advanced(self, theme_name, brightness=1.0,
                           saturation=1.0, hue=1.0,
                           preserve_transparency=True, output_dir=None):
        """
        Load an advanced theme that is customized upon runtime. Requires
        write permission into a temporary directory that is used to
        temporarily store the custom theme.
        :param theme_name: pixmap theme name to base the new theme on
        :param brightness: brightness modifier for the pixmaps
        :param saturation: saturation modifier for the pixmaps
        :param hue: hue modifier for the pixmaps
        :param output_dir: directory to put the theme in. By default,
                           a volatile temporary directory is used
        """
        # Check if the theme is a pixmap theme
        if theme_name not in self.png_themes:
            raise ValueError("Theme is not a valid pixmap theme")
        # Check if theme is available in the first place
        if theme_name not in self.themes:
            raise ValueError("Theme to create new theme from is not available")
        output_dir = os.path.join(utils.get_temp_directory()) if output_dir is None else output_dir
        self._setup_advanced_theme(theme_name, output_dir)
        # Perform image operations
        image_directory = os.path.join(output_dir, "advanced", "advanced")
        self._setup_images(image_directory, brightness, saturation, hue, preserve_transparency)
        # Load the new theme
        prev_folder = os.getcwd()
        os.chdir(output_dir)
        self.tk.call("lappend", "auto_path", "[{}]".format(output_dir))
        self.tk.eval("source pkgIndex.tcl")
        self.set_theme("advanced")
        os.chdir(prev_folder)

    @staticmethod
    def _setup_advanced_theme(theme_name, output_dir):
        """
        Setup all the files required to enable an advanced theme. Copies
        all the files over and creates the required directories if they
        do not exist.
        :param theme_name: theme to copy the files over from
        :param output_dir: output directory to place the files in
        """
        """Directories"""
        output_theme_dir = os.path.join(output_dir, "advanced")
        output_images_dir = os.path.join(output_theme_dir, "advanced")
        input_theme_dir = os.path.join(utils.get_themes_directory(), theme_name)
        input_images_dir = os.path.join(input_theme_dir, theme_name)
        advanced_pkg_dir = os.path.join(utils.get_file_directory(), "advanced")
        """Directory creation"""
        for directory in [output_dir, output_theme_dir]:
            utils.create_directory(directory)
        """Theme TCL file"""
        theme_input = os.path.join(input_theme_dir, theme_name + ".tcl")
        theme_output = os.path.join(output_theme_dir, "advanced.tcl")
        with open(theme_input, "r") as fi, open(theme_output, "w") as fo:
            for line in fi:
                fo.write(line.replace(theme_name, "advanced"))
        """pkgIndex.tcl file"""
        theme_pkg_input = os.path.join(advanced_pkg_dir, "pkgIndex.tcl")
        theme_pkg_output = os.path.join(output_theme_dir, "pkgIndex.tcl")
        copyfile(theme_pkg_input, theme_pkg_output)
        """pkgIndex_package.tcl -> pkgIndex.tcl"""
        theme_pkg_input = os.path.join(advanced_pkg_dir, "pkgIndex_package.tcl")
        theme_pkg_output = os.path.join(output_dir, "pkgIndex.tcl")
        copyfile(theme_pkg_input, theme_pkg_output)
        """Images"""
        if os.path.exists(output_images_dir):
            rmtree(output_images_dir)
        copytree(input_images_dir, output_images_dir)

    @staticmethod
    def _setup_images(directory, brightness, saturation, hue, preserve_transparency):
        """
        Perform operations on the images found in the folder provided
        as a parameter. Used to modify images of the advanced theme.
        :param directory: absolute path to writable directory with images
        :param brightness: brightness modifier
        :param saturation: saturation modifier
        :param hue: hue modifier
        """
        for file_name in os.listdir(directory):
            image = Image.open(os.path.join(directory, file_name))
            # Only perform required operations
            if brightness != 1.0:
                enhancer = ImageEnhance.Brightness(image)
                image = enhancer.enhance(brightness)
            if saturation != 1.0:
                enhancer = ImageEnhance.Color(image)
                image = enhancer.enhance(saturation)
            if hue != 1.0:
                image = imgops.shift_hue(image, hue)
            if preserve_transparency is True:
                image = imgops.make_transparent(image)
            # Save the new image
            image.save(os.path.join(directory, file_name))
        return
