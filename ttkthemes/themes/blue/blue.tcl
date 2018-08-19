# Theme Blue
# Available under the BSD 2-clause like Tcl License, see LICENSE

# blue.tcl, v0.7 - Copyright (C) 2004 Pat Thoyts
#   <patthoyts@users.sourceforge.net>

# v0.7, 19/08/2018 RedFantom
# Reformatted to comply with style guide and use proc load_images

namespace eval ttk::theme::blue {

  package provide ttk::theme::blue 0.7

  array set images [load_images blue]
  array set colors {
    -frame       "#6699cc"
    -lighter     "#bcd2e8"
    -window      "#e6f3ff"
    -selectbg    "#2d2d66"
    -selectfg    "#ffffff"
    -disabledfg  "#666666"
  }

  ttk::style theme create blue -settings {

    ttk::style configure . \
        -borderwidth         1 \
        -background         $colors(-frame) \
        -fieldbackground    $colors(-window) \
        -troughcolor        $colors(-lighter) \
        -selectbackground    $colors(-selectbg) \
        -selectforeground    $colors(-selectfg)

    ttk::style map . -foreground [list disabled $colors(-disabledfg)]

    ## Buttons
    #
    ttk::style configure TButton -padding "10 0"
    ttk::style layout TButton {
        Button.button -children {
        Button.focus -children {
            Button.padding -children {
            Button.label
            }
        }
        }
    }
    ttk::style element create Button.button image [list $images(button-n) \
        pressed $images(button-p) \
        active $images(button-h)  \
        ] -border 4 -sticky ew
    ttk::style element create Checkbutton.indicator image [list $images(check-nu) \
        {!disabled active selected} $images(check-hc) \
        {!disabled active} $images(check-hu) \
        {!disabled selected} $images(check-nc) ] \
        -width 24 -sticky w
    ttk::style element create Radiobutton.indicator image [list $images(radio-nu) \
        {!disabled active selected} $images(radio-hc) \
        {!disabled active} $images(radio-hu) \
        selected $images(radio-nc) ] \
        -width 24 -sticky w
    ttk::style configure TMenubutton -relief raised -padding {10 2}

    ## Toolbar buttons
    #
    ttk::style configure Toolbutton \
        -width 0 \
        -relief flat \
        -borderwidth 2 \
        -padding 4 \
        -background $colors(-frame) -foreground #000000 ;
    ttk::style map Toolbutton \
      -background [list active $colors(-selectbg)] \
      -foreground [list active $colors(-selectfg)] \
      -relief {
        disabled    lat
        selected    sunken
        pressed     sunken
        active      raised
      }

    ## Entry
    #
    ttk::style configure TEntry \
        -selectborderwidth 1 \
        -padding 2 \
        -insertwidth 2 \
        -font TkTextFont
    ttk::style configure TCombobox \
        -selectborderwidth 1 \
        -padding 2 \
        -insertwidth 2 \
        -font TkTextFont

    ## Notebooks.
    #
    ttk::style configure TNotebook.Tab -padding {4 2 4 2}
    ttk::style map TNotebook.Tab \
        -background [list selected $colors(-frame) active $colors(-lighter)] \
        -padding [list selected {4 4 4 2}]

    ## Labelframe
    #
    ttk::style configure TLabelframe -borderwidth 2 -relief groove

    ## Scrollbars
    #
    ttk::style layout Vertical.TScrollbar {
        Scrollbar.trough -children {
        Scrollbar.uparrow -side top
        Scrollbar.downarrow -side bottom
        Scrollbar.uparrow -side bottom
        Vertical.Scrollbar.thumb -side top -expand true -sticky ns
        }
    }
    ttk::style layout Horizontal.TScrollbar {
        Scrollbar.trough -children {
        Scrollbar.leftarrow -side left
        Scrollbar.rightarrow -side right
        Scrollbar.leftarrow -side right
        Horizontal.Scrollbar.thumb -side left -expand true -sticky we
        }
    }
    ttk::style element create Horizontal.Scrollbar.thumb image \
        [list $images(sb-thumb) \
            {pressed !disabled} $images(sb-thumb-p)\
        ] -border 3
    ttk::style element create Vertical.Scrollbar.thumb image \
        [list $images(sb-vthumb) \
            {pressed !disabled} $images(sb-vthumb-p)\
        ] -border 3

    ## Arrows
    #
    foreach dir {up down left right} {
        ttk::style element create ${dir}arrow image \
          [list $images(arrow${dir}) \
            disabled $images(arrow${dir}) \
            pressed $images(arrow${dir}-p) \
            active $images(arrow${dir}-h)
          ] -border 1 -sticky {}
    }

    ## Scales
    #
    ttk::style element create Scale.slider image \
      [list $images(slider) \
        {pressed !disabled} $images(slider-p)]

    ttk::style element create Vertical.Scale.slider image \
      [list $images(vslider) \
        {pressed !disabled} $images(vslider-p)]

    ttk::style element create Horizontal.Progress.bar \
        image $images(sb-thumb) -border 2
    ttk::style element create Vertical.Progress.bar \
        image $images(sb-vthumb) -border 2

    # Treeview
    ttk::style map Treeview \
        -background [list selected $colors(-selectbg)] \
        -foreground [list selected $colors(-selectfg)]
    ttk::style configure Treeview -fieldbackground $colors(-window)
  }

}

