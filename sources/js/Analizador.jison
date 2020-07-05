//* Definición Léxica */

%lex
%options case-insensitive
%option yylineno
%locations

%%

\s+											{}										// se ignoran espacios en blanco
"//".*										{}   // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			{} 	// comentario multiple líneas
<<EOF>>										{}										//ignora saltos de linea
 

//variables
"int"				return 'INT';
"double"			return 'DOUBLE';
"string"			return 'STRING';
"char"				return 'CHAR';
"bool"				return 'BOOL';

"="					return 'IGUAL';

//operadores
"-"					return 'SMENOS';
"+"					return 'SMAS';
"*"					return 'SPOR';
"/"					return 'SDIV';

")"					return 'PC';
"(" 				return 'PA';			


[0-9]+("."[0-9]+)			return 'DECIMAL';
[0-9]+						return 'ENTERO';
["][^"\n]*["]				return 'CADENA';
"true"						return 'TRUE';
"false"						return 'FALSE';
['][a-zA-Z][']				return 'CARACTER';

";"							return 'PTCOMA';
","							return 'COMA';	

([a-zA-Z])[a-zA-Z0-9_]*						return 'ID';



.					{  agregarError('Lexico','Caracter no reconocido '+yytext,yylloc.first_column,yylloc.first_line);}

/lex


%{
	//Contenido
	var tabs=0;
	var cValues=0;
	var tipo="nulo";
	var value =[] ;
	var contenido="";
%}


/* Asociación de operadores y precedencia */
//------------------------------------------

%start programa

%% /* Definición de la gramática */

programa
			:lsentencias
			|
;

lsentencias
			:lsentencias sentencias	
			|sentencias 
			|error PTCOMA {console.log("Modo panico activado!!");agregarError('Sintactico','Modo panico '+$1,'',@2.first_line);}
						
;

sentencias
			:variables  
;

variables
			: tipo v10 {  addVariable(value,$1,@1.first_line); value=[];  variables(tabs,$2);}
			| v10 {asignacion(tabs,$1)}
;

v10
			:v2 PTCOMA{$$=$1;}
			
;

v1	
			:COMA v2 {$$=$1+$2}
			|{$$="";}
;

v2
			: ID v3 v1 { value.push($1); $$=$1+$2+$3; }
;

v3
			: IGUAL dato {$$=$1+$2;}
			|{$$="";}
;

dato
			:CARACTER	{$$=$1;}
			|TRUE		{$$=$1;}
			|FALSE		{$$=$1;}
			|numeros	{$$=$1;}
			|CADENA		{$$=$1;}
;


numeros
			:numeros SMAS n1 	{$$=$1+$2+$3;}
			|numeros SMENOS n1  {$$=$1+$2+$3;}
			|n1					{$$=$1}
;

n1
			:n1 SPOR n2			 {$$=$1+$2+$3;}
			|n1 SDIV n2			 {$$=$1+$2+$3;}
			|n2					 {$$=$1}
;

n2
			:PA n3 PC  	 		 {$$=$1+$2+$3;}
			|n3					 {$$=$1}
;

n3
			:SMENOS n4	{$$=$1+$2;}
			|n4			{$$=$1}
;

n4
			: ENTERO 		{$$=$1}	
			| DOUBLE		{$$=$1}	
			| ID 	 		{$$=$1}	
			| ID llamado 	{$$=$1+$2}	
;

llamado:	PA pentrada PC  {$$=$1+$2+$3;};
pentrada	: dato p1  {$$=$1+$2}	
			| {$$=""}
;
p1			:COMA dato {$$=$1+$2}
			| {$$=""}
;

tipo
			:STRING
			|CHAR
			|INT
			|DOUBLE
			|BOOL
;