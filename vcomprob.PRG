** 22/01/2015
** agregar un tipo de comprobante para remitos manuales

** tener abierto vcomprob


SELECT vcomprob
LOCATE FOR codigo="RMs"
IF NOT FOUND()
	APPEND blank
	replace codigo 	WITH "RMs",;
			descripcio WITH "Rem. Manual Sal.",;
			letra		WITH 'X',;
			imprime		WITH 0,;
			sumaresta	WITH '+',;
			saldocaja	WITH 0
			
	=TABLEUPDATE(.T.,.T.,'vcomprob')
ENDIF 

LOCATE FOR codigo="RMe"
IF NOT FOUND()
	APPEND blank
	replace codigo 	WITH "RMe",;
			descripcio WITH "Rem. Manual Ent.",;
			letra		WITH 'X',;
			imprime		WITH 0,;
			sumaresta	WITH '+',;
			saldocaja	WITH 0

	=TABLEUPDATE(.T.,.T.,'vcomprob')
ENDIF 