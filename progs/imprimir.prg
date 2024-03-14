**** IMPRESION DE COMPROBANTES
** FACTURAS 

IF confirma(" Imprime "+comprob.descripcio)
	SET PRINTER TO (comprob.impresora)
	SELECT (tdetalle)
	GO TOP
	REPOR FORM factura TO PRINT PROMPT NOCONSOLE
	SET PRINTER TO
ENDIF

RETURN


