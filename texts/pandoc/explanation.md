---
title: Test
author: Author Name
header-includes: |
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhead[CO,CE]{This is fancy}
    \fancyfoot[CO,CE]{So is this}
    \fancyfoot[LE,RO]{\thepage}
abstract: This is a pandoc test . . .
---

***

how I did the one short assignment

```
header-includes: |
    \usepackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhead[R]{Ben Miller}
```

# main title

***

title: Test
author: Author Name
header: This is fancy
footer: So is this
geometry: margin=1in
abstract: This is a pandoc test . . .

Having the title in the header makes the first page a title page

use the pandoct command in zsh_user to compile easily to pdf

For the header footer letters
E: Even page
O: Odd page
L: Left field
C: Center field
R: Right field
H: Header
F: Footer


The decorative lines can be changed by increasing/decreasing their thickness (0pt means no line):

```
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
```

Note: According to the fancyhdr-documentation, the default layout is produced by the following commands:

```
\fancyhead[LE,RO]{\slshape \rightmark}
\fancyhead[LO,RE]{\slshape \leftmark}
\fancyfoot[C]{\thepage}
\headrulewidth 0.4pt
\footrulewidth 0 pt
```
