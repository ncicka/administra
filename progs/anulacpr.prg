*       *********************************************************
*       *                                                         
*       * 08/02/99            ANULACPR.PRG               12:00:50 
*       *                                                         
*       *********************************************************
*       *                                                         
*       * Nombre del autor                                        
*       *                                                         
*       * Copyright (c) 1999 Nombre de la empresa                 
*       * Dirección                                               
*       * Ciudad,     C.P.                                        
*       * País                                              
*       *                                                         
*       * Description:                                            
*       * Este programa lo ha generado automáticamente GENSCRN.    
*       *                                                         
*       *********************************************************

PARAMETERS quecom

RELEASE m.tipo, m.fecha, m.numero1, m.numero2, m.pagado, fichero1, ;
		fichero2, merror

PUBLIC m.tipo, m.fecha, m.numero1, m.numero2, m.pagado, fichero1, ;
		fichero2, merror

STORE 0			TO m.tipo, m.numero1, m.numero2
STORE " "		TO m.pagado
STORE {}		TO m.fecha
STORE SPACE(8) 	TO fichero1, fichero2

#REGION 0
REGIONAL m.currarea, m.talkstat, m.compstat

IF SET("TALK") = "ON"
	SET TALK OFF
	m.talkstat = "ON"
ELSE
	m.talkstat = "OFF"
ENDIF
m.compstat = SET("COMPATIBLE")
SET COMPATIBLE FOXPLUS

m.rborder = SET("READBORDER")
SET READBORDER ON

*       *********************************************************
*       *                                                         
*       *             Windows Definiciones de ventana             
*       *                                                         
*       *********************************************************
*

IF NOT WEXIST("_s2c0pr1ky")
	DEFINE WINDOW _s2c0pr1ky ;
		AT  0.000, 0.000  ;
		SIZE 20.923,92.600 ;
		TITLE "Anulación de "+quecom ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
		
	MOVE WINDOW _s2c0pr1ky CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *        ANULACIO/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1

IF USED("relacion")
	SELECT relacion
	SET ORDER TO relacion1
ELSE
	SELECT 0
	USE (LOCFILE("relacion.dbf", "DBF", "Buscar relacion?")) ;
		SHARED AGAIN ALIAS relacion ;
		ORDER relacion1
ENDIF

IF USED("aplicadc")
	SELECT aplicadc
	SET ORDER TO aplicadc1
ELSE
	SELECT 0
	USE (LOCFILE("aplicadc.dbf", "DBF", "Buscar aplicadc?")) ;
		SHARED AGAIN ALIAS aplicadc ;
		ORDER aplicadc1
ENDIF

IF USED("articulo")
	SELECT articulo
	SET ORDER TO articulo1
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo ;
		ORDER articulo1
ENDIF

IF USED("pagospr1")
	SELECT pagospr1
	SET ORDER TO pagospr1
ELSE
	SELECT 0
	USE (LOCFILE("pagospr1.dbf", "DBF", "Buscar pagospr1?")) ;
		SHARED AGAIN ALIAS pagospr1 ;
		ORDER pagospr1
ENDIF

IF USED("pagospr2")
	SELECT pagospr2
	SET ORDER TO pagospr2
ELSE
	SELECT 0
	USE (LOCFILE("pagospr2.dbf", "DBF", "Buscar pagospr2?")) ;
		SHARED AGAIN ALIAS pagospr2 ;
		ORDER pagospr2
ENDIF

IF USED("compras1")
	SELECT compras1
	SET ORDER TO compras1
ELSE
	SELECT 0
	USE (LOCFILE("compras1.dbf", "DBF", "Buscar compras1?")) ;
		SHARED AGAIN ALIAS compras1 ;
		ORDER compras1
ENDIF

IF USED("compras2")
	SELECT compras2
	SET ORDER TO compras1
ELSE
	SELECT 0
	USE (LOCFILE("compras2.dbf", "DBF", "Buscar compras2?")) ;
		SHARED AGAIN ALIAS compras2 ;
		ORDER compras1
ENDIF

IF USED("comprob")
	SELECT comprob
	SET ORDER TO comprob
ELSE
	SELECT 0
	USE (LOCFILE("comprob.dbf", "DBF", "Buscar comprob?")) ;
		SHARED AGAIN ALIAS comprob ;
		ORDER comprob
ENDIF

DO CASE
	CASE UPPER(quecom) = "FACTURA"
		STORE 2		TO m.tipo
		SET FILTER TO INLIST(tipo,2,3,10,11)		
	CASE UPPER(quecom) = "N. CREDITO"
		STORE 4		TO m.tipo
		SET FILTER TO INLIST(tipo,4,5)
	CASE UPPER(quecom) = "N. DEBITO"
		STORE 6		TO m.tipo
		SET FILTER TO INLIST(tipo,6,7)
	OTHERWISE
		STORE 9		TO m.tipo
		SET FILTER TO tipo = 9 
ENDCASE

IF WVISIBLE("_s2c0pr1ky")
	ACTIVATE WINDOW _s2c0pr1ky SAME
ELSE
	ACTIVATE WINDOW _s2c0pr1ky NOSHOW
ENDIF
@ 1.000,2.000 SAY "Fecha:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.615,2.000 SAY "Número:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 5.538,2.000 SAY "Proveedor:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 6.846,2.000 SAY "Dirección:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 8.154,2.000 SAY "Total:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 6.846,54.800 SAY "Cond. Venta:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 10.000,2.000 SAY "Pagos Realizados" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 9.769,2.000 TO 9.769,90.400 ;
	PEN 1, 8 ;
	STYLE "1"
@ 18.538,29.000 TO 18.538,29.000 ;
	PEN 1, 8 ;
	STYLE "16"
@ 2.538,18.600 TO 3.846,18.600 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.538,25.600 TO 3.846,25.600 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.538,38.400 TO 3.846,38.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.923,28.000 TO 2.231,28.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,14.600 TO 3.769,18.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,19.800 TO 3.769,25.600 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,27.000 TO 3.769,38.400 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.154,14.600 TO 2.154,28.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.923,14.600 TO 2.154,14.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,14.600 TO 3.769,14.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.615,19.800 TO 3.846,19.800 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,27.000 TO 3.769,27.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.923,14.800 TO 0.923,28.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,14.600 TO 2.538,18.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,19.800 TO 2.538,25.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,27.000 TO 2.538,38.600 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 1.077,15.200 GET m.fecha ;
	SIZE 1.000,12.200 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KE" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID fctrfech(m.fecha,"m.fecha")
@ 2.692,15.200 GET m.tipo ;
	SIZE 1.000,2.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ 99" ;
	VALID _s2c0pr1zn() ;
	COLOR ,RGB(,,,255,255,255)
@ 2.692,20.400 GET m.numero1 ;
	SIZE 1.000,5.600 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ" ;
	COLOR ,RGB(,,,255,255,255)
@ 2.692,27.600 GET m.numero2 ;
	SIZE 1.000,10.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	COLOR ,RGB(,,,255,255,255) ;
	ERROR merror;
	VALID LASTKEY() = 5 OR fnumero2()
@ 17.462,29.800 GET m.confirma ;
	PICTURE "@*HT \<Cancelar;\<Aceptar" ;
	SIZE 1.769,12.600,4.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8

IF NOT WVISIBLE("_s2c0pr1ky")
	ACTIVATE WINDOW _s2c0pr1ky
ENDIF

READ CYCLE MODAL

IF LASTKEY() # 27 AND m.confirma = 2
	DO anular
ENDIF
RELEASE WINDOW _s2c0pr1ky

#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF

IF USED("relacion")
	SELECT relacion
	USE
ENDIF

IF USED("aplicadc")
	SELECT aplicadc
	USE
ENDIF

IF USED("articulo")
	SELECT articulo
	USE
ENDIF

IF USED("pagospr1")
	SELECT pagospr1
	USE
ENDIF

IF USED("pagospr2")
	SELECT pagospr2
	USE
ENDIF

IF USED("compras1")
	SELECT compras1
	USE
ENDIF

IF USED("compras2")
	SELECT compras2
	USE
ENDIF

IF USED("contapr1")
	SELECT contapr1
	USE
ENDIF

IF USED("contapr2")
	SELECT contapr2
	USE
ENDIF

IF USED("ctactpr1")
	SELECT ctactpr1
	USE
ENDIF

IF USED("ctactpr2")
	SELECT ctactpr2
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF

RELEASE m.tipo, m.fecha, m.numero1, m.numero2, m.pagado, fichero1, ;
	fichero2, merror

*       *********************************************************
*       *                                                         
*       * _S2C0PR1ZN           m.tipo VALID                       
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         ANULACIO,     Record Number:   29  
*       * Variable:            m.tipo                             
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2c0pr1zn     &&  m.tipo VALID
#REGION 1
SELECT comprob

SEEK STR(m.tipo,2)
IF !FOUND()
	DO browenc WITH "descripcio :H='Comprobantes'",20,"descripcio"
ENDIF
STORE comprob.tipo 	TO m.tipo
@ 2.692,39.000 SAY Comprob.descripcio ;
	SIZE 1.000,20.000 ;
	FONT "MS Sans Serif", 8

RETURN .T.


FUNCTION fnumero2
PRIVATE usado, registro, orden, cta1, cta2
STORE .F.	TO cta1, cta2, usado

** Buscar en m.fichero si existe este número de comprobante

IF USED("contapr1")
	SELECT contapr1
	SET ORDER TO contapr1
ELSE
	SELECT 0
	USE (LOCFILE("contapr1.dbf", "DBF", "Buscar contapr1?")) ;
		SHARED AGAIN ALIAS contapr1 ;
		ORDER contapr1
ENDIF

IF USED("contapr2")
	SELECT contapr2
	SET ORDER TO contapr1
ELSE
	SELECT 0
	USE (LOCFILE("contapr2.dbf", "DBF", "Buscar contapr2?")) ;
		SHARED AGAIN ALIAS contapr2 ;
		ORDER contapr1
ENDIF

SELECT contapr1
SET ORDER TO contapr1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND() 
	IF tipo = 1 AND facturado
		STORE "Este comprobante tiene factura - No se anula" TO merror
		RETURN .F.
	ENDIF

	STORE "contapr1"	TO fichero1
	STORE "contapr2"	TO fichero2

	IF USED("ctactpr1")	
		SELECT ctactpr1
		USE
	ENDIF

	IF USED("ctactpr2")
		SELECT ctactpr2
		USE
	ENDIF

	SELECT (fichero1)
	
	STORE "Pagado"		TO m.pagado
	
	=verdet()
	
	RETURN .T.
ENDIF

IF USED("ctactpr1")
	SELECT ctactpr1
	SET ORDER TO ctactpr1
ELSE
	SELECT 0
	USE (LOCFILE("ctactpr1.dbf", "DBF", "Buscar ctactpr1?")) ;
		SHARED AGAIN ALIAS ctactpr1 ;
		ORDER ctactpr1
ENDIF

IF USED("ctactpr2")
	SELECT ctactpr2
	SET ORDER TO ctactpr1
ELSE
	SELECT 0
	USE (LOCFILE("ctactpr2.dbf", "DBF", "Buscar ctactpr2?")) ;
		SHARED AGAIN ALIAS ctactpr2 ;
		ORDER ctactpr1
ENDIF

SELECT ctactpr1
SET ORDER TO ctactpr1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	IF tipo = 1 AND facturado
		STORE "Este comprobante tiene factura - No se anula" TO merror
		RETURN .F.
	ENDIF

	IF USED("contapr1")	
		SELECT contapr1
		USE
	ENDIF

	IF USED("contapr2")
		SELECT contapr2
		USE
	ENDIF
	
	STORE "ctactpr1"	TO fichero1
	STORE "ctactpr2"	TO fichero2

	SELECT (fichero1)
	IF ctactpr1.pagado
		STORE "Pagado"	TO m.pagado
	ELSE
		STORE "NO pagado" TO m.pagado
	ENDIF
	=verdet()
	
	RETURN .T.
ENDIF
STORE "Comprobante inexistente o anulado" TO merror
RETURN .F.

FUNCTION verdet

SELECT (fichero1)
@ 5.615,15.200 SAY &fichero1..proveedor ;
	SIZE 1.000,5.400 ;
	FONT "MS Sans Serif", 8
@ 5.615,22.000 SAY &fichero1..nombre ;
	SIZE 1.000,68.800 ;
	FONT "MS Sans Serif", 8
@ 6.923,15.200 SAY &fichero1..direccion ;
	SIZE 1.000,33.800 ;
	FONT "MS Sans Serif", 8
@ 6.923,69.800 SAY &fichero1..condicion ;
	SIZE 1.000,20.000 ;
	FONT "MS Sans Serif", 8
@ 8.231,15.200 SAY &fichero1..total ;
	SIZE 1.000,15.600 ;
	FONT "MS Sans Serif", 8
@ 8.231,69.800 SAY m.pagado ;
	SIZE 1.000,11.600 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "XXXXXXXXX"

** Ver los pagos 

STORE 11.077 		TO mlinea

SELECT pagospr2
SET ORDER TO pagospr2
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

SCAN WHILE  cfecha   = m.fecha   AND ;
			ctipo    = m.tipo    AND ;
			cnumero1 = m.numero1 AND ;
			cnumero2 = m.numero2 AND ;
			mlinea <= 14.769

	@ mlinea,18.800 SAY pagospr2.fecha ;
		SIZE 1.000,12.000 ;
		FONT "MS Sans Serif", 8
	@ mlinea,40.400 SAY pagospr2.numero1 ;
		SIZE 1.000,5.600 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 9999"
	@ mlinea,46.300 SAY '-' ;
		FONT "MS Sans Serif", 8 
	@ mlinea,46.800 SAY pagospr2.numero2 ;
		SIZE 1.000,10.200 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 99999999"
	@ mlinea,58.800 SAY pagospr2.importe ;
		SIZE 1.000,15.800 ;
		FONT "MS Sans Serif", 8
	
	STORE mlinea + 1.231 	TO mlinea

	SELECT pagospr2
ENDSCAN

DO WHILE mlinea <= 14.769

	@ mlinea,18.800 SAY " " ;
		SIZE 1.000,12.000 ;
		FONT "MS Sans Serif", 8
	@ mlinea,40.400 SAY " " ;
		SIZE 1.000,4.600 ;
		FONT "MS Sans Serif", 8
	@ mlinea,46.800 SAY " " ;
		SIZE 1.000,10.200 ;
		FONT "MS Sans Serif", 8
	@ mlinea,58.800 SAY " " ;
		SIZE 1.000,15.800 ;
		FONT "MS Sans Serif", 8
	
	STORE mlinea + 1.231 	TO mlinea

ENDDO

RETURN .T.

PROCEDURE anular
PRIVATE mtotal, mfecha, mtipo, mnumero1, mnumero2
STORE 0	TO mtotal

IF !USED(fichero2) OR !USED(fichero1)
	RETURN
ENDIF

andele = SET('DELETE')
SET DELETE OFF

** Borrar los pagos si tiene

SELECT pagospr2
SET ORDER TO pagospr2
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE pagospr2.fecha		TO mfecha
	STORE pagospr2.tipo		TO mtipo
	STORE pagospr2.numero1	TO mnumero1
	STORE pagospr2.numero2	TO mnumero2

	SCAN WHILE  cfecha   = m.fecha   AND ;
				ctipo    = m.tipo    AND ;
				cnumero1 = m.numero1 AND ;
				cnumero2 = m.numero2 
		IF !DELETED()
			STORE 	pagospr2.importe + mtotal 	TO mtotal
			DO act_pro WITH "A", m.fecha, &fichero1..proveedor, pagospr2.importe
		ENDIF
		
		SELECT pagospr2		

		DO WHILE !RLOCK()
		ENDDO
			
		DELETE
	ENDSCAN

	SELECT pagospr1
	SET ORDER TO pagospr1
	SEEK DTOS(mfecha)+STR(mtipo,2)+STR(mnumero1,4)+STR(mnumero2,8)
	
	IF FOUND()
		DO WHILE !RLOCK()
		ENDDO
		IF pagospr1.total = mtotal
			DELETE
		ELSE
			REPLACE total	WITH total - mtotal
		ENDIF
	ENDIF
	
	UNLOCK ALL
ENDIF
SET DELETE &andele

** Actualizar el saldo del proveedor si corresponde

IF fichero1 = "ctactpr1" AND sicta()

	DO act_pro WITH IIF(INLIST(m.tipo,4,5),"A","B"), m.fecha, &fichero1..proveedor, &fichero1..total

ENDIF

** Borrar el detalle del comprobante y actualizar stock si corresponde


andele = SET('DELETE')
SET DELETE OFF

	SELECT (fichero2)
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

	SCAN WHILE  fecha   = m.fecha   AND;
			tipo	= m.tipo    AND ;
			numero1	= m.numero1 AND ;
			numero2 = m.numero2

		IF DELETED()
			LOOP
		ENDIF
	
		IF SEEK(rubro+articulo,'articulo') AND sicta()
			** actualizo el stock
			IF articulo.stock
				SELECT articulo
				DO WHILE !RLOCK()
				ENDDO
				IF m.tipo = 4 OR m.tipo = 5
					REPLACE actual	WITH actual + &fichero2..cantidad
				ELSE
					REPLACE actual 	WITH actual - &fichero2..cantidad
				ENDIF
				UNLOCK ALL
			ENDIF
		ENDIF
	
		SELECT (fichero2)
		DO WHILE !RLOCK()
		ENDDO
		DELETE 
		UNLOCK ALL
			
	ENDSCAN

	IF m.tipo = 9
		** Si es remito
		** Borrar la relacion con la factura, si tiene
	
		SELECT relacion
		SET ORDER TO relacion2
		SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
		SCAN WHILE  mfecha   = m.fecha   AND ;
				mtipo    = m.tipo    AND ;
				mnumero1 = m.numero1 AND ;
				mnumero2 = m.numero2 

			DO WHILE !RLOCK()
			ENDDO
			DELETE
			
		ENDSCAN
		UNLOCK ALL
	ELSE	
		** Si no es remito
		** Borrar las relaciones si la factura se realizó a notas de entrega
		** actualizar las notas de entrega que estén disponibles para 
		** una nueva facturación

		SELECT relacion
		SET ORDER TO relacion1
		SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
		SCAN WHILE  fecha   = m.fecha   AND ;
				tipo    = m.tipo    AND ;
				numero1 = m.numero1 AND ;
				numero2 = m.numero2 


			SELECT (fichero1)
			SEEK DTOS(mfecha)+STR(mtipo,2)+STR(mnumero1,4)+STR(mnumero2,8)
			IF FOUND()
				DO WHILE !RLOCK()
				ENDDO
				REPLACE facturado  	WITH .F.
				UNLOCK ALL				
			ENDIF
			
			SELECT relacion
			DO WHILE !RLOCK()
			ENDDO
			DELETE
			
		ENDSCAN
		UNLOCK ALL

		*** AGREGADO 01-09-2005 
		*** BORRAR LOS COMPROBANTES APLICADOS

		SELECT aplicadc
		SET ORDER TO aplicadc1
		SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
		DELETE WHILE  fecha   = m.fecha   AND ;
				tipo    = m.tipo    AND ;
				numero1 = m.numero1 AND ;
				numero2 = m.numero2 

	ENDIF

** Si no es remito anular del libro iva

IF  m.tipo <> 9
	SELECT compras2
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	SCAN WHILE  compras2.fecha   = m.fecha   AND;
				compras2.tipo    = m.tipo	AND ;
				compras2.numero1 = m.numero1 AND ;
				compras2.numero2 = m.numero2
		
			DO WHILE !RLOCK()
			ENDDO
			
			DELETE
	ENDSCAN
	UNLOCK ALL

	SELECT compras1
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	
	IF FOUND()
		DO WHILE !RLOCK()
		ENDDO
		DELETE 
		UNLOCK ALL		
	ENDIF
		
ENDIF
SELECT (fichero1)
DO WHILE !RLOCK()
ENDDO
DELETE
UNLOCK ALL

SET DELETE &andele

RETURN

FUNCTION sicta

IF m.tipo # 9
	SELECT relacion
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	IF FOUND()
		RETURN .F.
	ENDIF
ENDIF	

RETURN .T.

