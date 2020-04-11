%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
        
%}
%token IDENTIFIER MAIN NUM INT FLOAT CHAR DOUBLE VOID EQ LE GE AND OR XOR ASSIGN IF ELSE SWITCH BREAK WHILE CASE ADD SUB MUL DIV SEMICOLON COMMA SPACE OP CP OB CB DECIMAL FOR LT GT COLON DEFAULT DO PRINTF SCANF OS CS QUOTE QUOTES NEQ NOT INCLUDE

%start program

%%
program : function {printf("Input accepted\n");exit(0);}
	;
type : INT 
     | FLOAT 
     | CHAR 
     | DOUBLE
     | VOID 
     ;
rel : LT
    | GT
    | LE
    | GE
    | EQ
    | NEQ

    ;
declarations : INT variables_int  
             | FLOAT variables_float 
             | DOUBLE variables_double 
             | CHAR variables_char 
             ;

variables_int : IDENTIFIER
          | IDENTIFIER OS NUM CS
          | IDENTIFIER ASSIGN NUM
          | IDENTIFIER OS NUM CS ASSIGN OB NUM COMMA NUM CB
          | IDENTIFIER OS NUM CS ASSIGN NUM
          | variables_int COMMA variables_int
	  ;
variables_float : IDENTIFIER
          | IDENTIFIER OS NUM CS
          | IDENTIFIER OS NUM CS ASSIGN NUM
          | IDENTIFIER OS NUM CS ASSIGN DECIMAL
          | IDENTIFIER OS NUM CS ASSIGN OB NUM COMMA NUM COMMA NUM CB
          | IDENTIFIER OS NUM CS ASSIGN OB NUM COMMA DECIMAL COMMA DECIMAL CB
          | IDENTIFIER ASSIGN NUM
          | IDENTIFIER ASSIGN DECIMAL
	  | variables_float COMMA variables_float
	  ;
variables_char : IDENTIFIER
          | IDENTIFIER ASSIGN QUOTE IDENTIFIER QUOTE
	  | IDENTIFIER ASSIGN QUOTES IDENTIFIER QUOTES
          | IDENTIFIER OS NUM CS ASSIGN QUOTES IDENTIFIER QUOTES
	  | variables_char COMMA variables_char
	  ;
variables_double : IDENTIFIER
          | IDENTIFIER ASSIGN NUM
          | IDENTIFIER ASSIGN DECIMAL
          | IDENTIFIER OS NUM CS ASSIGN NUM
          | IDENTIFIER OS NUM CS ASSIGN DECIMAL
	  | variables_double COMMA variables_double
	  ;

function : INCLUDE type IDENTIFIER OP argumentlist CP OB body CB
         | INCLUDE INT MAIN OP CP OB body CB
         | INCLUDE VOID MAIN OP CP OB body CB
	 ;
body : statements
     | body body
     |
     ;
argumentlist : INT variables_int
        | FLOAT variables_float
        | DOUBLE variables_double
        | CHAR variables_char 
        | argumentlist COMMA argumentlist
        ;
statements : declarations SEMICOLON
	   | expressions SEMICOLON
           | for_loop
           | if_condn
           | while_loop
           | switch_case
           | do_while
	   ;
for_loop : FOR OP IDENTIFIER ASSIGN NUM SEMICOLON IDENTIFIER rel IDENTIFIER SEMICOLON expressions CP def
         | FOR OP IDENTIFIER ASSIGN IDENTIFIER SEMICOLON IDENTIFIER rel NUM SEMICOLON expressions CP def
         | FOR OP IDENTIFIER ASSIGN NUM SEMICOLON IDENTIFIER rel NUM SEMICOLON expressions CP def
         | FOR OP IDENTIFIER ASSIGN IDENTIFIER SEMICOLON IDENTIFIER rel IDENTIFIER SEMICOLON expressions CP def
         ;
def : OB for_body CB
    | expressions SEMICOLON
    | for_loop
    |
    ;
for_body : for_body for_body
         | expressions SEMICOLON
         | for_loop
         |
         ;
if_condn : IF OP expressions CP OB if_def CB
         | IF OP expressions CP OB if_s_line_def CB
	 | IF OP expressions CP if_s_line_def
         | IF OP expressions CP OB if_def CB ELSE OB if_def CB
	 | IF OP expressions CP OB if_s_line_def CB ELSE OB if_s_line_def CB
	 | IF OP expressions CP if_s_line_def ELSE if_s_line_def
	 | IF OP expressions CP if_s_line_def ELSE OB if_def CB
	 | IF OP expressions CP OB if_def CB ELSE if_s_line_def
         | IF OP expressions CP OB if_def CB 'else if' OB if_def CB ELSE OB if_def CB
	 | IF OP expressions CP OB if_s_line_def CB 'else if' OB if_s_line_def CB ELSE OB if_s_line_def CB
	 | IF OP expressions CP if_s_line_def 'else if' if_s_line_def ELSE if_s_line_def
         ;

if_s_line_def : expressions SEMICOLON
              ;

if_def : if_def if_def
       | expressions SEMICOLON
       ;
while_loop : WHILE OP expressions CP OB while_body CB
           | WHILE OP expressions CP expressions SEMICOLON 
           ;
while_body : while_body while_body
           | expressions SEMICOLON
           ;
switch_case : SWITCH OP IDENTIFIER CP OB switch_body CB
	    ;
switch_body : cases
            | cases default_case
            ;
cases : cases cases
      | CASE NUM COLON expressions SEMICOLON BREAK SEMICOLON
      | CASE NUM COLON BREAK SEMICOLON
      ;
default_case : DEFAULT COLON expressions SEMICOLON BREAK SEMICOLON
	     | DEFAULT COLON BREAK SEMICOLON
             ;
do_while : DO OB while_body CB WHILE OP expressions CP SEMICOLON
        ;
expressions : IDENTIFIER ASSIGN expressions
	    | expressions ADD expressions 
            | expressions SUB expressions 
            | expressions MUL expressions 
            | expressions DIV expressions
            | expressions ADD ADD
            | expressions SUB SUB
            | expressions AND expressions 
            | expressions OR expressions 
            | expressions XOR expressions
            | expressions rel expressions
	    | OP expressions CP
	    | NOT OP expressions CP
	    | NOT IDENTIFIER
            | IDENTIFIER 
            | NUM 
            | PRINTF
            | SCANF
            ;
%%
int yywrap()
{
return 1;
}
#include "lex.yy.c"
int main()
{
	yyin=fopen("input.c","r");
        yyparse();
        fclose(yyin);
	return 0;
}
int yyerror(char *s)
{
printf("Syntax error");
return 1;
}




