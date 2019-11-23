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
	#define TAM_PILA 50
	#define TOPE_PILA_VACIA -1
	#define TAM_PILA_ASM 50
	#define TOPE_PILA_ASM_VACIA -1
	#define AND_LOG 1
	#define OR_LOG 2

	/* Defino estructura de informacion para el arbol*/
	typedef struct {
		int tipoDato;
		int entero;
		double flotante;
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

	/* Defino estructura de informacion para la pila*/
	typedef struct {
		tNodo *vec[TAM_PILA];
		int tope;
	}t_pila;

	/* Defino estructura de informacion para la pila de assembler*/
	typedef struct {
		int vec[TAM_PILA_ASM];
		int tope;
	}t_pila_asm;

	/* Funciones necesarias */
	int yylex();
	int yyerror(char* mensaje);
	void agregarVarATabla(char* nombre);
	void agregarTiposDatosATabla(void);
	void agregarCteATabla(int num);
	void insertarEnTabla(char* nombre,int indice, int tipoDato);
	void chequearVarEnTabla(char* nombre);
	void compararTiposDeDatoASIG(int tdIzq, int tdDer, char* nombre);
	void compararTiposDeDatoTL(int tdIzq, int tdDer, char* nombre);
	int obtenerTipoDeDatoDesdeTS(char* nombre);
	int calcularTipoDatoResultante(char* operacion, int tdIzq, int tdDer);
	int buscarEnTabla(char * nombre);
	void grabarTabla(void);
	void chequearPrintId(char *nombre);
    void reemplazarCarEnString(char* destino , char find, char replace);
	/**FUNCIONES PARA LA ENTREGA 2 **/
	tNodo* crearNodo(char* dato, tNodo *pIzq, tNodo *pDer, int tipoDato);
	tNodo* crearHoja(const tInfo* info);
	int esHoja(tNodo *nodo);
	void invertir_comparador(char* cadena);
	void rellenarInfo(int tipoDato, tInfo* info);
	void mostrar_grafico(tArbol *pa, int n);
	void generar_intermedia(tArbol *pa,int n, FILE* arch);

	void crear_pila(t_pila *pp);
	int pila_vacia(const t_pila *pp);
	int pila_llena(const t_pila *pp);
	void vaciar_pila(t_pila *pp);
	int poner_en_pila(t_pila *pp, tNodo *pi);
	tNodo* sacar_de_pila(t_pila *pp);
	tNodo* ver_tope_pila(t_pila *pp);
	void imprimir_tope_de_pila(t_pila *pp);

	/**PILA ASM**/
	void crear_pila_asm(t_pila_asm *pp);
	int poner_en_pila_asm(t_pila_asm *pp, int pi);
	int sacar_de_pila_asm(t_pila_asm *pp);
	int pila_vacia_asm(const t_pila_asm *pp);
	int ver_tope_pila_asm(t_pila_asm *pp);

	/**OPTIMIZACION**/
	tNodo* optimizarSuma(tNodo* izquierda, tNodo* derecha);
	tNodo* optimizarResta(tNodo* izquierda, tNodo* derecha);
	tNodo* optimizarMultiplicacion(tNodo* izquierda, tNodo* derecha);
	tNodo* optimizarDivision(tNodo* izquierda, tNodo* derecha);
	tNodo* optimizarDIV(tNodo* izquierda, tNodo* derecha);
	tNodo* optimizarMOD(tNodo* izquierda, tNodo* derecha);

	/* ASSEMBLER */
	void generarAssembler(tArbol *pa, FILE* arch);
	void operacionAssembler(tArbol *pa, char* operacion);
	void asignacionAssembler(tArbol *pa);
	void comparacionAssembler(tArbol *pa, char* comparador);
	void invertir_comparador_asm(char* cadena);
	/* void restAssembler(tArbol *pa);
	void multiplicacionAssembler(tArbol *pa);
	void divisionAssembler(tArbol *pa);
	*/

	FILE* abrirArchivoAssembler();
	void escribirArchivoAssembler(FILE* archivoAssembler);
	void cerrarArchivoAssembler(FILE* archivoAssembler);


	int yystopparser=0;
	FILE  *yyin;

	/* Cosas de tabla de simbolos */
	typedef struct {
		char nombre[TAM_NOMBRE];
		int tipo_dato;
		char valor_s[TAM_NOMBRE];
		double valor_f;
		int valor_i;
		int longitud;
	} TS_Reg;

	/*TABLA DE TIPOS DE DATOS RESULTANTES*/

	/* formato 
			int | float
	int		00		01
	float	10		01
	*/

	int matrizTD[2][2] = {
		{1,2},
		{2,2}
	};

	/*ESTRUCTURA ASSEMBLER*/
		typedef struct {
			char operacion[100];
			char reg1[100];
			char reg2[100];
		} ASM;

	ASM vectorASM[200];
	int vectorASM_IDX = 0;
	ASM insertar_en_vector_instruccion(tArbol* arbol, char* tipoOperacion);
    ASM insertar_en_vector_instruccion_print(tArbol* arbol);
	/* Cosas para la declaracion de variables y la tabla de simbolos */
	int varADeclarar1 = 1;
	int cantVarsADeclarar = 0;
	int tipoDatoADeclarar[TAMANIO_TABLA];
	int indiceDatoADeclarar = 0;
    TS_Reg tabla_simbolo[TAMANIO_TABLA];
	int indice_tabla = -1;
	int processingFilter = 0;
	char* aux;
	int tipoDatoCalculado;
	FILE* archivoAssembler;
	FILE* intermedia;
	/* Declaraciones globales de punteros de elementos no terminales para el arbol de sentencias basicas*/

	tArbol 	asigPtr,			//Puntero de asignaciones
			exprPtr,			//Puntero de expresiones
			exprCadPtr,			//Puntero de expresiones de cadenas
			exprAritPtr,		//Puntero de expresiones aritmeticas
			terminoPtr,			//Puntero de terminos
			factorPtr,			//Puntero de factores
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
			termLogFilterPtr,	//Puntero de termino logico del filter
			compBoolPtr,		//Puntero de comparador Booleano	
			terminoFilterPtr,	//Puntero de termino de filter		
			compFilterPtr,   	//Puntero de comparador de filter	
			listaExpComaPtr,	//Puntero de lista expresion coma
			elseBloquePtr,		//Puntero para el bloque del else
			thenBloquePtr,		//Puntero para el bloque del then
			auxAritPtr;
				

	t_pila	progPilaPtr;
	t_pila	expLogPilaPtr;
	t_pila  exprAritPilaPtr;

	t_pila_asm pilaAssembler;
	t_pila_asm pilaCondicionIFAssembler;
	t_pila_asm pilaCondicionREPEATAssembler;
	t_pila_asm pilaElseProcesados;
	t_pila_asm pilaRepeatProcesado;
	t_pila_asm pilaAndRepeat;
	t_pila_asm pilaAndIf;
	t_pila_asm pilaOr;

	int contAssembler = 0;
	char auxAssembler[10];

	int repeatFlag = 0;
	int ifFlag = 0;
	int contTagRepeat = 1;
	int contTagEndRepeat = 0;
	int contTagElse = 1;
	int contTagEndif = 0;
%}

/* Tipo de estructura de datos, toma el valor SUMA grande*/
%union {

	int valor_int;
	double valor_float;
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

															archivoAssembler = abrirArchivoAssembler();
															mostrar_grafico(&bloquePtr,5);
															intermedia = fopen("intermedia.txt", "a+");
															generar_intermedia(&bloquePtr,5,intermedia);
															fclose(intermedia);
															generarAssembler(&bloquePtr, archivoAssembler);
															puts("\n\n------------------------------\n\n");
															mostrar_grafico(&bloquePtr,5);
															escribirArchivoAssembler(archivoAssembler);
															cerrarArchivoAssembler(archivoAssembler);
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
															 indiceDatoADeclarar = 0;
														};

t_datos:
	t_datos COMA t_dato									{printf("R 5: t_datos => t_datos COMA t_dato\n");}
	| t_dato 											{printf("R 6: t_datos => t_dato \n");};

t_dato:
	FLOAT		                                        {
															printf("R 7: t_dato => FLOAT\n");
															tipoDatoADeclarar[indiceDatoADeclarar++] = Float;
														}
	| INTEGER		                                    {
															printf("R 8: t_dato => INTEGER\n");
															tipoDatoADeclarar[indiceDatoADeclarar++] = Integer;
														}
	| STRING	                                        {
															printf("R 9: t_dato => STRING\n");
															tipoDatoADeclarar[indiceDatoADeclarar++] = String;
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
															varADeclarar1 = indice_tabla; /* Guardo posicion de primer variable de esta lista de declaracion. */
															cantVarsADeclarar = 1;
                                                        };

 /* Fin de Declaracion de variables */

 /* Seccion de codigo */

bloque:                                                 /* No existen bloques sin sentencias */
	bloque sentencia	                                {   
															printf("R 10: bloque => bloque sentencia\n");
															if(bloquePtr != NULL){
																bloquePtr = crearNodo("CUERPO", bloquePtr, sentenciaPtr, -1);
															} else {
																if(!pila_vacia(&progPilaPtr)){
																	bloquePtr = sacar_de_pila(&progPilaPtr);
																	bloquePtr = crearNodo("CUERPO", bloquePtr, sentenciaPtr, -1);
																	
																}
															}
															exprAritPtr = NULL;
														}
	
	| sentencia			                                {
															printf("R 11: bloque => sentencia\n"); 
															if(bloquePtr != NULL) {
																bloquePtr = crearNodo("CUERPO", bloquePtr, sentenciaPtr, -1);
																
															} else {
																bloquePtr = sentenciaPtr;
															}
															exprAritPtr = NULL;
															
														};

sentencia:
	asignacion			                    			{printf("R 12: sentencia => asignacion\n"); sentenciaPtr = asigPtr; }
	| bloque_if                                         {printf("R 13: sentencia => bloque_if\n"); sentenciaPtr = bloqueIfPtr;}
	| bloque_while                                      {printf("R 14: sentencia => bloque_while\n"); sentenciaPtr = bloqueWhPtr;}
	| lectura                                			{printf("R 15: sentencia => lectura\n");sentenciaPtr = lecturaPtr;}
	| escritura                              			{printf("R 16: sentencia => escritura\n");sentenciaPtr = escrituraPtr;}
	| expresion_aritmetica                   			{printf("R 17: sentencia => expresion_aritmetica\n");sentenciaPtr = exprAritPtr;};

bloque_if:
    IF expresion_logica THEN bloque ENDIF               {
															printf("R 18: bloque_if => IF expresion_logica THEN bloque ENDIF\n");
														
															if(expreLogPtr != NULL){
																bloqueIfPtr = crearNodo("IF",expreLogPtr,bloquePtr, -1);
																expreLogPtr = NULL;
															} else {
																if(!pila_vacia(&expLogPilaPtr)){
																	expreLogPtr = sacar_de_pila(&expLogPilaPtr);
																	bloqueIfPtr = crearNodo("IF",expreLogPtr,bloquePtr, -1);
																	expreLogPtr = NULL;
																}
															}
															 bloquePtr = NULL;
    													};

bloque_if:
    IF expresion_logica THEN bloque ELSE { 
											printf("R 19.1: bloque_if  => ELSE condition\n"); 
											thenBloquePtr = bloquePtr;
											bloquePtr = NULL;
											elseBloquePtr = crearNodo("ELSE",thenBloquePtr, NULL, -1);
			
										} else_bloque ENDIF   {
    													 		printf("R 19: bloque_if => IF expresion_logica THEN bloque ELSE bloque ENDIF\n");
														 		if(expreLogPtr != NULL){
																	bloqueIfPtr = crearNodo("IF",expreLogPtr,elseBloquePtr, -1);
																	expreLogPtr = NULL;
																} else {
																	 if(!pila_vacia(&expLogPilaPtr)){
																		expreLogPtr = sacar_de_pila(&expLogPilaPtr);
																		bloqueIfPtr = crearNodo("IF",expreLogPtr,elseBloquePtr, -1);
																		expreLogPtr = NULL;
																	}
																}
    													 		
    															
															};

else_bloque: 												
	bloque 													{
															    printf("R 19.2 ELSE: else_bloque => ELSE bloque\n");
																elseBloquePtr->der = bloquePtr;
																bloquePtr = NULL;
																
															};


bloque_while:
    REPEAT expresion_logica bloque ENDREPEAT            {
															printf("R 20: bloque_while => REPEAT expresion_logica bloque ENDREPEAT\n");
															if(expreLogPtr != NULL){
																	bloqueWhPtr = crearNodo("REPEAT", expreLogPtr, bloquePtr, -1);
																	expreLogPtr = NULL;
																 } else {
																	if(!pila_vacia(&expLogPilaPtr)){
																		expreLogPtr = sacar_de_pila(&expLogPilaPtr);
																		bloqueWhPtr = crearNodo("REPEAT", expreLogPtr, bloquePtr, -1);
																		expreLogPtr = NULL;
																	}
																 }
																
															bloquePtr = NULL;
														};

asignacion:
	ID 													{	
															aux = (char *) malloc(sizeof(char) * (strlen(yylval.valor_string) + 1));
															strcpy(aux, yylval.valor_string);
														}
	ASIG expresion	                             	   {
															chequearVarEnTabla($1);
															printf("R 21: asignacion => ID ASIG expresion\n");
															infoArbol.tipoDato = obtenerTipoDeDatoDesdeTS(aux); 															infoArbol.entero = 0 ;
															strcpy(infoArbol.cadena, aux);
															infoArbol.flotante = 0.0;
															infoArbol.entero = 0;
															compararTiposDeDatoASIG(infoArbol.tipoDato, exprPtr->info.tipoDato, infoArbol.cadena);
															asigPtr = crearNodo(":=", crearHoja(&infoArbol), exprPtr, -1);

														
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
															printf("R 24: expresion_cadena => CTE_STRING\n");
															rellenarInfo(CteString,&infoArbol);
														 	exprCadPtr = crearHoja(&infoArbol);
															agregarCteATabla(CteString);
						
														};

expresion_aritmetica:
	expresion_aritmetica { 
			poner_en_pila(&exprAritPilaPtr, exprAritPtr); 
			printf("R 25.1: apilo por SUMA\n");
		} SUMA termino 		           
														{
															printf("R 25: expresion_aritmetica => expresion_aritmetica SUMA termino\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);
															
															exprAritPtr = optimizarSuma(auxAritPtr, terminoPtr);
															
														}
	| expresion_aritmetica { 
			poner_en_pila(&exprAritPilaPtr, exprAritPtr);
			printf("R 26.1: apilo por RESTA\n");
		} RESTA termino 	            
														{
															printf("R 26: expresion_aritmetica => expresion_aritmetica RESTA termino\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);
															
															exprAritPtr = optimizarResta(auxAritPtr, terminoPtr);
															
														}
	| expresion_aritmetica { 
			poner_en_pila(&exprAritPilaPtr, exprAritPtr); 
			printf("R 27.1: apilo por MOD\n");
		} MOD termino                 
														{	
															printf("R 27: expresion_aritmetica => expresion_aritmetica MOD termino\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);
															
															exprAritPtr = optimizarMOD(auxAritPtr, terminoPtr);
																
														}
 	| expresion_aritmetica { 
		 	poner_en_pila(&exprAritPilaPtr, exprAritPtr); 
		 	printf("R 28.1: apilo por DIV\n");
		 } DIV termino                  
	 													{	
															printf("R 28: expresion_aritmetica => expresion_aritmetica DIV termino\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);
															
															exprAritPtr = optimizarDIV(auxAritPtr, terminoPtr);
																
														}
	| termino								            {	
															printf("R 29: expresion_aritmetica => termino\n");
															exprAritPtr = terminoPtr;
														};

termino:
	termino { 
			poner_en_pila(&exprAritPilaPtr, terminoPtr); 
			printf("R 30.1: apilo por POR\n");
		} POR factor 			
														{	
															printf("R 30: termino => termino POR factor\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);

															terminoPtr = optimizarMultiplicacion(auxAritPtr, factorPtr);
															
														}
	| termino { 
			poner_en_pila(&exprAritPilaPtr, terminoPtr); 
			printf("R 31.1: apilo por DIVIDIDO\n");
		} DIVIDIDO factor 	                        
														{	
															printf("R 31: termino => termino DIVIDIDO factor\n");
															auxAritPtr = sacar_de_pila(&exprAritPilaPtr);

															terminoPtr = optimizarDivision(auxAritPtr, factorPtr);
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
															/*No uso rellenar info al igual que en la asignacion*/
															chequearVarEnTabla(yylval.valor_string);
															printf("R 35: factor => ID\n");
															infoArbol.tipoDato = obtenerTipoDeDatoDesdeTS(yylval.valor_string); 															infoArbol.entero = 0 ;
															strcpy(infoArbol.cadena, yylval.valor_string);
															//rellenarInfo(tipoD,&infoArbol);
															factorPtr = crearHoja(&infoArbol);
														}
	| CTE_FLOAT	                                        {
															printf("R 36: factor => CTE_FLOAT\n");
															rellenarInfo(CteFloat,&infoArbol);
															agregarCteATabla(CteFloat);
															factorPtr = crearHoja(&infoArbol);
															
														}
	| CTE_INT	                                        {
															printf("R 37: factor => CTE_INT\n");
															rellenarInfo(CteInt,&infoArbol);	
															agregarCteATabla(CteInt);
															factorPtr = crearHoja(&infoArbol);

														};
/* Expresiones logicas */

expresion_logica:
    termino_logico AND termino_logico                 {  
    												   		printf("R 38: expresion_logica => termino_logico AND termino_logico\n");
															if(expreLogPtr != NULL){
																poner_en_pila(&expLogPilaPtr, expreLogPtr);
															}
															expreLogPtr = crearNodo("AND", termLogPtr, compBoolPtr, -1);
															if(bloquePtr != NULL){
																poner_en_pila(&progPilaPtr, bloquePtr);
															}
															bloquePtr = NULL;
															termLogPtr = NULL;
													  }
    | termino_logico OR termino_logico                {
    												  	 	printf("R 39: expresion_logica => termino_logico OR termino_logico\n");
															if(expreLogPtr != NULL){
																poner_en_pila(&expLogPilaPtr, expreLogPtr);
															}
															expreLogPtr = crearNodo("OR", termLogPtr, compBoolPtr, -1);
															if(bloquePtr != NULL){
																poner_en_pila(&progPilaPtr, bloquePtr);
															}
															bloquePtr = NULL;
															termLogPtr = NULL;
													  }
    | termino_logico                                  { 
															printf("R 40: expresion_logica => termino_logico\n");
															
															if(expreLogPtr != NULL){
																poner_en_pila(&expLogPilaPtr, expreLogPtr);
															}
															expreLogPtr = termLogPtr;
															if(bloquePtr != NULL){
																poner_en_pila(&progPilaPtr, bloquePtr);
															}
															bloquePtr = NULL;
															termLogPtr = NULL;
													  };

termino_logico:
    NOT termino_logico                              		{
																printf("R 41: NOT termino_logico\n");
																invertir_comparador(compBoolPtr->info.cadena);

															}
    | expresion_aritmetica comp_bool expresion_aritmetica 	{
																printf("R 42: termino_logico => expresion_aritmetica comp_bool expresion_aritmetica\n");
																compararTiposDeDatoTL(compBoolPtr->izq->info.tipoDato, exprAritPtr->info.tipoDato, compBoolPtr->info.cadena);
																compBoolPtr->der = exprAritPtr;
																if(termLogPtr == NULL){
																	termLogPtr = compBoolPtr;
																}
															};

termino_filter:
    GUION_BAJO comp_bool PA expresion_aritmetica PC         {
																printf("R 43: termino_filter => GUION_BAJO comp_bool PA expresion_aritmetica PC  \n");
																compBoolPtr->der = exprAritPtr;
																if(compFilterPtr == NULL){
																	compFilterPtr = compBoolPtr;
																	termLogFilterPtr = compFilterPtr;
																}
																
															}
    | GUION_BAJO comp_bool CTE_FLOAT			  			{
																printf("R 44: termino_filter => GUION_BAJO comp_bool CTE_FLOAT\n");
																rellenarInfo(CteFloat,&infoArbol);
																compBoolPtr->der = crearHoja(&infoArbol);
																if(compFilterPtr == NULL){
																	compFilterPtr = compBoolPtr;
																	termLogFilterPtr = compFilterPtr;
																}
															}
    | GUION_BAJO comp_bool CTE_INT			  				{
																printf("R 45: termino_filter => GUION_BAJO comp_bool CTE_INT\n");
																rellenarInfo(CteInt,&infoArbol);
																compBoolPtr->der = crearHoja(&infoArbol);
																if(compFilterPtr == NULL){
																	compFilterPtr = compBoolPtr;
																	termLogFilterPtr = compFilterPtr;
																}
															};

comparacion_filter:
    termino_filter AND termino_filter		  			{
															printf("R 46: comparacion_filter => termino_filter AND termino_filter\n");
															terminoFilterPtr = crearNodo("AND", termLogFilterPtr, compBoolPtr, -1);
														}
    | termino_filter OR termino_filter   				{
															printf("R 47: comparacion_filter => termino_filter OR termino_filter\n");
															terminoFilterPtr = crearNodo("AND", termLogFilterPtr, compBoolPtr, -1);
														}
    | termino_filter		  							{
															printf("R 48: comparacion_filter => termino_filter\n");
															terminoFilterPtr = compFilterPtr;
														}

comp_bool:
    MENOR                                               {
															printf("R 49: comp_bool => MENOR\n");
    													 	compBoolPtr = crearNodo("<", exprAritPtr, crearHoja(&infoArbol), -1);	
    												 	}
    |MAYOR                                              {
															printf("R 50: comp_bool => MAYOR\n");
    													 	//rellenarInfo(String, &infoArbol);
    													 	compBoolPtr = crearNodo(">", exprAritPtr, crearHoja(&infoArbol), -1);
    													}
    |MENOR_IGUAL                                        {
															printf("R 51: comp_bool => MENOR_IGUAL\n");
    														//rellenarInfo(String, &infoArbol);
    													 	compBoolPtr = crearNodo("<=", exprAritPtr, crearHoja(&infoArbol), -1);
    													}
    |MAYOR_IGUAL                                        {
															printf("R 52: comp_bool => MAYOR_IGUAL\n");
    													 	//rellenarInfo(String, &infoArbol);
    													 	compBoolPtr = crearNodo(">=", exprAritPtr, crearHoja(&infoArbol), -1);	
    													}
    |IGUAL                                              {
															printf("R 53: comp_bool => IGUAL\n");
    														//rellenarInfo(String, &infoArbol);
    													 	compBoolPtr = crearNodo("==", exprAritPtr, crearHoja(&infoArbol), -1);
    													 
    													}
    |DISTINTO                                           {
															printf("R 54: comp_bool => DISTINTO\n");
    													 	//rellenarInfo(String, &infoArbol);
														 	compBoolPtr = crearNodo("!=", exprAritPtr, crearHoja(&infoArbol), -1);
    													};
	

filter:
	FILTER {processingFilter = 1;} PA comparacion_filter COMA CA lista_exp_coma CC PC {
																printf("R 55: FILTER => FILTER PA comparacion_filter COMA CA lista_exp_coma CC PC\n");
																filterPtr = crearNodo("FILTER-PADRE", bloquePtr, NULL, 1);
																processingFilter = 0;
																bloquePtr = NULL;
																};

lista_exp_coma:
    lista_exp_coma COMA expresion_aritmetica            {
															printf("R 56: lista_exp_coma => lista_exp_coma COMA expresion_aritmetica\n");
															if(esHoja(terminoFilterPtr->izq)){
																bloquePtr = crearNodo("FILTER", bloquePtr, crearNodo(compBoolPtr->info.cadena, exprAritPtr, terminoFilterPtr->der, -1), -1);
															} else {
																bloquePtr = crearNodo("FILTER", bloquePtr,
																	crearNodo(compBoolPtr->info.cadena, //AND u OR
																		crearNodo(terminoFilterPtr->izq->info.cadena, exprAritPtr, terminoFilterPtr->izq->der, -1),
																		crearNodo(terminoFilterPtr->der->info.cadena, exprAritPtr, terminoFilterPtr->der->der, -1), -1), -1);
															}	
														}
    | expresion_aritmetica                              {
															printf("R 57: lista_exp_coma => expresion_aritmetica\n");
															compBoolPtr->izq = exprAritPtr;
															if(compFilterPtr != NULL){
																compFilterPtr->izq = exprAritPtr;
															}
															if(bloquePtr != NULL){
																poner_en_pila(&progPilaPtr, bloquePtr);
															}
															bloquePtr = terminoFilterPtr;
														};

lectura:
    READ ID												{
															chequearVarEnTabla($2);
															printf("R 58: lectura => READ ID\n");
															rellenarInfo(String,&infoArbol);
															lecturaPtr = crearNodo("READ", NULL, crearHoja(&infoArbol), -1);
														};


escritura:
    PRINT ID                                            {   
															chequearVarEnTabla($2);
															chequearPrintId($2);
															infoArbol.tipoDato = obtenerTipoDeDatoDesdeTS($2);
															strcpy(infoArbol.cadena,$2);
															escrituraPtr = crearNodo("PRINT", NULL, crearHoja(&infoArbol), -1);
															printf("R 59: escritura => PRINT ID\n");
														}
    | PRINT CTE_STRING                                  {
															printf("R 60: escritura => PRINT CTE_STRING\n");
															agregarCteATabla(CteString);
															rellenarInfo(CteString,&infoArbol);
															escrituraPtr = crearNodo("PRINT", NULL, crearHoja(&infoArbol), -1);

														};


%%

int main(int argc,char *argv[]){
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	crear_pila(&progPilaPtr);
	crear_pila(&expLogPilaPtr);
	crear_pila(&exprAritPilaPtr);
	crear_pila_asm(&pilaAssembler);
	crear_pila_asm(&pilaCondicionIFAssembler);
	crear_pila_asm(&pilaCondicionREPEATAssembler);
	crear_pila_asm(&pilaElseProcesados);
	crear_pila_asm(&pilaRepeatProcesado);	
	crear_pila_asm(&pilaAndRepeat);
	crear_pila_asm(&pilaAndIf);			
	crear_pila_asm(&pilaOr);										
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
   while(i<=indice_tabla){
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
	 if(indice_tabla >= TAMANIO_TABLA - 1){
		 printf("Error: No hay mas espacio en la tabla de simbolos.\n");
		 system("Pause");
		 exit(2);
	 }
	 //Si no hay otra variable con el mismo nombre...
	 if(buscarEnTabla(nombre) == -1){
		 //Agregar a tabla
		 indice_tabla ++;
		 strcpy(tabla_simbolo[indice_tabla].nombre, nombre);
	 }
	 else 
	 {
	 char msg[100] ;
	 sprintf(msg,"'%s' ya se encuentra declarada previamente.", nombre);
	 yyerror(msg);
	}
	printf("%d", indice_tabla);
 }

/** Agrega los tipos de datos a las variables declaradas. Usa las variables globales varADeclarar1, cantVarsADeclarar y tipoDatoADeclarar */
void agregarTiposDatosATabla(){
	int i;
	for(i = 0; i < cantVarsADeclarar; i++){
		tabla_simbolo[varADeclarar1 + i].tipo_dato = tipoDatoADeclarar[i];
	}
}
void insertarEnTabla(char* nombre,int indice, int tipoDato){
FILE* arch = fopen("ts.txt", "a+");
	if(!arch){
		printf("No se pudo crear el archivo ts.txt\n");
		return;
	}
agregarVarATabla(nombre);
tabla_simbolo[indice_tabla].tipo_dato = tipoDato;
fprintf(arch, "%-30s", &(tabla_simbolo[indice_tabla].nombre) );
switch (tipoDato){
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
			fprintf(arch, "|%-30s|%-30f|%-30s", "CTE_FLOAT",tabla_simbolo[indice_tabla].valor_f,"--");
			break;
		case CteInt:
			fprintf(arch, "|%-30s|%-30d|%-30s", "CTE_INT",tabla_simbolo[indice_tabla].valor_i,"--");
			break;
		case CteString:
			fprintf(arch, "|%-30s|%-30s|%-30d", "CTE_STRING",&(tabla_simbolo[indice_tabla].valor_s), tabla_simbolo[indice_tabla].longitud);
			break;
		}

		fprintf(arch, "\n");
	
	fclose(arch);

}
/** Guarda la tabla de simbolos en un archivo de texto */
void grabarTabla(){
	if(indice_tabla == -1)
		yyerror("No se encontro la tabla de simbolos");

	FILE* arch = fopen("ts.txt", "w+");
	if(!arch){
		printf("No se pudo crear el archivo ts.txt\n");
		return;
	}
	
	int i;

	fprintf(arch, "%-30s|%-30s|%-30s|%-30s\n","NOMBRE","TIPO","VALOR","LONGITUD");
	fprintf(arch, ".........................................................................................................\n");
	for(i = 0; i <= indice_tabla; i++){
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

	if(indice_tabla >= TAMANIO_TABLA - 1){
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
				indice_tabla++;
				strcpy(tabla_simbolo[indice_tabla].nombre, nombre);
			//Agregar tipo de dato
				tabla_simbolo[indice_tabla].tipo_dato = CteInt;
			//Agregar valor a la tabla
				tabla_simbolo[indice_tabla].valor_i = yylval.valor_int;
			}
		break;

		case CteFloat:
			sprintf(nombre, "_%f", yylval.valor_float);
			//Si no hay otra variable con el mismo nombre...
			if(buscarEnTabla(nombre) == -1){
			//Agregar nombre a tabla
				indice_tabla ++;
				strcpy(tabla_simbolo[indice_tabla].nombre, nombre);
			//Agregar tipo de dato
				tabla_simbolo[indice_tabla].tipo_dato = CteFloat;
			//Agregar valor a la tabla
				tabla_simbolo[indice_tabla].valor_f = yylval.valor_float;
			}
		break;

		case CteString:
			if(buscarEnTabla(yylval.valor_string) == -1){
			//Agregar nombre a tabla
				indice_tabla ++;
				strcpy(tabla_simbolo[indice_tabla].nombre, yylval.valor_string);

				//Agregar tipo de dato
				tabla_simbolo[indice_tabla].tipo_dato = CteString;

				//Agregar valor a la tabla
				int length = strlen(yylval.valor_string);
				char auxiliar[length];
				strcpy(auxiliar,yylval.valor_string);
				auxiliar[strlen(auxiliar)-1] = '\0';
				strcpy(tabla_simbolo[indice_tabla].valor_s, auxiliar+1); 

				//Agregar longitud
				tabla_simbolo[indice_tabla].longitud = length - 2;
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

void compararTiposDeDatoASIG(int tdIzq, int tdDer, char* nombre){
	if( tdIzq != tdDer && (tdIzq+3) != tdDer){
		char msg[100];
		sprintf(msg,"Asignacion entre tipos de datos incompatibles en la variable '%s' ", nombre);
		yyerror(msg);
	}
}

void compararTiposDeDatoTL(int tdIzq, int tdDer, char* nombre){
	printf("comparando %d %d\n", tdIzq, tdDer);
	if( tdIzq != tdDer && (tdIzq+3) != tdDer && (tdIzq-3) != tdDer){
		char msg[100];
		sprintf(msg,"Comparacion entre tipos de datos incompatibles en el operador '%s' ", nombre);
		yyerror(msg);
	}
}

int obtenerTipoDeDatoDesdeTS(char* nombre){
   	int i=0;
  	while(i<=indice_tabla){
	   if(strcmp(tabla_simbolo[i].nombre,nombre) == 0){
		   return tabla_simbolo[i].tipo_dato;
	   }
	   i++;
   	}
	return -1;
}

int convertirTD(int td){
	if(td == 1 || td == 4){
		return 0;
	} else if(td == 2 || td == 5){
		return 1;
	} else if(td == 3 || td == 6){
		return 500;
	}
	return 500;
}


int calcularTipoDatoResultante(char* operacion, int tdIzq, int tdDer){
	tdIzq = convertirTD(tdIzq);
	tdDer = convertirTD(tdDer);

	if(tdIzq == 500 || tdDer == 500){
		char msg[100];
		sprintf(msg,"Tipo de dato no soportado para la operacion '%s'", operacion);
		yyerror(msg);
	}

	return matrizTD[tdIzq][tdDer];
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

/***************ARBOL*****************/
tNodo* crearNodo(char* dato, tNodo *pIzq, tNodo *pDer, int tipoDato){
    
    tNodo* nodo = malloc(sizeof(tNodo));   
    tInfo info;  

    strcpy(info.cadena, dato);
	if(tipoDato == -1){
		info.tipoDato = String;
	} else {
		info.tipoDato = tipoDato;
	}
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

int esHoja(tNodo *nodo){
	return nodo->izq == NULL && nodo->der == NULL;
}

void invertir_comparador(char *cadena){
	char result[40];
	if(strcmp(cadena, "==") == 0){
		strcpy(result, "!=");
	} else if(strcmp(cadena, "!=") == 0){
		strcpy(result, "==");
	} else if(strcmp(cadena, ">") == 0){
		strcpy(result, "<=");
	} else if(strcmp(cadena, "<") == 0){
		strcpy(result, ">=");
	} else if(strcmp(cadena, "<=") == 0){
		strcpy(result, ">");
	} else {
		strcpy(result, "<");
	}
	strcpy(cadena, result);
}

void rellenarInfo(int tipoDato, tInfo* info){
	switch(tipoDato){
		case CteInt:
			printf("Rellenar info CteInt\n");
		    info->tipoDato = CteInt;
			info->entero = yylval.valor_int;
			strcpy(info->cadena,"");
			info->flotante = 0.0;
			break;

		case CteFloat:
			printf("Rellenar info CteFloat\n");
			info->tipoDato = CteFloat;
			info->flotante = yylval.valor_float;
			strcpy(info->cadena,"");
			info->entero = 0;
			break;

		case CteString:
			printf("Rellenar info CteString\n");
			info->tipoDato = CteString;
			info->flotante = 0.0;
			strcpy(info->cadena,yylval.valor_string);
			info->entero = 0;
			break;

		case Integer :
			printf("Rellenar info Integer\n");
		    info->tipoDato = CteInt;
			info->entero = yylval.valor_int;
			strcpy(info->cadena,"");
			info->flotante = 0.0;
			
			break;

		case Float:	
			printf("Rellenar info Float\n");
			info->tipoDato = CteFloat;
			info->flotante = yylval.valor_float;
			strcpy(info->cadena,"");
			info->entero = 0;
			break;

		case String:
			printf("Rellenar info String\n");
			info->tipoDato = String;
			info->flotante = 0.0;
			if(!processingFilter){
				strcpy(info->cadena,yylval.valor_string);
				processingFilter = 0;
			}
			info->entero = 0;		
			break;
	}
}

void generar_intermedia(tArbol *pa,int n, FILE* arch){
    int numNodos = 0;
    double aux = 0.0;
    int i=0;
     if(!*pa){ return; }
          
	generar_intermedia(&(*pa)->der, n+1, arch);

     for(i=0; i<n; i++)
     {
       //printf("   ");
	   fprintf(arch, "%s", "----");
     }


     numNodos++;

     if((*pa)->info.tipoDato == String || (*pa)->info.tipoDato == CteString){
		fprintf(arch," %s \n",(*pa)->info.cadena);
	 }
     
	 
	 if((*pa)->info.tipoDato == Integer || (*pa)->info.tipoDato == CteInt){
		if(strcmp((*pa)->info.cadena, "") == 0 ){
			fprintf(arch," %d  \n",(*pa)->info.entero); 
		} else {
			fprintf(arch," %s \n",(*pa)->info.cadena);
		}
		
	 }
 	 	
 	 
 	 if((*pa)->info.tipoDato == Float || (*pa)->info.tipoDato == CteFloat){
		  if(strcmp((*pa)->info.cadena, "") == 0 ){
			fprintf(arch," %f \n",(*pa)->info.flotante);
		} else {
			fprintf(arch," %s \n",(*pa)->info.cadena);
		}
		
	  }
     	

     generar_intermedia(&(*pa)->izq, n+1, arch);

}

void mostrar_grafico(tArbol *pa,int n){
    int numNodos = 0;
    double aux = 0.0;
    int i=0;
     if(!*pa){ return; }
          
	mostrar_grafico(&(*pa)->der, n+1);

     for(i=0; i<n; i++)
     {
       //printf("   ");
	   printf("----");
     }


     numNodos++;

     if((*pa)->info.tipoDato == String || (*pa)->info.tipoDato == CteString){
		printf(" %s \n",(*pa)->info.cadena);
	 }
     
	 
	 if((*pa)->info.tipoDato == Integer || (*pa)->info.tipoDato == CteInt){
		if(strcmp((*pa)->info.cadena, "") == 0 ){
			printf(" %d  \n",(*pa)->info.entero); 
		} else {
			printf(" %s \n",(*pa)->info.cadena);
		}
		
	 }
 	 	
 	 
 	 if((*pa)->info.tipoDato == Float || (*pa)->info.tipoDato == CteFloat){
		  if(strcmp((*pa)->info.cadena, "") == 0 ){
			printf(" %f \n",(*pa)->info.flotante);
		} else {
			printf(" %s \n",(*pa)->info.cadena);
		}
		
	  }
     	

     mostrar_grafico(&(*pa)->izq, n+1);

}

/*************** FIN ARBOL*****************/

/*************** PILA *****************/
void crear_pila(t_pila *pp){
	printf("Creando pila... \n");
	pp->tope = TOPE_PILA_VACIA;
}

int pila_vacia(const t_pila *pp){
	return pp->tope == TOPE_PILA_VACIA;
}

int pila_llena(const t_pila *pp){
	return pp->tope == TAM_PILA - 1;
}

void vaciar_pila(t_pila *pp){
	printf("Vaciando pila...\n");
	pp->tope = - 1;
}

int poner_en_pila(t_pila *pp, tNodo *pi){
	if(pp->tope == TAM_PILA - 1){
		printf("Pila llena\n");
		return -1;
	}
	pp->tope++;
	pp->vec[pp->tope]=pi;
	return 1;
}

tNodo* sacar_de_pila(t_pila *pp){
	if( pp->tope == -1){
		printf("Pila vacia\n");
		return NULL;
	}
	tNodo *result;
	result = pp->vec[pp->tope];
	pp->tope--;
	return result;
}

tNodo* ver_tope_pila(t_pila *pp){
	if( pp->tope == -1){
		printf("Pila vacia\n");
		return NULL;
	} 
	return pp->vec[pp->tope];
}

void imprimir_tope_de_pila(t_pila *pp){
	printf("Pila: %p\n", pp);
	if( pp->tope == -1){
		printf("Pila vacia\n");
	} else {
		printf("Tope: %d \n", pp->tope);
		printf("Tope de pila: %p \n", pp->vec[pp->tope]);
		
	}
}

/*************** FIN PILA *****************/

/*************** PILA ASSEMBLER ************/
void crear_pila_asm(t_pila_asm *pp){
	printf("Creando pila... \n");
	pp->tope = TOPE_PILA_ASM_VACIA;
}

int poner_en_pila_asm(t_pila_asm *pp, int pi){
	if(pp->tope == TAM_PILA_ASM - 1){
		printf("Pila llena\n");
		return -1;
	}
	pp->tope++;
	pp->vec[pp->tope]=pi;
	return 1;
}

int sacar_de_pila_asm(t_pila_asm *pp){
	if( pp->tope == -1){
		printf("Pila vacia\n");
		return -1;
	}
	int result;
	result = pp->vec[pp->tope];
	pp->tope--;
	return result;
}

int pila_vacia_asm(const t_pila_asm *pp){
	return pp->tope == TOPE_PILA_ASM_VACIA;
}

int ver_tope_pila_asm(t_pila_asm *pp){
	if( pp->tope == -1){
		printf("Pila vacia\n");
		return -1;
	} 
	return pp->vec[pp->tope];
}

/*********** FIN PILA ASSEMBLER *********/

/*************** OPTIMIZACION *************/
tNodo* optimizarSuma(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION SUMA: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero + derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION SUMA: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante + (double)derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION SUMA: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero + derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION SUMA: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante + derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("SUMA", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("+", izquierda, derecha, tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("SUMA", auxAritPtr->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("+", izquierda, derecha, tipoDatoCalculado);
	}
}

tNodo* optimizarResta(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION RESTA: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero - derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION RESTA: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante - (double)derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION RESTA: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero - derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION RESTA: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante - derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("RESTA", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("-", izquierda, derecha, tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("RESTA", izquierda->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("-", izquierda, derecha, tipoDatoCalculado);
	}
}

tNodo* optimizarMultiplicacion(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION MULTIPLICACION: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero * derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION MULTIPLICACION: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante * (double)derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION MULTIPLICACION: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero * derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION MULTIPLICACION: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante * derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("POR", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("*", izquierda, derecha, tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("POR", izquierda->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("*", izquierda, derecha, tipoDatoCalculado);
	}
}

tNodo* optimizarDivision(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION DIVISION: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero / derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION DIVISION: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante / (double)derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION DIVISION: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero / derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION DIVISION: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante / derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("DIVIDIDO", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("/", izquierda, derecha, tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("DIVIDIDO", izquierda->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("/", izquierda, derecha, tipoDatoCalculado);
	}
}

tNodo* optimizarDIV(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION DIV: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero / derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION DIV: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante / (double)derecha->info.entero;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION DIV: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero / derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION DIV: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante / derecha->info.flotante;
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("DIV", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("/", izquierda, derecha, tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("DIV", izquierda->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("/", izquierda, derecha, tipoDatoCalculado);
	}
}

tNodo* optimizarMOD(tNodo* izquierda, tNodo* derecha){
	if(esHoja(izquierda) && esHoja(derecha)){
		if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION MOD: %d y %d\n", izquierda->info.entero, derecha->info.entero);
			infoArbol.tipoDato = CteInt;
			infoArbol.entero = izquierda->info.entero - ((izquierda->info.entero / derecha->info.entero) * derecha->info.entero);
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteInt){
			printf("OPTIMIZACION MOD: %f y %d\n", izquierda->info.flotante, derecha->info.entero);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante - ((izquierda->info.flotante / (double)derecha->info.entero) * (double)derecha->info.entero);
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteInt && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION MOD: %d y %f\n", izquierda->info.entero, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = (double)izquierda->info.entero - (((double)izquierda->info.entero / derecha->info.flotante) * derecha->info.flotante);
			return crearHoja(&infoArbol);
		} else if(izquierda->info.tipoDato == CteFloat && derecha->info.tipoDato == CteFloat){
			printf("OPTIMIZACION MOD: %f y %f\n", izquierda->info.flotante, derecha->info.flotante);
			infoArbol.tipoDato = CteFloat;
			infoArbol.flotante = izquierda->info.flotante - ((izquierda->info.flotante / derecha->info.flotante) * derecha->info.flotante);
			return crearHoja(&infoArbol);
		} else {
			tipoDatoCalculado = calcularTipoDatoResultante("MOD", izquierda->info.tipoDato, derecha->info.tipoDato);
			return crearNodo("-", izquierda, crearNodo("*", crearNodo("/", izquierda, derecha, tipoDatoCalculado), derecha, tipoDatoCalculado), tipoDatoCalculado);
		}
	} else {
		tipoDatoCalculado = calcularTipoDatoResultante("MOD", izquierda->info.tipoDato, derecha->info.tipoDato);
		return crearNodo("-", izquierda, crearNodo("*", crearNodo("/", izquierda, derecha, tipoDatoCalculado), derecha, tipoDatoCalculado), tipoDatoCalculado);
	}
}

FILE* abrirArchivoAssembler(){
	FILE* arch = fopen("Final.asm", "w+");
	if(!arch){
		printf("No se pudo crear el archivo final.asm\n");
		return NULL;
	}

	return arch;
}

void escribirArchivoAssembler(FILE* arch){
	int i = 0;
    int j = 0;
	char variableFloat[TAM_NOMBRE];
	//ARMO LA CABECERA
	fprintf(arch, "include macros2.asm\n");
	fprintf(arch, "include number.asm\n");
	fprintf(arch, ".MODEL	LARGE \n");
	fprintf(arch, ".386\n");
	fprintf(arch, ".STACK 200h \n");
	fprintf(arch, ".DATA \n");
	for(j=0; j <= indice_tabla; j++){

			switch(tabla_simbolo[j].tipo_dato){

				case Integer:
						if(tabla_simbolo[j].nombre[0] == '@')
							fprintf(arch, "%-30s\t%s\t%s\n",tabla_simbolo[j].nombre,"DD", "?");
						else
							fprintf(arch, "_%-30s\t%s\t%s\n",tabla_simbolo[j].nombre,"DD", "?");
					break;
				case Float:
						if(tabla_simbolo[j].nombre[0] == '@')
							fprintf(arch, "%-30s\t%s\t%s\n",tabla_simbolo[j].nombre,"DD", "?");
						else
							fprintf(arch, "_%-30s\t%s\t%s\n",tabla_simbolo[j].nombre,"DD", "?");
					break;
				case String:
					strcpy(variableFloat, tabla_simbolo[j].nombre);
					reemplazarCarEnString(variableFloat,' ','_');
						if(tabla_simbolo[j].nombre[0] == '@')
							fprintf(arch, "%-30s\t%s\t%s\n",tabla_simbolo[j].nombre,"DB", "?");
						else
							fprintf(arch, "_%-30s\t%s\t%s\n",variableFloat,"DB", "?");

					break;
				case CteInt:
					fprintf(arch, "%-30s\t%s\t%f\n",tabla_simbolo[j].nombre,"DD", (float)tabla_simbolo[j].valor_i);
					break;
				case CteFloat:
					
					strcpy(variableFloat, tabla_simbolo[j].nombre);
					reemplazarCarEnString(variableFloat,'.','f');
					fprintf(arch, "%-30s\t%s\t%.2f\n",variableFloat,"DD", tabla_simbolo[j].valor_f);
					break;
				case CteString:
					strcpy(variableFloat, tabla_simbolo[j].valor_s);
					reemplazarCarEnString(variableFloat,' ','_');
					fprintf(arch, "_%-30s\t%s\t%s\n",variableFloat,"DB", tabla_simbolo[j].nombre);
					break;
			}
	  
	}
	fprintf(arch, ".CODE \n");
	fprintf(arch, "MAIN:\n");
	fprintf(arch, "\n");
    fprintf(arch, "\n");
    fprintf(arch, "mov AX,@DATA 	;inicializa el segmento de datos\n");
    fprintf(arch, "mov DS,AX \n");
    fprintf(arch, "mov ES,AX \n");
    fprintf(arch, "FNINIT \n");;
    fprintf(arch, "\n");

	for(i=0; i < vectorASM_IDX; i++){
		if(strcmp(vectorASM[i].reg2, "") != 0){	
			fprintf(arch, "%s %s, %s\n", vectorASM[i].operacion, vectorASM[i].reg1, vectorASM[i].reg2);
		} else {
			if(strcmp(vectorASM[i].reg1, "") != 0){
				fprintf(arch, "%s %s\n", vectorASM[i].operacion, vectorASM[i].reg1);
			} else {
				fprintf(arch, "%s\n", vectorASM[i].operacion);
			}
		}
	}


	fprintf(arch, "\n\t mov AX, 4C00h \t ; Genera la interrupcion 21h\n");
	fprintf(arch, "\t int 21h \t ; Genera la interrupcion 21h\n");
	fprintf(arch, "END MAIN\n");
	fclose(arch);
}

void cerrarArchivoAssembler(FILE* arch){
	fclose(arch);
}

void generarAssembler(tArbol *pa, FILE* arch){

	ASM instruccion;
	char aux[10];
	char tagAux[15];
	char tag[50];

	if(!*pa)
		return;
	

	if((*pa)->der != NULL || (*pa)->izq != NULL){ 
		if(!strcmp((*pa)->info.cadena, "REPEAT")){
			sprintf(tagAux, "%d", contTagRepeat);
			strcpy(tag, ".repeat");
			strcat(tag, tagAux);

			strcpy(instruccion.operacion, tag);
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			//poner_en_pila_asm(&pilaAssembler, vectorASM_IDX);
			poner_en_pila_asm(&pilaRepeatProcesado, vectorASM_IDX);
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;
			
			contTagRepeat++;
			contTagEndRepeat++;

			repeatFlag = 1;
		} else if(!strcmp((*pa)->info.cadena, "IF")){
			contTagEndif++;
			ifFlag = 1;
		}
	}

	/*Recorro para la izquierda*/
	generarAssembler(&(*pa)->izq, arch);
	
	if((*pa)->der != NULL || (*pa)->izq != NULL){ 
		if(!strcmp((*pa)->info.cadena, "ELSE")){
			strcpy(instruccion.operacion, "JMP");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			poner_en_pila_asm(&pilaAssembler, vectorASM_IDX);
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			sprintf(tagAux, "%d", contTagElse);
			
			strcpy(tag, ".else");
			strcat(tag, tagAux);
			strcat(tag, ":");
			strcpy(instruccion.operacion, tag);
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");

			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			poner_en_pila_asm(&pilaElseProcesados, contTagElse);
			contTagElse++;
		} else if(!strcmp((*pa)->info.cadena, "FILTER" ) && strcmp((*pa)->izq->info.cadena, "FILTER") != 0){
			int pos_condicion;

			strcpy(instruccion.operacion, "FFREE");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			pos_condicion = sacar_de_pila_asm(&pilaAssembler);
			strcpy(vectorASM[pos_condicion].reg1, ".continuefilter");

			// strcpy(instruccion.operacion, "FLD");
			// if( ((*pa)->izq->izq->info.entero != 0)){		
			// 	sprintf(instruccion.reg1,"%d", (*pa)->izq->izq->info.entero);
			// } else if ( ((*pa)->izq->izq->info.flotante != 0)){		
			// 	sprintf(instruccion.reg1,"%f", (*pa)->izq->izq->info.flotante);
			// } else {
			// 	if((*pa)->izq->izq->info.cadena[0] == '@'){
			// 		strcpy(instruccion.reg1, (*pa)->izq->izq->info.cadena);
			// 	} else {
			// 		sprintf(instruccion.reg1,"_%s", (*pa)->izq->izq->info.cadena);
			// 	}	
			// }
			// strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->izq->izq, "FLD");
			vectorASM_IDX++;

			strcpy(instruccion.operacion, "JMP");
			strcpy(instruccion.reg1, ".finfilter");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			strcpy(instruccion.operacion, ".continuefilter:");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

		}
	}


	/*Recorro para la derecha*/
	generarAssembler(&(*pa)->der, arch);

	if((*pa)->der != NULL && (*pa)->izq != NULL){ 
		if(!strcmp((*pa)->info.cadena, "+")){
			operacionAssembler(&(*pa), "FADD");
		} else if(!strcmp((*pa)->info.cadena, "-")){
			operacionAssembler(&(*pa), "FSUB");
		} else if(!strcmp((*pa)->info.cadena, "*")){
			operacionAssembler(&(*pa), "FMUL");
		} else if(!strcmp((*pa)->info.cadena, "/")){
			operacionAssembler(&(*pa), "FDIV");
		} else if(!strcmp((*pa)->info.cadena, ":=")){
			asignacionAssembler(&(*pa));
		} else if(!strcmp((*pa)->info.cadena, ">")){
			comparacionAssembler(&(*pa), "JLE");
		} else if(!strcmp((*pa)->info.cadena, ">=")){
			comparacionAssembler(&(*pa), "JL");
		} else if(!strcmp((*pa)->info.cadena, "<")){
			comparacionAssembler(&(*pa), "JGE");
		} else if(!strcmp((*pa)->info.cadena, "<=")){
			comparacionAssembler(&(*pa), "JG");
		} else if(!strcmp((*pa)->info.cadena, "==")){
			comparacionAssembler(&(*pa), "JNE");
		} else if(!strcmp((*pa)->info.cadena, "!=")){
			comparacionAssembler(&(*pa), "JE");
		} else if(!strcmp((*pa)->info.cadena, "IF")){
			int pos_condicion;
			int tipo_condicion;
			int jump_else;
			char tagElseAux[50];
			char tagEndifAux[50];
			char contTagElseAux[12];
			char contTagEndifAux[12];
			int indiceElse;
			int pilaAndAux;
			int pos_condOr;
			char saltoOr[20];

			sprintf(tagAux, "%d", contTagEndif);
			strcpy(tag, ".endif");
			strcat(tag, tagAux);
			strcat(tag, ":");

			strcpy(instruccion.operacion, tag);
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;


			sprintf(contTagEndifAux, "%d", contTagEndif);
			strcpy(tagEndifAux, ".endif");
			strcat(tagEndifAux, contTagEndifAux);

			//Si es un if con else
			if(!pila_vacia_asm(&pilaElseProcesados) && ver_tope_pila_asm(&pilaElseProcesados) == contTagEndif ){

				indiceElse = sacar_de_pila_asm(&pilaElseProcesados);

				strcpy(tagElseAux, ".else");
				sprintf(contTagElseAux, "%d", indiceElse);
				strcat(tagElseAux, contTagElseAux);
				
				jump_else = sacar_de_pila_asm(&pilaAssembler);
				strcpy(vectorASM[jump_else].reg1, tagEndifAux);
				
				if(pila_vacia_asm(&pilaCondicionIFAssembler)){
					pos_condicion = sacar_de_pila_asm(&pilaAssembler);
					strcpy(vectorASM[pos_condicion].reg1, tagElseAux);
				} else {
					pilaAndAux = sacar_de_pila_asm(&pilaAndIf);
					if(contTagEndif == pilaAndAux){
						tipo_condicion = sacar_de_pila_asm(&pilaCondicionIFAssembler);
						if(tipo_condicion == AND_LOG){
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagElseAux);
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagElseAux);
						}else{
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagElseAux);
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							invertir_comparador_asm(vectorASM[pos_condicion].operacion);
							pos_condOr = sacar_de_pila_asm(&pilaOr);
							sprintf(saltoOr, "%d", pos_condOr);
							strcpy(vectorASM[pos_condicion].reg1,saltoOr);

						}
					}
					else{
						poner_en_pila_asm(&pilaAndIf, pilaAndAux);
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						strcpy(vectorASM[pos_condicion].reg1, tagElseAux);
					}

				}
			} else {

				if(pila_vacia_asm(&pilaCondicionIFAssembler)){
					pos_condicion = sacar_de_pila_asm(&pilaAssembler);
					strcpy(vectorASM[pos_condicion].reg1, tagEndifAux);
				} else {
					//Si tiene condicion compuesta

					pilaAndAux = sacar_de_pila_asm(&pilaAndIf);
					if(contTagEndif == pilaAndAux){
						tipo_condicion = sacar_de_pila_asm(&pilaCondicionIFAssembler);
						if(tipo_condicion == AND_LOG){
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagEndifAux);
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagEndifAux);
						}else{
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							strcpy(vectorASM[pos_condicion].reg1, tagEndifAux);
							pos_condicion = sacar_de_pila_asm(&pilaAssembler);
							invertir_comparador_asm(vectorASM[pos_condicion].operacion);
							pos_condOr = sacar_de_pila_asm(&pilaOr);
							sprintf(saltoOr, "%d", pos_condOr);
							strcpy(vectorASM[pos_condicion].reg1,saltoOr);

						}
					}
					else{
						poner_en_pila_asm(&pilaAndIf, pilaAndAux);
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						strcpy(vectorASM[pos_condicion].reg1, tagEndifAux);
					}

				}
			}
			
			contTagEndif--;
			
		} else if(!strcmp((*pa)->info.cadena, "REPEAT")){
			int pos_condicion;
			int pos_ini_repeat;
			int tipo_condicion;
			char contAuxEndRepeat[50];
			char tagAuxEndRepeat[50];
			int pilaAndAux;
			int pos_condOr;
			char saltoOr[20];

			pos_ini_repeat = sacar_de_pila_asm(&pilaRepeatProcesado);
			
			strcpy(instruccion.operacion, "JMP");
			strcpy(instruccion.reg1, vectorASM[pos_ini_repeat].operacion);
			strcat(vectorASM[pos_ini_repeat].operacion, ":");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			strcpy(tagAuxEndRepeat, ".endrepeat");
			sprintf(contAuxEndRepeat, "%d", contTagEndRepeat);
			strcat(tagAuxEndRepeat, contAuxEndRepeat);
			
			strcpy(instruccion.operacion, tagAuxEndRepeat);
			strcat(instruccion.operacion, ":");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			
			if(pila_vacia_asm(&pilaCondicionREPEATAssembler)){
				pos_condicion = sacar_de_pila_asm(&pilaAssembler);
				strcpy(vectorASM[pos_condicion].reg1, tagAuxEndRepeat);
			} else {
				pilaAndAux = sacar_de_pila_asm(&pilaAndRepeat);
				if(contTagEndRepeat == pilaAndAux){
					tipo_condicion = sacar_de_pila_asm(&pilaCondicionREPEATAssembler);
					if(tipo_condicion == AND_LOG){
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						strcpy(vectorASM[pos_condicion].reg1, tagAuxEndRepeat);
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						strcpy(vectorASM[pos_condicion].reg1, tagAuxEndRepeat);
					}else{
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						strcpy(vectorASM[pos_condicion].reg1, tagAuxEndRepeat);
						pos_condicion = sacar_de_pila_asm(&pilaAssembler);
						invertir_comparador_asm(vectorASM[pos_condicion].operacion);
						pos_condOr = sacar_de_pila_asm(&pilaOr);
						sprintf(saltoOr, "%d", pos_condOr);
						strcpy(vectorASM[pos_condicion].reg1,saltoOr);

					}
				}
				else{
					poner_en_pila_asm(&pilaAndRepeat, pilaAndAux);
					pos_condicion = sacar_de_pila_asm(&pilaAssembler);
					strcpy(vectorASM[pos_condicion].reg1, tagAuxEndRepeat);
				}
				
			}
			contTagEndRepeat--;

			
		} else if(!strcmp((*pa)->info.cadena, "AND")){
			if(repeatFlag == 1){
				poner_en_pila_asm(&pilaCondicionREPEATAssembler, AND_LOG);
				poner_en_pila_asm(&pilaAndRepeat, contTagEndRepeat);
				repeatFlag = 0;
			} else if (ifFlag == 1){
				poner_en_pila_asm(&pilaCondicionIFAssembler, AND_LOG);
				poner_en_pila_asm(&pilaAndIf, contTagEndif);
				ifFlag = 0;
			}
			
		} else if(!strcmp((*pa)->info.cadena, "OR")){
			if(repeatFlag == 1){
				poner_en_pila_asm(&pilaCondicionREPEATAssembler, OR_LOG);
				poner_en_pila_asm(&pilaAndRepeat, contTagEndRepeat);
				poner_en_pila_asm(&pilaOr, vectorASM_IDX );
				repeatFlag = 0;
			} else if (ifFlag == 1){
				poner_en_pila_asm(&pilaCondicionIFAssembler, OR_LOG);
				poner_en_pila_asm(&pilaAndIf, contTagEndif);
				poner_en_pila_asm(&pilaOr, vectorASM_IDX );
				ifFlag = 0;
			}
		} else if(!strcmp((*pa)->info.cadena, "FILTER")){
			int pos_condicion;

			strcpy(instruccion.operacion, "FFREE");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;
			
			pos_condicion = sacar_de_pila_asm(&pilaAssembler);
			strcpy(vectorASM[pos_condicion].reg1, ".continuefilter");
			vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->der->izq, "FLD");
			vectorASM_IDX++;

			strcpy(instruccion.operacion, "JMP");
			strcpy(instruccion.reg1, ".finfilter");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

			strcpy(instruccion.operacion, ".continuefilter:");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;

		}
	} else if((*pa)->izq != NULL){
		printf("entre, info cadena: %s", (*pa)->info.cadena);
		if(!strcmp((*pa)->info.cadena, "FILTER-PADRE")){
			strcpy(instruccion.operacion, ".finfilter:");
			strcpy(instruccion.reg1, "");
			strcpy(instruccion.reg2, "");
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;
		}
	} else if((*pa)->der != NULL) {
		if(!strcmp((*pa)->info.cadena, "PRINT")){
			vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion_print(&(*pa)->der);
			vectorASM_IDX++;
		} else if(!strcmp((*pa)->info.cadena, "READ")){
			strcpy(instruccion.operacion, "CALL");
			strcpy(instruccion.reg1, "READ");

			if( ((*pa)->der->info.entero != 0)){		
				sprintf(instruccion.reg2,"%d", (*pa)->der->info.entero);
			} else if ( ((*pa)->der->info.flotante != 0)){		
				sprintf(instruccion.reg2,"%f", (*pa)->der->info.flotante);
			} else {
				if((*pa)->der->info.cadena[0] == '@'){
					strcpy(instruccion.reg2, (*pa)->der->info.cadena);
				} else {
					sprintf(instruccion.reg2,"_%s", (*pa)->der->info.cadena);
				}	
			}
			
			vectorASM[vectorASM_IDX] = instruccion;
			vectorASM_IDX++;
		}
	}
}


void operacionAssembler(tArbol *pa, char* operacion){
	
	char aux[10];
	char aux2[10];
	ASM instruccion;
	char instruccionTipo[10];

	if( ((*pa)->izq->info.tipoDato == Integer)||((*pa)->izq->info.tipoDato == CteInt)){
		strcpy(instruccionTipo,"FLD");
	} else if (((*pa)->izq->info.tipoDato == Float)||((*pa)->izq->info.tipoDato == CteFloat)){
		strcpy(instruccionTipo,"FLD");
	} else{
		strcpy(instruccionTipo,"STRING");
	}
	
    strcpy(instruccion.reg2,"");
	vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->izq, instruccionTipo);
	vectorASM_IDX++;

	if( ((*pa)->der->info.tipoDato == Integer)||((*pa)->der->info.tipoDato == CteInt)){
		strcpy(instruccionTipo,"FLD");
	} else if(((*pa)->der->info.tipoDato == Float)||((*pa)->der->info.tipoDato == CteFloat)){
		strcpy(instruccionTipo,"FLD");
	} else{
		strcpy(instruccionTipo,"STRING");
	}

	vectorASM[vectorASM_IDX] =  insertar_en_vector_instruccion(&(*pa)->der, instruccionTipo);
	vectorASM_IDX++;

    strcpy(instruccion.operacion, operacion);
	strcpy(instruccion.reg1,"");
	strcpy(instruccion.reg2,"");
    vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;

	contAssembler++;
	strcpy(aux, "@aux");
	sprintf(aux2, "%d", contAssembler);
	strcat(aux, aux2);
	insertarEnTabla(aux,indice_tabla,(*pa)->info.tipoDato);

	strcpy(instruccion.operacion, "FSTP");
	strcpy(instruccion.reg2,"");
	strcpy(instruccion.reg1, aux);
	strcpy(auxAssembler, aux);
	vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;

    strcpy(instruccion.operacion, "FFREE");
    strcpy(instruccion.reg1,"");
	strcpy(instruccion.reg2,"");
	vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;
    
    strcpy(instruccion.operacion, "");  
	(*pa)->der = NULL;
	(*pa)->izq = NULL;
	strcpy((*pa)->info.cadena,auxAssembler);
	(*pa)->info.entero = 0;
	(*pa)->info.flotante = 0;	
}

void comparacionAssembler(tArbol *pa, char* comparador){
	ASM instruccion;
	vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->izq,"FLD");
	vectorASM_IDX++;     
	vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->der,"FCOMP");;
	vectorASM_IDX++;
	strcpy(instruccion.operacion, "FSTSW");
	strcpy(instruccion.reg1, "AX");
	strcpy(instruccion.reg2,"");
    vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;
    strcpy(instruccion.operacion, "SAHF");
	strcpy(instruccion.reg1, "");
	strcpy(instruccion.reg2,"");
    vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;
	strcpy(instruccion.operacion, "FFREE");
	strcpy(instruccion.reg1, "");
	strcpy(instruccion.reg2,"");
    vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;



	strcpy(instruccion.operacion, comparador);
	strcpy(instruccion.reg1, "");
	strcpy(instruccion.reg2, "");
	poner_en_pila_asm(&pilaAssembler, vectorASM_IDX);
	
	vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;
	
}


ASM insertar_en_vector_instruccion(tArbol* arbol, char* tipoOperacion){
char variable [TAM_NOMBRE];
int posicion;
ASM instruccion;

strcpy(instruccion.operacion, tipoOperacion);

switch((*arbol)->info.tipoDato){

				case Integer:
						if((*arbol)->info.cadena[0] == '@')
							sprintf(instruccion.reg1,"%s", (*arbol)->info.cadena);
						else
							sprintf(instruccion.reg1,"_%s", (*arbol)->info.cadena);
					break;
				case Float:
						if((*arbol)->info.cadena[0] == '@')
							sprintf(instruccion.reg1,"%s", (*arbol)->info.cadena);
						else
							sprintf(instruccion.reg1,"_%s", (*arbol)->info.cadena);
					break;
				case String:
					posicion = buscarEnTabla((*arbol)->info.cadena);
					strcpy(variable,tabla_simbolo[posicion].valor_s);
					reemplazarCarEnString(variable,' ','_');

					if(variable[0] == '@')
						sprintf(instruccion.reg1,"%s",variable);
					else
						sprintf(instruccion.reg1,"_%s",variable);

					break;
				case CteInt:
					sprintf(instruccion.reg1,"_%d",(*arbol)->info.entero);
					break;
				case CteFloat:
					sprintf(instruccion.reg1,"_%f", (*arbol)->info.flotante);
					reemplazarCarEnString(instruccion.reg1,'.','f');
					break;
				case CteString:
					posicion = buscarEnTabla((*arbol)->info.cadena);
					strcpy(variable,tabla_simbolo[posicion].valor_s);
					reemplazarCarEnString(variable,' ','_');		
					sprintf(instruccion.reg1,"_%s",variable);

					break;
				
			}
	strcpy(instruccion.reg2,"");
	return instruccion;
}

ASM insertar_en_vector_instruccion_print(tArbol* arbol){
ASM instruccion;
strcpy(instruccion.operacion,"DISPLAYFLOAT");
switch((*arbol)->info.tipoDato){
				case Integer :
					sprintf(instruccion.reg1,"_%s,2",(*arbol)->info.cadena);
					break;
				case Float:
					sprintf(instruccion.reg1,"_%s,2",(*arbol)->info.cadena);
					break;
				case CteInt:				
					sprintf(instruccion.reg1,"_%f,2",(float)(*arbol)->info.entero);
					break;
				case CteFloat:
					sprintf(instruccion.reg1,"_%f,2",(*arbol)->info.flotante);
					break;
				
			}
	strcpy(instruccion.reg2,"");
	return instruccion;
}

void asignacionAssembler(tArbol *pa){
	ASM instruccion;
	vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->der,  "FLD");
	vectorASM_IDX++;
	vectorASM[vectorASM_IDX] = insertar_en_vector_instruccion(&(*pa)->izq,  "FSTP");
	vectorASM_IDX++;
	strcpy(instruccion.operacion, "FFREE");
    strcpy(instruccion.reg1,"");
	strcpy(instruccion.reg2,"");
	vectorASM[vectorASM_IDX] = instruccion;
	vectorASM_IDX++;
}

void invertir_comparador_asm(char *cadena){
	char result[40];
	if(strcmp(cadena, "JGE") == 0){
		strcpy(result, "JL");
	} else if(strcmp(cadena, "JG") == 0){
		strcpy(result, "JLE");
	} else if(strcmp(cadena, "JLE") == 0){
		strcpy(result, "JG");
	} else if(strcmp(cadena, "JL") == 0){
		strcpy(result, "JGE");
	} else if(strcmp(cadena, "JE") == 0){
		strcpy(result, "JNE");
	} else {
		strcpy(result, "JE");
	}
	strcpy(cadena, result);
}


void reemplazarCarEnString(char* destino , char find, char replace){

	char *current_pos = strchr(destino,find);
    if(current_pos){
        *current_pos = replace;    
    }

}