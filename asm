DATA SEGMENT

MENS1 DB 13,10,13,10," MENU --EXAMEN FINAL-- $"
MENS2 DB 13,10,13,10,"1. DATOS DEL AUTOR" " $"
MENS3 DB 13,10,13,10,"BAIRON DUVAN MARTIN MORENO $"
MENS4 DB 13,10,"2. SUMA DE DOS NUMEROS $"
MENS5 DB 13,10,"3. RESTA DE DOS NUMEROS $"
MENS6 DB 13,10,"4. MULTIPLICACION DE DOS NUMEROS $"
MENS7 DB 13,10,"5. DIVISION DE DOS NUMEROS $"
MENS8 DB 13,10,"6. VALIDAR SI EL NUMERO ES POSITIVO O NEGATIVO $"
MENS9 DB 13,10,"7. SALIR $"
MENS10 DB 13,10,13,10,"SELECCIONE UNA OPCION: $"
MENS11 DB 13,10,13,10,"INGRESE NUMERO: $",
MENS12 DB 13,10,"EL RESULTADO ES: $"
MENS13 DB "COCIENTE = $"
MENS14 DB " RESIDUO = $"
MENS15 DB 10,13,10,13, "EL NUMERO ES POSITIVO $"
MENS16 DB 10,13,10,13, "EL NUMERO ES NEGATIVO $"
RESULT DB 0
QUOTIENT DB 0
RESIDUE DB 0
NUMERO DB 0
SIGNOX DB 0
R2 DB ?
AC DB 0

DATA ENDS

PILA SEGMENT STACK

DW 256 DUP (?)

PILA ENDS

CODE SEGMENT

MENU PROC FAR

ASSUME CS:CODE,DS:DATA,SS:PILA
PUSH DS
XOR AX,AX
PUSH AX
MOV AX,DATA
MOV DS,AX
XOR DX,DX
MOV AX,0600H 


MOV AH,09H
MOV DX,OFFSET MENS1
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS2
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS4
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS5
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS6
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS7
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS8
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS9
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS10
INT 21H

;LEE

MOV AH,01H
INT 21H

;AJUSTAR EL TECLADO
XOR AH,AH
SUB AL,30H
MOV CX,2

;VERIFICA OPCION
CMP AL,1
JZ AUTOR

CMP AL,2
JZ SUMA

CMP AL,3
JZ RESTA

CMP AL,4
JZ MULT

CMP AL,5
JZ DIVI

CMP AL,6
JZ POSNEG

CMP AL,7
JZ FIN

AUTOR:

MOV AH,09H
MOV DX,OFFSET MENS3
INT 21H
JMP MENU

SUMA:

MOV AH,09H
MOV DX,OFFSET MENS11
INT 21H

;LEE TECLADO
MOV AH,01H
INT 21H

;VERIFICAR SI ES NEGATIVO
CMP AL,2DH
JE SIGNO

;AJUSTAR TECLADO
SUB AL,30H
ADD RESULT,AL
JMP RETURN1


SIGNO:
MOV AH,01H
INT 21H
SUB AL,30H
NEG AL
ADD RESULT,AL
JE RETURN1

RETURN1: LOOP SUMA

IMP1:
CMP RESULT,00
JL IMP2


MOV AH,02H
MOV DL,10
INT 21H
MOV AH,02H
MOV DL,13
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS12
INT 21H
JMP IMPRIME


IMP2:
NEG RESULT


MOV AH,02H
MOV DL,10
INT 21H
MOV AH,02H
MOV DL,13
INT 21H

MOV AH,09H
MOV DX,OFFSET MENS12
INT 21H
MOV AH,02H
MOV DL,'-'
INT 21H
JMP IMPRIME

IMPRIME:

MOV AH,0
MOV AL,RESULT
MOV CL,10
DIV CL

ADD AL,30H
ADD AH,30H; PASA A DECIMAL
MOV BL,AH

MOV DL,AL
MOV AH,02H
INT 21H

MOV DL,BL
MOV AH,02H
INT 21H
MOV CX,2
JMP MENU

RESTA:

MOV AH,09H
MOV DX,OFFSET MENS11
INT 21H

;LEE TECLADO
MOV AH,01H
INT 21H

;VERIFICANDO SI ES NEGATIVO
CMP AL,2DH
JE SIGNOR


SUB AL,30H
CMP CX,2
JE ETIQUETA1
SUB RESULT,AL
JMP RETURN2

ETIQUETA1:
MOV RESULT,AL
JMP RETURN2

SIGNOR:
MOV AH,01H
INT 21H
SUB AL,30H
NEG AL
CMP CX,2
JE ETIQUETA1
SUB RESULT,AL
JE RETURN2

RETURN2:
LOOP RESTA
JMP IMP1

MULT:

MOV AH,09H
MOV DX,OFFSET MENS11
INT 21H

;LEE TECLADO
MOV AH,01H
INT 21H

;VERIFICANDO SI ES NEGATIVO
CMP AL,2DH
JE SIGNOM
SUB AL,30H
CMP CX,2
JE ETIQUETA2
MOV AH,0
MUL RESULT
JMP RETURN3

ETIQUETA2:
MOV RESULT,AL
JMP RETURN3

SIGNOM:
MOV AH,01H
INT 21H
SUB AL,30H
NEG AL
CMP CX,2
JE ETIQUETA2
MOV AH,0
MUL RESULT
JMP RETURN3

RETURN3:
LOOP MULT
MOV RESULT,AL
JMP IMP1

MOV SIGNOX,0

POSNEG:

MOV AH,09H
MOV DX,OFFSET MENS11
INT 21H

;LEE TECLADO
MOV AH,01H
INT 21H

;VERIFICAR SI ES NEGATIVO
CMP AL,2DH
JG POCITIVO
JL NEGATIVO

POCITIVO:
MOV DX,OFFSET MENS15
MOV AH,09H
INT 21H
JMP MENU

NEGATIVO:
MOV DX,OFFSET MENS16
MOV AH,09H
INT 21H
JMP MENU

DIVI:

MOV AH,09H
MOV DX,OFFSET MENS11
INT 21H

;LEE TECLADO
MOV AH,01H
INT 21H

;VERIFICANDO SI ES NEGATIVO
CMP AL,2DH
JE SIGNOD

SUB AL,30H
CMP CX,2
JE ETIQUETA3
CMP AL,0
MOV AH,0
MOV NUMERO,AL
MOV AL,RESULT
DIV NUMERO
JMP RETURN4

ETIQUETA3:
MOV RESULT,AL
JMP RETURN4

SIGNOD:
MOV AH,01
INT 21H
SUB AL,30H
INC SIGNOX
CMP CX,2
JE ETIQUETA3
MOV AH,0
MOV NUMERO,AL
MOV AL,RESULT
DIV NUMERO
JMP RETURN4

RETURN4:LOOP DIVI
MOV QUOTIENT,AL
MOV RESIDUE,AH
MOV RESULT,AL
JMP IMP3

IMP3:

MOV AH,02H
MOV DL,10
INT 21H
MOV AH,02H
MOV DL,13
INT 21H
MOV AH,09H
MOV DX,OFFSET MENS12
INT 21H
JMP IMPRIMEDIVI

IMPRIMEDIVI:
MOV AL,RESULT

MOV CH,30H
ADD AL,CH
ADD AH,CH
MOV BL,AH

MOV AH,9
MOV DX,OFFSET MENS13
INT 21H

CMP SIGNOX,1
JZ CAMBIO
JMP TERMINA

CAMBIO:
MOV DL,"-"
MOV AH,02H
INT 21H
MOV SIGNOX,0

TERMINA:
MOV DX,0
ADD QUOTIENT,30H
MOV DL,QUOTIENT
MOV AH,02H
INT 21H

MOV AH,9
MOV DX,OFFSET MENS14
INT 21H

MOV DX,0
ADD RESIDUE,30H
MOV DL,RESIDUE
MOV AH,02H
INT 21H

JMP MENU
FIN:     RET
MENU ENDP
CODE ENDS 
END MENU
ENDP
