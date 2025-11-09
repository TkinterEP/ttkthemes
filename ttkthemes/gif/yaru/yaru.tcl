# Copyright (c) 2021 rdbende
# Copyright (c) 2020 RedFantom
# Derived from Ubuntu Yaru theme, Copyright (c) 2018-2020 The Yaru theme authors
# See <https://github.com/ubuntu/yaru/blob/master/AUTHORS> for a list of authors for the Yaru theme

package require Tk 8.6-

namespace eval ttk::theme::yaru {

    variable version 1.2
    package provide ttk::theme::yaru $version
    variable colors
    array set colors {
        -fg             "#3d3d3d"
        -bg             "#f7f7f7"
        -disabledfg     "#8b8e8f"
        -disabledbg     "#f7f7f7"
        -selectfg       "#f7f7f7"
        -selectbg       "#e95420"
    }

    proc LoadImages {imgdir} {
        variable I
        foreach file [glob -directory $imgdir *.gif] {
            set img [file tail [file rootname $file]]
            set I($img) [image create photo -file $file -format gif]
        }
    }

    LoadImages [file join [file dirname [info script]] yaru]

    # Settings
    ttk::style theme create yaru -parent default -settings {
        ttk::style configure . \
            -background $colors(-bg) \
            -foreground $colors(-fg) \
            -troughcolor $colors(-bg) \
            -focuscolor $colors(-selectbg) \
            -selectbackground $colors(-selectbg) \
            -selectforeground $colors(-selectfg) \
            -fieldbackground $colors(-selectbg) \
            -font TkDefaultFont \
            -borderwidth 1 \
            -relief flat

        ttk::style map . -foreground [list disabled $colors(-disabledfg)]

        tk_setPalette background [ttk::style lookup . -background] \
            foreground [ttk::style lookup . -foreground] \
            highlightColor [ttk::style lookup . -focuscolor] \
            selectBackground [ttk::style lookup . -selectbackground] \
            selectForeground [ttk::style lookup . -selectforeground] \
            activeBackground [ttk::style lookup . -selectbackground] \
            activeForeground [ttk::style lookup . -selectforeground]
        option add *font [ttk::style lookup . -font]


        # Layouts
        ttk::style layout TButton {
            Button.button -children {
                Button.padding -children {
                    Button.label -side left -expand true
                }
            }
        }

        ttk::style layout Toolbutton {
            Toolbutton.button -children {
                Toolbutton.padding -children {
                    Toolbutton.label -side left -expand true
                }
            }
        }

        ttk::style layout TMenubutton {
            Menubutton.button -children {
                Menubutton.padding -children {
                    Menubutton.indicator -side right
                    Menubutton.label -side right -expand true
                }
            }
        }

        ttk::style layout TOptionMenu {
            OptionMenu.button -children {
                OptionMenu.padding -children {
                    OptionMenu.indicator -side right
                    OptionMenu.label -side right -expand true
                }
            }
        }

        ttk::style layout TCheckbutton {
            Checkbutton.button -children {
                Checkbutton.padding -children {
                    Checkbutton.indicator -side left
                    Checkbutton.label -side right -expand true
                }
            }
        }

        ttk::style layout TRadiobutton {
            Radiobutton.button -children {
                Radiobutton.padding -children {
                    Radiobutton.indicator -side left
                    Radiobutton.label -side right -expand true
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

        ttk::style layout TCombobox {
            Combobox.field -children {
                Combobox.downarrow -side right -sticky {}
                Combobox.padding -expand 1 -children {
                    Combobox.textarea
                }
            }
        }

        ttk::style layout TSpinbox {
            Spinbox.field -children {
                null -side right -children {
                	Spinbox.uparrow -side top -sticky e
                	Spinbox.downarrow -side bottom -sticky s
                }
                Spinbox.padding -expand 0 -children {
                    Spinbox.textarea
                }
            }
        }

        ttk::style layout Horizontal.TSeparator {
            Horizontal.separator -sticky nswe
        }

        ttk::style layout Vertical.TSeparator {
            Vertical.separator -sticky nswe
        }

        ttk::style layout TLabelframe {
            Labelframe.border {
                Labelframe.padding -expand 1 -children {
                    Labelframe.label -side right
                }
            }
        }

        ttk::style layout TNotebook.Tab {
            Notebook.tab -children {
                Notebook.padding -side top -children {
                    Notebook.label -side top -sticky {}
                }
            }
        }

        ttk::style layout Treeview.Item {
            Treeitem.padding -sticky nswe -children {
                Treeitem.indicator -side left -sticky {}
                Treeitem.image -side left -sticky {}
                Treeitem.text -side left -sticky {}
            }
        }

        # Button
        ttk::style configure TButton -padding 4 -width -10 -anchor center

        ttk::style element create Button.button \
            image [list $I(button-basic) \
                disabled $I(button-disabled) \
                pressed $I(button-pressed) \
                active $I(button-basic) \
            ] -border 4 -sticky news

        # Toolbutton
        ttk::style configure Toolbutton -padding 4 -width -10 -anchor center

        ttk::style element create Toolbutton.button \
            image [list $I(empty) \
                disabled $I(empty) \
                pressed $I(button-pressed) \
                active $I(button-pressed) \
            ] -border 4 -sticky news

        # Menubutton
        ttk::style configure TMenubutton -padding 4

        ttk::style element create Menubutton.button \
            image [list $I(button-basic) \
                disabled $I(button-disabled) \
                pressed $I(button-pressed) \
                active $I(button-basic) \
            ] -border 4 -sticky news

        ttk::style element create Menubutton.indicator image $I(arrow-down-basic) -width 25 -sticky e

        # OptionMenu
        ttk::style configure TOptionMenu -padding 4

        ttk::style element create OptionMenu.button \
            image [list $I(button-basic) \
                disabled $I(button-disabled) \
                pressed $I(button-pressed) \
                active $I(button-basic) \
            ] -border 4 -sticky news

        ttk::style element create OptionMenu.indicator image $I(arrow-down-basic) -width 25 -sticky e

        # Checkbutton
        ttk::style configure TCheckbutton -padding 4

        ttk::style element create Checkbutton.indicator \
            image [list $I(checkbox-basic) \
            	disabled $I(checkbox-basic) \
                {selected disabled} $I(checkbox-selected-dis) \
                {pressed selected} $I(checkbox-selected) \
                {active selected} $I(checkbox-selected) \
                selected $I(checkbox-selected) \
                {pressed !selected} $I(checkbox-basic) \
                active $I(checkbox-basic) \
            ] -width 20 -sticky w

        # Radiobutton
        ttk::style configure TRadiobutton -padding 4

        ttk::style element create Radiobutton.indicator \
            image [list $I(radio-basic) \
            	disabled $I(radio-basic) \
                {selected disabled} $I(radio-selected-dis) \
                {pressed selected} $I(radio-selected) \
                {active selected} $I(radio-selected) \
                selected $I(radio-selected) \
                {pressed !selected} $I(radio-basic) \
                active $I(radio-basic) \
            ] -width 20 -sticky w

        # Scrollbar
        ttk::style element create Horizontal.Scrollbar.trough image $I(scrollbar-hor-trough) \
        	-border 2 -sticky ew

        ttk::style element create Horizontal.Scrollbar.thumb \
             image [list $I(scrollbar-hor-gray) \
                disabled $I(scrollbar-hor-gray) \
                pressed $I(scrollbar-hor-orange) \
                active $I(scrollbar-hor-orange) \
            ] -border 1 -sticky ew

        ttk::style element create Vertical.Scrollbar.trough image $I(scrollbar-vert-trough) \
        	-border 2 -sticky ns

        ttk::style element create Vertical.Scrollbar.thumb \
            image [list $I(scrollbar-vert-gray) \
                disabled $I(scrollbar-vert-gray) \
                pressed $I(scrollbar-vert-orange) \
                active $I(scrollbar-vert-orange) \
            ] -border 1 -sticky ns

        # Scale
        ttk::style element create Horizontal.Scale.trough \
        	image [ list $I(scale-trough) \
        		disabled $I(scale-trough-disabled)
        	] -border 9 -padding 0

        ttk::style element create Horizontal.Scale.slider \
            image [list $I(scale-slider) \
                disabled $I(scale-slider) \
                pressed $I(scale-slider-hover) \
                active $I(scale-slider-hover) \
            ] -sticky news

        ttk::style element create Vertical.Scale.trough \
        	image [ list $I(scale-trough) \
        		disabled $I(scale-trough-disabled)
        	] -border 9 -padding 0

        ttk::style element create Vertical.Scale.slider \
            image [list $I(scale-slider) \
                disabled $I(scale-slider) \
                pressed $I(scale-slider-hover) \
                active $I(scale-slider-hover) \
            ] -sticky news

        # Progressbar
        ttk::style element create Horizontal.Progressbar.trough image $I(progressbar-trough-hor) \
            -border 2 -sticky ew

        ttk::style element create Horizontal.Progressbar.pbar image $I(progressbar-hor) \
            -border 2 -sticky ew

        ttk::style element create Vertical.Progressbar.trough image $I(progressbar-trough-hor) \
            -border 2 -sticky ns

        ttk::style element create Vertical.Progressbar.pbar image $I(progressbar-hor) \
            -border 2 -sticky ns

        # Entry
        ttk::style element create Entry.field \
            image [list $I(entry-basic) \
                {focus hover} $I(entry-focus) \
                invalid $I(entry-focus) \
                disabled $I(entry-disabled) \
                focus $I(entry-focus) \
                hover $I(entry-basic) \
            ] -border 4 -padding 8 -sticky news

        # Combobox
        ttk::style map TCombobox -selectbackground [list \
            {!focus} $colors(-selectbg) \
            {readonly hover} $colors(-selectbg) \
            {readonly focus} $colors(-selectbg)]

        ttk::style map TCombobox -selectforeground [list \
            {!focus} $colors(-selectfg) \
            {readonly hover} $colors(-selectfg) \
            {readonly focus} $colors(-selectfg)]

        ttk::style element create Combobox.field \
            image [list $I(entry-basic) \
                {readonly disabled} $I(button-disabled) \
                {readonly pressed} $I(button-pressed) \
                {readonly focus hover} $I(button-basic) \
                {readonly focus} $I(button-basic) \
                {readonly hover} $I(button-basic) \
                {focus hover} $I(entry-focus) \
                readonly $I(button-basic) \
                disabled $I(entry-disabled) \
                focus $I(entry-focus) \
                hover $I(entry-basic) \
            ] -border 4 -padding 8

        ttk::style element create Combobox.downarrow image $I(arrow-down-basic) \
        	-width 25 -sticky e

        # Spinbox
        ttk::style element create Spinbox.field \
            image [list $I(entry-basic) \
                disabled $I(entry-disabled) \
                focus $I(entry-focus) \
                hover $I(entry-basic) \
            ] -border 4 -padding 8 -sticky news

        ttk::style element create Spinbox.uparrow \
            image [list $I(arrow-up-basic) \
                disabled $I(arrow-up-hover) \
                pressed $I(arrow-up-hover) \
                active $I(arrow-up-hover) \
            ] -width 15 -sticky e

        ttk::style element create Spinbox.downarrow \
            image [list $I(arrow-down-basic) \
                disabled $I(arrow-down-hover) \
                pressed $I(arrow-down-hover) \
                active $I(arrow-down-hover) \
            ] -width 15 -sticky e

        # Sizegrip
        ttk::style element create Sizegrip.sizegrip image $I(sizegrip) \
        	-sticky news

        # Separator
        ttk::style element create Horizontal.separator image $I(separator)

        ttk::style element create Vertical.separator image $I(separator)

        # Labelframe
        ttk::style element create Labelframe.border image $I(checkbox-basic) \
            -border 4 -padding 4 -sticky news

        # Notebook
        ttk::style element create Notebook.client \
            image $I(checkbox-basic) -border 4

        ttk::style element create Notebook.tab \
            image [list $I(tab-basic) \
                selected $I(tab-current) \
                active $I(tab-hover) \
            ] -border 6 -padding {14 10} -sticky news

        # Treeview
        ttk::style element create Treeview.field image $I(checkbox-basic) \
            -border 4

        ttk::style element create Treeheading.cell \
            image [list $I(tree-basic) \
                pressed $I(tree-pressed)
            ] -border 10 -padding 4 -sticky news

        ttk::style element create Treeitem.indicator \
            image [list $I(plus) \
                user2 $I(empty) \
                user1 $I(minus) \
            ] -width 15 -sticky w

        ttk::style configure Treeview -background $colors(-bg)
        ttk::style configure Treeview.Item
        ttk::style map Treeview \
            -background [list selected $colors(-selectbg)] \
            -foreground [list selected $colors(-selectfg)]

        # Sashes
        ttk::style configure TPanedwindow \
            -width 1 -padding 0
        ttk::style map TPanedwindow \
            -background [list hover $colors(-bg)]
    }
}
