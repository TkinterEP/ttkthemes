variable dir [pwd]

package ifneeded zlibtcl 1.2.11 \
    [list load [file join $dir zlibtcl1211.dll]]
package ifneeded pngtcl 1.6.28 \
    [list load [file join $dir pngtcl1628.dll]]
package ifneeded tifftcl 3.9.7 \
    [list load [file join $dir tifftcl397.dll]]
package ifneeded jpegtcl 9.2 \
    [list load [file join $dir jpegtcl92.dll]]
# -*- tcl -*- Tcl package index file
# --- --- --- Handcrafted, final generation by configure.

package ifneeded img::base 1.4.7 [list load [file join $dir tkimg147.dll]]

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
    package require img::tga
    package require img::ico
    package require img::pcx
    package require img::sgi
    package require img::sun
    package require img::xbm
    package require img::xpm
    package require img::ps
    package require img::jpeg
    package require img::png
    package require img::tiff
    package require img::bmp
    package require img::ppm
    package require img::gif
    package require img::pixmap
    package provide Img 1.4.7
}

package ifneeded img::bmp 1.4.7 \
    [list load [file join $dir tkimgbmp147.dll]]
package ifneeded img::gif 1.4.7 \
    [list load [file join $dir tkimggif147.dll]]
package ifneeded img::ico 1.4.7 \
    [list load [file join $dir tkimgico147.dll]]
package ifneeded img::jpeg 1.4.7 \
    [list load [file join $dir tkimgjpeg147.dll]]
package ifneeded img::pcx 1.4.7 \
    [list load [file join $dir tkimgpcx147.dll]]
package ifneeded img::pixmap 1.4.7 \
    [list load [file join $dir tkimgpixmap147.dll]]
package ifneeded img::png 1.4.7 \
    [list load [file join $dir tkimgpng147.dll]]
package ifneeded img::ppm 1.4.7 \
    [list load [file join $dir tkimgppm147.dll]]
package ifneeded img::ps 1.4.7 \
    [list load [file join $dir tkimgps147.dll]]
package ifneeded img::sgi 1.4.7 \
    [list load [file join $dir tkimgsgi147.dll]]
package ifneeded img::sun 1.4.7 \
    [list load [file join $dir tkimgsun147.dll]]
package ifneeded img::tga 1.4.7 \
    [list load [file join $dir tkimgtga147.dll]]
package ifneeded img::tiff 1.4.7 \
    [list load [file join $dir tkimgtiff147.dll]]
package ifneeded img::window 1.4.7 \
    [list load [file join $dir tkimgwindow147.dll]]
package ifneeded img::xbm 1.4.7 \
    [list load [file join $dir tkimgxbm147.dll]]
package ifneeded img::xpm 1.4.7 \
    [list load [file join $dir tkimgxpm147.dll]]
package ifneeded img::dted 1.4.7 \
    [list load [file join $dir tkimgdted147.dll]]
package ifneeded img::raw 1.4.7 \
    [list load [file join $dir tkimgraw147.dll]]
