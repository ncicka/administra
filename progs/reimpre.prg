*       *********************************************************
*       *                                                         
*       * 20/02/99             REIMPRE.PRG               17:47:18 
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

PUBLIC fichero1, fichero2, m.fecha, m.tipo, m.numero1, m.numero2, ;
	munitario, mimpuesto, mivari, temporal

STORE SPACE(8) TO fichero1, fichero2, temporal
STORE {}		TO m.fecha
STORE 0			TO m.tipo, m.numero1, m.numero2

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

IF NOT WEXIST("_s2o124k2o")
	DEFINE WINDOW _s2o124k2o ;
		AT  0.000, 0.000  ;
		SIZE 17.154,94.000 ;
		TITLE "Reimpresión de Comprobantes" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW _s2o124k2o CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *        REIMPRE/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

IF !USED(temporal)
	SELECT 0 
	STORE STUFF(SYS(3),1,2,"_D")  TO temporal

	CREATE CURSOR (temporal) (rubro C(3) ,articulo C(4), cantidad N(9,2),;
			descripcio C(30), unitario N(11,6), total N(10,2), ;
			p_impuesto N(5,3),	t_impuesto C(1))

ENDIF


IF USED("tipoiva")
	SELECT tipoiva
	SET ORDER TO tipoiva
ELSE
	SELECT 0
	USE (LOCFILE("tipoiva.dbf", "DBF", "Buscar tipoiva?")) ;
		SHARED AGAIN ALIAS tipoiva ;
		ORDER tipoiva
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

IF USED("comprob")
	SELECT comprob
	SET ORDER TO comprob
ELSE
	SELECT 0
	USE (LOCFILE("comprob.dbf", "DBF", "Buscar comprob?")) ;
		SHARED AGAIN ALIAS comprob ;
		ORDER comprob
ENDIF

SET KEY TO RANGE STR(2,2),STR(7,2))

IF USED("fijo")
	SELECT fijo
ELSE
	SELECT 0
	USE (LOCFILE("fijo.dbf", "DBF", "Buscar fijo?")) ;
		SHARED AGAIN ALIAS fijo 
ENDIF

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

#REGION 1
IF WVISIBLE("_s2o124k2o")
	ACTIVATE WINDOW _s2o124k2o SAME
ELSE
	ACTIVATE WINDOW _s2o124k2o NOSHOW
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
@ 9.462,1.800 SAY "Total:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 8.154,1.800 SAY "Cond. Venta:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
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
	VALID _s2o124kdl() ;
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
	VALID LASTKEY() = 5 OR fnumero2()
@ 10.154,60.000 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)
@ 13.615,28.000 GET m.confirma ;
	PICTURE "@*HT \<Cancelar;\<Aceptar" ;
	SIZE 1.769,12.600,4.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8

IF NOT WVISIBLE("_s2o124k2o")
	ACTIVATE WINDOW _s2o124k2o
ENDIF

READ CYCLE MODAL

IF LASTKEY() # 27 AND m.confirma = 2

	IF USED(fichero1) AND USED(fichero2)
		SELECT (fichero1)
		SET RELATION TO iva INTO tipoiva
		SCATTER MEMVAR

		DO gen_temp
			
		SELECT (temporal)
		GO TOP
		REPORT FORM factura TO PRINT PROMPT NOCONSOLE
	
		SELECT (fichero1)
		SET RELATION TO
	ENDIF
ENDIF

RELEASE WINDOW _s2o124k2o
RELEASE fichero1, fichero2, m.fecha, m.tipo, m.numero1, m.numero2, ;
		munitario, mimpuesto, mivari

IF USED("tipoiva")
	SELECT tipoiva
	USE
ENDIF

IF USED("articulo")
	SELECT articulo
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF

IF USED("fijo")
	SELECT fijo
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

IF USED(temporal)	
	SELECT (temporal)
	USE
ENDIF

RELEASE temporal
#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF


*       *********************************************************
*       *                                                         
*       * _S2O124KDL           m.tipo VALID                       
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         REIMPRE,     Record Number:   26   
*       * Variable:            m.tipo                             
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2o124kdl     &&  m.tipo VALID
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

SELECT contado1
SET ORDER TO contado1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND() 
	STORE "contado1"	TO fichero1
	STORE "contado2"	TO fichero2

	=verdet()
	
	RETURN .T.
ENDIF

SELECT ctacte1
SET ORDER TO ctacte1

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE "ctacte1"	TO fichero1
	STORE "ctacte2"	TO fichero2

	=verdet()
	
	RETURN .T.
ENDIF

RETURN .F.


FUNCTION verdet

@ 5.615,15.200 SAY &fichero1..cliente ;
	SIZE 1.000,5.400 ;
	FONT "MS Sans Serif", 8
@ 5.615,22.000 SAY &fichero1..nombre ;
	SIZE 1.000,68.800 ;
	FONT "MS Sans Serif", 8
@ 6.923,15.200 SAY &fichero1..direccion ;
	SIZE 1.000,33.800 ;
	FONT "MS Sans Serif", 8
@ 8.231,15.200 SAY &fichero1..condicion ;
	SIZE 1.000,20.000 ;
	FONT "MS Sans Serif", 8
@ 9.538,15.200 SAY &fichero1..total ;
	SIZE 1.000,15.600 ;
	FONT "MS Sans Serif", 8

RETURN 


PROCEDURE gen_temp

SELECT (fichero2)
SET RELATION TO rubro + articulo INTO articulo

SEEK DTOS(m.fecha)+STR(m.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

SCAN WHILE fecha = m.fecha AND ;
			tipo = m.tipo AND ;
			numero1 = m.numero1 AND ;
			numero2 = m.numero2
		
		SELECT (temporal)
		APPEND BLANK
		
		REPLACE rubro 		WITH &fichero2..rubro ,;
				articulo	WITH &fichero2..articulo ,;		
				cantidad	WITH &fichero2..cantidad ,;
				descripcio	WITH &fichero2..descripcio,;
				unitario	WITH &fichero2..unitario,;
				total		WITH &fichero2..total ,;
				t_impuesto	WITH articulo.fijo,;
				p_impuesto 	WITH articulo.interno
		SELECT (fichero2)
ENDSCAN

SET RELATION TO
		
RETURN

