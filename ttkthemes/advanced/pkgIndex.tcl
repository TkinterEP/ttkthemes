# Author: RedFantom
# License: GNU GPLv3
# Copyright (c) 2017-2019 RedFantom

package require Tk 8.6-

if {[file isdirectory [file join $dir advanced]]} {
    package ifneeded ttk::theme::advanced 1.0 \
        [list source [file join $dir advanced.tcl]]
}
