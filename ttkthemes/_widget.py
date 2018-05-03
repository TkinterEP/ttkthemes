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


class ThemedWidget(object):
    """
    Provides functions to manipulate themes in order to reduce code
    duplication in the ThemedTk and ThemedStyle classes.
    """

    pixmap_themes = [
        "arc",
        "blue",
        "clearlooks",
        "elegance",
        "kroc",
        "plastik",
        "radiance",
        "winxpblue"
    ]

    def __init__(self, tk_interpreter):
        """
        Loads themes into tk interpreter
        :param tk_interpreter: tk interpreter for tk.Widget that is
                               being initialized as ThemedWidget
        """
        self.tk = tk_interpreter

        # Change working directory temporarily to allow Tcl to work
        with utils.temporary_chdir(utils.get_file_directory()):
            # Load the themes
            self.folder = os.path.dirname(os.path.realpath(__file__)).replace("\\", "/")
            self.tk.call("lappend", "auto_path", "[%s]" % self.folder + "/themes")
            self._img_support = self._load_tkimg()
            self.tk.eval("source themes/pkgIndex.tcl")

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
        return list(self.tk.call("ttk::themes"))

    @property
    def themes(self):
        """Property alias of get_themes()"""
        return self.get_themes()

    def set_theme_advanced(self, theme_name, brightness=1.0,
                           saturation=1.0, hue=1.0,
                           preserve_transparency=True, output_dir=None,
                           advanced_name="advanced"):
        """
        Load an advanced theme that is customized upon runtime. Requires
        write permission into a temporary directory that is used to
        temporarily store the custom theme. Only available with Img
        library support (Tk 8.6 or higher, Python 3 unless you have
        compiled Tk yourself).
        :param theme_name: pixmap theme name to base the new theme on
        :param brightness: brightness modifier for the pixmaps
        :param saturation: saturation modifier for the pixmaps
        :param hue: hue modifier for the pixmaps, limited to 0.0-2.0
        :param preserve_transparency: When True, all black pixels in the
            resulting images will be set to transparent instead, as
            transparency is lost during RGBA->HSV conversion. Has no
            effect when not changing hue.
        :param output_dir: directory to put the theme in. By default,
            a volatile temporary directory is used
        :param advanced_name: Name to give to the new theme
        :raises: RuntimeError when PNG images are not supported by Tk.
            This usually applies to Python 2 platforms.
        :raises: ValueError is theme is not available or valid
        :raises: RuntimeError when the same name is used twice
        """
        if not self.img_support:
            raise RuntimeError("PNG images are not supported by your Tkinter installation")
        # Check if the theme is a pixmap theme
        if theme_name not in self.pixmap_themes:
            raise ValueError("Theme is not a valid pixmap theme")
        # Check if theme is available in the first place
        if theme_name not in self.themes:
            raise ValueError("Theme to create new theme from is not available: {}".format(theme_name))
        if advanced_name in self.themes:
            raise RuntimeError("The same name for an advanced theme cannot be used twice")
        # Unload advanced if already loaded
        output_dir = os.path.join(utils.get_temp_directory(), advanced_name) if output_dir is None else output_dir
        self._setup_advanced_theme(theme_name, output_dir, advanced_name)
        # Perform image operations
        image_directory = os.path.join(output_dir, advanced_name, advanced_name)
        self._setup_images(image_directory, brightness, saturation, hue, preserve_transparency)
        # Load the new theme
        with utils.temporary_chdir(output_dir):
            self.tk.call("lappend", "auto_path", "[{}]".format(output_dir))
            self.tk.eval("source pkgIndex.tcl")
            self.set_theme(advanced_name)

    @staticmethod
    def _setup_advanced_theme(theme_name, output_dir, advanced_name):
        """
        Setup all the files required to enable an advanced theme. Copies
        all the files over and creates the required directories if they
        do not exist.
        :param theme_name: theme to copy the files over from
        :param output_dir: output directory to place the files in
        """
        """Directories"""
        output_theme_dir = os.path.join(output_dir, advanced_name)
        output_images_dir = os.path.join(output_theme_dir, advanced_name)
        input_theme_dir = os.path.join(utils.get_themes_directory(), theme_name)
        input_images_dir = os.path.join(input_theme_dir, theme_name)
        advanced_pkg_dir = os.path.join(utils.get_file_directory(), "advanced")
        """Directory creation"""
        for directory in [output_dir, output_theme_dir]:
            utils.create_directory(directory)
        """Theme TCL file"""
        file_name = theme_name + ".tcl"
        theme_input = os.path.join(input_theme_dir, file_name)
        theme_output = os.path.join(output_theme_dir, "{}.tcl".format(advanced_name))
        with open(theme_input, "r") as fi, open(theme_output, "w") as fo:
            for line in fi:
                # Setup new theme
                line = line.replace(theme_name, advanced_name)
                # Setup new image format
                line = line.replace("gif89", "png")
                line = line.replace("gif", "png")
                # Write processed line
                fo.write(line)
        """pkgIndex.tcl file"""
        theme_pkg_input = os.path.join(advanced_pkg_dir, "pkgIndex.tcl")
        theme_pkg_output = os.path.join(output_theme_dir, "pkgIndex.tcl")
        with open(theme_pkg_input, "r") as fi, open(theme_pkg_output, "w") as fo:
            for line in fi:
                fo.write(line.replace("advanced", advanced_name))
        """pkgIndex_package.tcl -> pkgIndex.tcl"""
        theme_pkg_input = os.path.join(advanced_pkg_dir, "pkgIndex_package.tcl")
        theme_pkg_output = os.path.join(output_dir, "pkgIndex.tcl")
        with open(theme_pkg_input, "r") as fi, open(theme_pkg_output, "w") as fo:
            for line in fi:
                fo.write(line.replace("advanced", advanced_name))
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
            with open(os.path.join(directory, file_name), "rb") as fi:
                image = Image.open(fi).convert("RGBA")
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
            image.save(os.path.join(directory, file_name.replace("gif", "png")))
            image.close()
        for file_name in (item for item in os.listdir(directory) if item.endswith(".gif")):
            os.remove(os.path.join(directory, file_name))
        return

    def _load_tkimg(self):
        """
        Load the TkImg library from the tkimg folder for the current
        tk interpreter. Required for PNG support on Python 2, but also
        used on Python 3 as the theme files have been modified to
        support Img.
        :raise: tk.TclError if evaluation fails
        """
        tkimg_folder = utils.get_tkimg_directory()
        if not os.path.exists(tkimg_folder):
            raise RuntimeError("Unsupported platform and/or architecture")
        pkg_index = os.path.join(tkimg_folder, "pkgIndex.tcl")

        with utils.temporary_chdir(tkimg_folder):
            self.tk.call("lappend", "auto_path", "[{}]".format(tkimg_folder))
            self.tk.eval("source {}".format(os.path.relpath(pkg_index, os.getcwd())))
            self.tk.call("package", "require", "Img")
        return True

    @property
    def img_support(self):
        return self._img_support
