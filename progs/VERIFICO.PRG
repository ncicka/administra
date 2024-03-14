**** VERIFICAR SI EL TOTAL DE PAGOSPR ES IGUAL A LA SUMA DE LOS DETALLES DE pagospr2

SET DELETE ON

SELECT 0
USE pagospr2
SET ORDER TO pagospr1

SELECT 0
USE pagospr1

MTOT = 0
SCAN
	SELECT pagospr2
	SEEK DTOS(pagospr1.fecha)+STR(pagospr1.tipo,2)+STR(pagospr1.numero1,4)+STR(pagospr1.numero2,8)
	
	SCAN WHILE pagospr1.fecha = pagospr2.fecha AND ;
		pagospr1.tipo = pagospr2.tipo AND ;
		pagospr1.numero1 = pagospr2.numero1 AND ;
		pagospr1.numero2 = pagospr2.numero2
	
		MTOT = MTOT + pagospr2.importe
		SELECT pagospr2
	ENDSCAN
	SELECT pagospr1
	IF pagospr1.total <> mtot
		DELETE
		WAIT WINDOW DTOS(pagospr1.FECHA)+"-"+STR(pagospr1.TIPO,2)+"-"+STR(pagospr1.NUMERO1,4)+STR(pagospr1.NUMERO2,8)+STR(pagospr1.TOTAL-MTOT)
	endif
	mtot = 0
ENDSCAN

CLOS DATA
