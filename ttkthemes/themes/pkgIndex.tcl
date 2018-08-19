# ttkthemes basic: Theme Loader
# Available under GNU GPLv3

# pkgIndex.tcl, v1.0 - Copyright (c) 2017-2018 RedFantom

# v1.0, 19/08/2018 RedFantom
# Modify with a single procedure for loading images for all themes

package require Tk 8.5

proc load_images {theme_name {patterns {*.gif *.png}}} {
  # Load images for a given theme by theme name
  set theme_dir [file join [pwd] [file dirname [info script]]]
  set image_dir [file join $theme_dir $theme_name]
  variable images
  foreach pattern $patterns {
    foreach file [glob -nocomplain -directory $image_dir $pattern] {
      set image [file tail [file rootname $file]]
      if {![info exists images($image)]} {
        set images($image) [image create photo -file $file]
      }
    }
  }
  return [array get images]
}

package provide ttkthemes 1.0
set themesdir [file join [pwd] [file dirname [info script]]]
lappend auto_path $themesdir

# Load basic themes
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
