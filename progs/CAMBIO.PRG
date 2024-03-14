***** ARREGLAR LOS PAGOS A LOS COMPROBANTES

SET DELETE ON

SELECT 0
USE contapr1
SET ORDER TO contapr1

SELECT 0
USE pagos2
go top

SCAN
	IF INLIST(pagos2.ctipo,4,5,6,7)
		SELECT contapr1
		SEEK DTOS(pagos2.cfecha)+STR(pagos2.ctipo,2)+STR(pagos2.cnumero1,4)+STR(pagos2.numero2,8)
		IF FOUND()
			WAIT WINDOW CLIENTE+NOMBRE+STR(RECNO())
		ENDIF
		
	ENDIF
	SELECT pagos2
ENDSCAN


SELECT 0
USE contado1
SET ORDER TO contado1

SELECT 0
USE pagospr2
go top

SCAN
	IF INLIST(pagospr2.ctipo,4,5,6,7)
		SELECT contado1
		SEEK DTOS(pagospr2.cfecha)+STR(pagospr2.ctipo,2)+STR(pagospr2.cnumero1,4)+STR(pagospr2.numero2,8)
		IF FOUND()
			WAIT WINDOW CLIENTE+NOMBRE+STR(RECNO())
		ENDIF
		
	ENDIF
	SELECT pagos2
ENDSCAN