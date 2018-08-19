# Theme Clearlooks
# Available under the BSD 2-clause like Tcl License, see LICENSE

# clearlooks.tcl, v0.2 - Copyright (c) Clearlooks authors:
#   Regents of the University of California, Sun Microsystems, Inc., Scriptics
#   Corporation, and other parties.

# v0.2, 19/08/2018 RedFantom
# Formatted as required by style guide, use proc load_images, Fix Notebook
# TODO: Check Menubutton configuration

namespace eval ttk::theme::clearlooks {

  package provide ttk::theme::clearlooks 0.1

  array set images [load_images clearlooks]
  array set colors {
    -frame          "#efebe7"
    -lighter        "#f5f3f0"
    -dark           "#cfcdc8"
    -darker         "#9e9a9e"
    -darkest        "#d4cfca"
    -selectbg       "#7c99ad"
    -selectfg       "#ffffff"
    -disabledfg     "#b5b3ac"
    -entryfocus     "#6f9dc6"
    -tabbg          "#c9c1bc"
    -tabborder      "#b5aca7"
    -troughcolor    "#d7cbbe"
    -troughborder   "#ae9e8e"
    -checklight     "#f5f3f0"
  }


  ttk::style theme create clearlooks -parent clam -settings {

    ttk::style configure . \
      -borderwidth        1 \
      -background         $colors(-frame) \
      -foreground         black \
      -bordercolor        $colors(-darkest) \
      -darkcolor          $colors(-dark) \
      -lightcolor         $colors(-lighter) \
      -troughcolor        $colors(-troughcolor) \
      -selectforeground   $colors(-selectfg) \
      -selectbackground   $colors(-selectbg) \
      -font               TkDefaultFont

    ttk::style map . \
      -background [list \
        disabled $colors(-frame) \
        active $colors(-lighter)] \
      -foreground [list disabled $colors(-disabledfg)] \
      -selectbackground [list !focus $colors(-darker)] \
      -selectforeground [list !focus white]

    ## Treeview
    #
    ttk::style element create Treeheading.cell image \
      [list $images(tree-n) \
        selected $images(tree-p) \
        disabled $images(tree-d) \
        pressed $images(tree-p) \
        active $images(tree-h) \
      ] -border 4 -sticky ew
    ttk::style configure Row -background "#efefef"
    ttk::style map Row -background [list \
      {focus selected} "#71869e" \
      selected "#969286" \
      alternate white \
    ]
    ttk::style map Item -foreground [list selected white]
    ttk::style map Cell -foreground [list selected white]

    ## Button
    #
    ttk::style configure TButton -padding {10 0}
    ttk::style layout TButton {
    Button.button -children {
        Button.focus -children {
          Button.padding -children {
            Button.label
          }
        }
      }
    }
    ttk::style element create Button.button image \
      [list $images(button-n) \
        pressed $images(button-p) \
        {selected active} $images(button-pa) \
        selected $images(button-p) \
        active $images(button-a) \
        disabled $images(button-d) \
      ] -border {3 4 3 4} -sticky nswe

    ## Checkbutton
    #
    ttk::style element create Checkbutton.indicator image \
      [list $images(check-nu) \
        {disabled selected} $images(check-dc) \
        disabled $images(check-du) \
        {pressed selected} $images(check-pc) \
        pressed $images(check-pu) \
        {active selected} $images(check-ac) \
        active $images(check-au) \
        selected $images(check-nc) \
      ] -width 24 -sticky w
    ttk::style map TCheckbutton -background [list active $colors(-checklight)]
    ttk::style configure TCheckbutton -padding 1

    ## Radiobutton
    #
    ttk::style element create Radiobutton.indicator image \
      [list $images(radio-nu) \
        {disabled selected} $images(radio-dc) \
        disabled $images(radio-du) \
        {pressed selected} $images(radio-pc) \
        pressed $images(radio-pu) \
        {active selected} $images(radio-ac) \
        active $images(radio-au) \
        selected $images(radio-nc) \
      ] -width 24 -sticky w
    ttk::style map TRadiobutton -background [list active $colors(-checklight)]
    ttk::style configure TRadiobutton -padding 1

    ## Menubutton
    #
    ttk::style configure TMenubutton -relief raised -padding {10 2}
    ttk::style element create Menubutton.border image \
      [list $images(toolbutton-n) \
        pressed $images(toolbutton-p) \
        selected $images(toolbutton-p) \
        active $images(toolbutton-a) \
        disabled $images(toolbutton-n) \
      ] -border {4 7 4 7} -sticky nsew

    ## Toolbar buttons
    #
    ttk::style configure Toolbutton -padding -5 -relief flat
    ttk::style configure Toolbutton.label -padding 0 -relief flat
    ttk::style element create Toolbutton.border image \
      [list $images(blank) \
        pressed $images(toolbutton-p) \
        {selected active} $images(toolbutton-pa) \
        selected $images(toolbutton-p) \
        active $images(toolbutton-a) \
        disabled $images(blank) \
      ] -border 11 -sticky nsew

    ## Entry
    #
    ttk::style configure TEntry \
      -padding 1 \
      -insertwidth 1 \
      -fieldbackground white
    ttk::style map TEntry \
        -fieldbackground [list readonly $colors(-frame)] \
        -bordercolor [list focus $colors(-selectbg)] \
        -lightcolor [list focus $colors(-entryfocus)] \
        -darkcolor [list focus $colors(-entryfocus)]

    ## Combobox
    #
    ttk::style configure TCombobox -selectbackground $colors(-selectfg)
    ttk::style element create Combobox.downarrow image \
      [list $images(comboarrow-n) \
        disabled $images(comboarrow-d) \
        pressed $images(comboarrow-p) \
        active $images(comboarrow-a) \
      ] -border 1

    ttk::style element create Combobox.field image \
      [list $images(combo-n) \
        {readonly disabled} $images(combo-rd) \
        {readonly pressed} $images(combo-rp) \
        {readonly focus} $images(combo-rf) \
        readonly $images(combo-rn) \
      ] -border 4 -sticky ew

    ## Notebooks
    #
    ttk::style element create tab image \
      [list $images(tab-a) \
        selected $images(tab-n) \
      ] -border {3 4 3 4}
    ttk::style configure TNotebook.Tab -padding {6 2 6 2}
    ttk::style map TNotebook.Tab \
      -padding [list selected {6 4 6 2}] \
      -background [list selected $colors(-frame) {} $colors(-tabbg)] \
      -lightcolor [list selected $colors(-lighter) {} $colors(-dark)] \
      -bordercolor [list selected $colors(-darkest) {} $colors(-tabborder)]

    ## Labelframes
    #
    ttk::style configure TLabelframe -borderwidth 2 -relief groove


    ## Scrollbars
    #
    ttk::style layout Vertical.TScrollbar {
      Scrollbar.trough -sticky ns -children {
        Scrollbar.uparrow -side top
        Scrollbar.downarrow -side bottom
        Vertical.Scrollbar.thumb -side top -expand true -sticky ns
      }
    }
    ttk::style layout Horizontal.TScrollbar {
      Scrollbar.trough -sticky we -children {
        Scrollbar.leftarrow -side left
        Scrollbar.rightarrow -side right
        Horizontal.Scrollbar.thumb -side left -expand true -sticky we
      }
    }
    ttk::style element create Horizontal.Scrollbar.thumb image \
      [list $images(sbthumb-hn) \
        disabled $images(sbthumb-hd) \
        pressed $images(sbthumb-ha) \
        active $images(sbthumb-ha) \
      ] -border 3
    ttk::style element create Vertical.Scrollbar.thumb image \
        [list $images(sbthumb-vn) \
          disabled $images(sbthumb-vd) \
          pressed $images(sbthumb-va) \
          active $images(sbthumb-va) \
        ] -border 3

    ## Arrows
    #
    foreach dir {up down left right} {
      ttk::style element create ${dir}arrow image \
        [list $images(arrow${dir}-n) \
          disabled $images(arrow${dir}-d) \
          pressed $images(arrow${dir}-p) \
          active $images(arrow${dir}-a) \
        ] -border 1 -sticky {}
    }
    ttk::style configure TScrollbar -bordercolor $colors(-troughborder)

    ## Scales
    #
    ttk::style element create Scale.slider image \
      [list $images(scale-hn) \
        disabled $images(scale-hd) \
        active $images(scale-ha)]
    ttk::style element create Scale.trough image \
      $images(scaletrough-h) \
      -border 2 \
      -sticky ew \
      -padding 0

    ttk::style element create Vertical.Scale.slider image \
      [list $images(scale-vn) \
        disabled $images(scale-vd) \
        active $images(scale-va) \
      ]
    ttk::style element create Vertical.Scale.trough image \
      $images(scaletrough-v) \
      -border 2 \
      -sticky ns \
      -padding 0
    ttk::style configure TScale -bordercolor $colors(-troughborder)

    ## Progressbar
    #
    ttk::style element create Horizontal.Progressbar.pbar image \
      $images(progress-h) \
      -border {2 2 1 1}
    ttk::style element create Vertical.Progressbar.pbar image \
      $images(progress-v) \
      -border {2 2 1 1}
    ttk::style configure TProgressbar -bordercolor $colors(-troughborder)

    ## Statusbar parts
    #
    ttk::style element create sizegrip image $images(sizegrip)

    ## Panedwindow
    # TODO: Check these style elements
    # ttk::style element create hsash image $images(hseparator-n) -border {2 0} \
    #   -map [list {active !disabled} $images(hseparator-a)]
    # ttk::style element create vsash image $images(vseparator-n) -border {0 2} \
    #   -map [list {active !disabled} $images(vseparator-a)]
    ttk::style configure Sash -sashthickness 6 -gripcount 16

    ## Separator
    #
    ttk::style element create separator image $images(sep-h)
    ttk::style element create hseparator image $images(sep-h)
    ttk::style element create vseparator image $images(sep-v)

    ## Treeview
    #
    ttk::style map Treeview \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]
  }
}

