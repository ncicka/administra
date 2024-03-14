**** VERIFICAR SI EL TOTAL DE PAGOS ES IGUAL A LA SUMA DE LOS DETALLES DE PAGOS2

SET DELETE ON

SELECT 0
USE pagos2
SET ORDER TO pagos1

SELECT 0
USE pagos1

MTOT = 0
SCAN
	SELECT pagos2
	SEEK DTOS(pagos1.fecha)+STR(pagos1.tipo,2)+STR(pagos1.numero1,4)+STR(pagos1.numero2,8)
	
	SCAN WHILE pagos1.fecha = pagos2.fecha AND ;
		pagos1.tipo = pagos2.tipo AND ;
		pagos1.numero1 = pagos2.numero1 AND ;
		pagos1.numero2 = pagos2.numero2
	
		MTOT = MTOT + pagos2.importe
		SELECT pagos2
	ENDSCAN
	SELECT PAGOS1
	IF pagos1.total <> mtot
		DELETE
		WAIT WINDOW DTOS(PAGOS1.FECHA)+"-"+STR(PAGOS1.TIPO,2)+"-"+STR(PAGOS1.NUMERO1,4)+STR(PAGOS1.NUMERO2,8)+STR(PAGOS1.TOTAL-MTOT)
	endif
	mtot = 0
ENDSCAN

CLOS DATA
