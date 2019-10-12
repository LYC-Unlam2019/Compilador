flex Lexico.l
pause
bison -dyv Sintactico.y
pause
gcc.exe lex.yy.c y.tab.c -o Segunda.exe
pause

del lex.yy.c
del y.tab.c
del y.output