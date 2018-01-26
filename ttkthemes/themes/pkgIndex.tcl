# This file was written by RedFantom
# Copyright (C) 2017 RedFantom
# This file is available under the GNU GPLv3 as described in LICENSE

set themesdir [file join [pwd] [file dirname [info script]]]
lappend auto_path $themesdir
package provide ttkthemes 1.0
source [file join $themesdir plastik plastik.tcl]
source [file join $themesdir radiance radiance.tcl]
source [file join $themesdir kroc kroc.tcl]
source [file join $themesdir clearlooks clearlooks.tcl]
source [file join $themesdir elegance elegance.tcl]
source [file join $themesdir blue blue.tcl]
source [file join $themesdir aquativo aquativo.tcl]
source [file join $themesdir keramik keramik.tcl]
source [file join $themesdir winxpblue winxpblue.tcl]
source [file join $themesdir black black.tcl]
if {![catch {package present Img}]} {
    source [file join $themesdir arc arc.tcl]
}