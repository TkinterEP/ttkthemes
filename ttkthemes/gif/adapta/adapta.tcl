# Copyright (C) 2018 RedFantom
# Derived from https://github.com/adapta-project/adapta-gtk-theme (GNU GPLv2)
# Based on /ttkthemes/ttkthemes/themes/arc/arc.tcl (GNU GPLv3)
# Available under the GNU GPLv3, or at your option any later version

# Theme Adapta
namespace eval ttk::theme::adapta {

    # Widget colors
    variable colors
    array set colors {
        -foreground     "#000000"
        -background     "#fafbfc"
        -disabledbg     "#fafbfc"
        -disabledfg     "#c3c5d6"
        -selectbg       "#00bcd4"
        -selectfg       "#ffffff"
        -window         "#fafbfc"
        -focuscolor     "#1ee9b7"
        -checklight     "#1ee9b7"
    }

    # Function to load images from subdirectory
    variable directory
    # Subdirectory /adapta
    set directory [file join [file dirname [info script]] adapta]
    variable images
    # Load the images
    foreach file [glob -directory $directory *.gif] {
        set img [file tail [file rootname $file]]
        set images($img) [image create photo -file $file -format gif]
    }

    # Create a new ttk::style
    ttk::style theme create adapta -parent default -settings {
        # Configure basic style settings
        ttk::style configure . \
            -background $colors(-background) \
            -foreground $colors(-foreground) \
            -troughcolor $colors(-background) \
            -selectbackground $colors(-selectbg) \
            -selectforeground $colors(-selectfg) \
            -fieldbackground $colors(-window) \
            -font TkDefaultFont \
            -borderwidth 1 \
            -focuscolor $colors(-focuscolor)

        # Map disabled colors to disabledfg
        ttk::style map . -foreground [list disabled $colors(-disabledfg)]

        # WIDGET LAYOUTS

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

        # Style elements

        # Button
        ttk::style element create Button.button image [list $images(button) \
                pressed     $images(button-active) \
                active      $images(button-hover) \
                disabled    $images(button-insensitive) \
            ] -border 3 -padding {3 2} -sticky ewns

        # Toolbutton
        ttk::style element create Toolbutton.button image [list $images(toolbutton) \
                selected            $images(toolbutton-active) \
                pressed             $images(toolbutton-active) \
                {active !disabled}  $images(toolbutton-hover) \
            ] -border 3 -padding {3 2} -sticky news

        # Checkbutton
        ttk::style element create Checkbutton.indicator image [list $images(check-off) \
                disabled            $images(check-off-insensitive) \
                {active selected}   $images(check-on-hover) \
                {pressed selected}  $images(check-on) \
                active              $images(check-off) \
                selected            $images(check-on) \
                {disabled selected} $images(check-on-insensitive) \
            ] -width 25 -sticky w -padding {0 4 0 0}

        # Radiobutton
        ttk::style element create Radiobutton.indicator image [list $images(radio-off) \
                disabled            $images(radio-off-insensitive) \
                {active selected}   $images(radio-on-hover) \
                {pressed selected}  $images(radio-on) \
                active              $images(radio-off) \
                selected            $images(radio-on-hover) \
                {disabled selected} $images(radio-on-insensitive) \
            ] -width 25 -sticky w -padding {0 4 0 0}

        # Scrollbars
        ttk::style element create Horizontal.Scrollbar.trough \
            image [list $images(scroll-horiz-bg) \
                        disabled $images(scroll-horiz-bg-insensitive) \
            ]
        ttk::style element create Horizontal.Scrollbar.thumb \
            image [list $images(scroll-horiz-slider) \
                        {pressed !disabled} $images(scroll-horiz-slider-active) \
                        {active !disabled}  $images(scroll-horiz-slider-hover) \
                        disabled            $images(scroll-horiz-slider-insensitive) \
            ] -border 7 -sticky ew
        ttk::style element create Vertical.Scrollbar.trough \
            image [list $images(scroll-vert-bg) \
                        disabled $images(scroll-vert-bg-insensitive) \
            ]
        ttk::style element create Vertical.Scrollbar.thumb \
            image [list $images(scroll-vert-slider) \
                        {pressed !disabled} $images(scroll-vert-slider-active) \
                        {active !disabled}  $images(scroll-vert-slider-hover) \
                        disabled            $images(scroll-vert-slider-insensitive) \
            ] -border 7 -sticky ns

        # Scales
        ttk::style element create Horizontal.Scale.trough \
            image [list $images(scale-horiz-bg) \
                        disabled $images(scale-horiz-bg-insensitive) \
            ] \
            -border {10 5 10 5} -padding 0
        ttk::style element create Horizontal.Scale.slider \
            image [list $images(scale-slider) \
                        disabled $images(scale-slider-insensitive) \
                        active $images(scale-slider-hover) \
            ] \
            -sticky {}
        ttk::style element create Vertical.Scale.trough \
            image [list $images(scale-vert-bg) \
                        disabled $images(scale-vert-bg-insensitive) \
            ] \
            -border {5 10 5 10} -padding 0
        ttk::style element create Vertical.Scale.slider \
            image [list $images(scale-slider) \
                        disabled $images(scale-slider-insensitive) \
                        active $images(scale-slider-hover)
            ] \
            -sticky {}

        # Entry
        ttk::style element create Entry.field \
            image [list $images(entry) \
                        focus $images(entry-active) \
                        disabled $images(entry-insensitive)] \
            -border 4 -padding {6 6} -sticky news

        # LabelFrame
        # ttk::style element create Labelframe.border image $images(labelframe) \
        #     -border 4 -padding 4 -sticky news

        # Menubutton
        ttk::style element create Menubutton.button \
            image [list $images(button) \
                        pressed  $images(button-active) \
                        active   $images(button-hover) \
                        disabled $images(button-insensitive) \
            ] -sticky news -border 3 -padding {3 2}
        ttk::style element create Menubutton.indicator \
            image [list $images(arrow-down) \
                        active   $images(arrow-down-hover) \
                        pressed  $images(arrow-down-hover) \
            ] -sticky e -width 20

        # ComboBox
        ttk::style element create Combobox.field \
            image [list $images(combo-entry) \
                {readonly disabled}  $images(combo-entry-insensitive) \
                {readonly pressed}   $images(combo-entry-active) \
                {readonly hover}     $images(combo-entry-active) \
                readonly             $images(combo-entry) \
                {disabled} $images(combo-entry-insensitive) \
                {hover}    $images(combo-entry-active) \
            ] -border 4 -padding {6 0 0 0}
        ttk::style element create Combobox.downarrow \
            image [list $images(combo-button) \
                        pressed   $images(combo-button-active) \
                        active    $images(combo-button-hover) \
                        disabled  $images(combo-button-insensitive) \
          ] -border 4 -padding {0 10 6 10}
        ttk::style element create Combobox.arrow \
            image [list $images(button-unshade) \
                        active    $images(button-unshade-prelight) \
                        pressed   $images(button-unshade-pressed) \
                        disabled  $images(button-unshade) \
          ]  -sticky e -width 15

        # Spinbox
        # ttk::style element create Spinbox.field \
        #     image [list $images(combo-entry) focus $images(combo-entry-active)] \
        #     -border 4 -padding {6 0 0 0} -sticky news
        # ttk::style element create Spinbox.uparrow \
        #     image [list $images(up-bg) \
        #                 pressed   $images(up-bg-active) \
        #                 active    $images(up-bg-hover) \
        #                 disabled  $images(up-bg-disable) \
        #     ] -width 20 -border {0 2 3 0} -padding {0 5 6 2}
        # ttk::style element create Spinbox.symuparrow \
        #     image [list $images(arrow-up-small) \
        #                 active    $images(arrow-up-small-prelight) \
        #                 pressed   $images(arrow-up-small-prelight) \
        #                 disabled  $images(arrow-up-small-insens) \
        #     ]
        # ttk::style element create Spinbox.downarrow \
        #     image [list $images(down-bg) \
        #                 pressed   $images(down-bg-active) \
        #                 active    $images(down-bg-hover) \
        #                 disabled  $images(down-bg-disable) \
        #     ] -width 20 -border {0 0 3 2} -padding {0 2 6 5}
        # ttk::style element create Spinbox.symdownarrow \
        #     image [list $images(arrow-down) \
        #                 active    $images(arrow-down-prelight) \
        #                 pressed   $images(arrow-down-prelight) \
        #                 disabled  $images(arrow-down-insens) \
        #   ]

        # Notebook
        # ttk::style element create Notebook.client \
        #     image $images(notebook) -border 1
        ttk::style element create Notebook.tab \
            image [list $images(notebook) \
                        selected    $images(notebook-active) \
            ] -padding {4 4 4 2} -border {5 3 5 0}

        # Progressbars
        ttk::style element create Horizontal.Progressbar.trough \
            image $images(progress-bg) -border 0 -padding 1
        ttk::style element create Horizontal.Progressbar.pbar \
            image $images(progress-bar) -border 0 -padding 2

        ttk::style element create Vertical.Progressbar.trough \
            image $images(progress-bg) -border 0 -padding 1
        ttk::style element create Vertical.Progressbar.pbar \
            image $images(progress-bar) -border 0

        # Treeview
        ttk::style element create Treeview.field \
            image $images(treeview) -border 1
        ttk::style element create Treeheading.cell \
            image [list $images(toolbutton-hover) \
                pressed $images(toolbutton-active) \
                disabled $images(toolbutton-insensitive) \
                active $images(toolbutton-hover)] \
            -border {4 1 4 1} -padding 4 -sticky ewns
        # ttk::style element create Treeitem.indicator \
        #     image [list $images(plus) user2 $images(empty) user1 $images(minus)] \
        #     -width 15 -sticky w

        # Settings
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
        ttk::style configure TSeparator -background $colors(-background)

        # Treeview
        ttk::style configure Treeview -background $colors(-window)
        ttk::style configure Treeview.Item -padding {2 0 0 0}
        ttk::style map Treeview \
            -background [list selected $colors(-selectbg)] \
            -foreground [list selected $colors(-selectfg)]
    }
}

variable version 1.0
package provide ttk::theme::adapta $version
