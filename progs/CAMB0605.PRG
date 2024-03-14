***** ARREGLAR LOS PAGOS A LOS COMPROBANTES

SET DELETE ON

***************************** de los proveedores *****************************************************

IF USED("VARIOS")
	SELECT varios
	USE
ENDIF

SELECT 0
CREATE CURSOR varios (cfecha d, ctipo n(2), cnumero1 n(4), cnumero2 n(8), proveedor c(4), nombre c(50),;
					fecha d, tipo n(2), numero1 n(4), numero2 n(8))


SELECT 0
USE contapr1
SET ORDER TO contapr1

SELECT 0
USE pagos2
SET ORDER TO pagos1
go top

SCAN
	IF INLIST(pagos2.ctipo,4,5,6,7)
		SELECT contapr1
		SEEK DTOS(pagos2.cfecha)+STR(pagos2.ctipo,2)+STR(pagos2.cnumero1,4)+STR(pagos2.Cnumero2,8)
		IF FOUND()
			SELECT varios
			APPEND BLANK
			REPLACE cfecha		WITH pagos2.cfecha,;
					ctipo		WITH pagos2.ctipo,;
					cnumero1	WITH pagos2.cnumero1,;
					cnumero2	WITH pagos2.cnumero2,;
					proveedor	WITH contapr1.proveedor,;
					nombre		WITH contapr1.nombre
			REPLACE fecha		WITH pagos2.fecha,;
					tipo		WITH pagos2.tipo,;
					numero1		WITH pagos2.numero1,;
					numero2		WITH pagos2.numero2

		ENDIF
		
	ENDIF
	SELECT pagos2
ENDSCAN

*** PASAR COMPROBANTES DE PAGOS1 Y PAGOS2 A PAGOSPR1 Y PAGOSPR2

SELECT 0
USE pagos1
SET ORDER TO pagos1

SELECT 0
USE pagospr2
SET ORDER TO pagospr1

SELECT 0
USE pagospr1
SET ORDER TO pagospr1


SET DELETE OFF
SELECT VARIOS
GO TOP
SCAN
	SELECT pagos1
	SEEK DTOS(varios.fecha)+STR(varios.tipo,2)+STR(varios.numero1,4)+STR(varios.numero2,8)
	IF FOUND()

		SELECT pagos2
		SEEK DTOS(varios.fecha)+STR(varios.tipo,2)+STR(varios.numero1,4)+STR(varios.numero2,8)
		SCAN WHILE fecha = varios.fecha AND tipo = varios.tipo AND numero1 = varios.numero1 AND;
			numero2 = varios.numero2
			SCATTER MEMVAR MEMO
			SELECT pagospr2
			INSERT INTO (ALIAS()) FROM MEMVAR
			SELECT pagos2
			DELETE
		ENDSCAN
		SELECT pagos1
		SCATTER MEMVAR MEMO
		SELECT pagospr1
		INSERT INTO (ALIAS()) FROM MEMVAR
		SELECT pagos1
		DELETE
	ENDIF	
	SELECT VARIOS
ENDSCAN

************************************ de los clientes ************************************************
IF USED("VARIOS1")
	SELECT varios1
	USE
ENDIF

SELECT 0
CREATE CURSOR varios1 (cfecha d, ctipo n(2), cnumero1 n(4), cnumero2 n(8), cliente c(4), nombre c(50),;
					fecha d, tipo n(2), numero1 n(4), numero2 n(8))

SELECT 0
USE contado1
SET ORDER TO contado1

SELECT pagospr2
go top

SCAN
	IF INLIST(pagospr2.ctipo,4,5,6,7)
		SELECT contado1
		SEEK DTOS(pagospr2.cfecha)+STR(pagospr2.ctipo,2)+STR(pagospr2.cnumero1,4)+STR(pagospr2.Cnumero2,8)
		IF FOUND()
			SELECT varios1
			APPEND BLANK
			REPLACE cfecha		WITH pagospr2.cfecha,;
					ctipo		WITH pagospr2.ctipo,;
					cnumero1	WITH pagospr2.cnumero1,;
					cnumero2	WITH pagospr2.cnumero2,;
					cliente		WITH contado1.cliente,;
					nombre		WITH contado1.nombre
			REPLACE fecha		WITH pagospr2.fecha,;
					tipo		WITH pagospr2.tipo,;
					numero1		WITH pagospr2.numero1,;
					numero2		WITH pagospr2.numero2

		ENDIF
		
	ENDIF
	SELECT pagos2
ENDSCAN

SET DELETE OFF
SELECT varios1
GO TOP
SCAN
	SELECT pagospr1
	SEEK DTOS(varios1.fecha)+STR(varios1.tipo,2)+STR(varios1.numero1,4)+STR(varios1.numero2,8)
	IF FOUND()

		SELECT pagospr2
		SEEK DTOS(varios1.fecha)+STR(varios1.tipo,2)+STR(varios1.numero1,4)+STR(varios1.numero2,8)
		SCAN WHILE fecha = varios1.fecha AND tipo = varios1.tipo AND numero1 = varios1.numero1 AND;
			numero2 = varios1.numero2
			SCATTER MEMVAR MEMO
			SELECT pagos2
			INSERT INTO (ALIAS()) FROM MEMVAR
			SELECT pagospr2
			DELETE
		ENDSCAN
		SELECT pagospr1
		SCATTER MEMVAR MEMO
		SELECT pagos1
		INSERT INTO (ALIAS()) FROM MEMVAR
		SELECT pagospr1
		DELETE
	ENDIF	
	SELECT varios1
ENDSCAN


SELECT varios
USE

SELECT varios1
USE

*************************************************************************************************
** RECUPERAR LOS COBROS Y PAGOS BORRADOS CUANDO EL NOMBRE DE LA CUENTA NO ESTE VACIO

SET DELETE OFF

SELECT pagos1
GO TOP
SCAN
	IF DELETED() AND !EMPTY(pagos1.nombre)
		SELECT pagos2
		SEEK DTOS(pagos1.fecha)+STR(pagos1.tipo,2)+STR(pagos1.numero1,4)+STR(pagos1.numero2,8)
		RECALL WHILE pagos2.fecha = pagos1.fecha AND pagos2.tipo = pagos1.tipo AND ;
					pagos2.numero1 = pagos1.numero1 AND pagos2.numero2 = pagos1.numero2
		SELECT pagos1
		RECALL
	ENDIF
ENDSCAN

SELECT pagospr1
GO TOP
SCAN
	IF DELETED() AND !EMPTY(pagospr1.nombre)
		SELECT pagospr2
		SEEK DTOS(pagospr1.fecha)+STR(pagospr1.tipo,2)+STR(pagospr1.numero1,4)+STR(pagospr1.numero2,8)
		RECALL WHILE pagospr2.fecha = pagospr1.fecha AND pagospr2.tipo = pagospr1.tipo AND ;
					pagospr2.numero1 = pagospr1.numero1 AND pagospr2.numero2 = pagospr1.numero2
		SELECT pagospr1
		RECALL
	ENDIF
ENDSCAN

*************************************************************************************************
SELECT pagos1
USE

SELECT pagos2
USE

SELECT pagospr1
USE

SELECT pagospr2
USE

RETURN