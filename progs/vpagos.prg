** PROCEDIMIENTO DE DETALLE DE PAGOS
** CUANDO EL COMPROBANTE ES REC X (18)(IMPRESORA FISCAL)
** CONTROLAR QUE NO SUPERE LOS NUEVE(9) RENGLONES

IF EMPTY(m.cliente)
	WAIT 'Debe seleccionar el cliente' WINDOW NOWAIT
	_CUROBJ = OBJNUM(m.cliente)
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
		FIELD fecha      :H='Fecha'     :P="@E " :V=fctrfech(&tdetalle..fecha,"&tdetalle..fecha"):f :15,;
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

SELECT ctacte1
SET ORDER TO ctacte3
SET KEY TO 'F'+m.cliente

DO CASE
	CASE &tdetalle..codigo = "N Ent"
		STORE 1		TO var
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

LOCATE FOR ctacte1.fecha   = &tdetalle..fecha   AND ;
	       ctacte1.tipo    = var                AND ;
	       ctacte1.numero1 = &tdetalle..numero1 AND ;
	       ctacte1.numero2 = &tdetalle..numero2
	     

IF !FOUND()
	reng = 0
	GO TOP
	SCAN WHILE reng = 0
		reng = reng + 1
	ENDSCAN
	
	IF reng # 0
		var = " fecha   :H='Fecha' , "+ ;
			  " compro  =ftipo() " + ;
			  "+' '+TRAN(numero1,'@L 9999')+'-'+TRAN(numero2,'@L 99999999')" + ;
			  ":H='Tipo Número'"
		DO browenc WITH var,60,""
	ELSE
		WAIT WINDOW "NO HAY REGISTROS PARA SELECCIONAR"
		SET KEY TO
		SELECT (tdetalle)
		RETURN .T.
	ENDIF
ENDIF

SET KEY TO 


SELECT (tdetalle)
anrec = RECNO()

LOCATE FOR  fecha   = ctacte1.fecha AND ;
			tipo    = ctacte1.tipo AND ;
			numero1 = ctacte1.numero1 AND ;
			numero2 = ctacte1.numero2

GO anrec

IF !FOUND()
	REPLACE fecha		WITH ctacte1.fecha
	REPLACE tipo        WITH ctacte1.tipo
	REPLACE codigo		WITH ftipo()
	REPLACE numero1		WITH ctacte1.numero1
	REPLACE numero2		WITH ctacte1.numero2
	REPLACE total		WITH ctacte1.total
	REPLACE pagado		WITH fpagado()
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
PRIVATE anreg, cantreg
cantreg = 0

SELECT (tdetalle)
anreg = RECNO()
COUNT TO cantreg

GO BOTTOM

IF EMPTY(importe) AND EMPTY(descripcio) AND ;
	EMPTY(numero2)

	IF anreg <= RECCOUNT()
		GO anreg
		ACTIVATE WINDOW detalle SAME
		RETURN
	ENDIF
ENDIF

IF m.tipo = 18 AND cantreg > 9
	MESSAGEBOX("La cantidad de renglones no puede ser mayor a 9",48,"Recibos")
ELSE
	APPEND BLANK
ENDIF
ACTIVATE WINDOW detalle SAME
RETURN


FUNCTION fpagado
PRIVATE mpagado
STORE 0	TO mpagado

SELECT pagos2
SET ORDER TO pagos2

SEEK DTOS(ctacte1.fecha)+STR(ctacte1.tipo,2)+STR(ctacte1.numero1,4)+ ;
	STR(ctacte1.numero2,8)

SCAN WHILE  &tdetalle..fecha   = pagos2.cfecha AND ;
			&tdetalle..tipo    = pagos2.ctipo  AND ;
			&tdetalle..numero1 = pagos2.cnumero1 AND ;
			&tdetalle..numero2 = pagos2.cnumero2
			
	STORE mpagado + pagos2.importe 	TO mpagado
ENDSCAN

** busco si tiene alguna nota de credito aplicada el comprobante
IF USED ("aplicado")
	SELECT aplicado
	SET ORDER TO aplicado2

	SEEK DTOS(ctacte1.fecha)+STR(ctacte1.tipo,2)+STR(ctacte1.numero1,4)+ ;
		STR(ctacte1.numero2,8)

	SCAN WHILE  &tdetalle..fecha   = aplicado.cfecha AND ;
				&tdetalle..tipo    = aplicado.ctipo  AND ;
				&tdetalle..numero1 = aplicado.cnumero1 AND ;
				&tdetalle..numero2 = aplicado.cnumero2
			
		IF aplicado.tipo = 4 OR aplicado.tipo = 5
			mpagado =  mpagado + aplicado.importe
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