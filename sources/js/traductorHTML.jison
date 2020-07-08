//* Definición Léxica */

%lex
%options case-insensitive

%%
\s+											{}										// se ignoran espacios en blanco
"//".*										{}   // comentario simple línea
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]			{} 	// comentario multiple líneas
<<EOF>>										{}										//ignora saltos de linea

"Style"                                                     return 'STYLE';
"="                                                         return 'IGUAL';
["][^"]*["]                                                  return 'CADENA';
[<]"html"[>]                                                return 'INICIO';
[<][/]"html"[>]                                             return 'FINAL';
[<]"head"[>]                                                return 'IHEAD';
[<][/]"head"[>]                                             return 'FHEAD';
[<]"title"[>]                                               return 'ITITLE';
[<][/]"title"[>]                                            return 'FTITLE';
[<]"body"                                                   return 'IBODY';
[<][/]"body"[>]                                             return 'FBODY';

[>]                                                         return 'C';
[<]"div"                                                    return 'IDIV';
[<][/]"div"[>]                                              return 'FDIV';
[<]"br"[>]                                                  return 'BR';
[<]"h"[0-9][>]                                                  return 'IH1';
[<][/]"h"[0-9][>]                                               return 'FH1';

[<]"button"[>]                                              return 'IBUTTON';
[<][/]"button"[>]                                           return 'FBUTTON';
[<]"label"[>]                                               return 'ILABEL';
[<][/]"label"[>]                                            return 'FLABEL';
[<]"input"[^/>]*[/]?[>]                                      return 'INPUT';
[<][p][>]                                                   return 'IP';
[<][/][p][>]                                                   return 'FP';
[^<>]*	                                return 'TXT';



.*					{  }

/lex


%{

%}


/* Asociación de operadores y precedencia */
//------------------------------------------


%start html

%% /* Definición de la gramática */

html
			:INICIO cabeza body FINAL { setJSON( "\"html\":{\n"+ $2+",\n"+$3 +"\n}");}
            |
            
;
cabeza
            :IHEAD titulo FHEAD {$$="\t\"head\":{\n"+ $2 +"\n\t}";}
;
titulo
            :ITITLE TXT FTITLE {$$="\t\t\"title\":{\n\t\t\t\"TEXTO\":\""+ $2 +"\"\n\t\t}";}
            |ITITLE  FTITLE {$$="\t\t\"title\":{\n\n\t\t}";}
            |{$$="";}
;
body 
              : IBODY estilo C lcontenido FBODY   {$$="\t\"body\":{\n"+ $2+"\n"+tablear($4) +"\n\t}";}
;
estilo
                :STYLE IGUAL CADENA {$$="\t\t\"style\":"+$3;}
                |{$$="";}
;
lcontenido
                :contenido {$$=$1;}
                |{$$="";}
                
;
contenido
               :contenido sentencias{$$=$1+","+$2;}
               |sentencias{$$=$1;}
               
;
sentencias 
                :TXT                           {$$="\n\"Texto\": "+$1;}      
                |IDIV estilo C contenido FDIV {$$="\n\"div\":{\n"+tablear($4)+"\n}";} 
                |IDIV estilo C  FDIV {$$="\n\"div\":{\n\n}";}          
                |BR                            {$$="\n\"br\":\"br\""}
                |IH1 contenido FH1                   {$$="\"h1\":{\n"+tablear($2)+"\n}";}
                |IBUTTON contenido FBUTTON      {$$="\"button\":{\n"+tablear($2)+"\n}";}
                |ILABEL contenido FLABEL        {$$="\"label\":{\n"+tablear($2)+"\n}";}
                |INPUT                           {$$="\n\"input\":\"input\""} 
                |IP contenido FP        {$$="\"P\":{\n"+tablear($2)+"\n}";}
                
;

