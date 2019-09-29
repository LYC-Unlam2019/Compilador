/**
 * 
 *  UNLaM
 *  Lenguajes y Compiladores ( 2019 2C )
 *   
 *  Temas especiales: 
 *     1-Filter
 *	   2-MOD/DIV
 *
 *  Docente:  Mara Capuya , Hernan Villareal, Daniel Carrizo
 *
 *  Integrantes:
 *	Cairo, Matias | Calá, Federico | Lima, Maximiliano | Martin Mora, Juan Manuel | Tomaino, Matias
 *      
 */
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "y.tab.h"

	/* Tipos de datos para la tabla de simbolos */
  	#define Integer 1
	#define Float 2
	#define String 3
	#define CteInt 4
	#define CteFloat 5
	#define CteString 6
	#define SIN_MEM -4
	#define NODO_OK -3
	#define TAMANIO_TABLA 300
	#define TAM_NOMBRE 32

	/* Defino estructura de informacion para el arbol*/
	typedef struct {
		int tipoDato;
		int entero;
		float flotante;
		char cadena[40];
	}tInfo;

	/* Defino estructura de nodo de arbol*/
	typedef struct sNodo{
		tInfo info;
		struct sNodo *izq, *der;
	}tNodo;

	/* Defino estructura de arbol*/
	typedef tNodo* tArbol;
    tInfo infoArbol;
	/* Funciones necesarias */
	int yylex();
	int yyerror(char* mensaje);
	void agregarVarATabla(char* nombre);
	void agregarTiposDatosATabla(void);
	void agregarCteATabla(int num);
	void chequearVarEnTabla(char* nombre);
	int buscarEnTabla(char * nombre);
	void grabarTabla(void);
	void chequearPrintId(char *nombre);

	/**FUNCIONES PARA LA ENTREGA 2 **/
	tNodo* crearNodo(char* dato, tNodo *pIzq, tNodo *pDer);
	tNodo* crearHoja(const tInfo* info);
	void rellenarInfo(int tipoDato, tInfo* info);
	void mostrar_grafico(tArbol *pa, int n);

	int yystopparser=0;
	FILE  *yyin;

	/* Cosas de tabla de simbolos */
	typedef struct {
		char nombre[TAM_NOMBRE];
		int tipo_dato;
		char valor_s[TAM_NOMBRE];
		float valor_f;
		int valor_i;
		int longitud;
	} TS_Reg;


	TS_Reg tabla_simbolo[TAMANIO_TABLA];
	int fin_tabla = -1;

	/* Cosas para la declaracion de variables y la tabla de simbolos */
	int varADeclarar1 = 0;
	int cantVarsADeclarar = 0;
	int tipoDatoADeclarar;
	
	/* Declaraciones globales de punteros de elementos no terminales para el arbol de sentencias basicas*/

	tArbol 	asigPtr,			//Puntero de asignaciones
			exprPtr,			//Puntero de expresiones
			exprCadPtr,			//Puntero de expresiones de cadenas
			exprAritPtr,		//Puntero de expresiones aritmeticas
			terminoPtr,			//Puntero de terminos
			factorPtr,			//Puntero de factores
			programaPtr,		//Puntero de programa	
			secDecPtr,			//Puntero de seccion declaracion
			bloqueDecPtr,		//Puntero de bloque declaracion	
			declaPtr,			//Puntero de declaracion
			tDatosPtr,			//Puntero de t_datos
			listaIdPtr,			//Puntero de lista de ids
			tDatoPtr,			//Puntero de t_dato
			bloquePtr,			//Puntero de bloque
			sentenciaPtr,		//Puntero de sentencia	
			bloqueIfPtr,		//Puntero de bloque If
			bloqueWhPtr,		//Puntero de bloque de While
			lecturaPtr,			//Puntero de lectura
			escrituraPtr,		//Puntero de escritura
			expreLogPtr,		//Puntero de expresion logica	
			filterPtr,			//Puntero de filter
			termLogPtr,			//Puntero de termino logico
			compBoolPtr,		//Puntero de comparador Booleano	
			terminoFilterPtr,	//Puntero de termino de filter		
			compFilterPtr,   	//Puntero de comparador de filter	
			listaExpComaPtr;	//Puntero de lista expresion coma		
%}

/* Tipo de estructura de datos, toma el valor SUMA grande*/
%union {

	int valor_int;
	float valor_float;
	char *valor_string;
}

%token START
%token END

%token VAR ENDVAR
%token INTEGER FLOAT STRING

%token REPEAT ENDREPEAT
%token IF THEN ELSE ENDIF

%token AND OR NOT

%token ASIG
%token <valor_string> SUMA RESTA
%token DIVIDIDO
%token POR

%token MENOR  MAYOR MENOR_IGUAL MAYOR_IGUAL
%token IGUAL DISTINTO

%token PA PC
%token CA CC
%token COMA
%token PUNTO_COMA
%token DOS_PUNTOS
%token GUION_BAJO

%token READ
%token PRINT

%token FILTER
%token DIV
%token MOD

%token <valor_string>ID
%token <valor_float>CTE_FLOAT
%token <valor_int>CTE_INT
%token <valor_string>CTE_STRING

%%

programa:
	START seccion_declaracion bloque END 	            {
															printf("\nCOMPILACION EXITOSA\n");
															grabarTabla();

															
														};

 /* Declaracion de variables */

seccion_declaracion:
	VAR bloque_dec ENDVAR 				            {printf("R 1: Seccion declaracion => VAR bloque_dec ENDVAR\n");};

bloque_dec:
	bloque_dec declaracion					            {printf("R 2: bloque_dec => bloque_dec declaracion\n");}
	| declaracion							            {printf("R 3: bloque_dec => declaracion\n");};

declaracion:
	CA t_datos CC DOS_PUNTOS CA lista_id CC				{
															printf("R 4: declaracion => t_dato DOS_PUNTOS lista_id\n");
															 agregarTiposDatosATabla();
														};

t_datos:
	t_datos COMA t_dato									{printf("R 5: t_datos => t_datos COMA t_dato\n");}
	| t_dato 											{printf("R 6: t_datos => t_dato \n");};

t_dato:
	FLOAT		                                        {
															printf("R 7: t_dato => FLOAT\n");
															tipoDatoADeclarar = Float;
														}
	| INTEGER		                                        {
															printf("R 8: t_dato => INTEGER\n");
															tipoDatoADeclarar = Integer;
														}
	| STRING	                                        {
															printf("R 9: t_dato => STRING\n");
															tipoDatoADeclarar = String;
														};

lista_id:
	lista_id COMA ID	                            {
	                                                        printf("R 8: lista_id => lista_id COMA ID\n");
	                                                        agregarVarATabla(yylval.valor_string);
															cantVarsADeclarar++;
                                                        }
	| ID				                                {
	                                                        printf("R 9: lista_id => ID\n");
	                                                        agregarVarATabla(yylval.valor_string);
															varADeclarar1 = fin_tabla; /* Guardo posicion de primer variable de esta lista de declaracion. */
															cantVarsADeclarar = 1;
                                                        };

 /* Fin de Declaracion de variables */

 /* Seccion de codigo */

bloque:                                                 /* No existen bloques sin sentencias */
	bloque sentencia	                                {   
															printf("R 10: bloque => bloque sentencia\n");
														 	bloquePtr = crearNodo("SALTA",bloquePtr, sentenciaPtr);
														 	mostrar_grafico(&bloquePtr,15);
														 	printf("RAIZ: %s\n",bloquePtr->info.cadena );	
														}
	
	| sentencia			                                {printf("R 11: bloque => sentencia\n"); bloquePtr = sentenciaPtr;};

sentencia:
	asignacion			                    			{printf("R 12: sentencia => asignacion\n"); sentenciaPtr = asigPtr; }
	| bloque_if                                         {printf("R 13: sentencia => bloque_if\n"); sentenciaPtr = bloqueIfPtr;}
	| bloque_while                                      {printf("R 14: sentencia => bloque_while\n"); sentenciaPtr = bloqueWhPtr;}
	| lectura                                			{printf("R 15: sentencia => lectura\n");sentenciaPtr = lecturaPtr;}
	| escritura                              			{printf("R 16: sentencia => escritura\n");sentenciaPtr = escrituraPtr;}
	| expresion_aritmetica                   			{printf("R 17: sentencia => expresion_aritmetica\n");sentenciaPtr = exprAritPtr;};

bloque_if:
    IF expresion_logica THEN bloque ENDIF               {printf("R 18: bloque_if => IF expresion_logica THEN bloque ENDIF\n");};

bloque_if:
    IF expresion_logica THEN bloque ELSE bloque ENDIF   {printf("R 19: bloque_if => IF expresion_logica THEN bloque ELSE bloque ENDIF\n");};

bloque_while:
    REPEAT expresion_logica bloque ENDREPEAT              {printf("R 20: bloque_while => REPEAT expresion_logica bloque ENDREPEAT\n");};

asignacion:
	ID ASIG expresion	                                {
															chequearVarEnTabla($1);
															printf("R 21: asignacion => ID ASIG expresion\n");
															/*Aca no uso rellenar porque tomo el valor $1)*/
															infoArbol.tipoDato = String;
															infoArbol.entero = 0 ;
															strcpy(infoArbol.cadena,$1);
															asigPtr = crearNodo(":=", crearHoja(&infoArbol), exprPtr);
														
														};

/* Expresiones aritmeticas y otras */

expresion:
	expresion_cadena				                    {
															printf("R 22: expresion => expresion_cadena\n");
															exprPtr = exprCadPtr;
														}
	| expresion_aritmetica			                    {
															printf("R 23: expresion => expresion_aritmetica\n");
															exprPtr = exprAritPtr;
														};

expresion_cadena:
	CTE_STRING						                    {
															rellenarInfo(CteString,&infoArbol);
														 	exprCadPtr = crearHoja(&infoArbol);
															printf("R 24: expresion_cadena => CTE_STRING\n");
															agregarCteATabla(CteString);
						
														};

expresion_aritmetica:
	expresion_aritmetica SUMA termino 		            {
															printf("R 25: expresion_aritmetica => expresion_aritmetica SUMA termino\n");
															exprAritPtr = crearNodo("+", exprAritPtr, terminoPtr);
														}
	| expresion_aritmetica RESTA termino 	            {
															printf("R 26: expresion_aritmetica => expresion_aritmetica RESTA termino\n");
															exprAritPtr = crearNodo("-", exprAritPtr, terminoPtr);
														}
	| expresion_aritmetica MOD termino                  {	printf("R 27: expresion_aritmetica => expresion_aritmetica MOD termino\n");
															exprAritPtr = crearNodo("MOD", exprAritPtr, terminoPtr);
														}
 	| expresion_aritmetica DIV termino                  {	printf("R 28: expresion_aritmetica => expresion_aritmetica DIV termino\n");
															exprAritPtr = crearNodo("/", exprAritPtr, terminoPtr);
														}
	| termino								            {	printf("R 29: expresion_aritmetica => termino\n");
															exprAritPtr = terminoPtr;
														};

termino:
	termino POR factor 			                        {	printf("R 30: termino => termino POR factor\n");
															terminoPtr = crearNodo("*", terminoPtr, factorPtr);
															

														}
	| termino DIVIDIDO factor 	                        {	printf("R 31: termino => termino DIVIDIDO factor\n");
															//terminoPtr = crearNodo("DIVIDIDO",&terminoPtr, &factorPtr);
														}
	| factor					                        {	printf("R 32: termino => factor\n");
															terminoPtr = factorPtr;	
														};

factor:
	PA expresion_aritmetica PC	                        {	printf("R 33: factor => PA expresion_aritmetica PC\n");
															factorPtr = exprAritPtr;
														}
	| filter 											{	printf("R 34: factor => FILTER\n");
														    factorPtr = filterPtr;
														};

factor:
	ID			                                        {
															chequearVarEnTabla(yylval.valor_string);
															printf("R 35: factor => ID\n");
															rellenarInfo(String,&infoArbol);
															factorPtr = crearHoja(&infoArbol);
														}
	| CTE_FLOAT	                                        {
															rellenarInfo(CteFloat,&infoArbol);
															agregarCteATabla(CteFloat);
															factorPtr = crearHoja(&infoArbol);
															printf("R 36: factor => CTE_FLOAT\n");
														}
	| CTE_INT	                                        {
															printf("R 37: factor => CTE_INT\n");
															
															rellenarInfo(CteInt,&infoArbol);	
															agregarCteATabla(CteInt);
															factorPtr = crearHoja(&infoArbol);

														};
/* Expresiones logicas */

expresion_logica:
    termino_logico AND termino_logico                 {printf("R 38: expresion_logica => termino_logico AND termino_logico\n");}
    | termino_logico OR termino_logico                {printf("R 39: expresion_logica => termino_logico OR termino_logico\n");}
    | termino_logico                                    {printf("R 40: expresion_logica => termino_logico\n");}

termino_logico:
    NOT termino_logico                              		{printf("R 41: NOT termino_logico\n");}
    | expresion_aritmetica comp_bool expresion_aritmetica 	{printf("R 42: termino_logico => expresion_aritmetica comp_bool expresion_aritmetica\n");}

termino_filter:
    GUION_BAJO comp_bool PA expresion_aritmetica PC         {printf("R 43: termino_filter => GUION_BAJO comp_bool PA expresion_aritmetica PC  \n");}
    | GUION_BAJO comp_bool CTE_FLOAT			  			{printf("R 44: termino_filter => GUION_BAJO comp_bool CTE_FLOAT\n");}
    | GUION_BAJO comp_bool CTE_INT			  				{printf("R 45: termino_filter => GUION_BAJO comp_bool CTE_INT\n");};

comparacion_filter:
    termino_filter AND termino_filter		  			{printf("R 46: comparacion_filter => termino_filter AND termino_filter\n");}
    | termino_filter OR termino_filter   				{printf("R 47: comparacion_filter => termino_filter OR termino_filter\n");}
    | termino_filter		  							{printf("R 48: comparacion_filter => termino_filter\n");}

comp_bool:
    MENOR                                               {printf("R 49: comp_bool => MENOR\n");}
    |MAYOR                                              {printf("R 50: comp_bool => MAYOR\n");}
    |MENOR_IGUAL                                        {printf("R 51: comp_bool => MENOR_IGUAL\n");}
    |MAYOR_IGUAL                                        {printf("R 52: comp_bool => MAYOR_IGUAL\n");}
    |IGUAL                                              {printf("R 53: comp_bool => IGUAL\n");}
    |DISTINTO                                           {printf("R 54: comp_bool => DISTINTO\n");};
	

filter:
	FILTER PA comparacion_filter COMA CA lista_exp_coma CC PC {printf("R 55: FILTER => FILTER PA comparacion_filter COMA CA lista_exp_coma CC PC\n");}

lista_exp_coma:
    lista_exp_coma COMA expresion_aritmetica            {printf("R 56: lista_exp_coma => lista_exp_coma COMA expresion_aritmetica\n");}
    | expresion_aritmetica                              {printf("R 57: lista_exp_coma => expresion_aritmetica\n");};

lectura:
    READ ID												{
															chequearVarEnTabla($2);
															printf("R 58: lectura => READ ID\n");
														};


escritura:
    PRINT ID                                            {
															chequearVarEnTabla($2);
															chequearPrintId($2);
															rellenarInfo(String,&infoArbol);
															escrituraPtr = crearNodo("PRINT", escrituraPtr, crearHoja(&infoArbol));
															printf("R 59: escritura => PRINT ID\n");
														}
    | PRINT CTE_STRING                                  {
															printf("R 60: escritura => PRINT CTE_STRING\n");
															agregarCteATabla(CteString);
														};


%%

int main(int argc,char *argv[]){
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yyparse();
  	fclose(yyin);
  }
  return 0;
}


int yyerror(char* mensaje)
 {
	printf("Syntax Error: %s\n", mensaje);
	system ("Pause");
	exit (1);
 }

/* Funciones de la tabla de simbolos */

/* Devuleve la posicion en la que se encuentra el elemento buscado, -1 si no encontr� el elemento */
int buscarEnTabla(char * nombre){
   int i=0;
   while(i<=fin_tabla){
	   if(strcmp(tabla_simbolo[i].nombre,nombre) == 0){
		   return i;
	   }
	   i++;
   }
   return -1;
}

 /** Agrega un nuevo nombre de variable a la tabla **/
 void agregarVarATabla(char* nombre){
	 //Si se llena, error
	 if(fin_tabla >= TAMANIO_TABLA - 1){
		 printf("Error: No hay mas espacio en la tabla de simbolos.\n");
		 system("Pause");
		 exit(2);
	 }
	 //Si no hay otra variable con el mismo nombre...
	 if(buscarEnTabla(nombre) == -1){
		 //Agregar a tabla
		 fin_tabla++;
		 strcpy(tabla_simbolo[fin_tabla].nombre, nombre);
	 }
	 else 
	 {
	 char msg[100] ;
	 sprintf(msg,"'%s' ya se encuentra declarada previamente.", nombre);
	 yyerror(msg);
	}
 }

/** Agrega los tipos de datos a las variables declaradas. Usa las variables globales varADeclarar1, cantVarsADeclarar y tipoDatoADeclarar */
void agregarTiposDatosATabla(){
	int i;
	for(i = 0; i < cantVarsADeclarar; i++){
		tabla_simbolo[varADeclarar1 + i].tipo_dato = tipoDatoADeclarar;
	}
}

/** Guarda la tabla de simbolos en un archivo de texto */
void grabarTabla(){
	if(fin_tabla == -1)
		yyerror("No se encontro la tabla de simbolos");

	FILE* arch = fopen("ts.txt", "w+");
	if(!arch){
		printf("No se pudo crear el archivo ts.txt\n");
		return;
	}
	
	int i;

	fprintf(arch, "%-30s|%-30s|%-30s|%-30s\n","NOMBRE","TIPO","VALOR","LONGITUD");
	fprintf(arch, ".........................................................................................................\n");
	for(i = 0; i <= fin_tabla; i++){
		fprintf(arch, "%-30s", &(tabla_simbolo[i].nombre) );

		switch (tabla_simbolo[i].tipo_dato){
		case Float:
			fprintf(arch, "|%-30s|%-30s|%-30s","FLOAT","--","--");
			break;
		case Integer:
			fprintf(arch, "|%-30s|%-30s|%-30s","INTEGER","--","--");
			break;
		case String:
			fprintf(arch, "|%-30s|%-30s|%-30s","STRING","--","--");
			break;
		case CteFloat:
			fprintf(arch, "|%-30s|%-30f|%-30s", "CTE_FLOAT",tabla_simbolo[i].valor_f,"--");
			break;
		case CteInt:
			fprintf(arch, "|%-30s|%-30d|%-30s", "CTE_INT",tabla_simbolo[i].valor_i,"--");
			break;
		case CteString:
			fprintf(arch, "|%-30s|%-30s|%-30d", "CTE_STRING",&(tabla_simbolo[i].valor_s), tabla_simbolo[i].longitud);
			break;
		}

		fprintf(arch, "\n");
	}
	fclose(arch);
}


/** Agrega una constante a la tabla de simbolos */
void agregarCteATabla(int num){
	char nombre[30];

	if(fin_tabla >= TAMANIO_TABLA - 1){
		printf("Error: No hay mas espacio en la tabla de simbolos.\n");
		system("Pause");
		exit(2);
	}
	
	switch(num){
		case CteInt:
			sprintf(nombre, "_%d", yylval.valor_int);
			//Si no hay otra variable con el mismo nombre...
			if(buscarEnTabla(nombre) == -1){
			//Agregar nombre a tabla
				fin_tabla++;
				strcpy(tabla_simbolo[fin_tabla].nombre, nombre);
			//Agregar tipo de dato
				tabla_simbolo[fin_tabla].tipo_dato = CteInt;
			//Agregar valor a la tabla
				tabla_simbolo[fin_tabla].valor_i = yylval.valor_int;
			}
		break;

		case CteFloat:
			sprintf(nombre, "_%f", yylval.valor_float);
			//Si no hay otra variable con el mismo nombre...
			if(buscarEnTabla(nombre) == -1){
			//Agregar nombre a tabla
				fin_tabla ++;
				strcpy(tabla_simbolo[fin_tabla].nombre, nombre);
			//Agregar tipo de dato
				tabla_simbolo[fin_tabla].tipo_dato = CteFloat;
			//Agregar valor a la tabla
				tabla_simbolo[fin_tabla].valor_f = yylval.valor_float;
			}
		break;

		case CteString:
			if(buscarEnTabla(yylval.valor_string) == -1){
			//Agregar nombre a tabla
				fin_tabla ++;
				strcpy(tabla_simbolo[fin_tabla].nombre, yylval.valor_string);

				//Agregar tipo de dato
				tabla_simbolo[fin_tabla].tipo_dato = CteString;

				//Agregar valor a la tabla
				int length = strlen(yylval.valor_string);
				char auxiliar[length];
				strcpy(auxiliar,yylval.valor_string);
				auxiliar[strlen(auxiliar)-1] = '\0';
				strcpy(tabla_simbolo[fin_tabla].valor_s, auxiliar+1); 

				//Agregar longitud
				tabla_simbolo[fin_tabla].longitud = length - 2;
			}
		break;

	}
}


/** Se fija si ya existe una entrada con ese nombre en la tabla de simbolos. Si no existe, muestra un error de variable sin declarar y aborta la compilacion. */
void chequearVarEnTabla(char* nombre){
	//Si no existe en la tabla, error
	if( buscarEnTabla(nombre) == -1){
		char msg[100];
		sprintf(msg,"La variable '%s' debe ser declarada previamente en la seccion de declaracion de variables", nombre);
		yyerror(msg);
	}
	//Si existe en la tabla, dejo que la compilacion siga
}

void chequearPrintId(char * nombre){
	int pos = buscarEnTabla(nombre);
	if(pos != -1){
		if(tabla_simbolo[pos].tipo_dato != Integer && tabla_simbolo[pos].tipo_dato != Float){
			char msg[100];
			sprintf(msg,"La variable '%s' debe ser numerica para poder hacer un Print", nombre);
			yyerror(msg);
			return;
		}
	}
}

tNodo* crearNodo(char* dato, tNodo *pIzq, tNodo *pDer){
    
    tNodo* nodo = malloc(sizeof(tNodo));   
    
    if (nodo != NULL){
 		printf("se asigno memoria correctamente\n");    	
    }

    tInfo info;  

    strcpy(info.cadena, dato);
    info.tipoDato = String;
    nodo->info = info;
    nodo->izq = pIzq;
    nodo->der = pDer;

    return nodo;
}

tNodo* crearHoja(const tInfo* info){	
    tNodo* nodoNuevo = (tNodo*)malloc(sizeof(tNodo));
    
	nodoNuevo->info = *info;
    nodoNuevo->izq = NULL;
    nodoNuevo->der = NULL;
    return nodoNuevo;
}

void rellenarInfo(int tipoDato, tInfo* info){

	switch(tipoDato){
		case CteInt:
			printf("LELE");
		    info->tipoDato = CteInt;
			info->entero = yylval.valor_int;
			strcpy(info->cadena,"");
			info->flotante = 0.0;
		break;

		case CteFloat:
			info->tipoDato = CteFloat;
			info->flotante = yylval.valor_float;
			strcpy(info->cadena,"");
			info->entero = 0;
		break;

		case CteString:
			info->tipoDato = CteString;
			info->flotante = 0.0;
			strcpy(info->cadena,yylval.valor_string);
			info->entero = 0;
		break;

		case  Integer :
		    info->tipoDato = CteInt;
			info->entero = yylval.valor_int;
			strcpy(info->cadena,"");
			info->flotante = 0.0;
			
		break;

		case Float:	
			info->tipoDato = CteFloat;
			info->flotante = yylval.valor_float;
			strcpy(info->cadena,"");
			info->entero = 0;
		break;

		case String:
			info->tipoDato = String;
			info->flotante = 0.0;
			strcpy(info->cadena,yylval.valor_string);
			info->entero = 0;		
		break;


	}
}
void mostrar_grafico(tArbol *pa,int n)
{
    int numNodos = 0;
    float aux = 0.0;
    int i=0;
     if(!*pa)
          return;

        mostrar_grafico(&(*pa)->der, n+1);

     for(i; i<n; i++)
     {
       printf("   ");
     }


     numNodos++;

     if((*pa)->info.tipoDato == String || (*pa)->info.tipoDato == CteString)
     printf(" %s \n",(*pa)->info.cadena);
	 
	 if((*pa)->info.tipoDato == Integer || (*pa)->info.tipoDato == CteInt)
 	 	printf(" %d  \n",(*pa)->info.entero); 
 	 
 	 if((*pa)->info.tipoDato == Float || (*pa)->info.tipoDato == CteFloat)
     	printf(" %f \n",(*pa)->info.flotante);

     mostrar_grafico(&(*pa)->izq, n+1);

}



