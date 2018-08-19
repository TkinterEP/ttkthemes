# Theme Elegance
# Available under the BSD 2-clause like Tcl License, see LICENSE

# elegance.tcl, v0.1 - Copyright (c) Clearlooks authors:
#   Regents of the University of California, Sun Microsystems, Inc., Scriptics
#   Corporation, and other parties.

# v0.2, 19/08/2018 RedFantom
# Formatted as required by style guide
# Fix Menubutton.indicator arrow spacing
# Fix Notebook.Tab artifacts

namespace eval ::ttk::theme::elegance {

  package provide ttk::theme::elegance 0.2

  array set images [load_images elegance]
  array set colors {
    -frame      "#d8d8d8"
    -lighter    "#fcfcfc"
    -window     "#cdcdcd"
    -selectbg   "#3d3d3d"
    -selectfg   "#fcfcfc"
    -disabledfg "#747474"
  }

  ttk::style theme create elegance -settings {

    ttk::style configure . \
      -borderwidth 1 \
      -background $colors(-frame) \
      -troughcolor $colors(-lighter) \
      -selectbackground $colors(-selectbg) \
      -selectforeground $colors(-selectfg) \
      -fieldbackground $colors(-window) \
      -font TkDefaultFont
    ttk::style map . -foreground [list disabled $colors(-disabledfg)]

    # Button
    #
    ttk::style layout TButton {
      Button.background
      Button.button -children {
        Button.focus -children {
          Button.label
        }
      }
    }
    ttk::style element create button image [list $images(button-default) \
      pressed $images(button-active)  \
      active $images(button-prelight) \
      disabled $images(button-active-disabled)   \
    ] -border 4 -sticky ew
    ttk::style configure TButton \
      -padding {10 6} \
      -anchor center

    # Checkbutton
    #
    ttk::style element create Checkbutton.indicator image \
      [list $images(check1) \
        selected $images(check2) \
      ] -width 20 -sticky w

    # Radiobutton
    #
    ttk::style element create Radiobutton.indicator image \
      [list $images(option1) \
        selected $images(option2) \
      ] -width 20 -sticky w

    # Menubutton
    #
    ttk::style layout TMenubutton {
      Menubutton.background
      Menubutton.button -children {
        Menubutton.focus -children {
          Menubutton.padding -children {
            Menubutton.label -side left -expand true
            Menubutton.indicator -side right
          }
        }
      }
    }
    ttk::style element create Menubutton.indicator image \
      [list $images(arrow-optionmenu) \
        {pressed !disabled} $images(arrow-optionmenu-prelight) \
        {active !disabled} $images(arrow-optionmenu-prelight) \
        disabled $images(arrow-optionmenu-disabled) \
      ] -padding {0 0 12 0} -sticky e

    # Entry
    #
    ttk::style element create Entry.field image \
      [list $images(entry-active) \
        focus $images(entry-inactive)
      ] -height 18 -border 2 -padding {3 4} -sticky nswe

    # Combobox
    #
    ttk::style element create Combobox.field image \
      [list $images(combo-active) \
        {readonly} $images(button-active) \
        {active}   $images(combo-active) \
      ] -border {9 10 32 15} -padding {9 4 8 4} -sticky nswe
    ttk::style element create Combobox.downarrow image \
      [list $images(stepper-down) \
        disabled $images(stepper-down)
      ] -sticky e -border {15 0 0 0}

    # Notebook elements
    #
    ttk::style element create tab image \
      [list $images(tab-top) \
        selected $images(tab-top-active) \
        active $images(tab-top-active) \
      ] -border {3 3 3 0} -padding {6 3} -height 12

    ttk::style configure TNotebook -tabmargins {0 3 0 0}
    ttk::style map TNotebook.Tab \
      -expand [list selected {0 3 2 2} !selected {0 0 2}]

    # Scrollbars
    #
    ttk::style layout Horizontal.TScrollbar {
      Horizontal.Scrollbar.trough -sticky ew -children {
        Scrollbar.leftarrow -side left -sticky {}
        Scrollbar.rightarrow -side right -sticky {}
        Horizontal.Scrollbar.thumb -side left -expand true -sticky we -children {
          Horizontal.Scrollbar.grip -sticky {}
        }
      }
    }
    ttk::style element create Horizontal.Scrollbar.thumb image \
      [list $images(slider-horiz) \
        {pressed !disabled} $images(slider-horiz-prelight) \
      ] -border {1 0} -width 32 -height 16 -sticky nswe
    ttk::style element create Horizontal.Scrollbar.grip image \
      [list $images(grip-horiz) \
        {pressed !disabled} $images(grip-horiz-prelight)]
    ttk::style element create Horizontal.Scrollbar.trough image \
      $images(trough-scrollbar-horiz) -border 2 -padding 0 -width 32 -height 15
    ttk::style element create rightarrow image \
      [list $images(stepper-right) \
        {pressed !disabled} $images(stepper-right-prelight)]
    ttk::style element create leftarrow image \
      [list $images(stepper-left) \
        {pressed !disabled} $images(stepper-left-prelight)]

    ttk::style layout Vertical.TScrollbar {
      Scrollbar.background
      Vertical.Scrollbar.trough -children {
        Scrollbar.uparrow -side top -sticky {}
        Scrollbar.downarrow -side bottom -sticky {}
        Vertical.Scrollbar.thumb -side top -expand true -sticky ns -children {
          Vertical.Scrollbar.grip -sticky {}
        }
      }
    }
    ttk::style element create Vertical.Scrollbar.thumb image \
      [list $images(slider-vert) \
        {pressed !disabled} $images(slider-vert-prelight)
      ] -border {0 1} -width 15 -height 32 -sticky nswe
    ttk::style element create Vertical.Scrollbar.grip image \
      [list $images(grip-vert) \
        {pressed !disabled} $images(grip-vert-prelight)]
    ttk::style element create uparrow image \
      [list $images(stepper-up) \
        {pressed !disabled} $images(stepper-up-prelight)]
    ttk::style element create downarrow image \
      [list $images(stepper-down) \
        {pressed !disabled} $images(stepper-down-prelight)]
    ttk::style element create Vertical.Scrollbar.trough image \
      $images(trough-scrollbar-vert) -border 2 -padding 0 -width 15 -height 64

    # Progressbars
    #
    ttk::style element create Horizontal.Progressbar.trough \
      image $images(trough-progressbar-horiz) -border 3
    ttk::style element create Vertical.Progressbar.trough \
      image $images(trough-progressbar-vert) -border 3
    ttk::style element create Horizontal.Progressbar.pbar \
      image $images(progressbar-horiz) -border {2 9}
    ttk::style element create Vertical.Progressbar.pbar \
      image $images(progressbar-vert) -border {9 2}

    # Scales
    #
    ttk::style element create Scale.slider image \
      [list $images(scale) \
        pressed $images(scale-prelight) \
      ] -border 3
    ttk::style element create Horizontal.Scale.trough image \
      $images(trough-horiz) -border {6 1 7 0} -padding 0 -sticky wes
    ttk::style element create Vertical.Scale.trough image \
      $images(trough-vert) -border {1 6 0 7} -padding 0 -sticky nes

    # Treeview
    #
    ttk::style element create Treeheading.cell image \
      [list $images(list-header) \
        pressed $images(list-header-prelight)
      ] -border {4 10} -padding 4 -sticky ewns
    ttk::style map Treeview \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
  }
}
