# Author: RedFantom
# License: GNU GPLv3
# Copyright (c) 2017-2018 RedFantom

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
source [file join $themesdir smog smog.tcl]
source [file join $themesdir itft1 itft1.tcl]
