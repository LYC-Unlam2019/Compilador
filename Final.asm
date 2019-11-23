include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 
.DATA 
_numero1                       	DD	?
_real1                         	DD	?
_cadena1                       	DD	?
_numero2                       	DD	?
_real2                         	DD	?
_real3                         	DD	?
_numero3                       	DD	?
_numero4                       	DD	?
_cadena2                       	DD	?
_2                            	DD	2.00
_6                            	DD	6.00
_99999                         	DD	99999.99
_99                            	DD	99.00
_0                             	DD	1.00
_1                            	DD	1.00
_4                            	DD	4.00
_3                            	DD	3.00
_@sdADaSjfla%dfg               	DD	"@sdADaSjfla%dfg"
_asldkfhsjf                    	DD	"asldkfhsjf"
_hola mundo                    	DD	"hola mundo"
@aux1                         	DD	?
@aux2                         	DD	?
@aux3                         	DD	?
@aux4                         	DD	?
@aux5                         	DD	?
@aux6                         	DD	?
@aux7                         	DD	?
.CODE 
MAIN:


mov AX,@DATA 	;inicializa el segmento de datos
mov DS,AX 
mov ES,AX 
FNINIT 

FLD 2
FSTP _numero1
FFREE
FLD 6
FSTP _numero2
FFREE
FLD 99999.990000
FSTP _real1
FFREE
FLD 99.000000
FSTP _real2
FFREE
FLD 0.999900
FSTP _real3
FFREE
FLD _numero1
FCOMP _numero2
FSTSW AX
SAHF
FFREE
JE .else1
FLD _numero1
FCOMP _numero3
FSTSW AX
SAHF
FFREE
JNE .else1
.repeat1:
FLD _numero1
FCOMP _numero2
FSTSW AX
SAHF
FFREE
JGE .endrepeat1
FLD _numero1
FLD 1
FADD
FSTP @aux1
FFREE
FLD @aux1
FSTP _numero1
FFREE
JMP .repeat1
.endrepeat1:
JMP .endif1
.else1:
FLD _numero1
FCOMP 6.00
FSTSW AX
SAHF
FFREE
JNE .endif2
CALL PRINT, _numero2
.endif2:
.endif1:
FLD 4
FLD _numero1
FADD
FSTP @aux2
FFREE
FLD 1.00
FCOMP _@aux2
FSTSW AX
SAHF
FFREE
JLE
FLD 1.00
FCOMP 6.50
FSTSW AX
SAHF
FFREE
JG .continue-filter
FFREE
FLD 0.000000
JMP .end-filter
.continue-filter:
FLD 2.00
FCOMP _@aux2
FSTSW AX
SAHF
FFREE
JLE
FLD 2.00
FCOMP 6.50
FSTSW AX
SAHF
FFREE
JG
FLD 6616640.00
FCOMP 6616640.00
FSTSW AX
SAHF
FFREE
JG .continue-filter
FFREE
FLD 6616640
JMP .end-filter
.continue-filter:
FLD 4.00
FCOMP _@aux2
FSTSW AX
SAHF
FFREE
JLE
FLD 4.00
FCOMP 6.50
FSTSW AX
SAHF
FFREE
JG
FLD 6616640.00
FCOMP 6616640.00
FSTSW AX
SAHF
FFREE
JG .continue-filter
FFREE
FLD 6616640
JMP .end-filter
.continue-filter:
FLD 6.00
FCOMP _@aux2
FSTSW AX
SAHF
FFREE
JLE
FLD 6.00
FCOMP 6.50
FSTSW AX
SAHF
FFREE
JG
FLD 6616640.00
FCOMP 6616640.00
FSTSW AX
SAHF
FFREE
JG .continue-filter
FFREE
FLD 6616640
JMP .end-filter
.continue-filter:
.end-filter:
FLD 4
FLD _numero1
FADD
FSTP @aux3
FFREE
FLD @aux3
FLD 6
FDIV
FSTP @aux4
FFREE
FLD @aux4
FLD 6
FMUL
FSTP @aux5
FFREE
FLD @aux3
FLD @aux5
FSUB
FSTP @aux6
FFREE
FLD 1
FLD _@aux6
FADD
FSTP @aux7
FFREE
FLD _"@sdADaSjfla%dfg"
FSTP _cadena1
FFREE
FLD _"asldkfhsjf"
FSTP _cadena2
FFREE
CALL READ, _numero3
CALL PRINT, _"hola mundo"
CALL PRINT, _numero4

	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
