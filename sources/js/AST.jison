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
"for"				return 'FOR';
"int"				return 'INT';
"double"			return 'DOUBLE';

"string"			return 'STRING';
"char"				return 'CHAR';
"bool"				return 'BOOL';
"if"				return 'IF';
"else"				return 'ELSE';
"while"				return 'WHILE';
"Console"			return 'CONSOLA';

"break"				return 'BREAK';
"continue"			return 'CONTINUE';

"."					return 'PT';
"Write"				return 'WRITE';
"!="				return 'Diferente';
"&&"				return 'Y';
"||"				return 'O';
"!"					return 'NOT';
">"					return 'MYOR';
"<"					return 'MNOR';
"<="				return 'MNORI';
">="				return 'MYORI';
"=="				return 'MISMOq';


"++"				return 'INCREMENTO';
"--"				return 'DECREMENTO';


"="					return 'IGUAL';

//operadores
"-"					return 'SMENOS';
"+"					return 'SMAS';
"*"					return 'SPOR';
"/"					return 'SDIV';

")"					return 'PC';
"(" 				return 'PA';	
"{"					return 'LLA';	
"}"					return 'LLC';
"void"				return 'VOID';
"main"				return 'MAIN';
"switch"			return 'SWITCH';
"case"				return 'CASE';
":"					return 'DOSPTS';
"default"			return 'DEFAULT';
"do"				return 'DO';
"return"			return 'RETURN';


[0-9]+("."[0-9]+)			return 'DECIMAL';
[0-9]+						return 'ENTERO';
["][^"\n]*["]				return 'CADENA';
"true"						return 'TRUE';
"false"						return 'FALSE';

['][^']*[']					{setHTML(yytext); return 'HTML';}

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

//	function addVariable(){}
//	function traducir(){}
//	function agregarError(){}
%}


/* Asociación de operadores y precedencia */
//------------------------------------------


%start programa

%% /* Definición de la gramática */

programa
			:lsentencias { descaargarAST("[{\"lsentencias\":["+$1+"]}]");}
			|main {  descaargarAST("[{\"main\":["+$1+"]}]");}
;

main
			: VOID MAIN PA PC LLA lsentencias LLC {$$="{"+JSON($1)+","+JSON($2)+","+JSON($3)+","+JSON($4)+","+JSON($5)+",\"lsentencias\":["+$6+"]"+","+JSON($7)+"}";} 
;


lsentencias
			:sentencias lsentencias {$$="{\"sentencias\":["+$1+"]},\n"+$2;}
			|sentencias {$$="{\"sentencias\":[\n"+$1+"\n]}\n";}
            |funciones {$$="{\"funciones\":["+$1+"]}\n";}
            |funciones lsentencias {$$="{\"funciones\":["+$1+"]},\n"+$2;}
;
funciones
			: VOID ID PA parametros PC LLA LLC { $$="{"+JSON($1)+","+JSON($2)+","+JSON($3)+","+$4+""+JSON($5)+","+JSON($6)+","+JSON($7)+"}";}
			| VOID ID PA parametros PC LLA lsentencias LLC{ $$="{"+JSON($1)+","+JSON($2)+","+JSON($3)+","+$4+""+JSON($5)+","+JSON($6)+",\"sentencias\":["+$7+"],"+JSON($8)+"}"; }
			| tipo ID PA parametros PC LLA LLC { $$="{"+$1+","+JSON($2)+","+JSON($3)+","+$4+""+JSON($5)+","+JSON($6)+","+JSON($7)+"}";}
			| tipo ID PA parametros PC LLA lsentencias LLC{ $$="{"+$1+","+JSON($2)+","+JSON($3)+","+$4+""+JSON($5)+","+JSON($6)+","+$7+","+JSON($8)+"}"; }
;
parametros
			:tipo ID COMA parametros {$$=$1+","+JSON($2)+JSON($3)+","+$4;}
			|tipo ID { $$=$1+","+JSON($2)+",";}
			|{$$="";}
;
sentencias
			:ID  {$$="{\"ID\":\""+$1+"\"}"; }
		
;

tipo
			:STRING     {$$="{\"STRING\":\""+$1+"\"}";}
			|CHAR       {$$="{\"CHAR\":\""+$1+"\"}";}
			|INT        {$$="{\"INT\":\""+$1+"\"}";}
			|DOUBLE     {$$="{\"DOUBLE\":\""+$1+"\"}";}
			|BOOL       {$$="{\"BOOL\":\""+$1+"\"}";}
;