# Author: RedFantom
# License: GNU GPLv3
# Copyright (c) 2017-2018 RedFantom
set themesdir [file join [pwd] [file dirname [info script]]]

array set themes {
  arc 0.1
  equilux 1.1
  scid 0.9.1
  ubuntu 1.0
}

foreach {theme version} [array get themes] {
  package ifneeded ttk::theme::$theme $version \
    [list source [file join $themesdir $theme $theme.tcl]]
}
