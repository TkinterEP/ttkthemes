"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import os
from shutil import rmtree
import sys

DEPENDENCIES = ["pillow"]
REQUIREMENTS = ["codecov", "coverage", "nose", "setuptools", "pip", "wheel", "semantic_version"]
PACKAGES = "python-tk python3-tk libtk-img"

SDIST = os.environ.get("SDIST", "false") == "true"

TO_DELETE = ["ttkthemes"]


class Version(object):
    """
    Parses a semantic version string.
    """
    def __init__(self, string):
        """
        :param string: semantic version string (major.minor.patch)
        """
        elements = tuple(map(int, string.split(".")))
        if len(elements) == 3:
            self.major, self.minor, self.patch = elements
        else:
            (self.major, self.minor), self.patch = elements, 0
        self.version = (self.major, self.minor, self.patch)

    def __ge__(self, other):
        return all(elem1 >= elem2 for elem1, elem2 in zip(self.version, other.version))


def run_command(command):
    """
    :param command: command to run on os.system
    :return: exit code
    """
    print("Running system command: ", command)
    return_info = os.system(command)
    if sys.platform == "win32":
        return return_info
    else:
        return os.WEXITSTATUS(return_info)


def check_wheel_existence():
    """Return True if a wheel is built"""
    return len([file for file in os.listdir("dist") if file.endswith((".whl", ".tar.gz"))]) != 0


def build_and_install_wheel(python):
    """Build a binary distribution wheel and install it"""
    dist_type = "bdist_wheel" if not SDIST else "sdist"
    return_code = run_command("{} setup.py {}".format(python, dist_type))
    if return_code != 0:
        print("Building and installing wheel failed.")
        exit(return_code)
    # Check if an artifact exists
    assert check_wheel_existence()
    print("Wheel file exists.")
    # Install the wheel file
    wheel = [file for file in os.listdir("dist") if file.endswith((".whl", ".tar.gz"))][0]
    wheel = os.path.join("dist", wheel)
    print("Wheel file:", wheel)
    return_code = run_command("{} -m pip install --ignore-installed {}".format(python, wheel))
    if return_code != 0:
        print("Installation of wheel failed.")
        exit(return_code)
    print("Wheel file installed.")


def ci(python="python", codecov="codecov", coverage_file="coverage.xml", wheel=True):
    """
    Run the most common CI tasks
    """

    # Import pip
    from pip import __version__ as pip_version
    if Version(pip_version) >= Version("10.0.0"):
        import pip._internal as pip
    else:
        import pip

    # Install requirements with pip
    pip.main(["install"] + DEPENDENCIES + REQUIREMENTS + ["-U"])
    # Build the installation wheel
    if wheel is True:
        build_and_install_wheel(python)
        # Remove all non-essential files
        for to_delete in TO_DELETE:
            rmtree(to_delete)
    # Run the tests on the installed ttkthemes
    return_code = run_command("{} -m nose --with-coverage --cover-xml --cover-package=ttkthemes".format(python))
    if return_code != 0:
        print("Tests failed.")
        exit(return_code)
    print("Tests successful.")
    # Run codecov
    return_code = run_command("{} -f {}".format(codecov, coverage_file))
    if return_code != 0:
        print("Codecov failed.")
        exit(return_code)
    # Successfully finished CI
    exit(0)


def ci_windows():
    """
    Run CI tasks on AppVeyor. CI on AppVeyor is relatively easy, so
    just the general ci() is used.
    """
    ci(
        python="%PYTHON%\\python.exe",
        codecov="%PYTHON%\\Scripts\\codecov.exe",
        coverage_file="C:\\projects\\ttk-themes\\coverage.xml",
        wheel=False
    )


def ci_linux():
    """
    Setup Travis-CI linux for installation and testing
    """
    run_command("sudo apt-get install {}".format(PACKAGES))
    ci()


# Run CI tasks on AppVeyor and Travis-CI (macOS and Linux)
if __name__ == '__main__':
    if sys.platform == "win32":
        ci_windows()
    elif "linux" in sys.platform:   # linux2 on Python 2, linux on Python 3
        ci_linux()
    else:
        raise RuntimeError("Invalid platform: ", sys.platform)

