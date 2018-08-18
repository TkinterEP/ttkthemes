# Tcl Code Styling
In addition to providing a package with as many `ttk` themes as possible
for Python-Tkinter users, this project also aims to preserve the code
of as many `ttk` themes under a single, compatible license as possible.

In order to better achieve this goal, all the `.tcl` files should be 
formatted in a similar fashion. After seeing man `.tcl` theme files,
I have decided on a style guide that should be applied to all Tcl code
files in this repository.

## Headers
File headers should have the following format:
```tcl
# Short description of contents
# Available under {license name}

# {file name}, v{version} - {original author copyright}
```

In addition, files may specify a revision history with authors, in the
following format, each revision separated by a blank line:
```tcl
# v{version}, YYYY/MM/DD {author name}
# Short description of changes
```

## Themes
Themes should each be contained in their own namespace. All code should
be indented with two spaces. No indentation level should be skipped.
```tcl
namespace eval ttk::theme::{theme} {
  
  package provide ttk::theme::{theme} {version}
  
  # Theme code goes here
}
```

Widget configurations should be separated. All `Button` types should be
grouped together. Widgets do not have to be in a particular order, but
an alphabetical order is preferred.

```tcl
## {widget group}
# {optional comment}
ttk::style element create Button.button image \
  [list $images() \
    pressed $images() \
    active $images() \
  ] -border 1 -sticky nswe
```

`ttk::style configure` and `ttk::style map` commands with multiple 
options should have each option on a new line. If an option has a list
value it does not have to be spread across newlines if it remains within
an 80-character limit.

```tcl
ttk::style map Toolbutton \
    -background [list active $colors() disabled $colors()] \
    -foreground [list active $colors() disabled $colors()]
```

All colors defined for the theme should be defined in a single array
of colors at the start of the theme, after the `package provide` line 
and before loading images.

For older themes that were a work in progress originally, dead code 
should be tested and if deemed necessary removed. Code for Tk versions
earlier than Tk 8.5 may also be removed, as Tk 8.5 is the minimum
included with any Python distribution officially supported by this
library.
