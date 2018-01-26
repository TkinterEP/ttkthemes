package ifneeded pngtcl 1.6.28 \
    [list load [file join $dir libpngtcl1.6.28.so]]
# -*- tcl -*- Tcl package index file
# --- --- --- Handcrafted, final generation by configure.

package ifneeded img::base 1.4.7 [list load [file join $dir libtkimg1.4.7.so]]

# Compatibility hack. When asking for the old name of the package
# then load all format handlers and base libraries provided by tkImg.
# Actually we ask only for the format handlers, the required base
# packages will be loaded automatically through the usual package
# mechanism.

# When reading images without specifying it's format (option -format),
# the available formats are tried in reversed order as listed here.
# Therefore file formats with some "magic" identifier, which can be
# recognized safely, should be added at the end of this list.

package ifneeded Img 1.4.7 {
    package require img::window
    package require img::png
    package provide Img 1.4.7
}

package ifneeded img::png 1.4.7 \
    [list load [file join $dir libtkimgpng1.4.7.so]]
