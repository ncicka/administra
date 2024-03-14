** PROCEDIMIENTO DE DETALLE DE PAGOS

IF EMPTY(m.proveedor)
	WAIT 'Debe seleccionar el proveedor' WINDOW NOWAIT
	_CUROBJ = OBJNUM(m.proveedor)
	RETURN 
ENDIF

anesc = ON('KEY','ESC')
ON KEY LABEL ESC

IF !USED(tdetalle)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_D")  TO tdetalle

	CREATE CURSOR (tdetalle) (fecha D ,codigo C(5), numero1 N(4),;
			numero2 N(8), importe N(12,2), total N(12,2), pagado N(12,2),;
			tipo N(2), saldo N(10,2), descripcio C(30))

ENDIF

DEFINE WINDOW detalle AT 07.000,00.000 SIZE 7.800,130.000 ;
	IN WINDOW ventana  ;
	TITLE 'Detalle pagos' + ' INS = Agregar  F7 = Borrar ';
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
		FIELD fecha      :H='Fecha'    :P="@E " :V=fctrfech(&tdetalle..fecha,"&tdetalle..fecha"):f :15,;
			  codigo     :H='Tipo'     :P="@M ,Fac A,Fac B,NCr A, NCr B, NDb A, NDb B" ,;
			  numero1    :H='Pto.Vta.' :P="@ 9999"  ,;
	    	  numero2    :H='Número'   :P="@ 99999999" :V=fcomprob() :F,;
	    	  descripcio :H='Detalle' ,;
		      importe    :H='Importe'  :W=fen() :V=fimporte() AND ;
		      			ftotales():F, ;
		      saldo      :H='Saldo'    :W=.f. ;
		NODELETE NOMENU NAME oDetalle
		
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
IF EMPTY(&tdetalle..codigo) AND EMPTY(&tdetalle..descripcio)
	RETURN .F.
ENDIF
RETURN .T.


FUNCTION fcomprob
PRIVATE var
IF LASTKEY() = 5 OR LASTKEY() = 24 OR LASTKEY() = -6
	RETURN .T.
ENDIF
IF EMPTY(numero2)
	RETURN .T.
ENDIF

SELECT ctactpr1
SET ORDER TO ctactpr3
SET KEY TO 'F'+m.proveedor

DO CASE
	CASE &tdetalle..codigo = "Rem "
		STORE 9		TO var
	CASE &tdetalle..codigo = "Fac A"
		STORE 2		TO var
	CASE &tdetalle..codigo = "Fac B"
		STORE 3		TO var
	CASE &tdetalle..codigo = "NCr A"
		STORE 4		TO var
	CASE &tdetalle..codigo = "NCr B"
		STORE 5		TO var
	CASE &tdetalle..codigo = "NDb A"
		STORE 6 	TO var
	OTHERWISE
		STORE 7		TO var		
ENDCASE

LOCATE FOR ctactpr1.fecha   = &tdetalle..fecha   AND ;
	       ctactpr1.tipo    = var                AND ;
	       ctactpr1.numero1 = &tdetalle..numero1 AND ;
	       ctactpr1.numero2 = &tdetalle..numero2
	     

IF !FOUND()
	var = " fecha   :H='Fecha   ' :15, "+ ;
		  " compro  =ftipo() " + ;
		  "+' '+TRAN(numero1,'@L 9999')+'-'+TRAN(numero2,'@L 99999999')" + ;
		  ":H='Tipo Número'"
	DO browenc WITH var,60,""
ENDIF

SET KEY TO 

SELECT (tdetalle)
anrec = RECNO()

LOCATE FOR  fecha   = ctactpr1.fecha AND ;
			tipo    = ctactpr1.tipo AND ;
			numero1 = ctactpr1.numero1 AND ;
			numero2 = ctactpr1.numero2

GO anrec

IF NOT FOUND()
	REPLACE fecha		WITH ctactpr1.fecha
	REPLACE tipo        WITH ctactpr1.tipo
	REPLACE codigo		WITH ftipo()
	REPLACE numero1		WITH ctactpr1.numero1
	REPLACE numero2		WITH ctactpr1.numero2
	REPLACE total		WITH ctactpr1.total
	REPLACE pagado		WITH pagado()
	REPLACE importe		WITH total - pagado
	REPLACE saldo       WITH total - pagado

	=ftotales()
ENDIF

RETURN .T.

FUNCTION ftotales

STORE 0	TO m.total
	
IF USED(tdetalle)


	SELECT (tdetalle)
	anrec = RECNO()

	GO TOP
	SCAN
		m.total      = m.total + &tdetalle..importe
	ENDSCAN

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

IF WEXIST("detalle")
	ACTIVATE WINDOW detalle SAME
ENDIF

RETURN .T.

FUNCTION borrar
PRIVATE anreg

SELECT (tdetalle)
DELETE
oDetalle.Refresh

anreg = RECNO()

GO TOP
COUNT TO creg FOR !DELETED()
IF creg = 0
	APPEND BLANK
	oDetalle.Refresh
ELSE
	IF anreg <= RECCOUNT()
		GO anreg
	ENDIF
ENDIF

ACTIVATE WINDOW detalle SAME
=ftotales()
RETURN .T.

FUNCTION agregar
PRIVATE anreg

SELECT (tdetalle)
anreg = RECNO()
GO BOTTOM

IF EMPTY(importe) OR EMPTY(fecha) OR EMPTY(codigo) OR ;
	EMPTY(numero2)

	IF anreg <= RECCOUNT()
		GO anreg
		ACTIVATE WINDOW detalle SAME
		RETURN
	ENDIF
ENDIF

APPEND BLANK
ACTIVATE WINDOW detalle SAME
RETURN


FUNCTION pagado
PRIVATE mpagado
STORE 0	TO mpagado

SELECT pagospr2
SET ORDER TO pagospr2

SEEK DTOS(ctactpr1.fecha)+STR(ctactpr1.tipo,2)+STR(ctactpr1.numero1,4)+ ;
	STR(ctactpr1.numero2,8)

SCAN WHILE  ctactpr1.fecha   = pagospr2.cfecha AND ;
			ctactpr1.tipo    = pagospr2.ctipo  AND ;
			ctactpr1.numero1 = pagospr2.cnumero1 AND ;
			ctactpr1.numero2 = pagospr2.cnumero2
			
	STORE mpagado + pagospr2.importe 	TO mpagado
ENDSCAN

** busco si tiene alguna nota de credito aplicada el comprobante
IF USED ("aplicadc")
	SELECT aplicadc
	SET ORDER TO aplicadc2

	SEEK DTOS(ctactpr1.fecha)+STR(ctactpr1.tipo,2)+STR(ctactpr1.numero1,4)+ ;
		STR(ctactpr1.numero2,8)

	SCAN WHILE  &tdetalle..fecha   = aplicadc.cfecha AND ;
				&tdetalle..tipo    = aplicadc.ctipo  AND ;
				&tdetalle..numero1 = aplicadc.cnumero1 AND ;
				&tdetalle..numero2 = aplicadc.cnumero2
			
		IF aplicadc.tipo = 4 OR aplicadc.tipo = 5
			mpagado =  mpagado + aplicadc.importe
		ENDIF
	ENDSCAN
ENDIF

SELECT (tdetalle)

RETURN mpagado

FUNCTION fimporte

IF !EMPTY(numero2)
	IF &tdetalle..importe > (&tdetalle..total - &tdetalle..pagado)
		RETURN .F.
	ENDIF
ENDIF

RETURN .T.

FUNCTION ftipo
PRIVATE var
DO CASE
	CASE tipo = 1
		STORE "N Ent" 	TO var
	CASE tipo = 2
		STORE "Fac A" 	TO var
	CASE tipo = 3
		STORE "Fac B"	TO var
	CASE tipo = 4
		STORE "NCr A" 	TO var
	CASE tipo = 5
		STORE "NCr B"	TO var
	CASE tipo = 6
		STORE "NDb A"	TO var
	OTHERWISE
		STORE "NDb B"	TO var
ENDCASE

RETURN var