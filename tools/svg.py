"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom

Simple script to convert GTK-theme SVG images to PNG images

Depends on inkscape
"""
import os
import subprocess
from ttkthemes._utils import get_themes_directory

print("** SVG to PNG converter **")

theme = input("Theme name: ")
png_path = os.path.join(get_themes_directory(theme, True), theme, theme)
if not os.path.exists(png_path):
    print("Please copy the SVG images to {} first.".format(png_path))
    exit(-1)

print("Converting SVG images to PNG...", end="", flush=True)
os.chdir(png_path)
for svg_image in os.listdir(os.getcwd()):
    if not svg_image.endswith((".svg", ".svg.in")):
        continue
    png_image = svg_image.replace(".svg", ".png").replace(".in", "")
    command = ["inkscape", "-z", "-e", png_image, svg_image]
    p = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p.wait()
    stdout, stderr = p.communicate()
    if len(stderr) != 0 and not b"Format autodetect failed" in stderr:
        print("\nSubprocess error: {}".format(stderr))
        exit(-2)
    print(".", end="", flush=True)
    os.remove(svg_image)
print(" Done.")

