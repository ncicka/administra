*       *********************************************************
*       *                                                         
*       * 19/02/1999           ANULAPAG.PRG              09:23:20 
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

RELEASE m.tipo, m.fecha, m.numero1, m.numero2, merror
PUBLIC m.tipo, m.fecha, m.numero1, m.numero2, merror

STORE 0			TO m.tipo, m.numero1, m.numero2
STORE {}		TO m.fecha
STORE " "		TO merror

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

IF NOT WEXIST("_s2n0k4h1b")
	DEFINE WINDOW _s2n0k4h1b ;
		AT  0.000, 0.000  ;
		SIZE 20.462,92.800 ;
		TITLE "Anulación de Cobros de Clientes" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
		
	MOVE WINDOW _s2n0k4h1b CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *        ANULAPAG/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

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

IF USED("ctacte1")
	SELECT ctacte1
	SET ORDER TO ctacte1
ELSE
	SELECT 0
	USE (LOCFILE("ctacte1.dbf", "DBF", "Buscar ctacte1?")) ;
		SHARED AGAIN ALIAS ctacte1 ;
		ORDER ctacte1
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

STORE 8		TO m.tipo

#REGION 1
IF WVISIBLE("_s2n0k4h1b")
	ACTIVATE WINDOW _s2n0k4h1b SAME
ELSE
	ACTIVATE WINDOW _s2n0k4h1b NOSHOW
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
@ 9.769,2.000 TO 9.769,90.400 ;
	PEN 1, 8 ;
	STYLE "1"
@ 18.538,29.000 TO 18.538,29.000 ;
	PEN 1, 8 ;
	STYLE "16"
@ 2.538,20.400 TO 3.846,20.400 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.538,33.200 TO 3.846,33.200 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.923,29.000 TO 2.231,29.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,14.600 TO 3.769,20.400 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.769,21.800 TO 3.769,33.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 2.154,14.600 TO 2.154,29.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 0.923,14.600 TO 2.154,14.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.615,14.600 TO 3.846,14.600 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,21.800 TO 3.769,21.800 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.923,14.800 TO 0.923,29.200 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,14.600 TO 2.538,20.600 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 2.538,21.800 TO 2.538,33.400 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 1.077,15.200 GET m.fecha ;
	SIZE 1.000,13.200 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KE" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID fctrfech(m.fecha,"m.fecha")	
@ 2.692,15.200 GET m.numero1 ;
	SIZE 1.000,5.600 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ" ;
	COLOR ,RGB(,,,255,255,255)
@ 2.692,22.400 GET m.numero2 ;
	SIZE 1.000,10.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K" ;
	COLOR ,RGB(,,,255,255,255) ;
	ERROR merror ;
	VALID LASTKEY() = 5 OR fnumero2()
@ 17.462,29.800 GET m.confirma ;
	PICTURE "@*HT \<Cancelar;\<Aceptar" ;
	SIZE 1.769,12.600,4.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8

IF NOT WVISIBLE("_s2n0k4h1b")
	ACTIVATE WINDOW _s2n0k4h1b
ENDIF

READ CYCLE MODAL

IF LASTKEY() # 27 AND m.confirma = 2
	DO anular
ENDIF

RELEASE WINDOW _s2n0k4h1b

IF USED("pagos1")
	SELECT pagos1
	USE
ENDIF

IF USED("pagos2")
	SELECT pagos2
	USE
ENDIF

IF USED("ctacte1")
	SELECT ctacte1
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF

RELEASE m.tipo, m.fecha, m.numero1, m.numero2, merror

#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF


FUNCTION fnumero2
PRIVATE ctacte
STORE .F.	TO ctacte

SELECT pagos1
SET ORDER TO pagos1

SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND() 
	** Controlar que los pagos sean a facturas de ctacte
	
	SELECT pagos2
	SET ORDER TO pagos1
	
	SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

	SCAN WHILE  pagos2.fecha   = m.fecha   AND ;
				pagos2.tipo    = m.tipo    AND ;
				pagos2.numero1 = m.numero1 AND ;
				pagos2.numero2 = m.numero2
				
		SELECT ctacte1

		SEEK DTOS(pagos2.cfecha)+STR(pagos2.ctipo,2)+ ;
			STR(pagos2.cnumero1,4)+STR(pagos2.cnumero2,8)

		IF FOUND() OR EMPTY(pagos2.cnumero2)
			STORE .T.	TO ctacte
		ELSE
			STORE .F.	TO ctacte
			EXIT
		ENDIF
		
		SELECT pagos2
	ENDSCAN

	IF ctacte	
		=verdet()
		RETURN .T.
	ELSE
		STORE "El pago corresponde a Fac. de Contado" TO merror
		RETURN .F.
	ENDIF
ENDIF

STORE "Comprobante inexistente o anulado" TO merror
RETURN .F.


FUNCTION verdet

SELECT pagos1
@ 5.615,15.200 SAY pagos1.cliente ;
	SIZE 1.000,5.400 ;
	FONT "MS Sans Serif", 8
@ 5.615,22.000 SAY pagos1.nombre ;
	SIZE 1.000,68.800 ;
	FONT "MS Sans Serif", 8
@ 6.923,15.200 SAY pagos1.direccion ;
	SIZE 1.000,33.800 ;
	FONT "MS Sans Serif", 8
@ 8.231,15.200 SAY pagos1.total ;
	SIZE 1.000,15.600 ;
	FONT "MS Sans Serif", 8

** Ver los pagos 

STORE 11.077 		TO mlinea

SELECT pagos2
SET ORDER TO pagos1
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)
SET RELATION TO STR(ctipo,2) INTO comprob

SCAN WHILE  fecha   = m.fecha   AND ;
			tipo    = m.tipo    AND ;
			numero1 = m.numero1 AND ;
			numero2 = m.numero2 AND ;
			mlinea <= 14.769

	@ mlinea,15.200 SAY Pagos2.cfecha ;
		SIZE 1.000,12.000 ;
		FONT "MS Sans Serif", 8
	@ mlinea,29.000 SAY Comprob.codigo ;
		SIZE 1.000,6.000 ;
		FONT "MS Sans Serif", 8
	@ mlinea,36.800 SAY Pagos2.cnumero1 ;
		SIZE 1.000,5.600 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 9999"
	@ mlinea,42.700 SAY '-' ;
		FONT "MS Sans Serif", 8 
	@ mlinea,43.200 SAY Pagos2.cnumero2 ;
		SIZE 1.000,10.200 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@L 99999999"
	@ mlinea,55.200 SAY Pagos2.importe ;
		SIZE 1.000,15.800 ;
		FONT "MS Sans Serif", 8
	STORE mlinea + 1.231 	TO mlinea

	SELECT pagos2
ENDSCAN

DO WHILE mlinea <= 14.769

	@ mlinea,15.200 SAY " " ;
		SIZE 1.000,82.000 ;
		FONT "MS Sans Serif", 8
	
	STORE mlinea + 1.231 	TO mlinea

ENDDO

SET RELATION TO

RETURN .T.


PROCEDURE anular
PRIVATE mtotal, mfecha, mtipo, mnumero1, mnumero2
STORE 0	TO mtotal


andele = SET('DELETE')
SET DELETE OFF


SELECT pagos2
SET ORDER TO pagos1
SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

SCAN WHILE  fecha   = m.fecha   AND ;
			tipo    = m.tipo    AND ;
			numero1 = m.numero1 AND ;
			numero2 = m.numero2 

	IF !DELETED()
		** Buscamos la factura correspondiente

		SELECT ctacte1
		
		SEEK DTOS(pagos2.cfecha)+STR(pagos2.ctipo,2)+ ;
			STR(pagos2.cnumero1,4)+STR(pagos2.cnumero2,8)
		
		IF FOUND()
			DO WHILE !RLOCK()
			ENDDO
			REPLACE pagado	WITH .F.
			UNLOCK ALL
		ENDIF
	ENDIF
	
	SELECT pagos2	
	DO WHILE !RLOCK()
	ENDDO
			
	DELETE

ENDSCAN

UNLOCK ALL
	
DO act_cli WITH "B", m.fecha, pagos1.cliente, pagos1.total

SELECT pagos1

DO WHILE !RLOCK()
ENDDO

DELETE

UNLOCK ALL

SET DELETE &andele

RETURN
