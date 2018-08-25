# Theme Clearlooks
# Available under the BSD 2-clause like Tcl License, see LICENSE

# keramik.tcl, v0.6.3 - Copyright (c) 2004 Pat Thoyts

# v0.6.3, 25/08/2018 RedFantom
# Reformatted according to style guide

namespace eval ttk::theme::keramik {

  variable version 0.6.3
  package provide ttk::theme::keramik $version

  array set colors {
    -frame      "#cccccc"
    -lighter    "#cccccc"
    -window     "#ffffff"
    -selectbg   "#0a5f89"
    -selectfg   "#ffffff"
    -disabledfg "#aaaaaa"
  }
  array set images [load_images keramik]

  ttk::style theme create keramik -parent alt -settings {

    ttk::style configure . \
      -borderwidth 1 \
      -background $colors(-frame) \
      -troughcolor $colors(-lighter) \
      -selectbackground $colors(-selectbg) \
      -selectforeground $colors(-selectfg) \
      -fieldbackground $colors(-window) \
      -font TkDefaultFont
    ttk::style map . -foreground [list disabled $colors(-disabledfg)]

    ## Buttons
    # - the button has a large rounded border and needs a bit of horizontal
    #   padding.
    # - the checkbutton and radiobutton have the focus drawn around the whole
    #   widget - hence the new layouts.
    ttk::style layout TButton {
      Button.background
      Button.button -children {
        Button.focus -children {
          Button.label
        }
      }
    }
    ttk::style layout Toolbutton {
      Toolbutton.background
      Toolbutton.button -children {
        Toolbutton.focus -children {
          Toolbutton.label
        }
      }
    }
    ttk::style element create button image \
      [list $images(button-n) \
        {pressed !disabled}  $images(button-p) \
        selected    $images(button-s) \
        {active !disabled}  $images(button-h) \
        disabled    $images(button-d) \
      ] -border {8 6 8 16} -padding {6 6} -sticky news
    ttk::style configure TButton -padding {10 6} -anchor center
    ttk::style element create Toolbutton.button image \
      [list $images(tbar-n) \
        {pressed !disabled}  $images(tbar-p) \
        selected    $images(tbar-p) \
        {active !disabled}  $images(tbar-a) \
      ] -border {2 9 2 18} -padding {2 2} -sticky news
    ttk::style configure Toolbutton -anchor center
    ttk::style element create Checkbutton.indicator image \
      [list $images(check-u) \
        selected $images(check-c) \
      ] -width 20 -sticky w
    ttk::style element create Radiobutton.indicator image \
      [list $images(radio-u) \
        selected $images(radio-c) \
      ] -width 20 -sticky w

    ## Menubutton
    # The layout for the menubutton is modified to have a button element
    # drawn on top of the background. This means we can have transparent
    # pixels in the button element. Also, the pixmap has a special
    # region on the right for the arrow. So we draw the indicator as a
    # sibling element to the button, and draw it after (ie on top of) the
    # button image.
    ttk::style layout TMenubutton {
      Menubutton.background
      Menubutton.button -children {
        Menubutton.focus -children {
          Menubutton.padding -children {
            Menubutton.label -side left -expand true
          }
        }
      }
      Menubutton.indicator -side right
    }
    ttk::style element create Menubutton.button image \
      [list $images(mbut-n) \
        {active !disabled} $images(mbut-a) \
        {pressed !disabled} $images(mbut-a) \
        {disabled} $images(mbut-d) \
      ] -border {7 10 29 15} -padding {7 4 29 4} -sticky news
    ttk::style element create Menubutton.indicator image \
      $images(mbut-arrow-n) -width 11 -sticky w -padding {0 0 18 0}

    ## Combobox
    #
    ttk::style element create Combobox.field image [list $images(cbox-n) \
      [list readonly disabled]  $images(mbut-d) \
        {readonly active}  $images(mbut-a) \
        readonly $images(mbut-n) \
        disabled $images(cbox-d) \
        active $images(cbox-a) \
      ] -border {9 10 32 15} -padding {9 4 8 4} -sticky news
    ttk::style element create Combobox.downarrow image $images(mbut-arrow-n) \
      -width 11 -sticky e -border {22 0 0 0}

    # Scrollbars
    # Scrollbar has three buttons, two at the bottom, one at the top
    ttk::style layout Vertical.TScrollbar {
      Scrollbar.background
      Vertical.Scrollbar.trough -children {
        Scrollbar.uparrow -side top
        Scrollbar.downarrow -side bottom
        Scrollbar.uparrow -side bottom
        Vertical.Scrollbar.thumb -side top -expand true -sticky ns
      }
    }
    ttk::style layout Horizontal.TScrollbar {
      Scrollbar.background
      Horizontal.Scrollbar.trough -children {
        Scrollbar.leftarrow -side left
        Scrollbar.rightarrow -side right
        Scrollbar.leftarrow -side right
        Horizontal.Scrollbar.thumb -side left -expand true -sticky we
      }
    }
    ttk::style element create Horizontal.Scrollbar.thumb image \
      [list $images(hsb-n) \
        {pressed !disabled} $images(hsb-p) \
      ] -border {6 4} -width 15 -height 16 -sticky news
    ttk::style element create Horizontal.Scrollbar.trough image $images(hsb-t)
    ttk::style element create Vertical.Scrollbar.thumb image \
      [list $images(vsb-n) \
        {pressed !disabled} $images(vsb-p) \
      ] -border {4 6} -width 16 -height 15 -sticky news
    ttk::style element create Vertical.Scrollbar.trough image $images(vsb-t)

    ## Scales
    #
    ttk::style element create Horizontal.Scale.slider image \
      $images(hslider-n) -border 3
    ttk::style element create Horizontal.Scale.trough image \
      $images(hslider-t) -border {6 1 7 0} -padding 0 -sticky wes
    ttk::style element create Vertical.Scale.slider image \
      $images(vslider-n) -border 3
    ttk::style element create Vertical.Scale.trough image \
      $images(vslider-t) -border {1 6 0 7} -padding 0 -sticky nes

    ## Progressbar
    #
    ttk::style element create Horizontal.Progressbar.pbar image \
      $images(progress-h) -border {1 1 6}
    ttk::style element create Vertical.Progressbar.pbar image \
      $images(progress-v) -border {1 6 1 1}

    ## Arrows
    #
    ttk::style element create uparrow image \
      [list $images(arrowup-n) \
        {pressed !disabled} $images(arrowup-p)]
    ttk::style element create downarrow image \
      [list $images(arrowdown-n) \
        {pressed !disabled} $images(arrowdown-p)]
    ttk::style element create rightarrow image \
      [list $images(arrowright-n) \
        {pressed !disabled} $images(arrowright-p)]
    ttk::style element create leftarrow image \
      [list $images(arrowleft-n) \
        {pressed !disabled} $images(arrowleft-p)]

    ## Notebook
    #
    ttk::style element create tab image \
      [list $images(tab-n) \
        selected $images(tab-p) \
        active $images(tab-p) \
      ] -border {6 6 6 4} -padding {6 3} -height 12
    ttk::style configure TNotebook -tabmargins {0 3 0 0}
    ttk::style map TNotebook.Tab \
      -expand [list selected {0 3 2 2} !selected {0 0 2}]

    ## LabelFrame
    #
    ttk::style configure TLabelframe \
      -borderwidth 2 \
      -relief groove

    ## Spinbox
    # Available since 8.6b1 and 8.5.9
    ttk::style layout TSpinbox {
      Spinbox.field -side top -sticky we -children {
        Spinbox.arrows -side right -sticky ns -children {
          null -side right -sticky {} -children {
            Spinbox.uparrow -side top -sticky w
            Spinbox.downarrow -side bottom -sticky w
          }
        }
        Spinbox.padding -sticky nswe -children {
          Spinbox.textarea -sticky nswe
        }
      }
    }
    ttk::style element create Spinbox.arrows image \
      $images(spinbox-a) -border {0 9} -padding 0
    ttk::style element create Spinbox.uparrow image \
      [list $images(spinup-n) \
        {pressed !disabled} $images(spinup-p)]
    ttk::style element create Spinbox.downarrow image \
      [list $images(spindown-n) \
        {pressed !disabled} $images(spindown-p)]

    ## Treeview
    # Available since 8.6b1 and 8.5.9
    ttk::style element create Treeheading.cell image \
      [list $images(tree-n) \
        pressed $images(tree-p) \
      ] -border {5 15 5 8} -padding 12 -sticky ewns
    ttk::style configure Treeview -background $colors(-window)
    ttk::style map Treeview \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
    # TODO: Check whether these settings are still required
    ttk::style configure Treeview.Row -background $colors(-window)
    ttk::style configure Row -background $colors(-window)
    ttk::style configure Cell -background $colors(-window)
    ttk::style map Row \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
        ttk::style map Cell \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
    ttk::style map Item \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
  }
}

namespace eval ttk::theme::keramik_alt {

  package provide ttk::theme::keramik_alt $ttk::theme::keramik::version

  array set colors {
    -frame      "#cccccc"
    -lighter    "#cccccc"
    -window     "#ffffff"
    -selectbg   "#0a5f89"
    -selectfg   "#ffffff"
    -disabledfg "#aaaaaa"
  }
  array set images [load_images keramik_alt]

  ttk::style theme create keramik_alt -parent keramik -settings {

    ttk::style configure . \
      -borderwidth 1 \
      -background $colors(-frame) \
      -troughcolor $colors(-lighter) \
      -selectbackground $colors(-selectbg) \
      -selectforeground $colors(-selectfg) \
      -fieldbackground $colors(-window) \
      -font TkDefaultFont
    ttk::style map . -foreground [list disabled $colors(-disabledfg)]

    ## Scrollbars
    # keramik_alt does not have the conspicuous highlighted scrollbars
    ttk::style element create Vertical.Scrollbar.thumb image \
      [list $images(vsb-a) \
        {pressed !disabled} $images(vsb-h) \
      ] -border {4 6} -width 16 -height 15 -sticky news
    ttk::style element create Horizontal.Scrollbar.thumb image \
      [list $images(hsb-a) \
        {pressed !disabled} $images(hsb-h) \
      ] -border {6 4} -width 15 -height 16 -sticky news

    ## Additional Settings
    # These settings do not appear to be copied from the parent theme
    ttk::style configure TButton -padding {10 6} -anchor center
    ttk::style configure Toolbutton -anchor center
    ttk::style configure TNotebook -tabmargins {0 3 0 0}
    ttk::style map TNotebook.Tab \
      -expand [list selected {0 3 2 2} !selected {0 0 2}]
    ttk::style configure TLabelframe -borderwidth 2 -relief groove

    ## Treeview
    #
    ttk::style configure Treeview -background $colors(-window)
    ttk::style map Treeview \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
    ttk::style configure Treeview -padding 0
    ttk::style configure Treeview.Row -background $colors(-window)
    ttk::style configure Row -background $colors(-window)
    ttk::style configure Cell -background $colors(-window)
    ttk::style map Row \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
    ttk::style map Cell \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
    ttk::style map Item \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
  }
}
