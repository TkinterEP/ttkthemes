"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import sys
import os
from shutil import rmtree
from tempfile import gettempdir


def is_python_3():
    """Check interpreter version"""
    return sys.version_info.major == 3


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
    if os.path.exists(directory):
        rmtree(directory)
    os.makedirs(directory)
    return directory
