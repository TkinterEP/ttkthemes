"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from setuptools import setup
import os
import sys
from platform import architecture
from shutil import copytree, rmtree


platforms = {
    "win32": "win",
    "linux2": "linux"
}


def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()


if __name__ == '__main__':
    current_dir = os.path.dirname(__file__)
    dest_dir = os.path.join(current_dir, "ttkthemes", "tkimg")

    if os.path.exists(os.path.join(current_dir, "tkimg")):
        # ttkthemes source is in the ttkthemes/ folder and tkimg needs to
        # be copied there
        if "sdist" not in sys.argv[1]:
            # Set up TkImg library for bdist_wheel or bdist_wheel install
            prefix = sys.platform if sys.platform not in platforms else platforms[sys.platform]
            arch = int(architecture()[0][:2])
            tkimg_folder = os.path.join(current_dir, "tkimg", "{}{}".format(prefix, arch))
        else:
            # Set up TkImg library for sdist
            tkimg_folder = os.path.join(current_dir, "tkimg")

        if os.path.exists(dest_dir):
            rmtree(dest_dir)
        copytree(tkimg_folder, dest_dir)


setup(
    name='ttkthemes',
    packages=['ttkthemes'],
    package_data={"ttkthemes": ["themes/*", "tkimg/*"]},
    version='2.0.6',
    description='A group of themes for the ttk extensions of Tkinter with a Tkinter.Tk wrapper',
    author='The ttkthemes authors',
    author_email='redfantom@outlook.com',
    url='https://github.com/RedFantom/ttkthemes',
    download_url='https://github.com/RedFantom/ttkthemes/releases',
    include_package_data=True,
    keywords=['tkinter', 'ttk', 'gui', 'tcl', 'theme'],
    license='GPLv3',
    long_description=read('README.md'),
    classifiers=['Programming Language :: Python :: 2.7',
                 'Programming Language :: Python :: 3.4',
                 'Programming Language :: Python :: 3.5',
                 'Programming Language :: Python :: 3.6',
                 'Environment :: Win32 (MS Windows)',
                 'Environment :: X11 Applications',
                 'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
                 'Topic :: Software Development :: Libraries :: Tcl Extensions',
                 'Topic :: Software Development :: Libraries :: Python Modules'],
    zip_safe=False,
    install_requires=["pillow"],
    has_ext_modules=lambda: True,
)
