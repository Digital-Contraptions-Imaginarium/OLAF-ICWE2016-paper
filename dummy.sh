#!/bin/bash

# BibTeX to bibitem conversion instructions thanks to
# http://tex.stackexchange.com/questions/124874/converting-to-bibitem-in-latex
rm dummy.aux;dummy.bbl;rm dummy.blg;rm dummy.log
/Library/TeX/Distributions/Programs/texbin/latex dummy
/Library/TeX/Distributions/Programs/texbin/bibtex dummy
/Library/TeX/Distributions/Programs/texbin/bibtex dummy
/Library/TeX/Distributions/Programs/texbin/latex dummy
