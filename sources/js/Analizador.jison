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
			:lsentencias { traducir($1);}
;

lsentencias
			:lsentencias sentencias	{$$=$1+$2;}
			|sentencias {$$=$1;}
			
			|error PTCOMA {console.log("Modo panico activado!!");agregarError('Sintactico','Token no esperado, modo panico activado'+$1,'',@2.first_line); $$="";}
						
;

sentencias
			:variables  {$$='\n'+$1; }
			|stc_if 	{$$='\n'+$1; }
			|consol     {$$='\n'+$1; }
			|stc_while  {$$='\n'+$1; }
			|stc_for 	{$$='\n'+$1; }
			|n44	PTCOMA		{$$='\n'+$1; }
			|BREAK PTCOMA		{$$='\n'+$1; }
			|CONTINUE PTCOMA	{$$='\n'+$1; }
			|llamada {$$='\n'+$1; }
		
;

variables
			: tipo v10 {  addVariable(value,$1,@1.first_line); value=[];  $$='var '+$2;}
			| v10 { value=[]; $$='\n\s'+$1;}
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
			|HTML		{$$=$1;}
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
			|n4		{$$=$1}
;
n44
			:INCREMENTO ID	{$$=$1+$2}	
			|DECREMENTO ID	{$$=$1+$2}	
			| ID DECREMENTO	{$$=$1+$2}	
			| ID INCREMENTO	{$$=$1+$2}	
;
n4
			: ENTERO 		{$$=$1}	
			| DOUBLE		{$$=$1}	
			| ID 	 		{$$=$1}	
			| ID llamado 	{$$=$1+$2}	
			|CADENA			{$$=$1;}
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
stc_if
			: IF PA condicion PC LLA lsentencias LLC lprim {	 $$=$1+" "+$3+" : " +tablear($6)+'\n' +$8+'\n'; 	}
;

lprim
			: ELSE IF PA condicion PC LLA lsentencias LLC lprim {$$='elif '+$4 + tablear($7)+'\n' +$9+'\n';}
			| lprim2 {$$=$1;}
;

lprim2
			: ELSE LLA lsentencias LLC{$$=$1 + tablear($3);}
			|{$$="";}
;

condicion
			:condicion O c1 {$$=$1+' or '+$1;}
			|c1				{$$=$1;}
;
c1
			:c1 Y c2		{$$=$1+' and '+$1;}
			|c2				{$$=$1;}
;
c2
			:NOT comparador {$$=' not '+$2;}
			|comparador		{$$= $1;}
;
comparador
			:dato MYOR dato 		{$$=$1+$2+$3;}
			|dato MNOR dato			{$$=$1+$2+$3;}
			|dato MNORI dato		{$$=$1+$2+$3;}
			|dato MYORI dato		{$$=$1+$2+$3;}
			|dato MISMOq dato		{$$=$1+$2+$3;}
			|dato Diferente dato	{$$=$1+$2+$3;}
;
consol
			:CONSOLA PT WRITE PA dato PC PTCOMA {$$="print("+$5+")"}
;

stc_while
			: WHILE PA condicion  PC LLA lsentencias LLC {$$=$1+" "+$3+" : \n"+tablear($6)+"";}
;
stc_for
			: FOR PA variables comparador PTCOMA  n44 PC LLA lsentencias LLC {$$="for "+"a"+" in a range( 1"+" , "+"10 ): \n"+tablear($9)+"\n"}
			| FOR PA variables comparador PTCOMA  variables PC LLA lsentencias LLC {$$="for "+"a"+" in a range( 1"+" , "+"10 ): \n"+tablear($9)+"\n"}
;

llamada:	ID PA pentrada PC  PTCOMA {$$=$1+$2+$3+$4}
;