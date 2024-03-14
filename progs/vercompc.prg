** PROCEDIMIENTO PARA CARGAR Y SELECCIONAR REMITOS
** QUE TIENEN FACTURAS DE COMPRAS

STORE 0 TO m.seleccio

IF EMPTY(m.nombre)
	WAIT "Colocar el nombre del proveedor" WINDOW NOWAIT
	_CUROBJ=OBJNUM(m.nombre)
	RETURN
ENDIF

IF !USED(tselcomp)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_S")  TO tselcomp

	CREATE CURSOR (tselcomp) (fecha D ,tipo N(2), iva C(3), numero1 N(4),;
		numero2 N(8), nombre C(30), importe N(12,2), selecciono C(1))
	
	INDEX ON nombre + STR(tipo,2)+STR(numero1,4)+STR(numero2,8) TAG nombre OF (tselcomp)
	DO cargar
	
ENDIF

var = "nombre :H='Nombre'," + ;
	  "compro = DTOC(fecha)+' '+TRAN(numero1,'@L 9999')+'-'+TRAN(numero2,'@L 99999999') :H='Comprobante'," + ;
	  "importe :H='Importe' :P='9999999.99'," + ;
	  "selecciono :H='Sel.'"
SELECT (tselcomp)
GO TOP
DO selcompr WITH var, 88, "nombre"

SELECT (tselcomp)
GO TOP
COUNT TO m.seleccio FOR selecciono = "S"

DO preparo

SHOW GETS
=_s21117tx7()
=mosdet()
DO ftotales IN vdetallc

RETURN


PROCEDURE CARGAR
PRIVATE anord 

SELECT (m.fichero)
anord = ORDER()
SET ORDER TO IIF(quecon="CONTADO","contapr2","ctactpr2")
SEEK 'F'

SCAN WHILE !facturado

	IF !EMPTY(m.proveedor)
		IF &fichero..proveedor # m.proveedor
			LOOP
		ENDIF
	ELSE
		IF !UPPER(m.nombre) $ UPPER(nombre)
			LOOP
		ENDIF
	ENDIF
	
	IF INLIST(m.tipo,2,4,6)
		IF !INLIST(iva,"RI ","RNI")
			LOOP
		ENDIF
	ELSE
		IF INLIST(m.tipo,3,5,7)
			IF INLIST(iva,"RI ","RNI")
				LOOP
			ENDIF
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
ENDIF

** Si estan seleccionados algunos comprobantes
** Cargo el detalle con los comprobantes seleccionados

IF !USED(tdetalle)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_D")  TO tdetalle

	CREATE CURSOR (tdetalle) (rubro C(3) ,articulo C(4), cantidad N(9,2),;
			descripcio C(30), unitario N(11,6), impuesto N(10,6), ;
			lista N(2), por_desc N(5,2), descuento N(10,2), ivari N(10,2), ;
			ivarni N(10,2), ivanoc N(10,2), total N(10,2), p_impuesto N(5,2),;
			t_impuesto C(1), stock L)

ENDIF

SELECT (tselcomp)
GO TOP
SCAN
		
	IF selecciono = "S"

		SELECT (mfichero2)

		SEEK DTOS(&tselcomp..fecha)+STR(&tselcomp..tipo,2)+ ;
			STR(&tselcomp..numero1,4)+STR(&tselcomp..numero2,8)

		SCAN WHILE fecha   = &tselcomp..fecha AND ;
			       tipo    = &tselcomp..tipo  AND ;
			       numero1 = &tselcomp..numero1 AND ;
			       numero2 = &tselcomp..numero2
				
				SELECT (tdetalle)
				APPEND BLANK
				REPLACE rubro	  WITH &mfichero2..rubro
				REPLACE articulo  WITH &mfichero2..articulo
				REPLACE cantidad  WITH &mfichero2..cantidad
				REPLACE unitario  WITH &mfichero2..unitario
				REPLACE impuesto  WITH &mfichero2..impuesto
				REPLACE lista     WITH &mfichero2..lista
				REPLACE por_desc  WITH &mfichero2..por_desc
				REPLACE descuento WITH &mfichero2..descuento
				REPLACE ivari     WITH &mfichero2..ivari
				REPLACE ivarni    WITH &mfichero2..ivarni
				REPLACE total     WITH &mfichero2..total
				
				SELECT (mfichero2)
		ENDSCAN
		
		SELECT (m.fichero)
		SEEK DTOS(&tselcomp..fecha)+STR(&tselcomp..tipo,2)+ ;
			STR(&tselcomp..numero1,4)+STR(&tselcomp..numero2,8)

		IF FOUND()

			IF EMPTY(m.proveedor)
				DO showvar
			ENDIF

			STORE m.subtotal + subtotal 	TO m.subtotal
			STORE m.ivari + ivari			TO m.ivari
			STORE m.ivarni + ivarni			TO m.ivarni
			STORE m.ivanoc + ivanoc			TO m.ivanoc
			STORE m.impuesto + impuesto  	TO m.impuesto
			STORE m.descuento + descuento	TO m.descuento
			STORE m.descuento1 + descuento1	TO m.descuento1
			STORE m.total + total			TO m.total
		ENDIF

	ENDIF
	SELECT (tselcomp)
ENDSCAN

IF m.descuento > 0
	m.por_desc = ROUND((m.descuento * 100) / m.subtotal,2)
ENDIF


RETURN

PROCEDURE showvar

STORE &fichero..proveedor		TO m.proveedor
STORE &fichero..nombre		TO m.nombre
STORE &fichero..direccion	TO m.direccion
STORE &fichero..localidad	TO m.localidad
STORE &fichero..iva 		TO m.iva
STORE &fichero..cuit		TO m.cuit
STORE &fichero..telefono 	TO m.telefono
STORE &fichero..condicion	TO m.condicion

RETURN