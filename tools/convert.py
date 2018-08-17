"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom

Simple script to convert a PNG-based theme to a GIF-based theme on Linux

Depends on imagemagick
"""
import os
from shutil import copytree, rmtree
import subprocess
from ttkthemes._utils import get_themes_directory


print("** PNG to GIF Theme Converter **\n")
theme = input("PNG-theme name: ")
png_path = os.path.join(get_themes_directory(theme, True), theme)
if not os.path.exists(png_path):
    print("Invalid theme name: Directory does not exist: {}".format(png_path))
    exit(-1)

gif_path = os.path.join(get_themes_directory(theme, False), theme)
if os.path.exists(gif_path):
    a = input("GIF-theme directory exists. Overwrite? (y/n) [y]: ",)
    if a != "n":
        print("Deleting everything under '{}'...".format(gif_path), end=" ")
        rmtree(gif_path)
        print("Done.")
    else:
        print("Aborted by user.")
        exit(0)


print("Copying 'png/{0}' to 'gif/{0}'...".format(theme), end=" ")
copytree(png_path, gif_path)
print("Done.")

print("Replacing PNG with GIF references...", end=" ")
tcl_file = os.path.join(gif_path, theme + ".tcl")
with open(tcl_file) as fi:
    lines = fi.readlines()
with open(tcl_file, "w") as fo:
    fo.writelines([line.replace("png", "gif") for line in lines])
print("Done.")

print("Converting all PNG images to GIF images...", end=" ", flush=True)
img_path = os.path.join(gif_path, theme)
os.chdir(img_path)
for image in os.listdir(os.getcwd()):
    if not image.endswith(".png"):
        continue
    command = ["convert", image, "-channel", "A", "-threshold", "50%", image.replace(".png", ".gif")]
    p = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p.wait()
    stdout, stderr = p.communicate()
    if len(stderr) != 0:
        print("\nError in subprocess:\n{}".format(stderr))
        exit(-2)
    os.remove(image)
print("Done.")
