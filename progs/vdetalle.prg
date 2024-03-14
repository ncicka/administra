** PROCEDIMIENTO DE DETALLE DE COMPROBANTES
PARAMETERS pcompra

anesc = ON('KEY','ESC')
ON KEY LABEL ESC

IF !USED(tdetalle)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_D")  TO tdetalle

	CREATE CURSOR (tdetalle) (rubro C(3) ,articulo C(4), cantidad N(6,2),;
			descripcio C(37), unitario N(11,6), impuesto N(10,6), ;
			lista N(2), por_desc N(5,2), descuento N(10,2), ivari N(10,4), ;
			ivarni N(10,4), ivanoc N(10,4), total N(12,4), p_impuesto N(5,3),;
			t_impuesto C(1), stock L, codbarra C(15))

ENDIF

DEFINE WINDOW detalle AT 07.000,00.000 SIZE 9.800,125.000 ;
	IN WINDOW ventana  ;
	TITLE 'Detalle del Comprobante' + ' INS = Agregar  F7 = Borrar ';
	FONT "Ms Sans Serif", 9 ;
	NOCLOSE NOMINIMIZE NOFLOAT;
	DOUBLE ;
	COLOR SCHEME 1

ACTIVATE WINDOW detalle
ON KEY LABEL Ctrl+G  APPEND BLANK
ON KEY LABEL F9      KEYBOARD CHR(23)
ON KEY LABEL F7		 DO borrar
ON KEY LABEL INS	 DO agregar


SELECT (tdetalle)

IF RECCOUNT() = 0
	APPEND BLANK
ENDIF
DO WHILE .T.

	BROWSE WINDOW detalle;
		FIELD rubro      :H='Rubro'    :V=frubro()   :F,;
			  articulo   :H='Artic.'   :W=fen() :V=farticulo() AND fresul(1):F,;
			  cantidad   :H='Cantidad' :V=fcantidad() AND fresul(2) AND fstock();
			  		:P="@ 999.99" :F,;
	    	  descripcio :H='Descripción'   :F,;
		      lista      :H='Lista'    :W=fen() :V=flistap() AND fresul(2):P="@ 99" :F,;
		      unitario   :H='P. Unit.' :W=.F.,;
		      por_desc   :H='%Desc.'   :W=fen() :V=fdesc() AND fresul(2) :P="@ 99.99" :F,;
	    	  Total      :H='Total' 				:P="@ 999,999.99" ;
	    	  		:W=.F.;
		NODELETE NOMENU NAME vdetalle
*			  articulo   :H='Artic.'   :W=fen() :V=farticulo() AND fresul(1):F,;

*		      por_desc   :H='%Desc.'   :W=fen() :V=fdesc() 	AND fresul(2) :P="@ 99.99":F,;

*	BROWSE IN WINDOW detalle;
*		FIELD codbarra   :H='Cod.Barra' :V=fcodbarra() AND fresul(1)   :F,;
*			  cantidad   :H='Cantidad'  :W=fen() :V=fcantidad() AND fresul(2) ;
*			  		:P="@ 999999.99" :F,;
*	    	  descripcio :H='Descripción'  :26 :F,;
*		      lista      :H='Lista'     :W=fen() :V=flistap() AND fresul(2):F,;
*		      unitario   :H='P. Unit.'  :W=.F.,;
*		      por_desc   :H='%Desc.'    :W=fen() :V=fdesc() 	AND fresul(2) :P="@ 99.99":F,;
*	    	  Total      :H='Total' 				:P="@ 999,999.99" ;
*	    	  		:W=.F.;
*		NODELETE NOMENU

	IF LASTKEY() = 27 OR LASTKEY() = 23
		EXIT	
	ENDIF

ENDDO

RELEASE WINDOW detalle
ON KEY LABEL Ctrl+G 
ON KEY LABEL F9
ON KEY LABEL F7
ON KEY LABEL INS

=mosdet()

ON KEY LABEL ESC &anesc

RETURN


FUNCTION fen
IF EMPTY(&tdetalle..rubro)
	RETURN .F.
ENDIF
RETURN .T.


FUNCTION flistap

IF LASTKEY() = -6
	RETURN .T.
ENDIF

SELECT articulo
SET ORDER TO articulo1
SEEK &tdetalle..rubro+&tdetalle..articulo

SELECT lista
GO TOP
COUNT TO creg FOR !DELETED()

IF creg > 0 AND &tdetalle..lista # 1
	SEEK STR(&tdetalle..lista,2)
	
	IF !FOUND()
		DO browenc WITH "descripcio :H='Listas'",29,"descripcio"
	ENDIF
		
	SELECT (tdetalle)	
	REPLACE lista 	WITH lista.numero
ELSE
	SELECT (tdetalle)
	REPLACE lista	WITH 1
ENDIF

IF lista = 1
	IF UPPER(quecon) = "CONTADO"
		REPLACE unitario	WITH articulo.unitario
	ELSE
		REPLACE unitario	WITH articulo.unitario2
	ENDIF
ELSE
	IF SEEK(STR(lista,2),'lista')
		IF UPPER(quecon) = "CONTADO"
			REPLACE unitario WITH ROUND(articulo.unitario + (articulo.unitario * lista.contado / 100),2)
		ELSE
			REPLACE unitario	WITH ROUND(articulo.unitario2 + (articulo.unitario2 * lista.ctacte / 100),2)
		ENDIF
	ENDIF
ENDIF

RETURN 

FUNCTION fstock

IF articulo.stock
	IF articulo.actual <= articulo.minimo - cantidad
		DO MENSAJE WITH "El STOCK ES INFERIOR A " + TRAN(articulo.minimo,'@$ 999,999.99')+ ;
			CHR(13)+"Stock Actual: " +TRAN(articulo.actual,'@$ 999,999.99') 
	ENDIF
ENDIF

RETURN

FUNCTION fcantidad

REPLACE total	WITH ROUND(cantidad * unitario,2)

RETURN .T.

FUNCTION fimpuesto
PRIVATE mneto, mtotal
STORE 0	TO mneto, mtotal

IF t_impuesto = "%"
	mneto = unitario / (1 + (fijo.ivari + p_impuesto ) / 100)
	REPLACE impuesto	WITH ROUND(mneto * p_impuesto / 100 * cantidad,2)
ELSE
	REPLACE impuesto 	WITH ROUND(cantidad * p_impuesto,2)
ENDIF

RETURN .T.


FUNCTION ftotales
PRIVATE mneto

IF m.seleccio = 0
	STORE 0	TO m.total, m.subtotal, m.ivari, m.ivarni, m.ivanoc, m.impuesto, ;
		m.descuento, m.descuento1, mneto
ENDIF
	
IF USED(tdetalle) AND m.seleccio = 0


	SELECT (tdetalle)
	anrec = RECNO()

	GO TOP
	SCAN
		m.total      = m.total + &tdetalle..total
		m.ivari      = m.ivari + &tdetalle..ivari
		m.ivarni     = m.ivarni + &tdetalle..ivarni
		m.ivanoc     = m.ivanoc + &tdetalle..ivanoc
		m.impuesto   = m.impuesto + &tdetalle..impuesto
		m.descuento1 = m.descuento1 + &tdetalle..descuento
	ENDSCAN

	m.ivari 	= ROUND(m.ivari,2)
	m.ivarni 	= ROUND(m.ivarni,2)
	m.ivanoc 	= ROUND(m.ivanoc,2)
	
	IF !EMPTY(m.por_desc)

		*** Calcular el descuento general	
	
		m.descuento = ROUND((m.total - m.descuento1 - m.impuesto)* m.por_desc / 100,2)
		mneto		= ROUND((m.total - m.impuesto - m.descuento1 - m.descuento) / (1 + (fijo.ivari / 100)),2)
		m.ivari	 	= ROUND(mneto * fijo.ivari / 100,2)
	
		IF m.iva = "RNI"
			m.ivanoc = 0
			m.ivarni = ROUND(mneto * fijo.ivarni / 100,2)
		ENDIF
	
		IF m.iva = "NOC"
			m.ivarni = 0
			m.ivanoc = ROUND(mneto * fijo.ivanoc / 100,2)
		ENDIF
	ENDIF

	m.total = m.total - m.descuento - m.descuento1 
	m.subtotal  = m.total - m.ivari - m.impuesto - m.ivarni - m.ivanoc 

	SELECT (tdetalle)
	IF anrec <= RECCOUNT()
		GO anrec
	ENDIF
	
ENDIF
ACTIVATE WINDOW ventana SAME

@ 4.938,60.857 SAY m.total ;
	SIZE 1.000,14.615 ;
	FONT "MS Sans Serif", 18 ;
	STYLE "B" ;
	PICTURE "9,999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,0.714 SAY m.subtotal ;
	SIZE 1.000,13.143 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,14.714 SAY m.ivari ;
	SIZE 1.000,11.429 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,27.000 SAY m.ivarni ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,39.429 SAY m.ivanoc ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,51.857 SAY m.impuesto ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,64.286 SAY m.descuento ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,76.714 SAY m.descuento1 ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)


IF WEXIST("detalle")
	ACTIVATE WINDOW detalle SAME
ENDIF

= fversaldo()  && Mostrar mensaje si el total supera al credito máximo

RETURN .T.


FUNCTION fresul
PARAMETERS pque
IF !EMPTY(rubro) AND !EMPTY(articulo)
	IF pque = 1
		=flistap()
	ENDIF                              
	=fimpuesto()
	=fdesc()
	=fiva()
	=fcantidad()
	=ftotales()
ENDIF

RETURN .T.


FUNCTION v_calcular

anselec = SELECT()
SELECT (tdetalle)

GO TOP
SCAN
	=fdesc()
	=fiva()
	=fcantidad()
ENDSCAN

=ftotales()

SELECT (anselec)

RETURN .T.

FUNCTION borrar
PRIVATE anreg
ACTIVATE WINDOW detalle NOSHOW

SELECT (tdetalle)
DELETE
SKIP
IF EOF()
	GO BOTTOM
ENDIF
anreg = RECNO()

GO TOP
COUNT TO creg FOR !DELETED()
IF creg = 0
	APPEND BLANK
ELSE
	IF anreg <= RECCOUNT()
		GO anreg
	ENDIF
ENDIF

SHOW WINDOW detalle SAME 
=fresul(2)
RETURN .T.

FUNCTION agregar
PRIVATE anreg

SELECT (tdetalle)
anreg = RECNO()
GO BOTTOM

IF EMPTY(total) OR EMPTY(cantidad) OR EMPTY(articulo) OR ;
	EMPTY(rubro)

	IF anreg <= RECCOUNT()
		GO anreg
		ACTIVATE WINDOW detalle SAME
		RETURN
	ENDIF
ENDIF

APPEN BLANK
REPLACE lista	WITH m.lista
vdetalle.REFRESH
vdetalle.activatecell(RECNO(),1)
ACTIVATE WINDOW detalle SAME
RETURN


FUNCTION fcodbarra

IF LASTKEY() = 5 OR LASTKEY() = 24 OR LASTKEY() = -6 OR EMPTY(codbarra)
	RETURN .T.
ENDIF

annear = SET('NEAR')
SET NEAR ON

SELECT articulo
SET ORDER TO articulo4

SEEK &tdetalle..codbarra

IF !FOUND()
	SET ORDER TO articulo3
	DO browenc WITH "descripcio :H='Artículos'",29,"descripcio"
ENDIF

SELECT (tdetalle)
REPLACE articulo	WITH articulo.articulo
REPLACE descripcio  WITH ALLTRIM(articulo.descripcio) + " " + ALLTRIM(articulo.medida)
REPLACE p_impuesto	WITH articulo.interno
REPLACE t_impuesto	WITH articulo.fijo
REPLACE stock		WITH articulo.stock
REPLACE codbarra	WITH articulo.codbarra
REPLACE rubro		WITH articulo.rubro
IF EMPTY(lista)
	REPLACE lista		WITH m.lista
ENDIF

SET NEAR &annear
RETURN .T.
