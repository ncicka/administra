** PROCEDIMIENTO DE DETALLE DE NOTAS DE CREDITO DEBITO

anesc = ON('KEY','ESC')
ON KEY LABEL ESC

IF !USED(tdetalle)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_D")  TO tdetalle

	CREATE CURSOR (tdetalle) (rubro C(3) ,articulo C(4), cantidad N(9,2),;
			descripcio C(37), unitario N(11,6), impuesto N(10,6), ;
			lista N(2), ivari N(10,4), descuento N(10,2), ;
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
	REPLACE cantidad	WITH m.totsel
ENDIF

DO WHILE .T.

	BROWSE WINDOW detalle;
		FIELD rubro      :H='Rubro'    :V=frubro()   :F,;
			  articulo   :H='Artic.'   :W=fen() :V=farticulo() AND fresul(1):F,;
			  cantidad   :H='Cantidad' :V=fcantidad() AND fresul(2) ;
			  		:P="@ 999.99" :F,;
	    	  descripcio :H='Descripción'  :F,;
		      lista      :H='Lista'    :W=fen() :V=flistap() AND fresul(2):P="@99" :F,;
		      unitario   :H='P. Unit.' :W=.F.,;
	    	  Total      :H='Total' 				:P="@ 999,999.99" ;
	    	  		     :W=EMPTY(rubro) AND EMPTY(articulo) :V= fresul(2) :F;
		NODELETE NOMENU NAME vdetalle

*	BROWSE IN WINDOW detalle;
*		FIELD codbarra   :H='Cod.Barra' :V=fcodbarra() AND fresul(1)  :F,;
*			  cantidad   :H='Cantidad'  :W=fen() :V=fcantidad() AND fresul(2) ;
*			  		:P="@ 999999.99" :F,;
*	    	  descripcio :H='Descripción'  :26 :F,;
*		      lista      :H='Lista'     :W=fen() :V=flistap() AND fresul(2):F,;
*		      unitario   :H='P. Unit.'  :W=.F.,;
*	    	  Total      :H='Total' 				:P="@ 999,999.99" ;
*	    	  		     :W=EMPTY(rubro) AND EMPTY(articulo) :V= fresul(2) :F;
*		NODELETE NOMENU

	IF LASTKEY() = 27 OR LASTKEY() = 23
		STORE 0	TO vacio
		COUNT TO vacio FOR EMPTY(cantidad)
		IF vacio > 0
			MESSAGEBOX("La cantidad no puede ser 0",48,"Nota de Débito/Crédito")
		ELSE
			EXIT	
		ENDIF
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


FUNCTION farticulo

IF LASTKEY() = 5 OR LASTKEY() = 24 OR LASTKEY() = -6 OR EMPTY(articulo)
	RETURN .T.
ENDIF

annear = SET('NEAR')
SET NEAR ON

SELECT articulo
SET ORDER TO articulo1

SEEK &tdetalle..rubro+&tdetalle..articulo

IF !FOUND()
	SET ORDER TO articulo3
	SET KEY TO &tdetalle..rubro
	DO browenc WITH "descripcio :H='Artículos'",29,"descripcio"
	SET KEY TO
ENDIF

SELECT (tdetalle)
REPLACE articulo	WITH articulo.articulo
REPLACE descripcio  WITH ALLTRIM(articulo.descripcio) + " " + ALLTRIM(articulo.medida)
REPLACE p_impuesto	WITH articulo.interno
REPLACE t_impuesto	WITH articulo.fijo
REPLACE stock		WITH articulo.stock
IF EMPTY(lista)
	REPLACE lista		WITH m.lista
ENDIF

vdetalle.REFRESH
vdetalle.activatecell(RECNO(),3)

SET NEAR &annear
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


FUNCTION fcantidad

IF !EMPTY(rubro) AND !EMPTY(articulo)
	REPLACE total 	WITH ROUND(cantidad * unitario,2) 
ELSE
	REPLACE unitario	WITH total
ENDIF

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

STORE 0	TO m.total, m.subtotal, m.ivari, m.ivarni, m.ivanoc, m.impuesto, ;
		mneto

IF USED(tdetalle) 


	SELECT (tdetalle)
	anrec = RECNO()

	GO TOP
	SCAN
		m.total      = m.total + &tdetalle..total
		m.ivari      = m.ivari + &tdetalle..ivari
		m.ivarni     = m.ivarni + &tdetalle..ivarni
		m.ivanoc     = m.ivanoc + &tdetalle..ivanoc
		m.impuesto   = m.impuesto + &tdetalle..impuesto
	ENDSCAN


	m.ivari 	= ROUND(m.ivari,2)
	m.ivarni 	= ROUND(m.ivarni,2)
	m.ivanoc 	= ROUND(m.ivanoc,2)
	
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


IF WEXIST("detalle")
	ACTIVATE WINDOW detalle SAME
ENDIF

RETURN .T.


FUNCTION fresul
PARAMETERS pque
IF !EMPTY(rubro) AND !EMPTY(articulo)
	IF pque = 1
		=flistap()
	ENDIF
	=fimpuesto()
	=fcantidad()
ENDIF
IF !EMPTY(total)
	=fcantidad()
	=fiva()
	=ftotales()
ENDIF

IF m.totsel <> 0
	IF m.total < m.totsel
		MESSAGEBOX("El total debe ser igual o mayor "+CHR(13)+ ;
				"al total de las facturas "+CHR(13)+ ;
				"seleccionados "+"$"+ALLTRIM(STR(m.totsel,10,2)),48,"Mensaje")
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.


FUNCTION v_calcular

anselec = SELECT()
SELECT (tdetalle)

GO TOP
SCAN
	IF !EMPTY(rubro) AND !EMPTY(articulo) AND !EMPTY(cantidad)
		=fcantidad()
	ENDIF
	=fiva()
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

IF EMPTY(descripcio)

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
