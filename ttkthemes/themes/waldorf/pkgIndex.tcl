if {[file isdirectory [file join $dir waldorf]]} {
    package ifneeded ttk::theme::waldorf 0.1 \
        [list source [file join $dir waldorf.tcl]]
}
