"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import contextlib
import sys
import os
from shutil import rmtree
from platform import architecture
from tempfile import gettempdir


platforms = {
    "win32": "win",
    "linux2": "linux"
}


def is_python_3():
    """Check interpreter version"""
    return sys.version_info.major == 3


@contextlib.contextmanager
def temporary_chdir(new_dir):
    """
    Like os.chdir(), but always restores the old working directory.

    For example, code like this...

        old_curdir = os.getcwd()
        os.chdir('stuff')
        do_some_stuff()
        os.chdir(old_curdir)

    ...leaves the current working directory unchanged if do_some_stuff()
    raises an error, so it should be rewritten like this:

        old_curdir = os.getcwd()
        os.chdir('stuff')
        try:
            do_some_stuff()
        finally:
            os.chdir(old_curdir)

    Or equivalently, like this:

        with utils.temporary_chdir('stuff'):
            do_some_stuff()
    """
    old_dir = os.getcwd()
    os.chdir(new_dir)
    try:
        yield
    finally:
        os.chdir(old_dir)


def get_file_directory():
    """Return an absolute path to the current file directory"""
    return os.path.dirname(os.path.realpath(__file__))


def get_temp_directory():
    """Return an absolute path to an existing temporary directory"""
    # Supports all platforms supported by tempfile
    directory = os.path.join(gettempdir(), "ttkthemes")
    if not os.path.exists(directory):
        os.makedirs(directory)
    return directory


def get_themes_directory():
    """Return an absolute path the to /themes directory"""
    return os.path.join(get_file_directory(), "themes")


def create_directory(directory):
    """Create directory but first delete it if it exists"""
    if os.path.exists(directory):
        rmtree(directory)
    os.makedirs(directory)
    return directory


def get_tkimg_directory():
    """
    Return an absolute path to the TkImg directory for current platform
    """
    # Binary Distribution
    tkimg = os.path.join(os.path.dirname(__file__), "tkimg")
    if not os.path.exists(os.path.join(tkimg, "pkgIndex.tcl")):
        # Source Distribution
        prefix = sys.platform if sys.platform not in platforms else platforms[sys.platform]
        arch = architecture()[0][:2]
        tkimg = os.path.join(tkimg, "{}{}".format(prefix, arch))
        if not os.path.exists(tkimg):
            # Plain repository clone without having run bdist_wheel
            tkimg = os.path.realpath(
                os.path.join(
                    os.path.dirname(__file__),
                    "..",
                    "tkimg",
                    "{}{}".format(prefix, arch)))
    return tkimg
