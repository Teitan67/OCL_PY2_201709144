//* Definición Léxica */

%lex
%options case-insensitive


%%
\s+											{}										// se ignoran espacios en blanco
"//".*										{}   // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			{} 	// comentario multiple líneas
<<EOF>>										{}										//ignora saltos de linea
 

[<][h][t][m][l][>]                return 'INICIO';
[<][/][h][t][m][l][>]             return 'FINAL';
[<][h][e][a][d][>]                return 'IHEAD';
[<][/][h][e][a][d][>]             return 'FHEAD';
[<][t][i][t][l][e][>]             return 'ITITLE';
[<][/][t][i][t][l][e][>]          return 'FTITLE';
[<][b][o][d][y][>]                return 'IBODY';
[<][/][b][o][d][y][>]             return 'FBODY';
([a-zA-Z])[a-zA-Z0-9_\s]*	      return 'TXT';


.*					{  }

/lex


%{

%}


/* Asociación de operadores y precedencia */
//------------------------------------------


%start html

%% /* Definición de la gramática */

html
			:INICIO cabeza FINAL { setJSON( "\"html\":{\n"+ $2 +"\n}");}
            |INICIO  FINAL { setJSON( "\"html\":{\n\n}");}
            |INICIO cabeza body FINAL { setJSON( "\"html\":{\n"+ $2+","+$3 +"\n}");}
            |INICIO body FINAL { setJSON( "\"html\":{\n"+ $2 +"\n}");}
;
cabeza
            : IHEAD FHEAD {$$="\t\"head\":{\n\n\t}";}
            | IHEAD titulo FHEAD {$$="\t\"head\":{\n"+ $2 +"\n\t}";}
;
titulo
            :ITITLE TXT FTITLE {$$="\t\t\"title\":{\n\t\t\t\"TEXTO\":\""+ $2 +"\"\n\t\t}";}
            |ITITLE  FTITLE {$$="\t\t\"title\":{\n\n\t\t}";}
;
body 
            : IBODY FBODY {$$="\t\"body\":{\n\n\t}";}
            | IBODY contenido FBODY {$$="\t\"body\":{\n"+ $2 +"\n\t}";}
;
contenido :;