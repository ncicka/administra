** ESTE PROGRAMA BUSCA LOS PAGOS A LOS COMPROBANTES QUE ESTÁN EN 
** CTACTE1 Y LES COLOCA EL PAGADO

SET DELETED OFF

SELECT 0
USE PAGOS1
SET ORDER TO PAGOS1

SELECT 0
USE PAGOS2
SET ORDER TO PAGOS2

SELECT 0
USE CTACTE1
SET ORDER TO CTACTE1


GO TOP
SCAN 
	IF !DELETED()
		REPLACE pagado		WITH fpagado()
	ENDIF
	
ENDSCAN

RETURN 


FUNCTION fpagado
PRIVATE mpagado
STORE 0	TO mpagado

SELECT pagos2
SET ORDER TO pagos2

SEEK DTOS(ctacte1.fecha)+STR(ctacte1.tipo,2)+STR(ctacte1.numero1,4)+ ;
	STR(ctacte1.numero2,8)
mnumero2 = numero2

SCAN WHILE  ctacte1.fecha   = pagos2.cfecha AND ;
			ctacte1.tipo    = pagos2.ctipo  AND ;
			ctacte1.numero1 = pagos2.cnumero1 AND ;
			ctacte1.numero2 = pagos2.cnumero2

		IF !DELETED()
		IF mnumero2 = ctacte1.numero2 OR mpagado < CTACTE1.TOTAL
			STORE mpagado + pagos2.importe 	TO mpagado
			mnumero2 = pagos2.numero2
		ELSE
			IF mpagado = ctacte1.TOTAL
				SELECT pagos1
				SEEK DTOS(pagos2.fecha)+STR(pagos2.tipo,2)+STR(pagos2.numero1,4)+ ;
				STR(pagos2.numero2,8)
				IF FOUND()
					DELETE
				ENDIF
				SELECT pagos2
				DELETE
			ENDIF
		ENDIF
		ENDIF
		
ENDSCAN

SELECT ctacte1

RETURN mpagado>=CTACTE1.TOTAL
