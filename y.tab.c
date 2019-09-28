/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     START = 258,
     END = 259,
     VAR = 260,
     ENDVAR = 261,
     INTEGER = 262,
     FLOAT = 263,
     STRING = 264,
     REPEAT = 265,
     ENDREPEAT = 266,
     IF = 267,
     THEN = 268,
     ELSE = 269,
     ENDIF = 270,
     AND = 271,
     OR = 272,
     NOT = 273,
     ASIG = 274,
     SUMA = 275,
     RESTA = 276,
     POR = 277,
     DIVIDIDO = 278,
     MENOR = 279,
     MAYOR = 280,
     MENOR_IGUAL = 281,
     MAYOR_IGUAL = 282,
     IGUAL = 283,
     DISTINTO = 284,
     PA = 285,
     PC = 286,
     CA = 287,
     CC = 288,
     COMA = 289,
     PUNTO_COMA = 290,
     DOS_PUNTOS = 291,
     GUION_BAJO = 292,
     READ = 293,
     PRINT = 294,
     FILTER = 295,
     DIV = 296,
     MOD = 297,
     ID = 298,
     CTE_FLOAT = 299,
     CTE_INT = 300,
     CTE_STRING = 301
   };
#endif
/* Tokens.  */
#define START 258
#define END 259
#define VAR 260
#define ENDVAR 261
#define INTEGER 262
#define FLOAT 263
#define STRING 264
#define REPEAT 265
#define ENDREPEAT 266
#define IF 267
#define THEN 268
#define ELSE 269
#define ENDIF 270
#define AND 271
#define OR 272
#define NOT 273
#define ASIG 274
#define SUMA 275
#define RESTA 276
#define POR 277
#define DIVIDIDO 278
#define MENOR 279
#define MAYOR 280
#define MENOR_IGUAL 281
#define MAYOR_IGUAL 282
#define IGUAL 283
#define DISTINTO 284
#define PA 285
#define PC 286
#define CA 287
#define CC 288
#define COMA 289
#define PUNTO_COMA 290
#define DOS_PUNTOS 291
#define GUION_BAJO 292
#define READ 293
#define PRINT 294
#define FILTER 295
#define DIV 296
#define MOD 297
#define ID 298
#define CTE_FLOAT 299
#define CTE_INT 300
#define CTE_STRING 301




/* Copy the first part of user declarations.  */
#line 16 "Sintactico.y"

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
		int entero;
		float flotante;
		char *cadena;
	}tInfo;

	/* Defino estructura de nodo de arbol*/
	typedef struct sNodo{
		tInfo info;
		struct sNodo *izq, *der;
	}tNodo;

	/* Defino estructura de arbol*/
	typedef tNodo* tArbol;

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
	tNodo* crearNodo(int dato, tNodo *pIzq, tNodo *pDer);
	tNodo* crearHoja(int dato);

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
			compFilterPtr,		//Puntero de comparador de filter	
			listaExpComaPtr;	//Puntero de lista expresion coma		


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 120 "Sintactico.y"
{
	int valor_int;
	float valor_float;
	char *valor_string;
}
/* Line 193 of yacc.c.  */
#line 297 "y.tab.c"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 310 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   171

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  47
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  27
/* YYNRULES -- Number of rules.  */
#define YYNRULES  64
/* YYNRULES -- Number of states.  */
#define YYNSTATES  119

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   301

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     8,    12,    15,    17,    25,    29,    31,
      33,    35,    37,    41,    43,    46,    48,    50,    52,    54,
      56,    58,    60,    66,    74,    79,    83,    85,    87,    89,
      93,    97,   101,   105,   107,   111,   115,   117,   121,   123,
     125,   127,   129,   133,   137,   139,   142,   146,   152,   156,
     160,   164,   168,   170,   172,   174,   176,   178,   180,   182,
     191,   195,   197,   200,   203
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      48,     0,    -1,     3,    49,    55,     4,    -1,     5,    50,
       6,    -1,    50,    51,    -1,    51,    -1,    32,    52,    33,
      36,    32,    54,    33,    -1,    52,    34,    53,    -1,    53,
      -1,     8,    -1,     7,    -1,     9,    -1,    54,    34,    43,
      -1,    43,    -1,    55,    56,    -1,    56,    -1,    59,    -1,
      57,    -1,    58,    -1,    72,    -1,    73,    -1,    62,    -1,
      12,    65,    13,    55,    15,    -1,    12,    65,    13,    55,
      14,    55,    15,    -1,    10,    65,    55,    11,    -1,    43,
      19,    60,    -1,    61,    -1,    62,    -1,    46,    -1,    62,
      20,    63,    -1,    62,    21,    63,    -1,    62,    42,    63,
      -1,    62,    41,    63,    -1,    63,    -1,    63,    22,    64,
      -1,    63,    23,    64,    -1,    64,    -1,    30,    62,    31,
      -1,    70,    -1,    43,    -1,    44,    -1,    45,    -1,    66,
      16,    66,    -1,    66,    17,    66,    -1,    66,    -1,    18,
      66,    -1,    62,    69,    62,    -1,    37,    69,    30,    62,
      31,    -1,    37,    69,    44,    -1,    37,    69,    45,    -1,
      67,    16,    67,    -1,    67,    17,    67,    -1,    67,    -1,
      24,    -1,    25,    -1,    26,    -1,    27,    -1,    28,    -1,
      29,    -1,    40,    30,    68,    34,    32,    71,    33,    31,
      -1,    71,    34,    62,    -1,    62,    -1,    38,    43,    -1,
      39,    43,    -1,    39,    46,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   166,   166,   175,   178,   179,   182,   188,   189,   192,
     196,   200,   206,   211,   223,   224,   227,   228,   229,   230,
     231,   232,   235,   238,   241,   244,   253,   257,   263,   270,
     274,   278,   281,   284,   289,   292,   295,   300,   303,   308,
     314,   319,   331,   332,   333,   336,   337,   340,   341,   342,
     345,   346,   347,   350,   351,   352,   353,   354,   355,   359,
     362,   363,   366,   373,   378
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "START", "END", "VAR", "ENDVAR",
  "INTEGER", "FLOAT", "STRING", "REPEAT", "ENDREPEAT", "IF", "THEN",
  "ELSE", "ENDIF", "AND", "OR", "NOT", "ASIG", "SUMA", "RESTA", "POR",
  "DIVIDIDO", "MENOR", "MAYOR", "MENOR_IGUAL", "MAYOR_IGUAL", "IGUAL",
  "DISTINTO", "PA", "PC", "CA", "CC", "COMA", "PUNTO_COMA", "DOS_PUNTOS",
  "GUION_BAJO", "READ", "PRINT", "FILTER", "DIV", "MOD", "ID", "CTE_FLOAT",
  "CTE_INT", "CTE_STRING", "$accept", "programa", "seccion_declaracion",
  "bloque_dec", "declaracion", "t_datos", "t_dato", "lista_id", "bloque",
  "sentencia", "bloque_if", "bloque_while", "asignacion", "expresion",
  "expresion_cadena", "expresion_aritmetica", "termino", "factor",
  "expresion_logica", "termino_logico", "termino_filter",
  "comparacion_filter", "comp_bool", "filter", "lista_exp_coma", "lectura",
  "escritura", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    47,    48,    49,    50,    50,    51,    52,    52,    53,
      53,    53,    54,    54,    55,    55,    56,    56,    56,    56,
      56,    56,    57,    57,    58,    59,    60,    60,    61,    62,
      62,    62,    62,    62,    63,    63,    63,    64,    64,    64,
      64,    64,    65,    65,    65,    66,    66,    67,    67,    67,
      68,    68,    68,    69,    69,    69,    69,    69,    69,    70,
      71,    71,    72,    73,    73
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     4,     3,     2,     1,     7,     3,     1,     1,
       1,     1,     3,     1,     2,     1,     1,     1,     1,     1,
       1,     1,     5,     7,     4,     3,     1,     1,     1,     3,
       3,     3,     3,     1,     3,     3,     1,     3,     1,     1,
       1,     1,     3,     3,     1,     2,     3,     5,     3,     3,
       3,     3,     1,     1,     1,     1,     1,     1,     1,     8,
       3,     1,     2,     2,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     0,     1,     0,     0,     5,     0,
       0,     0,     0,     0,     0,    39,    40,    41,     0,    15,
      17,    18,    16,    21,    33,    36,    38,    19,    20,    10,
       9,    11,     0,     8,     3,     4,     0,    39,     0,     0,
      44,     0,     0,    62,    63,    64,     0,     0,     2,    14,
       0,     0,     0,     0,     0,     0,     0,     0,    45,    53,
      54,    55,    56,    57,    58,     0,     0,     0,     0,     0,
      37,     0,    52,     0,    28,    25,    26,    27,    29,    30,
      32,    31,    34,    35,     0,     7,    46,    24,    42,    43,
       0,     0,     0,     0,     0,     0,     0,    22,     0,    48,
      49,    50,    51,     0,    13,     0,     0,     0,    61,     0,
       6,     0,    23,    47,     0,     0,    12,    59,    60
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     4,     7,     8,    32,    33,   105,    18,    19,
      20,    21,    22,    75,    76,    23,    24,    25,    39,    40,
      72,    73,    65,    26,   109,    27,    28
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -36
static const yytype_int8 yypact[] =
{
       4,     9,    28,    11,    85,   -36,    17,    10,   -36,    -8,
      -8,   126,   -10,   -31,    19,    41,   -36,   -36,     1,   -36,
     -36,   -36,   -36,    45,    -5,   -36,   -36,   -36,   -36,   -36,
     -36,   -36,    46,   -36,   -36,   -36,    -8,   -36,   123,    85,
      76,    34,   -12,   -36,   -36,   -36,    20,   115,   -36,   -36,
     126,   126,   126,   126,   126,   126,    26,    17,   -36,   -36,
     -36,   -36,   -36,   -36,   -36,   126,    60,    -8,    -8,    85,
     -36,    92,    94,    33,   -36,   -36,   -36,    45,    -5,    -5,
      -5,    -5,   -36,   -36,    37,   -36,    45,   -36,   -36,   -36,
      38,   -24,    20,    20,    56,    30,    85,   -36,   126,   -36,
     -36,   -36,   -36,   126,   -36,    68,    97,    43,    45,    80,
     -36,    53,   -36,   -36,    77,   126,   -36,   -36,    45
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -36,   -36,   -36,   -36,   119,   -36,    65,   -36,   -35,   -15,
     -36,   -36,   -36,   -36,   -36,    -9,    81,    84,   136,   -13,
      61,   -36,    86,   -36,   -36,   -36,   -36
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      38,    38,    42,    49,    66,    48,    98,     1,    50,    51,
      36,     9,    44,    10,     3,    45,    34,    54,    55,    70,
      99,   100,    11,    58,    29,    30,    31,    38,     5,    52,
      53,    11,    14,    43,    90,    37,    16,    17,    77,    12,
      13,    14,     6,     6,    15,    16,    17,    69,     9,    46,
      10,    49,    96,    97,    88,    89,    86,    71,    38,    38,
      47,   106,    84,    50,    51,    50,    51,    94,    11,    95,
       9,    87,    10,   104,   113,    49,    12,    13,    14,    56,
      57,    15,    16,    17,    52,    53,    52,    53,   103,   107,
      11,    49,    67,    68,   108,     9,   116,    10,    12,    13,
      14,   110,   111,    15,    16,    17,   118,     9,   117,    10,
      92,    93,   112,   114,   115,    11,    59,    60,    61,    62,
      63,    64,    85,    12,    13,    14,    35,    11,    15,    16,
      17,    78,    79,    80,    81,    12,    13,    14,    82,    83,
      15,    16,    17,    50,    51,    11,    41,    59,    60,    61,
      62,    63,    64,   101,   102,    14,    11,    91,    37,    16,
      17,    74,     0,     0,    52,    53,    14,     0,     0,    37,
      16,    17
};

static const yytype_int8 yycheck[] =
{
       9,    10,    11,    18,    39,     4,    30,     3,    20,    21,
      18,    10,    43,    12,     5,    46,     6,    22,    23,    31,
      44,    45,    30,    36,     7,     8,     9,    36,     0,    41,
      42,    30,    40,    43,    69,    43,    44,    45,    47,    38,
      39,    40,    32,    32,    43,    44,    45,    13,    10,    30,
      12,    66,    14,    15,    67,    68,    65,    37,    67,    68,
      19,    96,    36,    20,    21,    20,    21,    34,    30,    32,
      10,    11,    12,    43,    31,    90,    38,    39,    40,    33,
      34,    43,    44,    45,    41,    42,    41,    42,    32,    98,
      30,   106,    16,    17,   103,    10,    43,    12,    38,    39,
      40,    33,    34,    43,    44,    45,   115,    10,    31,    12,
      16,    17,    15,    33,    34,    30,    24,    25,    26,    27,
      28,    29,    57,    38,    39,    40,     7,    30,    43,    44,
      45,    50,    51,    52,    53,    38,    39,    40,    54,    55,
      43,    44,    45,    20,    21,    30,    10,    24,    25,    26,
      27,    28,    29,    92,    93,    40,    30,    71,    43,    44,
      45,    46,    -1,    -1,    41,    42,    40,    -1,    -1,    43,
      44,    45
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    48,     5,    49,     0,    32,    50,    51,    10,
      12,    30,    38,    39,    40,    43,    44,    45,    55,    56,
      57,    58,    59,    62,    63,    64,    70,    72,    73,     7,
       8,     9,    52,    53,     6,    51,    18,    43,    62,    65,
      66,    65,    62,    43,    43,    46,    30,    19,     4,    56,
      20,    21,    41,    42,    22,    23,    33,    34,    66,    24,
      25,    26,    27,    28,    29,    69,    55,    16,    17,    13,
      31,    37,    67,    68,    46,    60,    61,    62,    63,    63,
      63,    63,    64,    64,    36,    53,    62,    11,    66,    66,
      55,    69,    16,    17,    34,    32,    14,    15,    30,    44,
      45,    67,    67,    32,    43,    54,    55,    62,    62,    71,
      33,    34,    15,    31,    33,    34,    43,    31,    62
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 166 "Sintactico.y"
    {
															printf("\nCOMPILACION EXITOSA\n");
															grabarTabla();
															//mostrar_grafico(&bloquePtr,10);
														}
    break;

  case 3:
#line 175 "Sintactico.y"
    {printf("R 1: Seccion declaracion => VAR bloque_dec ENDVAR\n");}
    break;

  case 4:
#line 178 "Sintactico.y"
    {printf("R 2: bloque_dec => bloque_dec declaracion\n");}
    break;

  case 5:
#line 179 "Sintactico.y"
    {printf("R 3: bloque_dec => declaracion\n");}
    break;

  case 6:
#line 182 "Sintactico.y"
    {
															printf("R 4: declaracion => t_dato DOS_PUNTOS lista_id\n");
															 agregarTiposDatosATabla();
														}
    break;

  case 7:
#line 188 "Sintactico.y"
    {printf("R 5: t_datos => t_datos COMA t_dato\n");}
    break;

  case 8:
#line 189 "Sintactico.y"
    {printf("R 6: t_datos => t_dato \n");}
    break;

  case 9:
#line 192 "Sintactico.y"
    {
															printf("R 7: t_dato => FLOAT\n");
															tipoDatoADeclarar = Float;
														}
    break;

  case 10:
#line 196 "Sintactico.y"
    {
															printf("R 8: t_dato => INTEGER\n");
															tipoDatoADeclarar = Integer;
														}
    break;

  case 11:
#line 200 "Sintactico.y"
    {
															printf("R 9: t_dato => STRING\n");
															tipoDatoADeclarar = String;
														}
    break;

  case 12:
#line 206 "Sintactico.y"
    {
	                                                        printf("R 8: lista_id => lista_id COMA ID\n");
	                                                        agregarVarATabla(yylval.valor_string);
															cantVarsADeclarar++;
                                                        }
    break;

  case 13:
#line 211 "Sintactico.y"
    {
	                                                        printf("R 9: lista_id => ID\n");
	                                                        agregarVarATabla(yylval.valor_string);
															varADeclarar1 = fin_tabla; /* Guardo posicion de primer variable de esta lista de declaracion. */
															cantVarsADeclarar = 1;
                                                        }
    break;

  case 14:
#line 223 "Sintactico.y"
    {printf("R 10: bloque => bloque sentencia\n");}
    break;

  case 15:
#line 224 "Sintactico.y"
    {printf("R 11: bloque => sentencia\n"); bloquePtr = sentenciaPtr;}
    break;

  case 16:
#line 227 "Sintactico.y"
    {printf("R 12: sentencia => asignacion\n"); sentenciaPtr = asigPtr;}
    break;

  case 17:
#line 228 "Sintactico.y"
    {printf("R 13: sentencia => bloque_if\n");}
    break;

  case 18:
#line 229 "Sintactico.y"
    {printf("R 14: sentencia => bloque_while\n");}
    break;

  case 19:
#line 230 "Sintactico.y"
    {printf("R 15: sentencia => lectura\n");}
    break;

  case 20:
#line 231 "Sintactico.y"
    {printf("R 16: sentencia => escritura\n");}
    break;

  case 21:
#line 232 "Sintactico.y"
    {printf("R 17: sentencia => expresion_aritmetica\n");}
    break;

  case 22:
#line 235 "Sintactico.y"
    {printf("R 18: bloque_if => IF expresion_logica THEN bloque ENDIF\n");}
    break;

  case 23:
#line 238 "Sintactico.y"
    {printf("R 19: bloque_if => IF expresion_logica THEN bloque ELSE bloque ENDIF\n");}
    break;

  case 24:
#line 241 "Sintactico.y"
    {printf("R 20: bloque_while => REPEAT expresion_logica bloque ENDREPEAT\n");}
    break;

  case 25:
#line 244 "Sintactico.y"
    {
															chequearVarEnTabla((yyvsp[(1) - (3)].valor_string));
															printf("R 21: asignacion => ID ASIG expresion\n");
															//asigPtr = crearNodo("ASIG", &(crearHoja("ID")), &exprPtr);
														}
    break;

  case 26:
#line 253 "Sintactico.y"
    {
															printf("R 22: expresion => expresion_cadena\n");
															exprPtr = exprCadPtr;
														}
    break;

  case 27:
#line 257 "Sintactico.y"
    {
															printf("R 23: expresion => expresion_aritmetica\n");
															exprPtr = exprAritPtr;
	}
    break;

  case 28:
#line 263 "Sintactico.y"
    {
															printf("R 24: expresion_cadena => CTE_STRING\n");
															agregarCteATabla(CteString);
															//exprAritPtr = crearHoja(CteString);
														}
    break;

  case 29:
#line 270 "Sintactico.y"
    {
															printf("R 25: expresion_aritmetica => expresion_aritmetica SUMA termino\n");
															//exprAritPtr = crearNodo("SUMA", &exprAritPtr, &terminoPtr);
														}
    break;

  case 30:
#line 274 "Sintactico.y"
    {
															printf("R 26: expresion_aritmetica => expresion_aritmetica RESTA termino\n");
															//exprAritPtr = crearNodo("RESTA", &exprAritPtr, &terminoPtr);
														}
    break;

  case 31:
#line 278 "Sintactico.y"
    {	printf("R 27: expresion_aritmetica => expresion_aritmetica MOD termino\n");
															//exprAritPtr = crearNodo("MOD", &exprAritPtr, &terminoPtr);
														}
    break;

  case 32:
#line 281 "Sintactico.y"
    {	printf("R 28: expresion_aritmetica => expresion_aritmetica DIV termino\n");
															//exprAritPtr = crearNodo("DIV", &exprAritPtr, &terminoPtr);
														}
    break;

  case 33:
#line 284 "Sintactico.y"
    {	printf("R 29: expresion_aritmetica => termino\n");
															exprAritPtr = terminoPtr;
														}
    break;

  case 34:
#line 289 "Sintactico.y"
    {	printf("R 30: termino => termino POR factor\n");
															//terminoPtr = crearNodo("POR", &terminoPtr, &factorPtr);
														}
    break;

  case 35:
#line 292 "Sintactico.y"
    {	printf("R 31: termino => termino DIVIDIDO factor\n");
															//terminoPtr = crearNodo("DIVIDIDO",&terminoPtr, &factorPtr);
														}
    break;

  case 36:
#line 295 "Sintactico.y"
    {	printf("R 32: termino => factor\n");
															terminoPtr = factorPtr;	
														}
    break;

  case 37:
#line 300 "Sintactico.y"
    {	printf("R 33: factor => PA expresion_aritmetica PC\n");
															factorPtr = exprAritPtr;
														}
    break;

  case 38:
#line 303 "Sintactico.y"
    {	printf("R 34: factor => FILTER\n");
														    factorPtr = filterPtr;
														}
    break;

  case 39:
#line 308 "Sintactico.y"
    {
															chequearVarEnTabla(yylval.valor_string);
															printf("R 35: factor => ID\n");
															factorPtr = crearHoja(Integer);
															printf("SE CREO UNA HOJA CORRECTAMENTE EN EL ARBOL\n"); //BORRAR ESTO
														}
    break;

  case 40:
#line 314 "Sintactico.y"
    {
															printf("R 36: factor => CTE_FLOAT\n");
															agregarCteATabla(CteFloat);
															factorPtr = crearHoja(CteFloat);
														}
    break;

  case 41:
#line 319 "Sintactico.y"
    {
															printf("R 37: factor => CTE_INT\n");
															agregarCteATabla(CteInt);
															factorPtr = crearHoja(CteInt);
															printf("SE CREO UNA HOJA CORRECTAMENTE EN EL ARBOL\n"); //BORRAR ESTO
															printf("Puntero:\n"); 
															printf("info: %d \n", factorPtr->info.entero);
															printf("\n");//BORRAR ESTO
														}
    break;

  case 42:
#line 331 "Sintactico.y"
    {printf("R 38: expresion_logica => termino_logico AND termino_logico\n");}
    break;

  case 43:
#line 332 "Sintactico.y"
    {printf("R 39: expresion_logica => termino_logico OR termino_logico\n");}
    break;

  case 44:
#line 333 "Sintactico.y"
    {printf("R 40: expresion_logica => termino_logico\n");}
    break;

  case 45:
#line 336 "Sintactico.y"
    {printf("R 41: NOT termino_logico\n");}
    break;

  case 46:
#line 337 "Sintactico.y"
    {printf("R 42: termino_logico => expresion_aritmetica comp_bool expresion_aritmetica\n");}
    break;

  case 47:
#line 340 "Sintactico.y"
    {printf("R 43: termino_filter => GUION_BAJO comp_bool PA expresion_aritmetica PC  \n");}
    break;

  case 48:
#line 341 "Sintactico.y"
    {printf("R 44: termino_filter => GUION_BAJO comp_bool CTE_FLOAT\n");}
    break;

  case 49:
#line 342 "Sintactico.y"
    {printf("R 45: termino_filter => GUION_BAJO comp_bool CTE_INT\n");}
    break;

  case 50:
#line 345 "Sintactico.y"
    {printf("R 46: comparacion_filter => termino_filter AND termino_filter\n");}
    break;

  case 51:
#line 346 "Sintactico.y"
    {printf("R 47: comparacion_filter => termino_filter OR termino_filter\n");}
    break;

  case 52:
#line 347 "Sintactico.y"
    {printf("R 48: comparacion_filter => termino_filter\n");}
    break;

  case 53:
#line 350 "Sintactico.y"
    {printf("R 49: comp_bool => MENOR\n");}
    break;

  case 54:
#line 351 "Sintactico.y"
    {printf("R 50: comp_bool => MAYOR\n");}
    break;

  case 55:
#line 352 "Sintactico.y"
    {printf("R 51: comp_bool => MENOR_IGUAL\n");}
    break;

  case 56:
#line 353 "Sintactico.y"
    {printf("R 52: comp_bool => MAYOR_IGUAL\n");}
    break;

  case 57:
#line 354 "Sintactico.y"
    {printf("R 53: comp_bool => IGUAL\n");}
    break;

  case 58:
#line 355 "Sintactico.y"
    {printf("R 54: comp_bool => DISTINTO\n");}
    break;

  case 59:
#line 359 "Sintactico.y"
    {printf("R 55: FILTER => FILTER PA comparacion_filter COMA CA lista_exp_coma CC PC\n");}
    break;

  case 60:
#line 362 "Sintactico.y"
    {printf("R 56: lista_exp_coma => lista_exp_coma COMA expresion_aritmetica\n");}
    break;

  case 61:
#line 363 "Sintactico.y"
    {printf("R 57: lista_exp_coma => expresion_aritmetica\n");}
    break;

  case 62:
#line 366 "Sintactico.y"
    {
															chequearVarEnTabla((yyvsp[(2) - (2)].valor_string));
															printf("R 58: lectura => READ ID\n");
														}
    break;

  case 63:
#line 373 "Sintactico.y"
    {
															chequearVarEnTabla((yyvsp[(2) - (2)].valor_string));
															chequearPrintId((yyvsp[(2) - (2)].valor_string));
															printf("R 59: escritura => PRINT ID\n");
														}
    break;

  case 64:
#line 378 "Sintactico.y"
    {
															printf("R 60: escritura => PRINT CTE_STRING\n");
															agregarCteATabla(CteString);
														}
    break;


/* Line 1267 of yacc.c.  */
#line 2027 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 384 "Sintactico.y"


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

tNodo* crearNodo(int dato, tNodo *pIzq, tNodo *pDer){
	
    tNodo* nodoNuevo = (tNodo*)malloc(sizeof(tNodo));
    tInfo info;

    switch(dato){
		case CteInt:
			info.entero = yylval.valor_int;
			break;
		case Integer:
		    info.entero = yylval.valor_int;
			break;		
		case CteFloat:
			info.flotante = yylval.valor_float;
			break;
		case Float:
			info.flotante = yylval.valor_float;
			break;		
		case CteString:
			strcpy(info.cadena , yylval.valor_string);
			break;
		case String:
			strcpy(info.cadena , yylval.valor_string);
			break;
	}
    
    nodoNuevo->info = info;
    nodoNuevo->izq = pIzq;
    nodoNuevo->der = pDer;
    return nodoNuevo;
}

tNodo* crearHoja(int dato){	
    tNodo* nodoNuevo = (tNodo*)malloc(sizeof(tNodo));
    tInfo info;

    switch(dato){
		case CteInt:
			info.entero = yylval.valor_int;
			break;
		case Integer:
		    info.entero = yylval.valor_int;
			break;		
		case CteFloat:
			info.flotante = yylval.valor_float;
			break;
		case Float:
			info.flotante = yylval.valor_float;
			break;		
		case CteString:
			strcpy(info.cadena , yylval.valor_string);
			break;
		case String:
			strcpy(info.cadena , yylval.valor_string);
			break;
	}

	nodoNuevo->info = info;
    nodoNuevo->izq = NULL;
    nodoNuevo->der = NULL;
    return nodoNuevo;
}






