"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import sys
import os


def is_python_3():
    return sys.version_info.major == 3


def get_tkimg_directory():
    """
    Return an absolute path to the TkImg directory for current platform
    """
    return os.path.join(os.path.dirname(__file__), "tkimg")
