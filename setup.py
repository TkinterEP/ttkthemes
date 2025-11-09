"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
from pathlib import Path
from setuptools import setup


def read(fname):
    return Path(__file__).with_name(fname).read_text()


setup(
    name="ttkthemes",
    packages=["ttkthemes"],
    package_data={"ttkthemes": ["themes/*", "png/*", "gif/*", "advanced/*"]},
    version="3.3.0",
    description="A group of themes for the ttk extensions of Tkinter with a Tkinter.Tk wrapper",
    author="The ttkthemes authors",
    author_email="redfantom@outlook.com",
    url="https://github.com/RedFantom/ttkthemes",
    download_url="https://github.com/RedFantom/ttkthemes/releases",
    include_package_data=True,
    keywords=["tkinter", "ttk", "gui", "tcl", "theme", "tk", "tcl/tk", "tile"],
    license="GPLv3",
    long_description=read("README.md"),
    long_description_content_type="text/markdown",
    classifiers=[
        "Programming Language :: Python :: 3 :: Only",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Programming Language :: Python :: 3.13",
        "Programming Language :: Python :: 3.14",
        "Programming Language :: Tcl",
        "Environment :: Win32 (MS Windows)",
        "Environment :: X11 Applications",
        "Operating System :: OS Independent",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Topic :: Software Development :: User Interfaces",
        "Topic :: Software Development :: Libraries :: Tcl Extensions",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
    zip_safe=False,
    install_requires=read("requirements.txt").splitlines(),
    has_ext_modules=lambda: True,
    python_requires=">=3.9"
)
