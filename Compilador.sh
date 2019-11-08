#!/bin/sh

flex Lexico.l
bison -dyv Sintactico.y
gcc lex.yy.c y.tab.c -o Segunda

rm lex.yy.c
rm y.tab.c
rm y.output
