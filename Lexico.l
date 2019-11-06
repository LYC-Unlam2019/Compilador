/**
 * 
 *  UNLaM
 *  Lenguajes y Compiladores ( 2019 2C )
 *   
 *  Temas especiales: 
 *     1-Filter
 *	   2-MOD/DIV
 *
 *  Docente:  Mara Capuya , Henan Villareal, Daniel Carrizo
 *
 *  Integrantes:
 *	Cairo, Matias | Calá, Federico | Lima, Maximiliano | Martin Mora, Juan Manuel | Tomaino, Matias
 *
 */
%{

/* include area */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"

void cota_error(char* mensaje);
float formateoNumero(char* num);
float my_atof(const char *s);

%}

%option noyywrap
%option yylineno

DIGITO 			[0-9]
CHAR 			[a-zA-Z]

ENTERO 			{DIGITO}+
CONSTANTE_ENTERA 	-?{ENTERO}
CONSTANTE_REAL 	-?{DIGITO}*"."{DIGITO}*

ID 	{CHAR}({CHAR}|{DIGITO}|_)*

NUEVA_SENTENCIA	[\r\n]
TABULACION 		[\t]
ESPACIO       " "
CARACTERES_ESPECIALES [\@\$\_\~\\\,\%]
CARACTERES_NO_PERMITIDOS [#\^\*\(\)\-\+\=\|\/\?\>\<\!\;\.\:\'\"\[\]\{\}]

INICIO_FIN_STR \"
CADENA ({CARACTERES_ESPECIALES}|{CARACTERES_NO_PERMITIDOS}|{DIGITO}|{CHAR}|{ESPACIO}|{TABULACION})
CONSTANTE_STRING {INICIO_FIN_STR}{CADENA}*{INICIO_FIN_STR}

INICIO_COMENTARIO "--/"
FIN_COMENTARIO "/--"
COMENTARIO {INICIO_COMENTARIO}{CADENA}*{FIN_COMENTARIO}

%%

"START"                   { return START; }

"END"                     { return END; }

"IF"                      { return IF; }

"ELSE"                    { return ELSE; }

"THEN"					  { return THEN; }

"ENDIF"                   { return ENDIF; }

"REPEAT"                   { return REPEAT; }

"ENDREPEAT"                { return ENDREPEAT; }

"FILTER"                  { return FILTER; }

"DIV"					  { return DIV; }

"MOD"					  { return MOD; }
                   
"VAR"                  	  { return VAR; }

"ENDVAR"                  { return ENDVAR; }

"PRINT"                   { return PRINT; }

"READ"                     { return READ; }

"INTEGER"                     { 
                            yylval.valor_int = atoi( yytext );
                            return INTEGER;
                          }

"FLOAT"                   { 
                            yylval.valor_float = atof( yytext );
                            return FLOAT;
                          }

"STRING"                  { 
                            yylval.valor_string = strdup( yytext );
                            return STRING;
                          }

":"                       { return DOS_PUNTOS; }

";"                       { return PUNTO_COMA; }

","                       { return COMA; }      

"_"                       { return GUION_BAJO; }                          

"+"                       { return SUMA; }

"-"                       { return RESTA; }

"*"                       { return POR; }

"/"                       { return DIVIDIDO; }

"AND"                     { return AND; }

"OR"                      { return OR; }

"NOT"                     { return NOT; }

":="                      { return ASIG; }

"<"                       { return MENOR; }

"<="                      { return MENOR_IGUAL; }

">"                       { return MAYOR; }

">="                      { return MAYOR_IGUAL; }

"=="                      { return IGUAL; }

"!="                      { return DISTINTO; }
                            
"("                       { return PA; }

")"                       { return PC; }

"["                       { return CA; }

"]"                       { return CC; }

{ID}          			  {
			                if(strlen(yytext) <= 30){
			                  yylval.valor_string = strdup(yytext);
			                  return ID;
			                }
							cota_error("El nombre de variable excede el limite permitido.");
			              }    
                        
{CONSTANTE_REAL}  		  {
							char* p = strchr(yytext,'.');
		                    printf("%s\n", p?p:"No" );
		                    //LO ACOTE A SEIS DIGITOS 
		                    if(atof(yytext)<=-3.40282347e+38F || atof(yytext)>=3.40282347e+38F || (p && strlen(p) > 6 )){
									cota_error("El valor de un flotante excede el limite permitido.");
		                 	}
		                    	yylval.valor_float = formateoNumero(yytext);
		                    	return CTE_FLOAT;                    
		        
		                  }  

{CONSTANTE_ENTERA}        {
		                      if(atoll(yytext)>=-32768 && atoll(yytext)<=32767){
		                      	yylval.valor_int = atoi(yytext);
		                      	return CTE_INT;
		                      }
							  cota_error("El valor del entero excede el limite permitido.");
		                  } 

{CONSTANTE_STRING}		  {	
							if(strlen(yytext)<=30){
							strcpy(yylval.valor_string,yytext);
							return CTE_STRING;
							}
							cota_error("El contenido de una cadena excede el limite permitido.");
						  }
{COMENTARIO}			  {	
							char *comentarios;
							char *segundoNivelDeComentarios;
							comentarios = (strstr(yytext,"/--"));
							segundoNivelDeComentarios = strstr(comentarios+3,"/--");
							if(segundoNivelDeComentarios != NULL){
								if ( strstr(segundoNivelDeComentarios+3,"/--") != NULL){
									cota_error("Solo se permite un nivel de comentarios anidados.");								
								}
							}	
						  }							
%%

void cota_error(char* mensaje)
{
	printf("Error lexico: %s\n", mensaje);
	system ("Pause");
	exit (1);
}

/**PARA FORMATEAR EL NUMERO**/
float formateoNumero(char* num){
char format [100];
char aux [100];
int i = 0, j = 0, decimales = 0;
strcpy(aux,num);
  if(aux[i] == '.'){
	format[j] = '0';
	j ++;
   }else{
	  while((format[j] = aux[i] ) != '.'){
		i ++ ; 
		j ++;
	  }
   }								      
		  format[j] = '.'; /*pego el punto*/ 
		  i++;
		  j++;
		  if( aux[i] == '\0'){/*Despues del punto */
			format[j] = '0';
			 j ++;
			format[j] = '\0';  
		  }else{
			while((format[j] = aux[i]  ) != '\0'){
				i++;
				j++;
				decimales ++;
			}
			while (decimales ++ < 6){
				format[j] = '\0';
				j++;																																																																																																							
			}
	   		 format[j] = '\0';  
		  }

	  return my_atof(format) ;
}

float my_atof(const char *s){
	int n1=0,n2=0,i,t,c=1;
	float f1,f2;
	for(i=0;s[i]!='.';++i)
	{
		if((s[i]>=48)&&(s[i]<=57))
		{
			n1=n1*10 +(s[i]-48);
		}
	}
	for(i=i+1;s[i];++i)
	{
		if((s[i]>=48)&&(s[i]<=57))
		{
			n2=n2*10 +(s[i]-48);
		}
	}
	t=n2;
	f1=n1;
	f2=n2;
	while(t)
	{
		t=t/10;
		c=c*10;
	}
	f2=f2/c;
	return (f1+f2);
}