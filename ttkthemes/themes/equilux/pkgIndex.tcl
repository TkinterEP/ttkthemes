# pkgIndex.tcl for additional tile pixmap theme arc.
#
# We don't provide the package is the image subdirectory isn't present,
# or we don't have the right version of Tcl/Tk
#
# To use this automatically within tile, the tile-using application should
# use tile::availableThemes and tile::setTheme

if {![file isdirectory [file join $dir arc]]} { return }

package ifneeded ttk::theme::equilux 1.0 [list source [file join $dir equilux.tcl]]
