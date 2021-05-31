include macros2.asm
include number.asm
.MODEL	LARGE 
.386
.STACK 200h 
.DATA 
_numero1                       	DD	?
_real1                         	DD	?
_cadena1                       	DB	?
_numero2                       	DD	?
_real2                         	DD	?
_real3                         	DD	?
_numero3                       	DD	?
_numero4                       	DD	?
_cadena2                       	DB	?
_2                            	DD	2.000000
_6                            	DD	6.000000
_99999f990000                 	DD	99999.99
_99f000000                    	DD	99.00
_0f999900                     	DD	1.00
_1                            	DD	1.000000
_4                            	DD	4.000000
_3                            	DD	3.000000
_@sdADaSjfla%dfg               	DB	"@sdADaSjfla%dfg"
_asldkfhsjf                    	DB	"asldkfhsjf"
@aux1                         	DD	?
@aux2                         	DD	?
@aux3                         	DD	?
@aux4                         	DD	?
@aux5                         	DD	?
@aux6                         	DD	?
.CODE 
MAIN:


mov AX,@DATA 	;inicializa el segmento de datos
mov DS,AX 
mov ES,AX 
FNINIT 

FLD _2
FSTP _numero1
FFREE
FLD _6
FSTP _numero2
FFREE
FLD _99999f990000
FSTP _real1
FFREE
FLD _99f000000
FSTP _real2
FFREE
FLD _0f999900
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
FLD _1
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
FCOMP _6
FSTSW AX
SAHF
FFREE
JNE .endif2
DISPLAYFLOAT _numero2,2
.endif2:
.endif1:
FLD _1
FCOMP _4
FSTSW AX
SAHF
FFREE
JLE .continuefilter
FFREE
FLD _1
JMP .finfilter
.continuefilter:
FLD _2
FCOMP _4
FSTSW AX
SAHF
FFREE
JLE .continuefilter
FFREE
FLD _2
JMP .finfilter
.continuefilter:
FLD _4
FCOMP _4
FSTSW AX
SAHF
FFREE
JLE .continuefilter
FFREE
FLD _4
JMP .finfilter
.continuefilter:
FLD _6
FCOMP _4
FSTSW AX
SAHF
FFREE
JLE .continuefilter
FFREE
FLD _6
JMP .finfilter
.continuefilter:
.finfilter:
FLD _4
FLD _numero1
FADD
FSTP @aux2
FFREE
FLD @aux2
FLD _6
FDIV
FSTP @aux3
FFREE
FLD @aux3
FLD _6
FMUL
FSTP @aux4
FFREE
FLD @aux2
FLD @aux4
FSUB
FSTP @aux5
FFREE
FLD _1
FLD @aux5
FADD
FSTP @aux6
FFREE
FLD _@sdADaSjfla%dfg
FSTP _cadena1
FFREE
FLD _asldkfhsjf
FSTP _cadena2
FFREE
CALL READ, _numero3
DISPLAYFLOAT _numero4,2

	 mov AX, 4C00h 	 ; Genera la interrupcion 21h
	 int 21h 	 ; Genera la interrupcion 21h
END MAIN
