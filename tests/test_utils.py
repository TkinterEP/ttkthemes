"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from unittest import TestCase
from ttkthemes import _utils as utils
import os


class TestUtils(TestCase):
    def test_is_python_3(self):
        self.assertIsInstance(utils.is_python_3(), bool)

    def test_get_file_directory(self):
        directory = utils.get_file_directory()
        self.assertIsInstance(directory, str)
        self.assertTrue(os.path.exists(directory))
        test_dir = os.path.realpath(os.path.join(directory, "..", "tests"))
        self.assertTrue(os.path.basename(__file__) in os.listdir(test_dir))

    def test_get_temp_directory(self):
        self.assertTrue(os.path.exists(utils.get_temp_directory()))

    def test_get_themes_directory(self):
        themes = ["blue", "plastik", "keramik", "aquativo",
                  "clearlooks", "elegance", "kroc", "radiance",
                  "winxpblue", "black", "arc"]
        folders = os.listdir(utils.get_themes_directory())
        for theme in themes:
            self.assertTrue(theme in folders)

