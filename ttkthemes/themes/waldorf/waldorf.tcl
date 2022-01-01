# CrunchBang-Waldorf pixmap theme for ttk

# Copyright (c) 2016 François Tonneau <francois.tonneau@gmail.com>

# The Waldorf theme has not been published in the ttkthemes package so far due to its unclear license.
# This theme is a derivative of the Chrunchbang Linux Gtk theme, created by Philip Newborough. He said any
# open source license could be used for it, but then considered that the theme might be a derivative of yet
# another theme. Hence, if the theme being derived from another theme is to be disregarded,
# which does not seem a crazy thing to do as the Crunchbang theme itself was widely distributed.
# GNU GPLv2 seems like the right license to use.

package require Tk

package provide ttk::theme::waldorf 0.1

namespace eval ttk::theme::waldorf {
}

ttk::style theme create waldorf -settings {

ttk::style configure "." \
    -background gray82 \
    -foreground black \
    -selectbackground gray35 \
    -selectforeground white \
    -troughcolor gray82 \
    -borderwidth 0 \
    -relief flat

#    -font TkDefaultFont

ttk::style map "." -foreground [list \
    {disabled} gray35
]

ttk::style map "." -background [list \
    {active} gray90 \
    {focus} gray79
]

# button: layout with new button image; focus removed

image create photo ttk::theme::waldorf::button -data {
R0lGODdhGwAbAPYAAJOTk5WVlZaWlpeXl5iYmJqamp6enp+fn6CgoKGhoaKioqOjo6SkpKWlpaam
pqioqKmpqaurq6ysrK2tra6urq+vr7GxsbKysrOzs7S0tLW1tba2tri4uLq6uru7u7y8vL29vb6+
vr+/v8DAwMHBwcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3Nzc/Pz9DQ0NHR0dLS
0tPT09TU1NXV1dbW1tfX19jY2NnZ2dvb29zc3N7e3t/f3+Dg4OHh4eLi4uPj4+Xl5ebm5ufn5+jo
6Onp6erq6uvr6+zs7O3t7e7u7u/v7/Hx8fPz8/T09PX19fb29gAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAAbABsAAAfvgH8eGYSFhoeIhCGCOU2Oj5CRko45IQFMmJmam5yaGQFLoaKjpKWj
n0qpqqusraufSbGys7S1s59Iubq7vL27n0fBwsPExcOfRsnKy8zNy59F0dLT1NXT0NbZ2p9E3d7f
4OHfn0Pl5ufo6eefQu3u7/Dx759B9fb3+Pn3n0D9/v8AA/779KOgwYMIEx785KOhw4cQIz781KOi
xYsYM178xKOjx48gQ378tKOkyZMoU578pKOly5cwY778lKOmzZs4c97McIAFjp9Agwod+nNGhgUW
bihdyrSpU6VHLSwIQLWq1atYqSL9k6irVw9/AgEAOw==
}

image create photo ttk::theme::waldorf::button_a -data {
R0lGODdhGwAbAPYAAJycnJ2dnZ+fn6CgoKGhoaSkpKampqenp6ioqKmpqaqqqqysrK2tra6urq+v
r7CwsLGxsbKysrOzs7S0tLW1tba2tri4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHBwcLCwsPD
w8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM3NzdHR0dLS0tbW1tvb29zc3N3d3d7e3t/f3+Dg
4OHh4eLi4uTk5Obm5ufn5+jo6Onp6erq6uzs7O3t7e7u7u/v7/Dw8PHx8fLy8vPz8/T09PX19fb2
9vf39/j4+Pn5+fr6+vv7+/z8/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOzs7AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAAbABsAAAfxgH8eg4SFhoeEJH8BNUmOj5CRko41HgFImJmam5yalkegoaKjpKKW
RqipqqusqpZFsLGys7SylkS4ubq7vLqWQ8DBwsPEwpZCyMnKy8zKlkHQ0dLT1NLP1djZlkDc3d7f
4N6WP+Tl5ufo5pY+7O3u7/Dulj309fb3+PaWPPz9/v8A/VnaQbCgwYMIDVrSwbChw4cQHVrKQbGi
xYsYLVrCwbGjx48gPVq6QbKkyZMoTVqywbKly5cwXVqqQbOmzZs4bVpyQaOnz59Ag/ac4UGBhhlI
kypdyhSpBgUQFASYSrWq1atTof6hwLWr169gvf4JBAA7
}

image create photo ttk::theme::waldorf::button_d -data {
R0lGODdhGwAbAPUAAKSkpKWlpaampqioqKqqqqurq62tra6urq+vr7CwsLGxsbKysrOzs7S0tLW1
tbe3t7i4uLu7u7y8vL29vb6+vsHBwcPDw8TExMXFxcbGxsfHx8jIyMnJycrKysvLy8zMzM/Pz9DQ
0NHR0dLS0tfX19jY2Nvb29zc3N3d3d7e3uDg4OHh4eLi4uPj4+Tk5OXl5QAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAD8ALAAAAAAbABsAAAaqwB8C
QCwaj0gi4pfAuJ7QqHT6xAQALo52y+16tamra0Mum89oskmsabvf8Hh7jc3Y7/i83k5vYf6AgYKD
f30Xh4iJiouHfRaPkJGSk49hACkVmZqbnJ2Zlpieop6gFKanqKmqpqWrrqt0Ka+zqHQmtLiWt7iz
tryzur+vwcKwV7LFqpYkycpXzM2oy9HSV7vUFJYQ2KbbIBQO4eLj5OXhFiY/LS1U7VQpP0EAOw==
}

image create photo ttk::theme::waldorf::button_f -data {
R0lGODdhGwAbAPYAAISEhIaGhoeHh4iIiImJiYqKiouLi4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpSU
lJaWlpeXl5mZmZqamqSkpKenp6ioqKmpqaqqqqurq6ysrK2tra6urq+vr7CwsLGxsbKysrOzs7S0
tLW1tba2tre3t7i4uLm5ubq6uru7u7y8vL29vb6+vr+/v8DAwMHBwcLCwsPDw8TExMXFxcbGxsfH
x8jIyMnJycrKysvLy8zMzM3Nzc7Ozs/Pz9DQ0NHR0dLS0tPT09TU1NXV1dbW1tfX19jY2Nra2tvb
29zc3N3d3d7e3uDg4OTk5Obm5gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAAbABsAAAf6gH8cEoSFhoeIhByCEzZBj5CRkpM2E4M0Lpmam5ydmTSEPi2jpKWm
p6M+oSysra6vsKyqEj4rtre4ubq2sz4qv8DBwsO/vSnHyMnKy8e9KM/Q0dLTz70n19jZ2tvX1tzf
3L0m4+Tl5ufjvSXr7O3u7+u9JPP09fb3870j+/z9/v/7eokYSLCgwYMDe4VYyLChw4cLFUKcCLEX
iIsYM2rceLHXh48gQ4oc+bGXh5MoU6pcebJXh5cwY8qc+bIXh5s4c+rcebPXhp9Agwod+nMWBw1I
kypdyhTpIAsPMkidSrWqVakPLPyxUABAgABeAYgV+3WsWbEFJvwJBAA7
}

image create photo ttk::theme::waldorf::button_p -data {
R0lGODdhGwAbAPUAAHZ2dnh4eHl5eXp6enx8fIGBgYKCgoODg4SEhIWFhYeHh4iIiImJiYqKiouL
i4yMjI2NjY6Ojo+Pj5CQkJGRkZKSkpOTk5aWlpeXl5iYmJmZmZqampubm6CgoKKioqOjo6SkpKWl
paampqenp6ioqKmpqaqqqqurq6ysrK2tra6urq+vr7CwsLGxsbKysrOzs8DAwMnJycrKysvLy83N
zc/Pz9HR0dLS0tfX19nZ2eDg4OHh4eLi4uPj4+Tk5OXl5SH5BAEAAD8ALAAAAAAbABsAAAakwF8k
QCwaj8hAZCa0qJ7QqHSqulh4gZR2y+16twgsakwum8/kcODEbrvf8LbaRK/b7/i6usTv+/+AfWok
hIWGh4iFaiOMjY6PkI1qIpSVlpeYlZOZnJxqIaChoqOkoWogqKmqq6ypah+wsbKztLGvtbi4t7m8
tli9wB+7wbq/xLnDx7PJyr4BzbXM0NLN1MphHBzQshoePD8eFuLj5OXmFiM5P0EAOw==
}

ttk::style element create Button.button image [list \
    ttk::theme::waldorf::button \
    {!disabled pressed} ttk::theme::waldorf::button_p \
    {!disabled active} ttk::theme::waldorf::button_a \
    {!disabled focus} ttk::theme::waldorf::button_f \
    {disabled} ttk::theme::waldorf::button_d \
] -border {5 13} -padding {6 6 6 4}


ttk::style layout TButton {
    Button.button -children {
        Button.padding -children {
            Button.label
        }
    }
}

ttk::style configure TButton -anchor center -justify center

# checkbutton: layout with changed indicator; focus removed

image create photo ttk::theme::waldorf::check -data {
R0lGODdhEgAMAPcAAAAAAKOjo5KSkpCQkJCQkJCQkJCQkJCQkJCQkJKSkqOjowAAAAAAAAAAAAAA
AAAAAAAAAAAAAKSkpMbGxvPz8/X19fX19fX19fX19fX19fX19fPz88XFxaenpwAAAAAAAAAAAAAA
AAAAAAAAAJeXl/Pz8/X19fX19fX19fX19fX19fX19fX19fX19erq6qOjowAAAAAAAAAAAAAAAAAA
AAAAAJmZmfX19fX19fX19fX19fX19fX19fX19fX19fX19erq6qSkpAAAAAAAAAAAAAAAAAAAAAAA
AJ+fn/Ly8vX19fX19fX19fX19fX19fX19fX19fX19fDw8KSkpAAAAAAAAAAAAAAAAAAAAAAAAKKi
ovDw8PX19fX19fX19fX19fX19fX19fX19fX19fDw8KampgAAAAAAAAAAAAAAAAAAAAAAAKioqPDw
8PX19fX19fX19fX19fX19fX19fX19fX19fDw8KWlpQAAAAAAAAAAAAAAAAAAAAAAAKurq/Dw8PX1
9fX19fX19fX19fX19fX19fX19fX19fLy8qioqAAAAAAAAAAAAAAAAAAAAAAAAK+vr+7u7vX19fX1
9fX19fX19fX19fX19fX19fX19fX19aioqAAAAAAAAAAAAAAAAAAAAAAAALS0tOzs7PX19fX19fX1
9fX19fX19fX19fX19fX19fPz86urqwAAAAAAAAAAAAAAAAAAAAAAALm5udLS0vPz8/X19fPz8/Dw
8PDw8PDw8O/v7+vr69HR0bq6ugAAAAAAAAAAAAAAAAAAAAAAAAAAALy8vLGxsbGxsbOzs7Ozs7W1
tbe3t7e3t7q6ur29vQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAP8ALAAAAAASAAwA
AAi2AP8FEDCAQAEDBxAkUPCvocN/EiZQqGDhAoYMGjZw6PCwIYkSJk6gSKFiBYsWLl50/GfjBo4c
Onbw6OHjB5AgK5EkUbKESRMnT6BEkTJlpZYtXLp4+QImjJgxZMqsZNPGzRs4ceTMoVPHzp2Vfv4A
CiRoEKFChg4hSrQSUiRJkyhVsnQJUyZNm1aKGkWqlKlTqFKpWsWq1UpatWzdwpVL1y5evXz9Wvnv
GLJkypYxa+bsGTTKAQEAOw==
}

image create photo ttk::theme::waldorf::check_d -data {
R0lGODdhEgAMAPcAAAAAAL29vba2trW1tbW1tbW1tbW1tbW1tbW1tba2tr29vQAAAAAAAAAAAAAA
AAAAAAAAAAAAAL29vcnJydra2tvb29vb29vb29vb29vb29vb29ra2snJyb+/vwAAAAAAAAAAAAAA
AAAAAAAAALi4uNra2tvb29vb29vb29vb29vb29vb29vb29vb29fX1729vQAAAAAAAAAAAAAAAAAA
AAAAALi4uNvb29vb29vb29vb29vb29vb29vb29vb29vb29fX1729vQAAAAAAAAAAAAAAAAAAAAAA
ALu7u9ra2tvb29vb29vb29vb29vb29vb29vb29vb29nZ2b29vQAAAAAAAAAAAAAAAAAAAAAAALy8
vNnZ2dvb29vb29vb29vb29vb29vb29vb29vb29nZ2b29vQAAAAAAAAAAAAAAAAAAAAAAAL6+vtnZ
2dvb29vb29vb29vb29vb29vb29vb29vb29nZ2b29vQAAAAAAAAAAAAAAAAAAAAAAAL+/v9nZ2dvb
29vb29vb29vb29vb29vb29vb29vb29ra2r6+vgAAAAAAAAAAAAAAAAAAAAAAAMHBwdjY2Nvb29vb
29vb29vb29vb29vb29vb29vb29vb2729vQAAAAAAAAAAAAAAAAAAAAAAAMLCwtjY2Nvb29vb29vb
29vb29vb29vb29vb29vb29ra2r+/vwAAAAAAAAAAAAAAAAAAAAAAAMTExM7Oztra2tvb29ra2tnZ
2dnZ2dnZ2dnZ2dfX183NzcbGxgAAAAAAAAAAAAAAAAAAAAAAAAAAAMfHx8LCwsHBwcLCwsLCwsPD
w8TExMTExMXFxcjIyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAP8ALAAAAAASAAwA
AAi2AP8FEDCAQAEDBxAkUPCvocN/EiZQqGDhAoYMGjZw6PCwIYkSJk6gSKFiBYsWLl50/GfjBo4c
Onbw6OHjB5AgK5EkUbKESRMnT6BEkTJlpZYtXLp4+QImjJgxZMqsZNPGzRs4ceTMoVPHzp2Vfv4A
CiRoEKFChg4hSrQSUiRJkyhVsnQJUyZNm1aKGkWqlKlTqFKpWsWq1UpatWzdwpVL1y5evXz9Wvnv
GLJkypYxa+bsGTTKAQEAOw==
}

image create photo ttk::theme::waldorf::check_s -data {
R0lGODdhEgAMAPcAAAAAAJmZmYmJiYeHh4eHh4eHh4eHh4eHh4eHh4mJiZmZmQAAAAAAAAAAAAAA
AAAAAAAAAAAAAJeXl6qqqtra2t3d3d3d3d3d3d3d3d3d3d3d3dra2pubm4iIiOjo6AAAAAAAAAAA
AAAAAAAAAISEhNjY2Li4uLe3t7a2tre3t7e3t7a2tre3t6mpqX19fejo6PDw8AAAAAAAAAAAAAAA
AAAAAIGBgdra2p2dnampqbW1tbW1tbW1tbW1taWlpXFxcefn5/Dw8AAAAAAAAAAAAAAAAAAAAAAA
AIKCgra2tn19fXNzc6enp7S0tLS0tKOjo3BwcObm5vv7+4eHhwAAAAAAAAAAAAAAAAAAAAAAAICA
gIaGhufn5+Xl5XNzc6enp6Ojo3BwcOXl5f///5+fn2trawAAAAAAAAAAAAAAAAAAAAAAAICAgISE
hOfn5////+Xl5XJycnBwcOXl5f///7Ozs4uLi319fQAAAAAAAAAAAAAAAAAAAAAAAH9/f6ioqHx8
fPX19f///+Xl5eXl5f///9DQ0GhoaMvLy3t7ewAAAAAAAAAAAAAAAAAAAAAAAH9/f8fHx4yMjHx8
fPX19f///////+bm5mZmZp6entPT03Z2dgAAAAAAAAAAAAAAAAAAAAAAAICAgJ+fn6ampomJiXx8
fOTk5OTk5HBwcJGRkaampqSkpHV1dQAAAAAAAAAAAAAAAAAAAAAAAIiIiIyMjKKioqOjo4eHh2Zm
ZmZmZoCAgJ+fn5ycnIuLi4iIiAAAAAAAAAAAAAAAAAAAAAAAAAAAAIaGhnFxcXBwcHR0dHR0dHZ2
dnl5eXl5eX19fYeHhwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAP8ALAAAAAASAAwA
AAi4AP8FEDCAQAEDBxAkUPCvocN/EiZQqGDhAoYMGjZw6ODh4T8SJUycQJFCxQoWLVy8gOHRxg0c
OXTs4NHDxw8gQTz+Q5JEyRImTZw8gRJFyhSdWrZw6eLlC5gwYsaQKaOTTRs3b+DEkTOHTh07d3T6
+QMokKBBhAoZOoQokU5IkSRNolTJ0iVMmTRt0ilqFKlSpk6hSqVqFatWOmnVsnULVy5du3j18vVL
579jyJIpW8asmbNn0CwHBAA7
}

image create photo ttk::theme::waldorf::check_sd -data {
R0lGODdhEgAMAPcAAAAAAMbGxsLCwsHBwcHBwcHBwcHBwcHBwcHBwcLCwsbGxgAAAAAAAAAAAAAA
AAAAAAAAAAAAAMTExNXV1e/v7/Dw8PHx8fHx8fHx8fHx8fDw8O/v79bW1sfHx729vQAAAAAAAAAA
AAAAAAAAAL+/v+7u7uDg4OHh4eHh4eLi4uLi4uHh4eHh4eLi4uXl5b29vby8vAAAAAAAAAAAAAAA
AAAAAL29ve/v7+Hh4eLi4uLi4uPj4+Pj4+Li4uPj4+Dg4MLCwry8vAAAAAAAAAAAAAAAAAAAAAAA
AL6+vu7u7tzc3OHh4ePj4+Tk5OTk5OTk5OHh4cHBwby8vMHBwQAAAAAAAAAAAAAAAAAAAAAAAL29
vezs7MHBwcHBweHh4eXl5ebm5uLi4sHBwbu7u9ra2sDAwAAAAAAAAAAAAAAAAAAAAAAAAL29vezs
7MHBwbu7u8LCwuLi4uPj48LCwru7u8zMzOvr67y8vAAAAAAAAAAAAAAAAAAAAAAAALy8vOvr69jY
2L29vbu7u8HBwcHBwbu7u8bGxuHh4evr67u7uwAAAAAAAAAAAAAAAAAAAAAAALy8vObm5t3d3djY
2L29vbu7u7u7u8HBwd7e3tzc3Ozs7Lm5uQAAAAAAAAAAAAAAAAAAAAAAALy8vNTU1NnZ2dzc3NfX
18HBwcHBwdnZ2dzc3NnZ2dfX17i4uAAAAAAAAAAAAAAAAAAAAAAAAL6+vsfHx9bW1tfX19jY2NnZ
2dnZ2djY2NTU1NPT08fHx7+/vwAAAAAAAAAAAAAAAAAAAAAAAAAAAL6+vra2trW1tbe3t7e3t7i4
uLm5ubm5ubu7u7+/vwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAP8ALAAAAAASAAwA
AAi4AP8FEDCAQAEDBxAkUPCvocN/EiZQqGDhAoYMGjZw6ODh4T8SJUycQJFCxQoWLVy8gOHRxg0c
OXTs4NHDxw8gQTz+Q5JEyRImTZw8gRJFyhSdWrZw6eLlC5gwYsaQKaOTTRs3b+DEkTOHTh07d3T6
+QMokKBBhAoZOoQokU5IkSRNolTJ0iVMmTRt0ilqFKlSpk6hSqVqFatWOmnVsnULVy5du3j18vVL
579jyJIpW8asmbNn0CwHBAA7
}

ttk::style element create Checkbutton.indicator image [list \
    ttk::theme::waldorf::check \
    {selected disabled} ttk::theme::waldorf::check_sd \
    {selected} ttk::theme::waldorf::check_s \
    {disabled} ttk::theme::waldorf::check_d \
]

ttk::style layout TCheckbutton {
    Checkbutton.padding -sticky nswe -children {
        Checkbutton.indicator -side left -sticky {}
        Checkbutton.focus -side left -sticky w -children {
            Checkbutton.label -sticky nswe
        }
    }
}
#ttk::style layout TCheckbutton {
#    Checkbutton.padding -children {
#        Checkbutton.indicator -side left -sticky {}
#        Checkbutton.label
#    }
#}

ttk::style configure TCheckbutton -padding {4 2}

# combobox: layout with non-sticky arrow and field like entry

image create photo ttk::theme::waldorf::entry -data {
R0lGODdhGwAbAPUAAKWlpaampqenp6mpqaqqqqysrK2tra+vr7CwsLKysrOzs7W1tba2tri4uLm5
ubu7u7y8vL6+vr+/v8HBwcLCwsTExMbGxsnJycrKys3NzdXV1dzc3OLi4uPj4+Tk5OXl5efn5+3t
7e7u7vX19QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAGwAbAAAGkcCMcEgsGouaC2DJ
bDqfTZASRK1ar1cRSASQDkCjsHhMLo+6l695bf6mwex42G2Ay9n1S/0ezyfsfGV+gIFjfxd/hWaH
CoSKI4yOio0XjY9klA6ShZQQm4GaF5qXY54XnqRipqipI6YTn3yvsXewF7CtI7YVIrm2uK27va0V
UhUVF8fHycjMyMvOySAaWNXWV0EAOw==
}

image create photo ttk::theme::waldorf::entry_a -data {
R0lGODdhGwAbAPQAAG9vb3BwcHFxcXJycnNzc3R0dHV1dXZ2dnd3d3h4eHp6ent7e3x8fH19fX5+
fn9/f4CAgIGBgYKCgoODg4WFhcnJycrKys3Nzc/Pz9XV1dzc3OLi4uPj4+Tk5OXl5fX19SwAAAAA
GwAbAAAFpeBVjWRpnmVWAYLAumwMzO1sw9x6YTy/95hfT3gB5ASYj3LJbDoxxgrSSa1iBMdkdbu8
5gwXrhhj+GrFVoOnYjijn2q2+80k5xJzuhKTuOf1FwlreHpPDGsMf3R8iIpvjBWJhU0YDDmSk12H
kY5olWsSYZlKFxKgoqOloJ1jphUSrFwYrrCjpLSxW6oVFEJAv7++FGsUxcbHyMnHHhkezs/Q0dLR
IQA7
}

image create photo ttk::theme::waldorf::entry_d -data {
R0lGODdhGwAbAPUAAKSkpKWlpaampqioqKqqqqurq62tra6urq+vr7CwsLGxsbKysrOzs7S0tLW1
tbe3t7i4uLy8vL29vb6+vsHBwcLCwsPDw8TExMXFxcbGxsfHx8jIyMnJycrKytHR0dfX19vb29zc
3N3d3d7e3uLi4uPj4+Xl5QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAAGwAbAAAGpECPcEgsGo8LhHLJ
bDqXwkWpZKpar9gqtQRaREudsHhMLoe8HilnzW673+fvZk6v2+/dqEnD7/v/gHlpJRmFhoeIiYJS
GI2Oj5CRiyEXlZaXmJlxaSEWnp+goaKbCyEVp6ipqqukIBSvsLGys60Ttre4ubq1ur29iyC+wrjA
w8bFxsKLH8nCpMzNvc/Rv2gL0NTE1iHZudPdt5Pgt5vjukfo6URBADs=
}

ttk::style element create Combobox.field image [list  \
    ttk::theme::waldorf::entry \
    {!disabled active} ttk::theme::waldorf::entry_a \
    {!disabled focus} ttk::theme::waldorf::entry_a \
    {disabled} ttk::theme::waldorf::entry_d \
] -border {5 13} -padding {6 6 6 4}

image create photo ttk::theme::waldorf::arrow -data {
R0lGODdhDQAJAPYAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMfHxzw8PDY2NjY2NjY2NjY2
NjY2Njw8PMbGxgAAAAAAAAAAAAAAAAAAAKKiokVFRXFxcXR0dHFxcUVFRaGhoQAAAAAAAAAAAAAA
AAAAAAAAAAAAAHJyck5OTmtra05OTnJycgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANra2k1NTUZG
Rk1NTdnZ2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMPDw0FBQcTExAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAM/PzwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAANAAkAAAcqgH+Cg4SFhoYdHh8gISIdhjgrLC0uKziHODk6OZeHf0ZURp6DVKOm
p4SBADs=
}

ttk::style element create Combobox.downarrow image ttk::theme::waldorf::arrow

ttk::style layout TCombobox {
    Combobox.field -children {
        Combobox.downarrow -side right -sticky {}
        Combobox.padding -expand 1 -children {
            Combobox.textarea
        }
    }
}

ttk::style configure ComboboxPopdownFrame -background gray66

# entry: changed field image

ttk::style element create Entry.field image [list  \
    ttk::theme::waldorf::entry \
    {!disabled active} ttk::theme::waldorf::entry_a \
    {!disabled focus} ttk::theme::waldorf::entry_a \
    {disabled} ttk::theme::waldorf::entry_d \
] -border {5 13} -padding {6 6 6 4}

# labelframe: image as transparent surface with border

image create photo ttk::theme::waldorf::surface -data {
R0lGODdhPAA8APMAAKioqKmpqa+vr7Ozs7S0tLy8vMfHx9DQ0NHR0dvb2wAAAAAAAAAAAAAAAAAA
AAAAACH5BAEAAAoALAAAAAA8ADwAAATGUBFAq704683BUEORjGRpnmiqrkgxJUosz3Rt33iuGAIA
68CgkMbzDY/IW/GXbCKXzugQKq3mqNYsscfUerFeLThsHZOl5rMzrU6y28c3XCifA+v2Kze/3vPd
fn9xgYJ0hIV3h4h6RotBeI47ipE1kI6Wi5iImoWcgp5/oHyieaR2pnOocKptrGquZ7BksmG0X5OU
M7ZiuLkxu1nAZb2+wlXGaMS5yFHMfY2+Ns5NCB4FBtjZ2tvc3d7f4AYFHwMd5ufoGQoRADs=
}

ttk::style element create Labelframe.border image ttk::theme::waldorf::surface -border 5

ttk::style configure TLabelframe -labelanchor nw

# menubutton: layout with button image and combobox arrow as indicator; focus
# removed

ttk::style layout TMenubutton {
    Button.button -children {
        Combobox.downarrow -side right -sticky {}
        Menubutton.padding -expand 1 -sticky we -children {
            Menubutton.label -side left -sticky {}
        }
    }
}

# notebook: layout with changed client and tab; focus removed; background
# changes disabled by putting an empty list in ttk::style map

image create photo ttk::theme::waldorf::tab -data {
R0lGODdhFQAVAPQAALOzs7S0tLW1tba2tre3t7q6ury8vL29vb6+vr+/v8DAwMHBwcPDw8bGxsjI
yM3Nzc7OztHR0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEA
AB8ALAAAAAAVABUAAAVp4CeOZGmKRQCsbLsGQTEWymPfeK7IX+D8wKDwFxABGsikconkARjQqHQK
LX4Ai6x2y81aAYqweEwOWwOJtHrNTp/b8PU3Tp/T4fY7O69X8/sJf32CegBGgGuGHwWIajyLKi6S
K48nliUhADs=
}

image create photo ttk::theme::waldorf::tab_a -data {
R0lGODdhFQAVAPQAAK2tra6urq+vr7CwsLKysrOzs7W1tbq6uru7u8rKytHR0dnZ2dra2tvb29zc
3N3d3d/f3+Hh4efn5+jo6Orq6gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEA
AB8ALAAAAAAVABUAAAVw4CeOZGmKR6CubHuMRzLNdG0riBhIfO//vIIuQiwaj0ThJwBpOp/QphLw
qFqv2Koy4Oh6v+DutkEum8/kgY7BbrvfbPUHAK+7p/a8nJ6v4/twcgGAgWuEbgGGh2yJS4ttjTGP
CS8oLQAAAZkuJ52dIQA7
}

image create photo ttk::theme::waldorf::tab_s -data {
R0lGODdhFQAVAPQAAKioqKmpqaqqqqurq62tra6urrCwsLW1tba2tsXFxdHR0dTU1NXV1dbW1tfX
19jY2Nra2tzc3OLi4uPj4+Xl5QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEA
AB8ALAAAAAAVABUAAAVl4CeOZGmKR6CubHuMR0LNdG0n7xdMfO//PIMoICkaj8iiUBdpOp/Q5jIA
qVqv2Or0we16v9ypY0wum8fThnrNbqvT7vgaLo/T6+07fj7cu/V+gHuCeEsxfmsJSx8pLY4rOSeS
JiEAOw==
}

ttk::style element create Notebook.client image ttk::theme::waldorf::surface -border 5

ttk::style element create Notebook.tab image [list \
    ttk::theme::waldorf::tab \
    {selected active} ttk::theme::waldorf::tab_a \
    {selected focus} ttk::theme::waldorf::tab_a \
    {selected} ttk::theme::waldorf::tab_s \
] -border {3 10} -padding {6 6 6 4}

ttk::style layout TNotebook.Tab {
    Notebook.tab -children {
        Notebook.padding -side top -children {
            Notebook.label -side top -sticky {}
        }
    }
}

ttk::style map TNotebook -background [list \
]

ttk::style configure TNotebook -tabposition nw

# panedwindow: changed sashes

image create photo ttk::theme::waldorf::sash_h -data {
R0lGODlhCQAIAPYAANHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0bq6utHR0dHR0bq6utHR0dHR
0bq6utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0bq6
utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0bq6utHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAAAAAAALAAAAAAJAAgAAAdKgAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQl
JicoKSorLC0uLzAxMjM0NTY3ODk6Ozw9Pj9AQUJDREVGR4EAOw==
}

image create photo ttk::theme::waldorf::sash_v -data {
R0lGODlhCAAJAPYAANHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0bq6urq6urq6urq6
utHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0dHR0bq6urq6urq6urq6utHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0dHR0dHR0dHR0dHR0dHR0dHR0bq6urq6urq6urq6utHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAAAAAAALAAAAAAIAAkAAAdKgAABAgMEBQYHCAkKCwwNDg8QERITFBUWFxgZGhscHR4fICEiIyQl
JicoKSorLC0uLzAxMjM0NTY3ODk6Ozw9Pj9AQUJDREVGR4EAOw==
}

ttk::style element create hsash image ttk::theme::waldorf::sash_h -sticky s

ttk::style element create vsash image ttk::theme::waldorf::sash_v -sticky e

ttk::style configure TPanedwindow -background gray82

# progressbar: changed trough and bars

image create photo ttk::theme::waldorf::gauge -data {
R0lGODdhFgAWAPMAAJycnJ2dnZ+fn6GhoaKioqOjo6Wlpaampqenp6qqqqurq6ysrK2tra6urq+v
r8zMzCH5BAEAAA8ALAAAAAAWABYAAARF8ClAq71VSaO6/6DHKUtpnug5kWmLrm5sAqzs0rbr4HlL
Oz3UrhacEYtDYNG4PPGaw2YpKV08mz8pVXpd0gzSyaO6eEQAADs=
}

image create photo ttk::theme::waldorf::bar_h -data {
R0lGODdhFgAWAPUAAFxcXF5eXmBgYGpqamtra2xsbG1tbW5ubm9vb3FxcXNzc3R0dHl5eXp6enx8
fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouLi4yMjI2NjY6Ojo+P
j5CQkJGRkZKSkpOTk5SUlJaWlpeXl5iYmJmZmZubm5ycnJ6enqGhoaOjo6ampqenp7+/v8DAwAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAD8ALAAAAAAWABYAAAalwB9k
kVgQjUXkEQn5TUKnqHRKlXYmCZN2y+12E4mSeEwul8GktHrNZoNH8Lh8PgeL7vi8Xg8O+f+AgYFg
IIWGh4iIYB+MjY6Pj2Aek5SVlpZgHZqbnJ2dYByhoqOkpGAbqKmqq6tgGq+wsbKyYBm2t7i5uWAY
vb6/wMBgF8TFxsfHYBbLzM3OzgkDFdPU1dbWA9EU29zd3twICT8JAOXm5+jlAuJBADs=
}

image create photo ttk::theme::waldorf::bar_v -data {
R0lGODdhFgAWAPUAAFxcXF5eXmBgYGpqamtra2xsbG1tbW5ubm9vb3FxcXNzc3R0dHl5eXp6enx8
fH19fX5+fn9/f4CAgIGBgYKCgoODg4SEhIWFhYaGhoeHh4iIiImJiYqKiouLi4yMjI2NjY6Ojo+P
j5CQkJGRkZKSkpOTk5SUlJaWlpeXl5iYmJmZmZubm5ycnJ6enqGhoaOjo6ampqenp7+/v8DAwAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAD8ALAAAAAAWABYAAAaRwN8k
QSwaj8YfpGMqkUaiEOjj6XA2mgzmYqkgiKfmMzqtXrPbLkWQCDuhUqoVq+VW1m0xvDxH2/FuY3Fm
dGl3bIF7cmd1aoh6ZIuFf49vkYR+jnmWg32Nh5uCfIyGgJCdpJShipifppyjk5qJl56llaKSmaC0
qLK8p7G7r7mtt6u1qWoAECHBup8DCUJI1Ug/QQA7
}

ttk::style element create Progressbar.trough image ttk::theme::waldorf::gauge -border 5 \
    -padding 0

ttk::style element create Horizontal.Progressbar.pbar image ttk::theme::waldorf::bar_h \
    -border 5

ttk::style element create Vertical.Progressbar.pbar image ttk::theme::waldorf::bar_v \
    -border 5

# radiobutton: layout with changed indicator; focus removed

image create photo ttk::theme::waldorf::radio -data {
R0lGODdhEgAMAPcAAAAAAAAAAAAAAKqqqpmZmZGRkZGRkZmZmaqqqsPDwwAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAJmZmcTExOjo6PT09PT09Ojo6MTExJiYmMTExAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAJubm+Dg4PX19fX19fX19fX19fX19fX19d/f35ycnNnZ2QAAAAAAAAAAAAAAAAAA
AAAAAK6ursfHx/X19fX19fX19fX19fX19fX19fX19fX19cbGxrW1tdzc3AAAAAAAAAAAAAAAAAAA
AKOjo+np6fX19fX19fX19fX19fX19fX19fX19fX19ejo6KSkpOHh4QAAAAAAAAAAAAAAAAAAAJ+f
n/T09PX19fX19fX19fX19fX19fX19fX19fX19fDw8KKiouTk5AAAAAAAAAAAAAAAAAAAAKWlpfHx
8fX19fX19fX19fX19fX19fX19fX19fX19fT09KKiouTk5AAAAAAAAAAAAAAAAAAAAKurq+vr6/X1
9fX19fX19fX19fX19fX19fX19fX19erq6qurq+Hh4QAAAAAAAAAAAAAAAAAAALi4uM7OzvX19fX1
9fX19fX19fX19fX19fX19fX19c3Nzb6+vtzc3AAAAAAAAAAAAAAAAAAAAAAAAK+vr+Tk5PX19fX1
9fX19fX19fX19fX19eTk5K+vr9zc3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALKystHR0evr6/T0
9PHx8evr69HR0bKystTU1AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMPDw7a2trGxsbOz
s7a2tsPDw93d3QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAASAAwA
AAihAAEIHECggIEDCAQqXCiQQgULFzBk0LCB4cISJk6gSKFiBYsWLiwCsHEDRw4dO3j08PEDSBCL
SJIoWcKkiZMnUKJImWJRyxYuXbx8ARNGzBgyZSyyaePmDZw4cubQqWPnjkU/fwAFEjSIUCFDhxAl
sggpkqRJlCpZuoQpk6ZNIkeRKmXqFKpUqlaxEinQ1i1cuXTt4tWLr8JkypYxa+bMcEAAOw==
}

image create photo ttk::theme::waldorf::radio_d -data {
R0lGODdhEgAMAPcAAAAAAAAAAAAAAL+/v7i4uLW1tbW1tbm5ub+/v8fHxwAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAALm5ucnJydbW1tvb29vb29bW1snJybm5uc7OzgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAALq6utPT09vb29vb29vb29vb29vb29vb29PT07q6ut7e3gAAAAAAAAAAAAAAAAAA
AAAAAMHBwcrKytvb29vb29vb29vb29vb29vb29vb29vb28rKysfHx9zc3AAAAAAAAAAAAAAAAAAA
ALy8vNfX19vb29vb29vb29vb29vb29vb29vb29vb29bW1r29veHh4QAAAAAAAAAAAAAAAAAAALq6
utvb29vb29vb29vb29vb29vb29vb29vb29vb29nZ2by8vOTk5AAAAAAAAAAAAAAAAAAAALy8vNnZ
2dvb29vb29vb29vb29vb29vb29vb29vb29vb27u7u+Tk5AAAAAAAAAAAAAAAAAAAAL+/v9fX19vb
29vb29vb29vb29vb29vb29vb29vb29fX17+/v+Hh4QAAAAAAAAAAAAAAAAAAAMTExMzMzNvb29vb
29vb29vb29vb29vb29vb29vb28zMzMrKytzc3AAAAAAAAAAAAAAAAAAAAAAAAMDAwNTU1Nvb29vb
29vb29vb29vb29vb29TU1MDAwN/f3wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMHBwc3NzdfX19vb
29ra2tfX183NzcHBwdnZ2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMzMzMTExMHBwcLC
wsTExMzMzN/f3wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAASAAwA
AAihAAEIHECggIEDCAQqXCiQQgULFzBk0LCB4cISJk6gSKFiBYsWLiwCsHEDRw4dO3j08PEDSBCL
SJIoWcKkiZMnUKJImWJRyxYuXbx8ARNGzBgyZSyyaePmDZw4cubQqWPnjkU/fwAFEjSIUCFDhxAl
sggpkqRJlCpZuoQpk6ZNIkeRKmXqFKpUqlaxEinQ1i1cuXTt4tWLr8JkypYxa+bMcEAAOw==
}

image create photo ttk::theme::waldorf::radio_s -data {
R0lGODdhEgAMAPcAAAAAAAAAAAAAAKOjo46OjoiIiIiIiI+Pj6Ojo8PDwwAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAIqKiq2trdDQ0Nzc3Nzc3NDQ0K2trYmJibi4uAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAIiIiMPDw8HBwbe3t7e3t7e3t7e3t8HBwcPDw4iIiMDAwAAAAAAAAAAAAAAAAAAA
AAAAAJ2dnaqqqr6+vrKyspaWloODg4ODg5aWlrKysr+/v6ioqJ+fn8rKygAAAAAAAAAAAAAAAAAA
AIaGhszMzLKyspOTk6ioqPPz8/Pz86ioqJOTk7e3t8XFxYeHh8bGxgAAAAAAAAAAAAAAAAAAAH19
fdPT07GxsYGBgfLy8v////////Ly8oGBgbOzs8zMzICAgMPDwwAAAAAAAAAAAAAAAAAAAH19fczM
zLGxsYCAgPLy8v////////Ly8oCAgK+vr9HR0Xp6esDAwAAAAAAAAAAAAAAAAAAAAICAgMHBwbGx
sY+Pj6SkpPLy8vLy8qSkpI+Pj6ysrMbGxoCAgL+/vwAAAAAAAAAAAAAAAAAAAJWVlZ+fn7S0tKio
qI2NjXx8fHx8fI2NjaioqLS0tJ+fn5aWlsPDwwAAAAAAAAAAAAAAAAAAAAAAAHp6epqamqenp6io
qKioqKioqKioqKenp5qamnp6erS0tAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHd3d4uLi52dnaOj
o6GhoZ2dnYuLi3d3d6mpqQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJGRkXh4eHBwcHNz
c3l5eZGRka+vrwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAASAAwA
AAihAAEIHECggIEDCAQqXCiQQgULFzBk0LCB4cISJk6gSKFiBYsWLiwCsHEDRw4dO3j08PEDSBCL
SJIoWcKkiZMnUKJImWJRyxYuXbx8ARNGzBgyZSyyaePmDZw4cubQqWPnjkU/fwAFEjSIUCFDhxAl
sggpkqRJlCpZuoQpk6ZNIkeRKmXqFKpUqlaxEinQ1i1cuXTt4tWLr8JkypYxa+bMcEAAOw==
}

image create photo ttk::theme::waldorf::radio_sd -data {
R0lGODdhEgAMAPcAAAAAAAAAAAAAAMfHx8PDw8HBwcHBwcPDw8fHx8nJyQAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAMLCwtbW1urq6vHx8fDw8Orq6tbW1sLCwtDQ0AAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAMHBwePj4+Xl5eHh4eLi4uLi4uHh4eXl5eLi4sHBwd7e3gAAAAAAAAAAAAAAAAAA
AAAAAMTExNXV1eTk5OLi4uPj4+Xl5eXl5ePj4+Li4uTk5NTU1MrKygAAAAAAAAAAAAAAAAAAAAAA
AL+/v+jo6OHh4ePj49fX17+/v7+/v9fX1+Pj4+Pj4+Xl5cDAwAAAAAAAAAAAAAAAAAAAAAAAALu7
u+zs7ODg4OPj47+/v7u7u7u7u7+/v+Pj4+Hh4enp6b29vQAAAAAAAAAAAAAAAAAAAAAAALy8vOrq
6uHh4ePj47+/v7u7u7u7u7+/v+Pj4+Dg4Ozs7Lq6ugAAAAAAAAAAAAAAAAAAAAAAALy8vOTk5OHh
4eDg4NfX17+/v7+/v9fX1+Dg4N7e3ubm5r29vQAAAAAAAAAAAAAAAAAAAAAAAMHBwdDQ0ODg4N3d
3d/f3+Hh4eHh4d/f393d3eDg4NDQ0MfHxwAAAAAAAAAAAAAAAAAAAAAAAAAAALq6utHR0dvb29vb
29zc3Nzc3Nvb29vb29HR0bq6ut7e3gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALm5ucfHx9PT09jY
2NbW1tPT08fHx7m5udfX1wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMXFxbm5ubW1tbe3
t7m5ucXFxd7e3gAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAAAALAAAAAASAAwA
AAihAAEIHECggIEDCAQqXCiQQgULFzBk0LCB4cISJk6gSKFiBYsWLiwCsHEDRw4dO3j08PEDSBCL
SJIoWcKkiZMnUKJImWJRyxYuXbx8ARNGzBgyZSyyaePmDZw4cubQqWPnjkU/fwAFEjSIUCFDhxAl
sggpkqRJlCpZuoQpk6ZNIkeRKmXqFKpUqlaxEinQ1i1cuXTt4tWLr8JkypYxa+bMcEAAOw==
}

ttk::style element create Radiobutton.indicator image [list \
    ttk::theme::waldorf::radio \
    {selected disabled} ttk::theme::waldorf::radio_sd \
    {selected} ttk::theme::waldorf::radio_s \
    {disabled} ttk::theme::waldorf::radio_d \
]

ttk::style layout TRadiobutton {
    Radiobutton.padding -children {
        Radiobutton.indicator -side left -sticky {}
        Radiobutton.label
    }
}

ttk::style configure TRadiobutton -padding {4 2}

# scale: layout with added scales and changed slider

image create photo ttk::theme::waldorf::slider -data {
R0lGODlhDQANAPcAALm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5ubm5uba2tvr6
+vr6+vr6+vn5+fn5+fr6+vn5+fn5+fr6+vr6+vr6+ra2trOzs/Ly8uzs7Ovr6+vr6+vr6+vr6+vr
6+vr6+vr6+zs7PLy8rOzs7Gxsevr6+Tk5OTk5OPj4+Tk5OTk5OTk5OPj4+Tk5OTk5Ovr67Gxsa6u
ruTk5N3d3d3d3d7e3t/f397e3t/f397e3t3d3d3d3eTk5K6urqysrN7e3tfX19jY2Nra2tvb29vb
29vb29ra2tjY2NfX197e3qysrKmpqdbW1tDQ0NLS0tTU1NbW1tfX19bW1tTU1NLS0tDQ0NbW1qmp
qaamptLS0s3Nzc/Pz9HR0dPT09PT09PT09HR0c/Pz83NzdLS0qampqSkpM3NzcnJycrKyszMzM3N
zc3Nzc3NzczMzMrKysnJyc3NzaSkpKGhocjIyMPDw8TExMbGxsfHx8fHx8fHx8bGxsTExMPDw8jI
yKGhoZ+fn7+/v7+/v7+/v7+/v8HBwcHBwcHBwb+/v7+/v7+/v7+/v5+fn5ycnLu7u7u7u7u7u7u7
u7u7u7u7u7u7u7u7u7u7u7u7u7u7u5ycnJqampqampqampqampqampqampqampqampqampqampqa
mpqampqamgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAANAA0A
AAjBAAEEEDCAQAEDBxAkULCAQQMHDyBEkDCBQgULFzBk0LCBQwcPH0CEEDGCRAkTJ1CkULGCRQsX
L2DEkDGDRg0bN3Dk0LGDRw8fP4AEETKESBEjR5AkUbKESRMnT6BEkTKFShUrV7Bk0bKFSxcvX8CE
ETOGTBkzZ9CkUbOGTRs3b+DEkTOHTh07d/Dk0bOHTx8/fwAFEjSIUCFDhxAlUrSIUSNHjyBFkjSJ
UiVLlzBl0rSJUydPn0CFEjWKVClTp1AFBAA7
}

image create photo ttk::theme::waldorf::slider_a -data {
R0lGODlhDQANAPcOAMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMnJyf//
/////////////////////////////////////////8nJycbGxv////7+/v7+/v39/f7+/v39/f7+
/v39/f7+/v7+/v///8bGxsTExPv7+/j4+Pj4+Pj4+Pf39/j4+Pf39/j4+Pj4+Pj4+Pv7+8TExMHB
wfb29vHx8fHx8fLy8vLy8vPz8/Ly8vLy8vHx8fHx8fb29sHBwb6+vvHx8evr6+3t7e3t7e/v7+/v
7+/v7+3t7e3t7evr6/Hx8b6+vry8vOzs7Obm5ujo6Onp6evr6+zs7Ovr6+np6ejo6Obm5uzs7Ly8
vLm5uefn5+Li4uPj4+Xl5ebm5ufn5+bm5uXl5ePj4+Li4ufn57m5uba2tuHh4d3d3d/f3+Hh4eHh
4eLi4uHh4eHh4d/f393d3eHh4ba2trS0tNzc3NfX19nZ2dra2tvb29vb29vb29ra2tnZ2dfX19zc
3LS0tLGxsdLS0tLS0tLS0tPT09TU1NTU1NTU1NPT09LS0tLS0tLS0rGxsa6urs7Ozs7Ozs7Ozs7O
zs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozq6urqysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys
rKysrKysrAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAAAAAAALAAAAAANAA0A
AAjBAAEEEDCAQAEDBxAkULCAQQMHDyBEkDCBQgULFzBk0LCBQwcPH0CEEDGCRAkTJ1CkULGCRQsX
L2DEkDGDRg0bN3Dk0LGDRw8fP4AEETKESBEjR5AkUbKESRMnT6BEkTKFShUrV7Bk0bKFSxcvX8CE
ETOGTBkzZ9CkUbOGTRs3b+DEkTOHTh07d/Dk0bOHTx8/fwAFEjSIUCFDhxAlUrSIUSNHjyBFkjSJ
UiVLlzBl0rSJUydPn0CFEjWKVClTp1AFBAA7
}

image create photo ttk::theme::waldorf::scale_h -data {
R0lGODdhHQANAPIAAJ+fn7q6usnJydHR0dfX1+Xl5QAAAAAAACH5BAEAAAcALAAAAAAdAA0AAAMm
eLrc/jDKSaudIOvNuz9AII5kaZYAeK6smIZtTL5ebWtXru98TyUAOw==
}

image create photo ttk::theme::waldorf::scale_v -data {
R0lGODdhDQAdAPIAAJ+fn7q6usnJydHR0dfX1+Xl5QAAAAAAACH5BAEAAAcALAAAAAANAB0AAAM7
eHrQvZCFCeICM1QrKe/ah3ncGJbZZplqxIopTK4xOrs1fUOvfeo/3O6SEwZ5ReRQ0QO2lMeL4/mB
JAAAOw==
}

ttk::style element create Scale.slider image [list \
    ttk::theme::waldorf::slider \
    {active} ttk::theme::waldorf::slider_a \
]

ttk::style element create hscale image ttk::theme::waldorf::scale_h -border 2

ttk::style layout Horizontal.TScale {
    Horizontal.Scale.trough -children {
        hscale
        Horizontal.Scale.slider -side left -sticky {}
    }
}

ttk::style element create vscale image ttk::theme::waldorf::scale_v -border 2

ttk::style layout Vertical.TScale {
    Vertical.Scale.trough -children {
        vscale
        Vertical.Scale.slider -side top -sticky {}
    }
}

# scrollbar: arrows removed; background changes disabled by putting an empty
# list in ttk::style map

ttk::style layout Horizontal.TScrollbar {
    Horizontal.Scrollbar.trough -sticky we -children {
        Horizontal.Scrollbar.thumb -expand 1 -sticky nswe
    }
}

ttk::style layout Vertical.TScrollbar {
    Vertical.Scrollbar.trough -sticky ns -children {
        Vertical.Scrollbar.thumb -expand 1 -sticky nswe
    }
}

ttk::style configure TScrollbar \
    -troughcolor gray78 -troughrelief flat -borderwidth 3 \
    -background gray56 -relief flat -width 9

ttk::style map TScrollbar -background [list \
]

# separator: layout with added separators

image create photo ttk::theme::waldorf::sep_h -data {
R0lGODdhGAAEAPYAANHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0c/Pz8/Pz9LS0tTU1NbW1tnZ2dvb29vb29vb
29vb29vb29vb29vb29vb29vb29vb29nZ2dbW1tTU1NLS0s/Pz8/Pz9HR0dHR0c/Pz83NzcvLy8nJ
ycXFxcPDw8LCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsLCwsPDw8XFxcjIyMrKys3Nzc/Pz9HR
0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR0dHR
0dHR0dHR0dHR0dHR0dHR0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAAYAAQAAAc6gH+Cg4SFhoQZGhscHR4fICEiIyQlJicoKSorLC0ugjEyMzQ1Njc4
OTo7PD0+P0BBQkNERUaHtrd/gQA7
}

image create photo ttk::theme::waldorf::sep_v -data {
R0lGODdhBAAYAPYAANHR0dHR0dHR0dHR0dHR0c/Pz8/Pz9HR0dHR0c3Nzc/Pz9HR0dHR0cvLy9LS
0tHR0dHR0cnJydTU1NHR0dHR0cXFxdbW1tHR0dHR0cPDw9nZ2dHR0dHR0cLCwtvb29HR0dHR0cLC
wtvb29HR0dHR0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR
0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR0cLCwtvb29HR0dHR0cPDw9nZ2dHR
0dHR0cXFxdbW1tHR0dHR0cjIyNTU1NHR0dHR0crKytLS0tHR0dHR0c3Nzc/Pz9HR0dHR0c/Pz8/P
z9HR0dHR0dHR0dHR0dHR0QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5
BAEAAH8ALAAAAAAEABgAAAdIgH+CggUGggkKgg0OghESghUWghkagh0egiEigiUmgikqgi0ugjEy
gjU2gjk6gj0+gkFCgkVGgklKgk1OglFSglVWgllag4KBADs=
}

ttk::style element create Separator.separator image ttk::theme::waldorf::sep_h \
    -border {8 1}

ttk::style element create Horizontal.separator image ttk::theme::waldorf::sep_h \
    -border {8 1}

ttk::style element create Vertical.separator image ttk::theme::waldorf::sep_v \
    -border {1 8}

ttk::style layout TSeparator {
    Separator.separator -sticky nswe
}

ttk::style layout Horizontal.TSeparator {
    Horizontal.separator -sticky nswe
}

ttk::style layout Vertical.TSeparator {
    Vertical.separator -sticky nswe
}

# sizegrip: the theme does not use sizegrips -> image blanked

image create photo ttk::theme::waldorf::sizegrip
ttk::theme::waldorf::sizegrip blank

ttk::style element create Sizegrip.sizegrip image ttk::theme::waldorf::sizegrip

# spinbox: layout with entry image and changed arrows

image create photo ttk::theme::waldorf::up -data {
R0lGODdhDwAMAPcAAMrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysnJycnJycnJycnJycnJ
ydXV1bS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tOPj47W1tfv7
+/v7+/v7+/v7+/v7+/r6+vr6+vr6+vv7+/v7+/v7+/v7+/v7+7W1tePj47e3t/X19fHx8fHx8fDw
8PDw8PDw8PDw8PDw8PDw8PDw8PHx8fHx8fX19be3t+Pj47i4uPHx8e3t7e3t7ezs7Ozs7Ozs7Ovr
6+zs7Ozs7Ozs7O3t7e3t7fHx8bi4uOPj47q6uu3t7enp6enp6enp6ejo6Ojo6Ojo6Ojo6Ojo6Onp
6enp6enp6e3t7bq6uuPj47y8vOnp6eXl5eXl5eTk5OXl5eXl5d7e3uXl5eXl5eTk5OXl5eXl5enp
6by8vOPj4729veXl5eHh4eLi4uHh4eHh4be3t0FBQbe3t+Hh4eHh4eLi4uHh4eXl5b29veTk5L+/
v+Hh4d7e3t7e3t7e3rW1tT8/P1JSUj8/P7W1td7e3t7e3t7e3uHh4b+/v+Tk5MHBwd7e3tra2tvb
27Kysjw8PDY2NjY2NjY2Njw8PLKystvb29ra2t7e3sHBweTk5MLCwtra2tjY2NjY2NnZ2dra2tvb
29vb29vb29ra2tnZ2djY2NjY2Nra2sLCwuTk5MTExNbW1tTU1NbW1tfX19jY2NnZ2dra2tnZ2djY
2NfX19bW1tTU1NbW1sTExOTk5MbGxtLS0tDQ0NPT09TU1NXV1dfX19jY2NfX19XV1dTU1NPT09DQ
0NLS0sbGxuTk5AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAADwAMAAAIzQAhRJAw
gUIFCxcwZNCwgUMHDyBCiBhBooSJEyhSqFjBooULGDFkzKBRw8YNHDl07ODRwweQIEKGECli5AiS
JEqWMGniBEoUKVOoVLFyBUsWLVu4dPECJoyYMWTKmDmDJo2aNWzauIETR84cOnXs3MGTR88ePn38
AAokaBChQoYOIUqkaBGjRo4gRZI0iVIlS5cwZdK0iVMnT6BCiRpFqpSpU6hSqVrFqpUrWLFkzaJV
y9YtXLl07eLVyxewYMKGEStm7BiyZMqWMWvmLCAAOw==
}

image create photo ttk::theme::waldorf::up_p -data {
R0lGODdhDwAMAPcAAMrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysnJycnJycnJycnJycnJ
ydXV1bS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tOPj47W1ta+v
r6+vr6+vr6+vr6+vr66urq6urq6urq+vr6+vr6+vr6+vr6+vr7W1tePj47e3t7Ozs7Ozs7Ozs7Ky
srKysrKysrKysrKysrKysrKysrOzs7Ozs7Ozs7e3t+Pj47i4uLm5ube3t7e3t7e3t7e3t7e3t7e3
t7e3t7e3t7e3t7e3t7e3t7m5ubi4uOPj47q6ury8vLu7u7u7u7u7u7u7u7u7u7u7u7u7u7u7u7u7
u7u7u7u7u7y8vLq6uuPj47y8vL+/v76+vr6+vr29vb6+vr6+vri4uL6+vr6+vr29vb6+vr6+vr+/
v7y8vOPj4729vcPDw8HBwcLCwsHBwcHBwZ2dnTk5OZ2dncHBwcHBwcLCwsHBwcPDw729veTk5L+/
v8XFxcPDw8PDw8PDw5+fnzg4OEhISDg4OJ+fn8PDw8PDw8PDw8XFxb+/v+Tk5MHBwcjIyMbGxsbG
xqGhoTY2NjAwMDAwMDAwMDY2NqGhocbGxsbGxsjIyMHBweTk5MLCwsnJycjIyMjIyMjIyMnJycrK
ysrKysrKysnJycjIyMjIyMjIyMnJycLCwuTk5MTExMrKysnJycrKysvLy8zMzMzMzM3NzczMzMzM
zMvLy8rKysnJycrKysTExOTk5MbGxtLS0tDQ0NPT09TU1NXV1dfX19jY2NfX19XV1dTU1NPT09DQ
0NLS0sbGxuTk5AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAADwAMAAAIzQAhRJAw
gUIFCxcwZNCwgUMHDyBCiBhBooSJEyhSqFjBooULGDFkzKBRw8YNHDl07ODRwweQIEKGECli5AiS
JEqWMGniBEoUKVOoVLFyBUsWLVu4dPECJoyYMWTKmDmDJo2aNWzauIETR84cOnXs3MGTR88ePn38
AAokaBChQoYOIUqkaBGjRo4gRZI0iVIlS5cwZdK0iVMnT6BCiRpFqpSpU6hSqVrFqpUrWLFkzaJV
y9YtXLl07eLVyxewYMKGEStm7BiyZMqWMWvmLCAAOw==
}

image create photo ttk::theme::waldorf::down -data {
R0lGODdhDwANAPcAAMbGxtLS0tDQ0NPT09TU1NXV1dfX19jY2NfX19XV1dTU1NPT09DQ0NLS0sbG
xuTk5MfHx9DQ0M/Pz9HR0dLS0tPT09XV1dXV1dXV1dPT09LS0tHR0c/Pz9DQ0MfHx+Tk5MnJyc7O
zs3Nzc7OztDQ0NHR0dPT09LS0tPT09HR0dDQ0M7Ozs3Nzc7OzsnJyeTk5MrKyszMzMzMzM3Nzaio
qDw8PDY2NjY2NjY2Njw8PKioqM3NzczMzMzMzMrKyuTk5MzMzMrKysnJycvLy8zMzKenpz4+Pk9P
Tz4+Pqenp8zMzMvLy8nJycrKyszMzOTk5M7OzsfHx8bGxsjIyMnJycvLy6ampj8/P6ampsvLy8nJ
ycjIyMbGxsfHx87OzuTk5M/Pz8XFxcPDw8XFxcbGxsfHx8fHx8LCwsfHx8fHx8bGxsXFxcPDw8XF
xc/Pz+Xl5dHR0cPDw8DAwMLCwsPDw8TExMXFxcTExMXFxcTExMPDw8LCwsDAwMPDw9HR0eXl5dPT
08HBwb6+vr6+vr+/v8DAwMHBwcHBwcHBwcDAwL+/v76+vr6+vsHBwdPT0+Xl5dTU1Ly8vLy8vLy8
vLy8vLy8vLy8vL29vby8vLy8vLy8vLy8vLy8vLy8vNTU1OXl5dbW1rq6urq6urq6urq6urq6urq6
urq6urq6urq6urq6urq6urq6urq6utbW1uXl5djY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY
2NjY2NjY2NjY2NjY2NjY2OXl5eXl5eXl5eXl5eXl5eTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OPj
4+Li4uLi4tzc3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAADwANAAAI3gABBBAw
gEABAwcQJFCwgEEDBxAiSJhAoYKFCxgyaNjAoYMHECFEjCBRwsQJFClUrGDRwgWMGDJm0Khh4waO
HDp28OjhA0gQIUOIFDFyBEkSJUuYNHECJYqUKVSqWLmCJYuWLVy6eAETRswYMmXMnEGTRs0aNm3c
wIkjZw6dOnbu4MmjZw+fPn4ABRI0iFAhQ4cQJVK0iFEjR5AiSZpEqZKlS5gyadrEqZMnUKFEjSJV
ytQpVKlUrWLVyhWsWLJm0apl6xauXLp28erlC1gwYcOIFTN2DFkyZcuYNXMWEAA7
}

image create photo ttk::theme::waldorf::down_p -data {
R0lGODdhDwANAPcAAMfHx6qqqqqqqqqqqqqqqqqqqqurq6urq6urq6qqqqqqqqqqqqqqqqqqqsfH
x+Tk5MfHx6qqqqqqqqqqqqqqqqqqqqurq6urq6urq6qqqqqqqqqqqqqqqqqqqsfHx+Tk5MnJyays
rKysrKysrK2tra2tra2tra2tra2tra2tra2traysrKysrKysrMnJyeTk5MrKyq+vr6+vr6+vr5CQ
kDU1NTAwMDAwMDAwMDU1NZCQkK+vr6+vr6+vr8rKyuTk5MzMzLGxsbGxsbGxsbKyspGRkTc3N0ZG
Rjc3N5GRkbKysrGxsbGxsbGxsczMzOTk5M7OzrKysrKysrOzs7Ozs7S0tJOTkzg4OJOTk7S0tLOz
s7Ozs7KysrKyss7OzuTk5M/Pz7S0tLOzs7S0tLW1tbW1tbW1tbCwsLW1tbW1tbW1tbS0tLOzs7S0
tM/Pz+Xl5dHR0bW1tbOzs7S0tLW1tbW1tba2trW1tba2trW1tbW1tbS0tLOzs7W1tdHR0eXl5dPT
07a2trS0tLS0tLW1tba2tra2tra2tra2tra2trW1tbS0tLS0tLa2ttPT0+Xl5dTU1LW1tbW1tbW1
tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tbW1tdTU1OXl5dbW1rW1tbW1tbW1tbW1tbW1tbW1
tbW1tbW1tbW1tbW1tbW1tbW1tbW1tdbW1uXl5djY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY
2NjY2NjY2NjY2NjY2NjY2OXl5eXl5eXl5eXl5eXl5eTk5OTk5OTk5OTk5OTk5OTk5OTk5OTk5OPj
4+Li4uLi4tzc3AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAADwANAAAI3gABBBAw
gEABAwcQJFCwgEEDBxAiSJhAoYKFCxgyaNjAoYMHECFEjCBRwsQJFClUrGDRwgWMGDJm0Khh4waO
HDp28OjhA0gQIUOIFDFyBEkSJUuYNHECJYqUKVSqWLmCJYuWLVy6eAETRswYMmXMnEGTRs0aNm3c
wIkjZw6dOnbu4MmjZw+fPn4ABRI0iFAhQ4cQJVK0iFEjR5AiSZpEqZKlS5gyadrEqZMnUKFEjSJV
ytQpVKlUrWLVyhWsWLJm0apl6xauXLp28erlC1gwYcOIFTN2DFkyZcuYNXMWEAA7
}

ttk::style element create Spinbox.uparrow image [list \
    ttk::theme::waldorf::up \
    {pressed} ttk::theme::waldorf::up_p \
]

ttk::style element create Spinbox.downarrow image [list \
    ttk::theme::waldorf::down \
    {pressed} ttk::theme::waldorf::down_p \
]

ttk::style layout TSpinbox {
    null -side right -sticky {} -children {
        Spinbox.uparrow -side top
        Spinbox.downarrow -side bottom
    }
    Entry.field -children {
        Spinbox.textarea
    }
}

# treeview: layout with changed heading; focus removed

image create photo ttk::theme::waldorf::heading -data {
R0lGODlhFQAVAPIAAKWlpby8vNfX1+vr6+/v7wAAAAAAAAAAACH5BAAAAAAALAAAAAAVABUAAAMq
SLrcLjDKSau9OGsZxqbdN4ViRJbCWaoi+7kbrMkZjdkXju4o4P/AoDABADs=
}

ttk::style element create Treeheading.border image ttk::theme::waldorf::heading -border 4

ttk::style layout Treeview.Item {
    Treeitem.padding -children {
        Treeitem.indicator -side left -sticky {}
        Treeitem.image -side left -sticky {}
        Treeitem.text -side left -sticky {}
    }
}

ttk::style configure Treeview -borderwidth 0

ttk::style configure Toolbutton -padding -7 -relief flat
ttk::style configure Toolbutton.label -padding 0 -relief flat -anchor center -justify center

image create photo ttk::theme::waldorf::blank -data {
  R0lGODlhGAAYAIAAAP8AAAAAACH5BAEAAAAALAAAAAAYABgAAAIWhI+py+0Po5y02ouz3rz7D4biSJZTAQA7
}

ttk::style element create Toolbutton.border image [list \
    ttk::theme::waldorf::blank \
    {!disabled pressed} ttk::theme::waldorf::button_p \
    {!disabled active} ttk::theme::waldorf::button_a \
    {!disabled focus} ttk::theme::waldorf::button_f \
    {disabled} ttk::theme::waldorf::blank \
    ] -border 11 -sticky nsew

}
