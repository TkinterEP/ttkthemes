# ttk-themes
A group of themes for the ttk extenstions for Tkinter gathered together by RedFantom and 
created by various authors.

![Tcl/Tk logo](https://www.gsfparser.tk/wp-content/uploads/2017/03/Tcl.Tk_.png)

## Themes
  
- aquativo

  An Apple-style like theme by Pat Thoyts, created in 2004. The original site is listed to 
  be `http://www.fewt.com`, but you will only be able to view this site using the
  Internet archive's Wayback machine. It appears the theme is related to the Ubuntu-based
  Linux distribution [Fuduntu](https://en.wikipedia.org/wiki/Fuduntu).
  
- arc
  
  The newest theme of the bunch. Being created by Sergei Golovan in 2015 this theme
  requires Tk 8.6.0 in order to load. This is because the theme uses PNG images with
  transparency, making for a blue-tinted modern look and feel.
  
- elegance
  
  A theme that appears to be created by the Tcl/Tk developers team. While attempts to
  tracing its exact origin have been unsuccessful so far, this theme was probably created
  around 2008. The theme can be found 
  [here](https://www.gnome-look.org/content/show.php/Blue+Elegance+Light?content=164806), but
  no author is listed.
  
- blue
  
  A theme that does live up to its name. This theme will burn your eyes out being so bright.
  Everything is blue, though in some widgets there is a nice color gradient. This theme was
  also created by Pat Thoyts in 2004.
  
- clearlooks
  
  This theme was created by the Tcl/Tk developers team as a demo for what bitmap themes can do.
  The light tints move toward peach colors, giving this theme a feminine look. It still looks
  sleek and modern, and wouldn't be a bad choice. Just as with all themes though, the corners
  are rounded.
  
- keramik and keramik_alt
  
  These two themes use a single file `keramik.tcl` and the differences between them are fairly
  limited. Originally developed by Pat Thoyts in 2004. These themes look the opposite of modern.
  They are futuristic, but in a bit of a wrong way. Keramic_alt uses a different color scrollbar
  element, namely silver instead of dark blue.
  
- kroc
  
  This orange theme by David Zolli is busy on the eyes and has a wood-like grain in the Button
  widgets. Not a recommended choice for modern UI development.
  
- plastik
  
  A nice looking theme created by Pat Thoyts in 2005. While not bolstering the most distinctive
  features, it looks quite modern. Performance suffers heavily though, this is resolved by
  commenting out line 193 of the `plastik.tcl` file. The theme changes only slightly because
  of this change, but native performance is restored.
  
- radiance
  
  A theme that was developed by the Tcl/Tk developers team. This theme, as the name suggests,
  boasts the native look of Ubuntu's radiance theme, making for a good choice  when targeting
  this platform. Large Progressbar widgets (namely in height) may look a bit mutated, so try
  sticking to the normal Progressbar height.

- winxpblue  
  
  A theme that tries to imitate the Windows XP look and feel created by Pat Thoyts in 2004. Not
  recommended, even for Windows XP applications.
  
## Recommendations
The themes `plastik`, `clearlooks` and `elegance` are recommended to make your UI look nicer
on all platforms when using `Tkinter` and the `ttk` extensions in Python. When you are targeting
Ubuntu, consider using the great `radiance` theme.
