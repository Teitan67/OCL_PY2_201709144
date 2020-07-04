/* Definición Léxica */

%lex
%options case-insensitive
%option yylineno
%locations

%%

\s+											// se ignoran espacios en blanco
"//".*										// comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			// comentario multiple líneas
<<EOF>>										//ignora saltos de linea

//variables
"int"				return 'INT';
"double"			return 'DOUBLE';
"string"			return 'STRING';
"char"				return 'CHAR';

"="					return 'IGUAL';

//operadores
"-"					return 'SMENOS';
"+"					return 'SMAS';
"*"					return 'SPOR';
"/"					return 'SDIV';


[0-9]+\b			return 'ENTERO';
";"					return 'PTCOMA';
([a-zA-Z])[a-zA-Z0-9_]*	return 'ID';

.					{ ; 
					  agregarError('Lexico','Caracter no reconocido '+yytext,yylloc.first_column,yylloc.first_line);
					}

/lex


%{
	//Contenido
	var tabs=0;
	var tipo="";
	var id="";
%}


/* Asociación de operadores y precedencia */
//------------------------------------------

%start programa

%% /* Definición de la gramática */

programa
			:lsentencias
;

lsentencias
			:lsentencias sentencias	
			|sentencias 			
;

sentencias
			:variables  
;

variables
			: tipo V10 { tipo= $1 }
;

V10
			:
;

tipo
			:STRING
			|CHAR
			|INT
			|DOUBLE
;