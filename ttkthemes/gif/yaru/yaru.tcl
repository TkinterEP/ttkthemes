# Copyright (c) 2020 RedFantom
# Derived from arc theme file, Copyright (c) 2015 Sergei Golovan
# Derived from Ubuntu Yaru theme, Copyright (c) 2018-2020 The Yaru theme authors
# See <https://github.com/ubuntu/yaru/blob/master/AUTHORS> for a list of
# authors for the Yaru theme

# Licensed under GNU GPLv3 (most restrictive, derivative of 'arc')

namespace eval ttk::theme::yaru {

    variable colors
    array set colors {
        -fg             "#3d3d3d"
        -bg             "#f5f6f7"
        -disabledfg     "#8b8e8f"
        -disabledbg     "#f1f1f1"
        -selectfg       "#ffffff"
        -selectbg       "#e95420"
        -window         "#f4f4f4"
        -focuscolor     "#5c616c"
        -checklight     "#fbfcfc"
    }

    proc LoadImages {imgdir} {
        variable I
        foreach file [glob -directory $imgdir *.gif] {
            set img [file tail [file rootname $file]]
            set I($img) [image create photo -file $file -format gif]
        }
    }

    LoadImages [file join [file dirname [info script]] yaru]

    ttk::style theme create yaru -parent default -settings {
        ttk::style configure . \
            -background $colors(-bg) \
            -foreground $colors(-fg) \
            -troughcolor $colors(-bg) \
            -selectbackground $colors(-selectbg) \
            -selectforeground $colors(-selectfg) \
            -fieldbackground $colors(-window) \
            -font TkDefaultFont \
            -borderwidth 1 \
            -focuscolor $colors(-focuscolor)

        ttk::style map . -foreground [list disabled $colors(-disabledfg)]

        ttk::style layout TButton {
            Button.button -children {
                Button.focus -children {
                    Button.padding -children {
                        Button.label -side left -expand true
                    }
                }
            }
        }

        ttk::style layout Toolbutton {
            Toolbutton.button -children {
                Toolbutton.focus -children {
                    Toolbutton.padding -children {
                        Toolbutton.label -side left -expand true
                    }
                }
            }
        }

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

        ttk::style layout TMenubutton {
            Menubutton.button -children {
                Menubutton.focus -children {
                    Menubutton.padding -children {
                        Menubutton.indicator -side right
                        Menubutton.label -side right -expand true
                    }
                }
            }
        }

        ttk::style layout TCombobox {
            Combobox.field -sticky nswe -children {
                Combobox.downarrow -side right -sticky ns -children {
                    Combobox.arrow -side right
                }
                Combobox.padding -expand true -sticky nswe -children {
                    Combobox.textarea -sticky nswe
                }
            }
        }

        ttk::style layout TSpinbox {
            Spinbox.field -side top -sticky we -children {
                Spinbox.buttons -side right -children {
                    null -side right -sticky {} -children {
                        Spinbox.uparrow -side top -sticky nse -children {
                            Spinbox.symuparrow -side right -sticky e
                        }
                        Spinbox.downarrow -side bottom -sticky nse -children {
                            Spinbox.symdownarrow -side right -sticky e
                        }
                    }
                }
                Spinbox.padding -sticky nswe -children {
                    Spinbox.textarea -sticky nswe
                }
            }
        }

        ttk::style element create Button.button image [list \
            $I(button) \
            pressed     $I(button-active) \
            active      $I(button-hover) \
            disabled    $I(button-insensitive) \
        ] -border 3 -padding {3 2} -sticky ewns

        ttk::style element create Toolbutton.button image [list \
            $I(button) \
            selected            $I(button-active) \
            pressed             $I(button-active) \
            {active !disabled}  $I(button-hover) \
        ] -border 3 -padding {3 2} -sticky news

        ttk::style element create Checkbutton.indicator image [list \
            $I(checkbox-unchecked) \
            disabled            $I(checkbox-unchecked-insensitive) \
            {active selected}   $I(checkbox-checked) \
            {pressed selected}  $I(checkbox-checked) \
            active              $I(checkbox-unchecked) \
            selected            $I(checkbox-checked) \
            {disabled selected} $I(checkbox-checked-insensitive) \
        ] -width 17 -sticky w

        ttk::style element create Radiobutton.indicator image [list \
            $I(radio-unchecked) \
            disabled            $I(radio-unchecked-insensitive) \
            {active selected}   $I(radio-checked) \
            {pressed selected}  $I(radio-checked) \
            active              $I(radio-unchecked) \
            selected            $I(radio-checked) \
            {disabled selected} $I(radio-checked-insensitive) \
        ] -width 17 -sticky w

        ttk::style element create Horizontal.Scrollbar.trough image $I(scrollbar-horz-trough)

        ttk::style element create Horizontal.Scrollbar.thumb image [list \
            $I(scrollbar-horz-slider) \
            {pressed !disabled} $I(scrollbar-horz-slider-active) \
            {active !disabled}  $I(scrollbar-horz-slider) \
        ] -border 5 -sticky ew

        ttk::style element create Vertical.Scrollbar.trough image $I(scrollbar-vert-trough)

        ttk::style element create Vertical.Scrollbar.thumb image [list \
            $I(scrollbar-vert-slider) \
            {pressed !disabled} $I(scrollbar-vert-slider-active) \
            {active !disabled}  $I(scrollbar-vert-slider) \
        ] -border 6 -sticky ns

        ttk::style element create Horizontal.Scale.trough image [list \
            $I(scale-horz-trough) \
            {pressed !disabled} $I(scale-horz-trough-active) \
        ] -border 10 -padding 0

        ttk::style element create Horizontal.Scale.slider image [list \
            $I(scale-slider)  \
            disabled $I(scale-slider-insensitive) \
            active $I(scale-slider-active) \
        ] -sticky {}

        ttk::style element create Vertical.Scale.trough image [list \
            $I(scale-vert-trough-active) \
            disabled $I(scale-vert-trough) \
        ] -border 10 -padding 0

        ttk::style element create Vertical.Scale.slider image [list \
            $I(scale-slider) \
            disabled $I(scale-slider-insensitive) \
            active $I(scale-slider-active) \
        ] -sticky {}

        ttk::style element create Entry.field image [list \
            $I(entry) \
            focus $I(entry-active) \
            disabled $I(entry-insensitive) \
        ] -border 3 -padding {6 4} -sticky news

        ttk::style element create Labelframe.border image $I(labelframe) \
           -border 4 -padding 4 -sticky news

        ttk::style element create Menubutton.button image [list \
            $I(button) \
            pressed $I(button-active) \
            active $I(button-hover) \
            disabled $I(button-insensitive) \
        ] -sticky news -border 3 -padding {3 2}

        ttk::style element create Menubutton.indicator image [list \
            $I(spin-down) \
            active $I(spin-down) \
            pressed $I(spin-down) \
            disabled $I(spin-down-insensitive) \
        ] -sticky e -width 20

        ttk::style element create Combobox.field image [list \
            $I(combo-entry-ltr-entry) \
            {readonly disabled} $I(combo-entry-ltr-button-insensitive) \
            {readonly pressed} $I(combo-entry-ltr-button-active) \
            readonly $I(combo-entry-ltr-button) \
            {disabled} $I(combo-entry-ltr-entry-insensitive) \
            {focus} $I(combo-entry-ltr-entry) \
            {hover} $I(combo-entry-ltr-entry) \
        ] -border 4 -padding {6 0 0 0}

        ttk::style element create Combobox.downarrow image [list \
            $I(combo-entry-ltr-button) \
            pressed $I(combo-entry-ltr-button-active) \
            active $I(combo-entry-ltr-button-hover) \
            disabled $I(combo-entry-ltr-button-insensitive) \
        ] -border 4 -padding {0 10 6 10}

        ttk::style element create Combobox.arrow image [list \
            $I(pan-down) \
            active $I(pan-down) \
            pressed $I(pan-down) \
            disabled $I(pan-down-insensitive) \
        ]  -sticky e -width 15

        ttk::style element create Spinbox.field image [list \
            $I(combo-entry-ltr-entry) \
            focus $I(combo-entry-ltr-entry-active) \
        ] -border 4 -padding {6 0 0 0} -sticky news

        ttk::style element create Spinbox.uparrow image [list \
            $I(spin-ltr-up) \
            pressed $I(spin-ltr-up-active) \
            active $I(spin-ltr-up-hover) \
            disabled $I(spin-ltr-up-insensitive) \
        ] -width 20 -border {0 2 3 0} -padding {0 5 6 2}

        ttk::style element create Spinbox.symuparrow image [list \
            $I(pan-up) \
            active $I(pan-up) \
            pressed $I(pan-up) \
            disabled $I(pan-up-insensitive) \
        ]

        ttk::style element create Spinbox.downarrow image [list \
            $I(spin-ltr-down) \
            pressed $I(spin-ltr-down-active) \
            active $I(spin-ltr-down-hover) \
            disabled $I(spin-ltr-down-insensitive) \
        ] -width 20 -border {0 0 3 2} -padding {0 2 6 5}

        ttk::style element create Spinbox.symdownarrow image [list \
            $I(pan-down) \
            active $I(pan-down) \
            pressed $I(pan-down) \
            disabled $I(pan-down-insensitive) \
        ]

        # ttk::style element create Notebook.client \
        #     image $I(notebook) -border 1
        ttk::style element create Notebook.tab image [list \
            $I(notebook-entry) \
            selected    $I(notebook-entry-active) \
            active      $I(notebook-entry) \
        ] -padding {0 2 0 0} -border 4

        ttk::style element create Horizontal.Progressbar.trough \
            image $I(progressbar-vert-trough) -border {3 1 3 1} -padding 1
        ttk::style element create Horizontal.Progressbar.pbar \
            image $I(progressbar-vert) -border {1 0 1 0}

        ttk::style element create Vertical.Progressbar.trough \
            image $I(progressbar-horz-trough) -border {1 3 1 3} -padding 1
        ttk::style element create Vertical.Progressbar.pbar \
            image $I(progressbar-horz) -border {0 1 0 1}

        ttk::style element create Treeview.field \
            image $I(empty) -border 1
        ttk::style element create Treeheading.cell image [list \
            $I(notebook-entry) \
            pressed $I(notebook-entry-active) \
            disabled $I(notebook-entry-insensitive) \
        ] -border 4 -padding 4 -sticky ewns

        ttk::style element create Treeitem.indicator \
            image [list $I(plus) user2 $I(empty) user1 $I(minus)] \
            -width 15 -sticky w

        #ttk::style element create Separator.separator image $I()

        #
        # Settings:
        #

        ttk::style configure TButton -padding {8 4 8 4} -width -10 -anchor center
        ttk::style configure TMenubutton -padding {8 4 4 4}
        ttk::style configure Toolbutton -anchor center
        ttk::style map TCheckbutton -background [list active $colors(-checklight)]
        ttk::style configure TCheckbutton -padding 3
        ttk::style map TRadiobutton -background [list active $colors(-checklight)]
        ttk::style configure TRadiobutton -padding 3
        ttk::style configure TNotebook -tabmargins {0 2 0 0}
        ttk::style configure TNotebook.Tab -padding {6 2 6 2} -expand {0 0 2}
        ttk::style map TNotebook.Tab -expand [list selected {1 2 4 2}]
        ttk::style configure TSeparator -background $colors(-bg)

        # Treeview
        ttk::style configure Treeview -background $colors(-window)
        ttk::style configure Treeview.Item -padding {2 0 0 0}
        ttk::style map Treeview \
            -background [list selected $colors(-selectbg)] \
            -foreground [list selected $colors(-selectfg)]
    }
}

variable version 0.1
package provide ttk::theme::yaru $version

