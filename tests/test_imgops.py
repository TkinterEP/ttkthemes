"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from unittest import TestCase
from ttkthemes import _imgops as imgops
from PIL import Image


class TestImgOps(TestCase):
    def test_make_transparent(self):
        transparent = imgops.make_transparent(Image.new("RGBA", (10, 10)))
        transparent_data = transparent.getdata()
        for i in range(0, 10*10):
            self.assertEqual(transparent_data[i], (255, 255, 255, 255))

    def test_shift_hue(self):
        red_image = Image.new("RGBA", (10, 10), (255, 0, 0, 255))
        shifted_image = imgops.shift_hue(red_image, 0.5)
        self.assertNotEqual(shifted_image.getdata()[0], red_image.getdata()[0])

    def test_check_pixel(self):
        black_image = Image.new("RGBA", (10, 10))
        for pixel in black_image.getdata():
            self.assertTrue(imgops._check_pixel(pixel))
        white_image = Image.new("RGBA", (10, 10), (255, 255, 255, 255))
        for pixel in white_image.getdata():
            self.assertFalse(imgops._check_pixel(pixel))
