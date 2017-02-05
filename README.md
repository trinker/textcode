textcode   [![Follow](https://img.shields.io/twitter/follow/tylerrinker.svg?style=social)](https://twitter.com/intent/follow?screen_name=tylerrinker)
============


[![Build
Status](https://travis-ci.org/trinker/textcode.svg?branch=master)](https://travis-ci.org/trinker/textcode)
[![Coverage
Status](https://coveralls.io/repos/trinker/textcode/badge.svg?branch=master)](https://coveralls.io/r/trinker/textcode?branch=master)
<a href="https://img.shields.io/badge/Version-0.0.1-orange.svg"><img src="https://img.shields.io/badge/Version-0.0.1-orange.svg" alt="Version"/></a>
</p>
**textcode** provides tools for qualitative text coding. The tools
enhance the ability to: (a) export text for qualitative coding, (b)
import coding schemes, and (c) reshape the imports into an analysis
ready format. This package ports much of the coding mechanisms from the
[**qdap**](https://github.com/trinker/qdap) package but with
consistency, more obvious usage, optimization all in a single package.

-  [ ] export tools:
  -  [ ] .csv (word \[in qdap\], sentence, turn of talk level)
  -  [ ] spanning sheets (time)
  -  [ ] Transcript out with word numbering \[in qdap\] but add
    sentence numbering too ((1)) sent one. ((2)) sent two.
-  [ ] examine tools:
  -  [ ] text and html concordance/context
  -  [ ] import tools \[in qdap\]


Table of Contents
============

-   [Installation](#installation)
-   [Contact](#contact)

Installation
============


To download the development version of **textcode**:

Download the [zip
ball](https://github.com/trinker/textcode/zipball/master) or [tar
ball](https://github.com/trinker/textcode/tarball/master), decompress
and run `R CMD INSTALL` on it, or use the **pacman** package to install
the development version:

    if (!require("pacman")) install.packages("pacman")
    pacman::p_load_gh("trinker/textcode")

Contact
=======

You are welcome to:    
- submit suggestions and bug-reports at: <https://github.com/trinker/textcode/issues>    
- send a pull request on: <https://github.com/trinker/textcode/>    
- compose a friendly e-mail to: <tyler.rinker@gmail.com>    
