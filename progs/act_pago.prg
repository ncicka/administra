*** PROCEDIMIENTO PARA LA ACTUALIZACION DE PAGOS A COMPROBANTES.

PARAMETERS abm, pcfecha, pctipo, pcnumero1, pcnumero2, ;
				pcliente, pnombre, pdocumento, pdireccion, ;
				plocalidad, piva, pcuit, ptelefono, ptotal, ;
				pfecha, ptipo, pnumero1, pnumero2

PRIVATE pago1, pago2, orden1, orden2				
STORE .F. 	TO pago1, pago2

IF USED("pagos1")
	SELECT pagos1
	STORE .T.		TO pago1
	STORE ORDER()	TO orden1
	SET ORDER TO pagos1
ELSE
	SELECT 0
	USE (LOCFILE("pagos1.dbf", "DBF", "Buscar pagos1?")) ;
		SHARED AGAIN ALIAS pagos1 ;
		ORDER pagos1
ENDIF

IF USED("pagos2")
	SELECT pagos2
	STORE .T.		TO pago2
	STORE ORDER()	TO orden2
	SET ORDER TO pagos1
ELSE
	SELECT 0
	USE (LOCFILE("pagos2.dbf", "DBF", "Buscar pagos2?")) ;
		SHARED AGAIN ALIAS pagos2 ;
		ORDER pagos1
ENDIF

DO proceso

IF pago1
	SELECT pagos1
	SET ORDER TO &orden1
ELSE	
	SELECT pagos1
	USE
ENDIF

IF pago2
	SELECT pagos2
	SET ORDER TO &orden2
ELSE	
	SELECT pagos2
	USE
ENDIF


RETURN


PROCEDURE proceso

IF abm = "A"
	SELECT pagos1
	SEEK DTOS(pfecha)+STR(ptipo,2)+STR(pnumero1,4)+STR(pnumero2,8)
	
	IF !FOUND()
		APPEND BLANK
		DO WHILE !RLOCK()
		ENDDO
		
		REPLACE fecha	    WITH pfecha    ,;
				tipo	    WITH ptipo     ,;
				numero1	    WITH pnumero1  ,;
				numero2	    WITH pnumero2  ,;
				cliente	    WITH pcliente  ,;
				nombre	    WITH pnombre   ,;
				documento	WITH pdocumento,;
				direccion	WITH pdireccion,;
				localidad	WITH plocalidad,;
				iva			WITH piva      ,;
				cuit		WITH pcuit     ,;
				telefono	WITH ptelefono 
	ELSE
		DO WHILE !RLOCK()
		ENDDO
	ENDIF
	REPLACE total		WITH total + ptotal

	UNLOCK ALL
		
	SELECT pagos2
		
	APPEND BLANK
		
	DO WHILE !RLOCK()
	ENDDO
		
	REPLACE fecha		WITH pfecha  ,;
			tipo		WITH ptipo   ,;
			numero1		WITH pnumero1,;
			numero2		WITH pnumero2,;
			importe		WITH ptotal  ,;
			cfecha 		WITH pcfecha  ,;
			ctipo		WITH pctipo   ,;
			cnumero1	WITH pcnumero1,;
			cnumero2	WITH pcnumero2
	
ENDIF

RETURN 