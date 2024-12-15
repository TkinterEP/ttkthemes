### sciddarkthemes - Copyright (C) 2022 Uwe Klimmek
### Available under the BSD-like 2-clause Tcl License as described in LICENSE in this folder
############################################################################################
###
### sciddark.tcl: modern dark ttk themes for tcl and SCID in 6 colors
### style names:
### sciddarkblue sciddarkmint sciddarkgreen sciddarksand sciddarkpurple sciddarkgrey
###
### Use in tcl-code: load this file, select a theme and apply style
###     source -encoding utf-8 [file nativename "sciddark.tcl"]
###     ttk::style theme use sciddarkblue
###     applyStyle sciddarkblue

package require Tk
package provide ttk::theme::sciddark 1.0

#configure titlebar of a notebook: 0: looks like the standard themes; 2000: fills the titlebar  
set ::notebookWidth 2000
if { [info commands styleOption] eq "" } {
    set ::themeOptions {}
    proc styleOption {themeName pattern value} {
        lappend ::themeOptions [list $themeName $pattern $value]
    }
    proc applyStyle { style } {
        foreach elem [lsearch -all -inline -exact -index 0 $::themeOptions $style] {
            option add [lindex $elem 1] [lindex $elem 2]
        }
    }
}

foreach t { blue mint green sand purple grey } \
    c { "#3b6dce" "#7d9d6c" "#54b564" "#b58554" "#9f60a9" "#858585" } {
    set ::tks $t
    set ::bgct $c
    namespace eval ttk::theme::sciddark$t {
        set t $::tks
        proc LoadImages {color {patterns {*.png}}} {
            set themedir [file join [file dirname [info script]] scid]
            foreach imgdir [list $themedir $themedir$color] {
                foreach pattern $patterns {
                    foreach file [glob -directory $imgdir $pattern] {
                        set img [file tail [file rootname $file]]
                        if {![info exists images($img)]} {
                            set images($img) [image create photo -file $file]
                        }
                    }
                }
            }
            return [array get images]
        }

        variable I
        array set I [LoadImages $t *.png]

        variable colors
        array set colors {
            background     "#35363a"
            lighter        "#8c8c8c"    darkest        "#18192d"
            dark           "#292a2f"    darker         "#9e9e9e"
            selectbg       "#454649"    selectfg       "#fcfcfc"
            disabledfg     "#a0a0a0"    entryfocus     "#252629"
            troughcolor    "#454649"    troughborder   "#353639"
            eborder        "#5464c4"    pborder        "#35363a"
            text           "#e8e8e8"    fieldbg        "#28292d"
        }

        ttk::style theme create sciddark$t -settings {
            ttk::style configure . \
                -background         $colors(background) \
                -foreground         $colors(text) \
                -borderwidth        1 \
                -bordercolor        $colors(darkest) \
                -darkcolor          $colors(dark) \
                -lightcolor         $colors(lighter) \
                -troughcolor        $colors(troughcolor) \
                -fieldbackground    $colors(dark) \
                -selectforeground   $colors(selectfg) \
                -selectbackground   $::bgct \
                -activebackground   $::bgct \
                -activeforeground   $colors(selectfg) \
                -disabledforeground $colors(lighter) \
                -insertcolor        $colors(text) \
                -arrowcolor         $::bgct \
                -selectcolor        red \
                -relief             flat \
                ;

            # This option can only be set by "option add"
            ::styleOption sciddark$t *HighlightThickness 0
            ::styleOption sciddark$t *HighlightColor $colors(background)
            ::styleOption sciddark$t *HighlightBackground $colors(background)
            ::styleOption sciddark$t *TCombobox*Listbox.borderWidth 1
            ::styleOption sciddark$t *TCombobox*Listbox.background $colors(fieldbg)
            ::styleOption sciddark$t *TCombobox*Listbox.foreground $colors(text)
            ::styleOption sciddark$t *TCombobox*Listbox.selectBackground $::bgct
            ::styleOption sciddark$t *TCombobox*Listbox.selectForeground $colors(selectfg)
            ::styleOption sciddark$t *Text.highlightThickness 2
            ::styleOption sciddark$t *Text.highlightBackground $colors(background)
            ::styleOption sciddark$t *Text.highlightColor $::bgct
            ::styleOption sciddark$t *Text.BorderWidth 1
            ::styleOption sciddark$t *Text.Relief flat
            ::styleOption sciddark$t *Menu.Relief flat
            ::styleOption sciddark$t *Menu.BorderWidth 1
            ::styleOption sciddark$t *Menu.activeBackground $::bgct
            ::styleOption sciddark$t *Menu.activeForeground $colors(selectfg)
            ::styleOption sciddark$t *Menu.background $colors(dark)
            ::styleOption sciddark$t *Menu.foreground $colors(text)
            ::styleOption sciddark$t *Menu.disabledForeground $colors(lighter)
            ::styleOption sciddark$t *Menu.selectColor red

            ttk::style map . \
                -background [list active $::bgct disabled $colors(background)] \
                -foreground [list active $colors(selectfg) disabled $colors(disabledfg)] \
                -selectforeground [list \
                     !focus white] \
                ;
           ttk::style configure Error.TEntry -foreground #ff2020

            ## Treeview.
            ttk::style element create Treeheading.cell image \
                [list $I(tree-n) \
                     selected $I(tree-p) \
                     disabled $I(tree-d) \
                     pressed $I(tree-p) \
                     active $I(tree-h) \
                    ] \
                -border 4 -sticky ew

            ttk::style configure Row -background $colors(background)
            ttk::style configure Treeview -fieldbackground $colors(fieldbg) -background $colors(fieldbg) \
                -selectbackground $::bgct -selectforeground $colors(selectfg)
            ttk::style map Treeview -background [list selected $::bgct] \
                -foreground [list selected $colors(selectfg)]

            ## Buttons.
            ttk::style configure TButton -anchor center
            ttk::style layout TButton { Button.button -children {
                Button.focus -children { Button.padding -children {
                    Button.label
                } }
            } }

            ttk::style element create button image \
                [list $I(button-n) \
                     {pressed active} $I(button-pa) active $I(button-a) \
                     selected $I(button-a) {selected active} $I(button-pa) \
                     disabled $I(button-d) pressed $I(button-p)] \
                -border { 13 12 13 12 } -padding {4 0} -sticky nswe
            ttk::style configure Tbutton -padding {2 0 2 0}


            ## Checkbuttons.
            ttk::style element create Checkbutton.indicator image \
                [list $I(check-nu) {disabled selected} $I(check-dc) \
                     disabled $I(check-du) {pressed selected} $I(check-pc) \
                     pressed $I(check-pu) {active selected} $I(check-ac) \
                     active $I(check-hu) selected $I(check-nc) ] \
                -width 20 -sticky w

            ttk::style map TCheckbutton -background [list active $colors(fieldbg)]

            ## Switchbuttons.
            ttk::style element create Switch.indicator image \
                [list $I(switch-off) {disabled selected} $I(switch-off) \
                     disabled $I(switch-off) {pressed selected} $I(switch-on) \
                     pressed $I(switch-off) {active selected} $I(switch-on) \
                     active $I(switch-off) selected $I(switch-on) ] \
                -width 46 -sticky w
            ttk::style layout Switch.TCheckbutton {
                Switch.padding -children {
                    Switch.indicator -side left -sticky e
                    Switch.label -side right -expand true -sticky w
                }
            }
#            ttk::style map TSwitchbutton -background [list active $colors(fieldbg)]

            ## Radiobuttons.
            ttk::style element create Radiobutton.indicator image \
                [list $I(radio-nu) {disabled selected} $I(radio-dc) \
                     disabled $I(radio-du) {pressed selected} $I(radio-pc) \
                     pressed $I(radio-pu) {active selected} $I(radio-ac) \
                     active $I(radio-hu) selected $I(radio-nc) ] \
                -width 20 -sticky w

            ttk::style map TRadiobutton -background [list active $colors(fieldbg)]

            ## Menubuttons.
            ttk::style element create Menubutton.indicator \
                image [list $I(menuarrow-a) disabled $I(menuarrow-d)] \
                -sticky e -border {15 0 0 0}

            ttk::style element create Menubutton.border image \
                [list $I(button-n) selected $I(button-a) pressed $I(button-pa) \
                     disabled $I(button-d) active $I(button-a) \
                    ] \
                -border 4 -sticky ew
            ttk::style configure TMenubutton -padding {4 0 4 0} \
                -selectbackground $::bgct -selectforeground $colors(text)

            ## Toolbar buttons.
            ttk::style configure Toolbutton -padding -5 -relief flat
            ttk::style configure Toolbutton.label -padding 0 -relief flat

            ttk::style element create Toolbutton.border image \
                [list $I(blank) pressed $I(button-p) {selected active} \
                     $I(button-a) selected $I(button-p) \
                     active $I(button-a) disabled $I(blank)] \
                -border 12 -padding {10 10} -sticky nsew

            ## Entry widgets.
            ttk::style configure TEntry -padding {0 2 0 2 } -insertwidth 1\
                -selectbackground $::bgct -selectforeground $colors(text)

            ttk::style element create Entry.field image \
                [list $I(entry-n) {focus} $I(entry-a) \
                     {readonly disabled} $I(entry-rd) {readonly pressed} $I(entry-d) \
                     {focus readonly} $I(entry-d) readonly $I(entry-d) \
                    ] \
                -border 3 -sticky nsew

            ## Combobox.
            ttk::style element create Combobox.downarrow image \
                [list $I(comboarrow-n) focus $I(comboarrow-af) \
                     disabled $I(comboarrow-d) pressed $I(comboarrow-p) \
                     active $I(comboarrow-a) ] \
                -sticky we -border {2 2 0 2}

            ttk::style element create Combobox.field image \
                [list $I(combo-n) focus $I(combo-ra) {active pressed} $I(combo-ra) \
                     {readonly disabled} $I(combo-rd) {readonly pressed} $I(combo-rp) \
                     {readonly focus} $I(combo-rf) focus $I(combo-ra) readonly $I(combo-rn) \
                     {pressed selected} $I(combo-ra) {active selected} $I(combo-ra) \
                     pressed $I(combo-ra) active $I(combo-ra) selected $I(combo-ra) \
                    ] \
                -border {4 0 0 0} -sticky ew
            ttk::style configure TCombobox -selectbackground $::bgct -selectforeground $colors(text)

            ## Spinbox.
            ttk::style element create Spinbox.downarrow image \
                [list $I(spinarrowdown-a) {focus pressed} $I(spinarrowdown-paf) \
                     focus $I(spinarrowdown-af) disabled $I(spinarrowdown-a) \
                     active $I(spinarrowdown-p) ] \
                -border 4 -sticky {}
            ttk::style element create Spinbox.uparrow image \
                [list $I(spinarrowup-a) {focus pressed} $I(spinarrowup-paf) \
                     focus $I(spinarrowup-af) disabled $I(spinarrowup-a) \
                     active $I(spinarrowup-p) ] \
                -border 4 -sticky {}
            ttk::style element create Spinbox.field image \
                [list $I(combo-n) focus $I(combo-ra) {readonly disabled} $I(combo-rd) \
                     {readonly pressed} $I(combo-rp) {readonly focus} $I(combo-rf) \
                     readonly $I(combo-rn) ] \
                -border {4 0 0 0} -sticky nsew
            ttk::style configure TSpinbox -selectbackground $::bgct -selectforeground $colors(text)

            ## Notebooks.
            ttk::style element create Notebook.client image $I(surface) -border { 2 0 3 2 } -sticky news
            # ttk::style map TNotebook.Tab \
                -width [list selected $::notebookWidth !selected [expr $::notebookWidth * 2 / 5]] ;
            ttk::style element create Notebook.tab image [list $I(tab-n) \
                                                 {active !selected !disabled} $I(tab-a) selected $I(tab-s) pressed $I(tab-n) ] \
                -border {3 9 3 9} -padding {3 4 3 3} -width $::notebookWidth
            ttk::style layout TNotebook.Tab {Notebook.tab -children { Notebook.label -side left -border 100}}

            ## Labelframes.
            ttk::style element create Labelframe.border image $I(labelframe) \
                -border 4 -sticky news
            ttk::style configure TLabelframe -padding 4

            ## Scrollbars.
            ttk::style layout Vertical.TScrollbar {
                Vertical.Scrollbar.trough -sticky ns -children {
                    Vertical.Scrollbar.thumb -expand true
                }
            }

            ttk::style layout Horizontal.TScrollbar {
                Horizontal.Scrollbar.trough -sticky ew -children {
                    Horizontal.Scrollbar.thumb -expand true
                }
            }
            ttk::style element create Horizontal.Scrollbar.thumb image \
                [list $I(sbthumb-hn) disabled $I(sbthumb-hd) \
                     pressed $I(sbthumb-ha) active $I(sbthumb-ha)] \
                -border { 4 0 4 0 }
            ttk::style element create Vertical.Scrollbar.thumb image \
                [list $I(sbthumb-vn) disabled $I(sbthumb-vd) \
                     pressed $I(sbthumb-va) active $I(sbthumb-va)] \
                -border { 0 4 0 4 }
            ttk::style element create Horizontal.Scrollbar.trough image $I(sbtrough-h) -border { 7 0 7 0}
            ttk::style element create Vertical.Scrollbar.trough image $I(sbtrough-v) -border { 0 7 0 7 }

            ttk::style configure TScrollbar -bordercolor $colors(troughborder)

            ## Scales.
            ttk::style element create Horizontal.Scale.slider image \
                [list $I(radio-nc) disabled $I(radio-dc) active $I(radio-ac) ]

            ttk::style element create Horizontal.Scale.trough image \
                [list $I(scaletrough-h) pressed $I(scaletrough-hp) ] \
                -border 4 -sticky ew -padding 0

            ttk::style element create Vertical.Scale.slider image \
                [list $I(radio-nc) disabled $I(radio-dc) active $I(radio-ac) ]
            ttk::style element create Vertical.Scale.trough image \
                [list $I(scaletrough-v) pressed $I(scaletrough-vp) ] \
                -border {0 3 0 3 } -padding 0

            ttk::style configure TScale -bordercolor $colors(troughborder)

            ## Progressbar.
            ttk::style element create Progressbar.trough image $I(entry-n) -border 3
            ttk::style element create Vertical.Progressbar.pbar image $I(progress-v) -border {2 2 1 1}
            ttk::style element create Horizontal.Progressbar.pbar image $I(progress-h) -border {1 2 1 1}
            ttk::style configure TProgressbar -bordercolor $colors(troughborder) -foreground $colors(eborder)

            ## Statusbar parts.
            ttk::style element create sizegrip image $I(sizegrip)

            ## Separator.
            ttk::style element create separator image $I(sep-h)
            ttk::style element create hseparator image $I(sep-h)
            ttk::style element create vseparator image $I(sep-v)

            ## Paned window.
            ttk::style configure TPanedwindow -background $colors(pborder)
            ttk::style element create vsash image $I(sas-v) -sticky e
            ttk::style element create hsash image $I(sas-h) -sticky s
        }
    }
}
unset ::tks
unset ::bgct
