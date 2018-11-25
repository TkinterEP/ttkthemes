Theming
========

``ttkthemes`` supports the creation of custom themes based upon static
themes during runtime. This is called dynamic theming. The functions to
create dynamic themes are implemented in the ``ThemedWidget`` class.
PNG-based theme support is required to apply a dynamic theme.

Choosing a theme
----------------
In order to use dynamic theming, you must first choose a theme to base
your new theme on. The supported themes for dynamic themes are all
pixmap themes that use files (and not a packed archive with files)
directly to load pixmaps. An up-to-date ``list`` of supported pixmap
themes may be found in the ``pixmap_themes`` class attribute of any
``ThemedWidget`` instance (such as ``ThemedTk`` or ``ThemedStyle``). At
the time of writing, the following list is available:

.. code-block:: python

    pixmap_themes = [
       "arc",
       "blue",
       "clearlooks",
       "elegance",
       "kroc",
       "plastik",
       "radiance",
       "winxpblue"
    ]

It is recommended to choose a theme with noticeable colors for the best
results. ``radiance`` and ``blue`` have proven to be quite suitable for
this purpose. In order to use ``blue``, it is recommended to also modify
the ``background`` colors of all widgets you plan to use, as the
theme colors are not changed during the operations.

Note that while being a pixmap theme, ``equilux`` is not included
because using dynamic theming with that theme results in severe
conversion artifacts.

Modifying a theme
-----------------
In order to load an advanced theme, the following function is provided
within any ``ThemedWidget``:

.. code-block:: python

    def set_theme_advanced(
        self, theme_name, brightness=1.0, saturation=1.0, hue=1.0,
        preserve_transparency=True, output_dir=None, advanced_name="advanced"
    )

As you might be able to deduce from the function definition, various
parameters can be used to modify the pixmaps of the theme you choose:

- ``theme_name``: The name of a valid pixmap theme to use for
  modification
- ``brightness``: A modifier that is passed on to a
  :obj:`PIL.ImageEnhance.Brightness enhancer`. Values between 0.0 and
  2.0 are expected.
- ``saturation``: A modifier that is passed on to a
  :obj:`PIL.ImageEnhance.Color` enhancer. Values between 0.0 and 2.0 are
  expected.
- ``hue``: A modifier that is used for the
  :obj:`ttkthemes._utils.shift_hue` function. Shifts the hue of an image
  by a certain amount. Note that the hue is the hue shift. Values
  between 0.0 and 2.0 are expected.
- ``preserve_transparency``: When set to :obj:`True`, all resulting
  black pixels will be set to transparent. This is only required when
  modifying the hue of an image. During the conversion from RGBA to HSV
  image format, transparency is lost to black pixels, resulting in ugly
  black patches in images if not reversed.
- ``output_dir``: Directory (to which write access is available) in
  which the new theme files should be placed. By default, a temporary
  directory is used provided by :obj:`tempfile`. Note that on most
  systems, this directory is cleared upon reboot.
- ``advanced_name``: Name of the theme to generate. You can combine this
  with an ``output_dir`` parameter to actually create a custom theme
  that you can install on other machines as well. NOTE THAT IT IS
  REQUIRED TO USE A DIFFERENT NAME EACH TIME IF YOU SET THE ADVANCED
  THEME FOR A SINGLE TK INTERPRETER INSTANCE MULTIPLE TIMES.

Examples
--------
Some examples of what you can create using this function:

|radiance|

A modified radiance theme. The hue is changed so all originally orange
features are a bright green.

|arc|

A modified arc theme. The hue is changed as well as the brightness,
though the latter only very slightly.

Notes
-----
Note that the theme is generated during runtime, when the function
``set_theme_advanced`` is called. When the function is called, rather
resource-expensive operations upon tens of images are performed, as well
as disk I/O and loading all images into memory may cause a spike in
memory usage, even though it is not all that much on most modern PCs.

.. |radiance| image:: https://user-images.githubusercontent.com/15170036/35413951-5422cd4a-0221-11e8-96c5-a21154ed2b31.png
.. |arc| image:: https://user-images.githubusercontent.com/15170036/35414048-a2af1ff4-0221-11e8-9462-e9733f91fb34.png
