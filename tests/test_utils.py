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

    def assertPathEquals(self, a, b):
        if hasattr(os.path, 'samefile'):
            self.assertTrue(os.path.samefile(a, b))
        else:
            # on windows, os.path.normcase lowercases because 'ASD' and 'asd'
            # should be treated equally
            self.assertEqual(os.path.normcase(a), path.normcase(b))

    def test_temporary_chdir(self):
        dir1 = os.getcwd()
        with utils.temporary_chdir(utils.get_temp_directory()):
            dir2 = os.getcwd()
        dir3 = os.getcwd()
        self.assertTrue(os.path.samefile(dir1, dir3))
        self.assertTrue(os.path.samefile(dir2, utils.get_temp_directory()))

        with self.assertRaises(RuntimeError):
            with utils.temporary_chdir(utils.get_temp_directory()):
                raise RuntimeError("oh no")
        dir4 = os.getcwd()
        self.assertTrue(os.path.samefile(dir1, dir4))

    def test_get_file_directory(self):
        directory = utils.get_file_directory()
        self.assertIsInstance(directory, str)
        self.assertTrue(os.path.exists(directory))

    def test_get_temp_directory(self):
        self.assertTrue(os.path.exists(utils.get_temp_directory()))

    def test_get_themes_directory(self):
        themes = ["blue", "plastik", "keramik", "aquativo",
                  "clearlooks", "elegance", "kroc", "radiance",
                  "winxpblue", "black", "arc"]
        folders = os.listdir(utils.get_themes_directory())
        for theme in themes:
            self.assertTrue(theme in folders)

