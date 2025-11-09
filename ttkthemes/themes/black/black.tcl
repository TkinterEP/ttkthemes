# black.tcl -
#
#  Copyright (c) 2007-2008 Mats Bengtsson
#
# $Id: black.tcl,v 1.2 2009/10/25 19:21:30 oberdorfer Exp $

package require Tk 8.6-


namespace eval ttk {
  namespace eval theme {
    namespace eval black {
      variable version 0.1
    }
  }
}

namespace eval ttk::theme::black {
  variable dir [file dirname [info script]]

  variable colors
  array set colors {
    -disabledfg	"DarkGrey"
    -frame  	"#424242"
    -dark	    "#222222"
    -darker 	"#121212"
    -darkest	"black"
    -light	    "#626262"
    -lighter    "#a9a9a9"
    -lightest 	"white"
    -selectbg	"#4a6984"
    -selectfg	"white"
  }

  if {[info commands ::ttk::style] ne ""} {
    set styleCmd ttk::style
  } else {
    set styleCmd style
  }

  $styleCmd theme create black -parent clam -settings {

    # -----------------------------------------------------------------
    # Theme defaults
    #
    $styleCmd configure "." \
        -background $colors(-frame) \
        -foreground $colors(-lightest) \
        -bordercolor $colors(-darkest) \
        -darkcolor $colors(-dark) \
        -lightcolor $colors(-light) \
        -troughcolor $colors(-darker) \
        -selectbackground $colors(-selectbg) \
        -selectforeground $colors(-selectfg) \
        -selectborderwidth 0 \
        -arrowcolor $colors(-lighter) \
        -indicatorbackground $colors(-lighter) \
        -insertcolor $colors(-lightest) \
        -font TkDefaultFont

    $styleCmd map "." \
        -background [list disabled $colors(-frame) active $colors(-light)] \
        -foreground [list disabled $colors(-disabledfg)] \
        -selectbackground [list !focus $colors(-darkest)] \
        -selectforeground [list !focus white]

    # ttk widgets.
    $styleCmd configure TButton -width -8 -padding {5 2} -relief raised
    $styleCmd configure Toolbutton -width -8 -padding {5 2}
    $styleCmd configure TMenubutton -width -11 -padding {5 2} -relief raised

    $styleCmd configure TCheckbutton -indicatormargin {1 1 4 1}
    $styleCmd configure TRadiobutton -indicatormargin {1 1 4 1}

    $styleCmd configure TEntry \
        -fieldbackground $colors(-light) -foreground $colors(-lightest) \
        -padding 4
    $styleCmd configure TCombobox \
        -fieldbackground $colors(-light) -foreground $colors(-lightest) \
        -padding 4
    $styleCmd configure TSpinbox \
        -fieldbackground $colors(-light) -foreground $colors(-lightest) \
        -padding 4

    $styleCmd configure TNotebook.Tab -padding {6 2 6 2}
    $styleCmd map TNotebook.Tab -background [list selected $colors(-light)]

    $styleCmd configure TreeCtrl \
        -background gray30 -itembackground {gray60 gray50} \
        -itemfill white -itemaccentfill yellow

    $styleCmd map Treeview \
        -background [list selected $colors(-selectbg)] \
        -foreground [list selected $colors(-selectfg)]

    $styleCmd configure Treeview -fieldbackground $colors(-frame)

    # tk widgets.
    $styleCmd map Menu \
        -background [list active $colors(-light)] \
        -foreground [list disabled $colors(-disabledfg)]
  }
}

# A few tricks for Tablelist.

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

package provide ttk::theme::black $::ttk::theme::black::version
