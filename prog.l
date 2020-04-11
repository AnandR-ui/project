%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<malloc.h>
	#include<string.h>
%}
alpha [a-zA-Z]
digit [0-9]
string {alpha}?\"(\\.|[^\\"])*\"
%%
[ \t\n];
"-" return SUB;
"+" return ADD;
"*" return MUL;
"/" return DIV;
"<" return LT;
">" return GT;
">=" return GE;
"<=" return LE;
"==" return EQ;
"=" return ASSIGN;
"&&" return AND;
"||" return OR;
"^" return XOR;
"int" return INT;
"float" return FLOAT;
"char" return CHAR;
"double" return DOUBLE;
"void" return VOID;
"main" return MAIN;
"switch" return SWITCH;
"if" return IF;
"else" return ELSE;
"break" return BREAK;
"default" return DEFAULT;
"while" return WHILE;
"do" return DO;
"for" return FOR;
"case" return CASE;
(printf\({string}(\,([^,)])+)*\)) return PRINTF;
(scanf\({string}(\,([^,)])+)*\)) return SCANF;
{alpha}({alpha}|{digit})* return IDENTIFIER;
{digit}+  return NUM;
{digit}+.{digit}+ return DECIMAL;
"#include<stdio.h>" return INCLUDE;
":" return COLON;
";" return SEMICOLON;
"," return COMMA;
"[" return OS;
"]" return CS;
"(" return OP;
")" return CP;
"{" return OB;
"}" return CB;
\'  return QUOTE; 
\"  return QUOTES;
"!=" return NEQ;
"!" return NOT;
%%

