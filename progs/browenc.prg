** Mostrar un browse y permitir buscar y seleccionar
** pcampo = es una variable que contiene los campos del browse que se
** muestran
** pcol = numero de columna derecha del browse
** pvar = es el campo para buscar con buscokey

PARAMETERS pcampo, pcol, pvar

		pfin = RECCOUNT()+3
		IF pfin > 20
			STORE 19 TO pfin
		ENDIF 

		DEFINE WINDOW scenc AT 05,44 SIZE pfin,pcol IN SCREEN ;
			TITLE "Seleccionar" ;
			FONT "Ms Sans Serif", 8 ;
			DOUBLE ;
			COLOR SCHEME 10
			
		PUSH KEY CLEAR
		IF !EMPTY(pvar)
			FOR ky=65	TO 90
				ON KEY LABEL CHR(ky) DO buscokey  WITH pvar
			ENDFOR
		ENDIF
		ON KEY LABEL F1  DO nada
		ON KEY LABEL F2  DO nada
		ON KEY LABEL F3  DO nada
		ON KEY LABEL F4  DO nada
		ON KEY LABEL F5  DO nada
		ON KEY LABEL F6  DO nada
		ON KEY LABEL F7  DO nada
		ON KEY LABEL F8  DO nada
		ON KEY LABEL F9  DO nada
		ON KEY LABEL F10 DO nada
		ON KEY LABEL ENTER KEYBOARD CHR(23)
		ON KEY LABEL ESC   KEYBOARD CHR(23)
		ACTIVATE WINDOW scenc
		BROWSE NOEDIT NODELETE NOAPPEND NOMENU WINDOW scenc ;
			FIELDS &pcampo NOLGRID NORGRID
		RELEASE WINDOW scenc
		IF !EMPTY(pvar)
			FOR ky=32	TO 90
				ON KEY LABEL CHR(ky)
			ENDFOR
		ENDIF
		ON KEY LABEL F1
		ON KEY LABEL F2
		ON KEY LABEL F3
		ON KEY LABEL F4
		ON KEY LABEL F5
		ON KEY LABEL F6
		ON KEY LABEL F7
		ON KEY LABEL F8
		ON KEY LABEL F9
		ON KEY LABEL F10
		ON KEY LABEL ENTER
		ON KEY LABEL ESC
		POP KEY
RETURN

PROCEDURE buscokey
PARAMETERS pvar
PUSH KEY CLEAR
*regant=RECNO()
DEFINE WINDOW fbuscoky AT 00,00 SIZE 02,42 ;
	TITLE " Buscar " ;
	FONT "Ms Sans Serif", 8 ;
	DOUBLE ;
	COLOR RGB(,,,192,192,192)
	
MOVE WINDOW fbuscoky CENTER
ACTIVATE WINDOW fbuscoky
m.buscoky=SPACE(30)
KEYBOARD CHR(LASTKEY())
@ 0.420,1.350 TO 1.720,40.890 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.420,1.350 TO 0.420,40.890 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.420,1.350 TO 1.720, 1.350 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)

@ 0.500,2.000 GET m.buscoky ;
	SIZE 1.000,38.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	COLOR ,RGB(0,0,0,255,255,255)
READ
POP KEY
RELEASE WINDOW fbuscoky
anexac=SET('EXACT')
SET EXACT OFF
IF LASTKEY()<>27
	LOCATE FOR &pvar. = TRIM(UPPER(m.buscoky))
ENDIF
SET EXACT &anexac
RETURN

PROCEDURE nada
RETURN

