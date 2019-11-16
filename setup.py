"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import sys
import os
if sys.version_info[0] >= 3:
    from tkinter import TkVersion
else:  # Python 2
    from Tkinter import TkVersion
from setuptools import setup


if TkVersion <= 8.5:
    try:
        import tkimg
    except ImportError:
        print("With this version of Tk, PNG-based themes are only "
              "available with python-tkimg")


def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()


setup(
    name='ttkthemes',
    packages=['ttkthemes'],
    package_data={"ttkthemes": ["themes/*"]},
    version='2.4.0',
    description='A group of themes for the ttk extensions of Tkinter with a Tkinter.Tk wrapper',
    author='The ttkthemes authors',
    author_email='redfantom@outlook.com',
    url='https://github.com/RedFantom/ttkthemes',
    download_url='https://github.com/RedFantom/ttkthemes/releases',
    include_package_data=True,
    keywords=['tkinter', 'ttk', 'gui', 'tcl', 'theme'],
    license='GPLv3',
    long_description=read('README.md'),
    classifiers=[
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Environment :: Win32 (MS Windows)',
        'Environment :: X11 Applications',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Topic :: Software Development :: Libraries :: Tcl Extensions',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ],
    zip_safe=False,
    install_requires=["pillow"],
    has_ext_modules=lambda: True,
)
