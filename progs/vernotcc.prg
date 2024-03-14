** PROCEDIMIENTO PARA CARGAR Y SELECCIONAR 
** FACTURAS PARAA APLICAR LA NOTA DE CRÉDITO

m.seleccio 	= 0
m.totsel 	= 0

IF EMPTY(m.nombre)
	WAIT "Colocar el nombre del proveedor" WINDOW NOWAIT
	_CUROBJ=OBJNUM(m.nombre)
	RETURN
ENDIF

IF !USED(tselcomp)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_S")  TO tselcomp

	CREATE CURSOR (tselcomp) (fecha D ,tipo N(2), iva C(3), numero1 N(4),;
		numero2 N(8), nombre C(30), importe N(12,2), porcentaje N(5,2), ;
		descuento N(10,2), selecciono C(1))
	
	INDEX ON DTOS(fecha)+ STR(tipo,2)+STR(numero1,4)+STR(numero2,8) TAG nombre OF (tselcomp) DESCENDING

	DO cargar
	
ENDIF

var = "nombre 		:H='Nombre' :R," + ;
	  "compro = DTOC(fecha)+' '+TRAN(numero1,'@L 9999')+'-'+TRAN(numero2,'@L 99999999') :H='Comprobante' :R," + ;
	  "importe 		:H='Importe' :P='9999999.99' :R," + ;
	  "porcentaje 	:H='%' :W=!EMPTY(selecciono) :P='99.99' :V=fcal_w() :F," + ;
	  "descuento	:H='Desc.' :P='9999999.99' :R," + ;
	  "selecciono 	:H='Sel.' :R"
SELECT (tselcomp)
GO TOP
DO selcompr1 WITH var, 130, "nombre"

SELECT (tselcomp)
GO TOP
COUNT TO m.seleccio FOR selecciono = "S"

DO preparo

ACTIVATE WINDOW ventana SAME
SHOW GET m.condicion
*=_s21117tx7()
*=mosdet()
*DO ftotales IN vdetalle

RETURN


PROCEDURE CARGAR
PRIVATE anord 

** Cuando es nota de credito no importa si el comprobante
** esta o no pagado.

SELECT (m.fichero)
anord = ORDER()
SET NEAR ON
SET ORDER TO IIF(quecon="CONTADO","contapr4","ctactpr4")
SEEK m.proveedor

SET NEAR OFF

SCAN WHILE &fichero..proveedor = m.proveedor

	IF INLIST(&fichero..tipo,4,5)
		LOOP
	ENDIF
	IF !INLIST(&fichero..tipo,1,2,3,13,14,16)
		LOOP
	ENDIF
	IF INLIST(m.iva,"RI ","RNI") 
		IF !INLIST(&fichero..tipo,1,2,13)
			LOOP
		ENDIF
	ELSE
		IF INLIST(&fichero..tipo,1,2,13)
			LOOP
		ENDIF
	ENDIF

	SELECT (tselcomp)
	APPEND BLANK
	REPLACE fecha	WITH &fichero..fecha  ,;
			tipo   	WITH &fichero..tipo   ,;
			numero1 WITH &fichero..numero1,;
			numero2	WITH &fichero..numero2,;
			iva		WITH &fichero..iva    ,;
			nombre	WITH &fichero..nombre ,;
			importe	WITH &fichero..total
	SELECT (m.fichero)
ENDSCAN

SELECT (m.fichero)
SET ORDER TO &anord
RETURN


PROCEDURE preparo

IF m.seleccio = 0
	SELECT (tselcomp)
	USE
	IF USED(tdetalle)
		SELECT (tdetalle)
		USE
	ENDIF
	STORE SPACE(8) TO tselcomp, tdetalle
	RETURN
ELSE
	** Si estan seleccionados algunos comprobantes
	** Coloco los numeros seleccionados en condicion de venta
	m.condicion = ""
	SELECT (tselcomp)
	GO TOP
	SCAN 
		IF selecciono = "S"
			m.condicion = ALLTRIM(m.condicion) + ALLTRIM(STR(numero1)) + '-' + ALLTRIM(STR(numero2)) +"/"
			m.totsel = m.totsel + descuento
		ENDIF
	ENDSCAN	
ENDIF


RETURN

FUNCTION selcompr1
PARAMETERS pcampo, pcol, pvar

		pfin = RECCOUNT()+5
		IF pfin > 30
			STORE 29 TO pfin
		ENDIF 

		DEFINE WINDOW scenc AT 05,20 SIZE pfin,pcol IN SCREEN ;
			TITLE "Seleccionar" ;
			FONT "Ms Sans Serif", 8 ;
			DOUBLE ;
			COLOR SCHEME 10
			
		PUSH KEY CLEAR
		FOR ky=65	TO 90
			ON KEY LABEL CHR(ky) DO buscokey  WITH pvar
		ENDFOR
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
		ON KEY LABEL ESC   KEYBOARD CHR(23)
		ON KEY LABEL SPACEBAR DO marca
		ACTIVATE WINDOW scenc
		BROWSE NODELETE NOAPPEND NOMENU WINDOW scenc ;
			FIELDS &pcampo NOLGRID NORGRID NAME mibrowse
		RELEASE WINDOW scenc
		FOR ky=32	TO 90
			ON KEY LABEL CHR(ky)
		ENDFOR
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
		ON KEY LABEL ESC
		ON KEY LABEL SPACEBAR
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


PROCEDURE marca

IF selecciono = "S"
	REPLACE selecciono WITH " "
ELSE
	REPLACE selecciono WITH "S"
ENDIF

RETURN 

FUNCTION fcal_w
	IF !EMPTY(porcentaje)
		REPLACE descuento	WITH ROUND(importe * porcentaje / 100,2)
	ENDIF
	mibrowse.refresh
RETURN
