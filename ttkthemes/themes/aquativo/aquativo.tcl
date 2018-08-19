# Theme Aquativo
# Available under the BSD-like 2-clause Tcl License, see LICENSE

# aquativo.tcl, v0.2 - Copyright (C) 2004 Pat Thoyts <patthoyts@users.sourceforge.net>

# v0.2, 2018/08/19 RedFantom
# Modified to use image files instead of base64 encoded texts
# Reformatted according to style guide


namespace eval ttk::theme::aquativo {

  package provide ttk::theme::aquativo 0.2

  variable images
  array set images [load_images aquativo]

  ttk::style theme create aquativo -settings {

    ttk::style configure . \
        -font TkDefaultFont \
        -background "#fafafa" \
        -foreground "Black"

    ttk::style map . \
        -foreground { disabled "#565248" } \
        -background { \
          disabled "#e3e1dd"
          pressed  "#bab5ab"
          active   "#c1d2ee"
        }

    # Panedwindow parts

    ttk::style element create hsash \
            image $images(hseparator) -border {2 0}
    ttk::style element create vsash \
            image $images(vseparator) -border {0 2}

    # Buttons
    #
    ttk::style layout TButton {
      Button.background
      Button.button -children {
        Button.focus -children {
          Button.label
        }
      }
    }
    ttk::style element create Button.button image \
        [list $images(buttonNorm) \
          pressed $images(buttonPressed) active $images(buttonPressed)] \
        -border {4 4} -padding 3 -sticky nswe

    ttk::style element create Checkbutton.indicator image \
        [list $images(checkbox_unchecked) selected $images(checkbox_checked)] \
        -width 20 -sticky w
    ttk::style element create Radiobutton.indicator image \
        [list $images(option_out) selected $images(option_in)] \
        -width 20 -sticky w

    # Menubuttons
    #
    ttk::style element create Menubutton.button image \
        [list $images(menubar_option) ] \
        -border {7 10 29 15} \
        -padding {7 4 29 4} \
        -sticky news
    ttk::style element create Menubutton.indicator image \
        [list $images(menubar_option_arrow) \
          disabled $images(menubar_option_arrow_insensitive)
        ] -width 11 -sticky w -padding {0 0 18 0}

    # Scrollbars
    #
    ttk::style element create Horizontal.Scrollbar.trough \
        image $images(horizontal_trough) \
        -width 16 -border 0 -sticky ew

    ttk::style element create Vertical.Scrollbar.trough \
        image $images(vertical_trough) \
        -height 16 -border 0 -sticky ns

    ttk::style element create Horizontal.Scrollbar.thumb image \
      [list $images(scrollbar_horizontal) \
        {active !disabled} $images(scrollbar_horizontal) \
        disabled  $images(horizontal_trough) \
      ] -border 7 -width 16 -height 0 -sticky nswe

    ttk::style element create Vertical.Scrollbar.thumb image \
      [list $images(scrollbar_vertical) \
        {active !disabled}  $images(scrollbar_vertical) \
        disabled $images(vertical_trough) \
      ] -border 7 -width 0 -height 16 -sticky nswe

    # Scales
    #
    ttk::style element create Horizontal.Scale.trough \
      image $images(horizontal_trough) -border 0
    ttk::style element create Vertical.Scale.trough \
      image $images(vertical_trough) -border 0
    ttk::style element create Horizontal.Scale.slider \
      image $images(scrollbar_horizontal) \
      -border 3 -width 30 -height 16
    ttk::style element create Vertical.Scale.slider \
      image $images(scrollbar_vertical) \
      -border 3 -width 16 -height 30

    # Progressbar
    #
    ttk::style element create Progress.bar image $images(progressbar)
    ttk::style element create Progress.trough \
      image $images(vertical_trough) -border 0

    # Arrows
    #
    ttk::style element create uparrow image \
        [list $images(arrow_up_normal) \
              pressed $images(arrow_up_active) \
              disabled $images(arrow_up_insensitive)] -width 12
    ttk::style element create downarrow image \
        [list $images(arrow_down_normal) \
              pressed $images(arrow_down_active) \
              disabled $images(arrow_down_insensitive)] -width 12
    ttk::style element create leftarrow image \
        [list $images(arrow_left_normal) \
              pressed $images(arrow_left_active) \
              disabled $images(arrow_left_insensitive)] -height 12
    ttk::style element create rightarrow image \
        [list $images(arrow_right_normal) \
              pressed $images(arrow_right_active) \
              disabled $images(arrow_right_insensitive)] -height 12

    # Notebook
    #
    ttk::style element create tab image \
        [list $images(notebook) \
          selected $images(notebook_active) \
          active   $images(notebook_inactive) \
          disabled $images(notebook_inactive) \
        ] -sticky news -border {10 2 10 2} -height 10
    ttk::style configure TNotebook.Tab -padding {2 2}
    ttk::style configure TNotebook -expandtab {2 2}

    # Labelframe
    #
    ttk::style configure TLabelframe -borderwidth 2 -relief groove

    # Treeview
    #
    ttk::style map Treeview \
        -background [list selected #85cafc] \
        -foreground [list selected #000000]
  }
}


## TableList
# TableList is a special third-party for Tk
namespace eval ::tablelist:: {
  proc aquativoTheme {} {
    variable themeDefaults
    array set themeDefaults [list \
      -background           white \
      -foreground           black \
      -disabledforeground   black \
      -stripebackground     #edf3fe \
      -selectbackground     #000000 \
      -selectforeground     #ffffff \
      -selectborderwidth    0 \
      -font                 TkTextFont \
      -labelbackground      #fafafa \
      -labeldisabledBg      #fafafa \
      -labelactiveBg        #fafafa \
      -labelpressedBg       #fafafa \
      -labelforeground      black \
      -labeldisabledFg      black \
      -labelactiveFg        black \
      -labelpressedFg       black \
      -labelfont            TkDefaultFont \
      -labelborderwidth     2 \
      -labelpady            1 \
      -arrowcolor           #777777 \
      -arrowstyle           flat7x7 \
      -showseparators       yes \
    ]
  }
}
