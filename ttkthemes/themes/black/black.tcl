# Theme Black
# Available under the BSD 2-clause like Tcl License

# black.tcl, v1.2 - Copyright (c) 2007-2008 Mats Bengtsson

namespace eval ttk::theme::black {

  package provide ttk::theme::black 0.1

  variable colors
  array set colors {
    -disabledfg	"DarkGrey"
    -frame  	"#424242"
    -dark	    "#222222"
    -darker 	"#121212"
    -darkest	"black"
    -lighter	"#626262"
    -lightest 	"#ffffff"
    -selectbg	"#4a6984"
    -selectfg	"#ffffff"
  }

  variable dir [file dirname [info script]]

  ttk::style theme create black -parent clam -settings {

    ttk::style configure . \
        -background $colors(-frame) \
        -foreground white \
        -bordercolor $colors(-darkest) \
        -darkcolor $colors(-dark) \
        -lightcolor $colors(-lighter) \
        -troughcolor $colors(-darker) \
        -selectbackground $colors(-selectbg) \
        -selectforeground $colors(-selectfg) \
        -selectborderwidth 0 \
        -font TkDefaultFont

    ttk::style map . \
      -background [list \
        disabled $colors(-frame) \
        active $colors(-lighter)] \
      -foreground [list disabled $colors(-disabledfg)] \
      -selectbackground [list !focus $colors(-darkest)] \
      -selectforeground [list !focus white]

    ## Buttons
    #
    ttk::style configure TButton \
      -width -8 -padding {5 1} -relief raised
    ttk::style configure TMenubutton \
      -width -11 -padding {5 1} -relief raised
    ttk::style configure TCheckbutton \
      -indicatorbackground $colors(-selectfg) \
      -indicatormargin {1 1 4 1}
    ttk::style configure TRadiobutton \
      -indicatorbackground $colors(-selectfg) \
      -indicatormargin {1 1 4 1}

    ## Entries
    #
    ttk::style configure TEntry \
      -fieldbackground white \
      -foreground black \
      -padding {2 0}
    ttk::style configure TCombobox \
      -fieldbackground white \
      -foreground black \
      -padding {2 0}

    ## Notebook
    #
    ttk::style configure TNotebook.Tab \
      -padding {6 2 6 2}

    ## Menu
    #
    ttk::style map Menu \
      -background [list active $colors(-lighter)] \
      -foreground [list disabled $colors(-disabledfg)]

    ## TreeCtrl
    # TreeCtrl is a special third-party widget for Tk
    ttk::style configure TreeCtrl \
      -background gray30 \
      -itembackground {gray60 gray50} \
      -itemfill white \
      -itemaccentfill yellow

    ## Treeview
    #
    ttk::style map Treeview \
      -background [list selected $colors(-selectbg)] \
      -foreground [list selected $colors(-selectfg)]

    ttk::style configure Treeview -fieldbackground $colors(-lighter)
  }
}

## TableList
# TableList is a special third-party widget for Tk
namespace eval ::tablelist:: {

  proc blackTheme {} {
    variable themeDefaults

    array set colors [array get ttk::theme::black::colors]

    array set themeDefaults [list \
      -background	  "Black" \
      -foreground	  "White" \
      -disabledforeground $colors(-disabledfg) \
      -stripebackground	  "#191919" \
      -selectbackground	  "#4a6984" \
      -selectforeground	  "DarkRed" \
      -selectborderwidth 0 \
      -font		TkTextFont \
      -labelbackground	$colors(-frame) \
      -labeldisabledBg	"#dcdad5" \
      -labelactiveBg	"#eeebe7" \
      -labelpressedBg	"#eeebe7" \
      -labelforeground	white \
      -labeldisabledFg	"#999999" \
      -labelactiveFg	white \
      -labelpressedFg	white \
      -labelfont	TkDefaultFont \
      -labelborderwidth	2 \
      -labelpady	1 \
      -arrowcolor	"" \
      -arrowstyle	sunken10x9 \
    ]
  }
}
