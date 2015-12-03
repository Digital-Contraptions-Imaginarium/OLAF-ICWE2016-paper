#!/bin/bash

# BibTeX to bibitem conversion instructions thanks to
# http://tex.stackexchange.com/questions/124874/converting-to-bibitem-in-latex
rm compile_bibitems.aux;rm compile_bibitems.bbl;rm compile_bibitems.blg;rm compile_bibitems.log
/Library/TeX/Distributions/Programs/texbin/latex compile_bibitems
/Library/TeX/Distributions/Programs/texbin/bibtex compile_bibitems
/Library/TeX/Distributions/Programs/texbin/bibtex compile_bibitems
/Library/TeX/Distributions/Programs/texbin/latex compile_bibitems
