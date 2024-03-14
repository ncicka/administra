*       *********************************************************
*       *                                                         
*       * 08/02/99            ANULACIO.PRG               12:00:50 
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

IF USED("articulo")
	SELECT articulo
	SET ORDER TO articulo1
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo ;
		ORDER articulo1
ENDIF

IF USED("pagos1")
	SELECT pagos1
	SET ORDER TO pagos1
ELSE
	SELECT 0
	USE (LOCFILE("pagos1.dbf", "DBF", "Buscar pagos1?")) ;
		SHARED AGAIN ALIAS pagos1 ;
		ORDER pagos1
ENDIF

IF USED("pagos2")
	SELECT pagos2
	SET ORDER TO pagos2
ELSE
	SELECT 0
	USE (LOCFILE("pagos2.dbf", "DBF", "Buscar pagos2?")) ;
		SHARED AGAIN ALIAS pagos2 ;
		ORDER pagos2
ENDIF

IF USED("ventas1")
	SELECT ventas1
	SET ORDER TO ventas1
ELSE
	SELECT 0
	USE (LOCFILE("ventas1.dbf", "DBF", "Buscar ventas1?")) ;
		SHARED AGAIN ALIAS ventas1 ;
		ORDER ventas1
ENDIF

IF USED("ventas2")
	SELECT ventas2
	SET ORDER TO ventas1
ELSE
	SELECT 0
	USE (LOCFILE("ventas2.dbf", "DBF", "Buscar ventas2?")) ;
		SHARED AGAIN ALIAS ventas2 ;
		ORDER ventas1
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
	CASE UPPER(quecom) = "N. CREDITO"
		STORE 4		TO m.tipo
	CASE UPPER(quecom) = "N. DEBITO"
		STORE 6		TO m.tipo
	OTHERWISE
		STORE 1		TO m.tipo
ENDCASE

IF m.tipo = 1 
	SET KEY TO STR(m.tipo,2)
ELSE
	SET KEY TO RANGE STR(m.tipo,2),STR(m.tipo+1,2))
ENDIF
	


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
@ 5.538,2.000 SAY "Cliente:" ;
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
@ 2.538,17.600 TO 3.846,17.600 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.538,24.600 TO 3.846,24.600 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.538,37.400 TO 3.846,37.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.923,28.000 TO 2.231,28.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,14.400 TO 3.769,14.400 ;
	PEN 1, 8
@ 3.769,14.600 TO 3.769,17.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,18.800 TO 3.769,24.600 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,26.000 TO 3.769,37.400 ;
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
@ 2.615,18.800 TO 3.846,18.800 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,26.000 TO 3.769,26.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.923,14.800 TO 0.923,28.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,14.600 TO 2.538,17.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,18.800 TO 2.538,24.800 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,26.000 TO 2.538,37.600 ;
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
	SIZE 1.000,1.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ 99" ;
	VALID _s2c0pr1zn() ;
	COLOR ,RGB(,,,255,255,255)
@ 2.692,19.400 GET m.numero1 ;
	SIZE 1.000,5.600 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ" ;
	COLOR ,RGB(,,,255,255,255)
@ 2.692,26.600 GET m.numero2 ;
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

IF USED("articulo")
	SELECT articulo
	USE
ENDIF

IF USED("pagos1")
	SELECT pagos1
	USE
ENDIF

IF USED("pagos2")
	SELECT pagos2
	USE
ENDIF

IF USED("ventas1")
	SELECT ventas1
	USE
ENDIF

IF USED("ventas2")
	SELECT ventas2
	USE
ENDIF

IF USED("contado1")
	SELECT contado1
	USE
ENDIF

IF USED("contado2")
	SELECT contado2
	USE
ENDIF

IF USED("ctacte1")
	SELECT ctacte1
	USE
ENDIF

IF USED("ctacte2")
	SELECT ctacte2
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

IF USED("contado1")
	SELECT contado1
	SET ORDER TO contado1
ELSE
	SELECT 0
	USE (LOCFILE("contado1.dbf", "DBF", "Buscar contado1?")) ;
		SHARED AGAIN ALIAS contado1 ;
		ORDER contado1
ENDIF

IF USED("contado2")
	SELECT contado2
	SET ORDER TO contado1
ELSE
	SELECT 0
	USE (LOCFILE("contado2.dbf", "DBF", "Buscar contado2?")) ;
		SHARED AGAIN ALIAS contado2 ;
		ORDER contado1
ENDIF

SELECT contado1
SET ORDER TO contado1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND() 
	IF tipo = 1 AND facturado
		STORE "Este comprobante tiene factura - No se anula" TO merror
		RETURN .F.
	ENDIF

	STORE "contado1"	TO fichero1
	STORE "contado2"	TO fichero2

	IF USED("ctacte1")	
		SELECT ctacte1
		USE
	ENDIF

	IF USED("ctacte2")
		SELECT ctacte2
		USE
	ENDIF

	SELECT (fichero1)
	
	STORE "Pagado"		TO m.pagado
	
	=verdet()
	
	RETURN .T.
ENDIF

IF USED("ctacte1")
	SELECT ctacte1
	SET ORDER TO ctacte1
ELSE
	SELECT 0
	USE (LOCFILE("ctacte1.dbf", "DBF", "Buscar ctacte1?")) ;
		SHARED AGAIN ALIAS ctacte1 ;
		ORDER ctacte1
ENDIF

IF USED("ctacte2")
	SELECT ctacte2
	SET ORDER TO ctacte1
ELSE
	SELECT 0
	USE (LOCFILE("ctacte2.dbf", "DBF", "Buscar ctacte2?")) ;
		SHARED AGAIN ALIAS ctacte2 ;
		ORDER ctacte1
ENDIF

SELECT ctacte1
SET ORDER TO ctacte1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	IF tipo = 1 AND facturado
		STORE "Este comprobante tiene factura - No se anula" TO merror
		RETURN .F.
	ENDIF

	IF USED("contado1")	
		SELECT contado1
		USE
	ENDIF

	IF USED("contado2")
		SELECT contado2
		USE
	ENDIF
	
	STORE "ctacte1"	TO fichero1
	STORE "ctacte2"	TO fichero2

	SELECT (fichero1)
	IF ctacte1.pagado
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
@ 5.615,15.200 SAY &fichero1..cliente ;
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

SELECT pagos2
SET ORDER TO pagos2
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

SCAN WHILE  cfecha   = m.fecha   AND ;
			ctipo    = m.tipo    AND ;
			cnumero1 = m.numero1 AND ;
			cnumero2 = m.numero2 AND ;
			mlinea <= 14.769

	@ mlinea,18.800 SAY Pagos2.fecha ;
		SIZE 1.000,12.000 ;
		FONT "MS Sans Serif", 8
	@ mlinea,40.400 SAY Pagos2.numero1 ;
		SIZE 1.000,5.600 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 9999"
	@ mlinea,46.300 SAY '-' ;
		FONT "MS Sans Serif", 8 
	@ mlinea,46.800 SAY Pagos2.numero2 ;
		SIZE 1.000,10.200 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 99999999"
	@ mlinea,58.800 SAY Pagos2.importe ;
		SIZE 1.000,15.800 ;
		FONT "MS Sans Serif", 8
	
	STORE mlinea + 1.231 	TO mlinea

	SELECT pagos2
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

SELECT pagos2
SET ORDER TO pagos2
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE pagos2.fecha		TO mfecha
	STORE pagos2.tipo		TO mtipo
	STORE pagos2.numero1	TO mnumero1
	STORE pagos2.numero2	TO mnumero2

	SCAN WHILE  cfecha   = m.fecha   AND ;
				ctipo    = m.tipo    AND ;
				cnumero1 = m.numero1 AND ;
				cnumero2 = m.numero2 
		IF !DELETED()
			STORE 	pagos2.importe + mtotal 	TO mtotal
			DO act_cli WITH "A", m.fecha, &fichero1..cliente, pagos2.importe
		ENDIF
		
		SELECT pagos2		

		DO WHILE !RLOCK()
		ENDDO
			
		DELETE
	ENDSCAN

	SELECT pagos1
	SET ORDER TO pagos1
	SEEK DTOS(mfecha)+STR(mtipo,2)+STR(mnumero1,4)+STR(mnumero2,8)
	
	IF FOUND()
		DO WHILE !RLOCK()
		ENDDO
		IF pagos1.total = mtotal
			DELETE
		ELSE
			REPLACE total	WITH total - mtotal
		ENDIF
	ENDIF
	
	UNLOCK ALL
ENDIF
SET DELETE &andele

** Actualizar el saldo del cliente si corresponde

IF fichero1 = "ctacte1" AND sicta()

	DO act_cli WITH IIF(INLIST(m.tipo,4,5),"A","B"), m.fecha, &fichero1..cliente, &fichero1..total

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
					REPLACE actual	WITH actual - &fichero2..cantidad
				ELSE
					REPLACE actual 	WITH actual + &fichero2..cantidad
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

	IF m.tipo = 1
		** Si es nota de entrega
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
		** Si no es nota de entrega
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
	
	ENDIF

** Si no es nota de entrega anular del libro iva

IF m.tipo > 1
	SELECT ventas2
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	SCAN WHILE  ventas2.fecha   = m.fecha   AND;
				ventas2.tipo    = m.tipo	AND ;
				ventas2.numero1 = m.numero1 AND ;
				ventas2.numero2 = m.numero2
		
			DO WHILE !RLOCK()
			ENDDO
			
			DELETE
	ENDSCAN
	UNLOCK ALL

	SELECT ventas1
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	
	IF FOUND()
		DO WHILE !RLOCK()
		ENDDO
		REPLACE subtotal    WITH 0,;
				impuesto    WITH 0,;
				tasaivari   WITH 0,;
				ivari		WITH 0,;
				tasaivarni	WITH 0,;
				ivarni		WITH 0,;
				tasaivanoc 	WITH 0,;
				ivanoc		WITH 0,;
				por_desc	WITH 0,;
				descuento	WITH 0,;
				descuento1	WITH 0,;
				total		WITH 0,;
				anulada     WITH .T.
		
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

IF m.tipo > 1
	SELECT relacion
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
	IF FOUND()
		RETURN .F.
	ENDIF
ENDIF	

RETURN .T.

