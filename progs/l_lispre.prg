*       *********************************************************
*       *                                                         
*       * 23/02/99            L_LISPRE.PRG               09:28:22 
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

IF NOT WEXIST("vsinfac") ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.PJX" ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.SCX" ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.MNX" ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.PRG" ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.FRX" ;
	OR UPPER(WTITLE("VSINFAC")) == "VSINFAC.QPR"
	DEFINE WINDOW vsinfac ;
		AT  0.000, 0.000  ;
		SIZE 11.214,81.200 ;
		TITLE "Lista de Precios" ;
		FONT "Arial", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
	MOVE WINDOW vsinfac CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *  L_LISPRE/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1
PUBLIC m.mensaje, m.lista, dlispre, mlen, m.orden

STORE ""		TO m.mensaje
STORE 1			TO m.lista
STORE 2			TO m.orden
STORE SPACE(8)	TO dlispre

PRIVATE m.setkey
STORE ""	TO m.setkey

SELECT 0
IF !USED("fijo")
	USE fijo SHARED ALIAS fijo
ELSE
	SELECT fijo
ENDIF

SELECT 0
IF !USED("empresa")
	USE empresa SHARED ALIAS empresa
ELSE
	SELECT empresa
ENDIF

SELECT 0
IF !USED("articulo")
	USE articulo SHARED ALIAS articulo ORDER articulo3
ELSE
	SELECT articulo
	SET ORDER TO articulo3
ENDIF

SELECT 0
IF !USED("rubro")
	USE rubro SHARED ALIAS rubro ORDER rubro
ELSE
	SELECT rubro
	SET ORDER TO rubro
ENDIF

SELECT 0
IF !USED("lista")
	USE lista SHARED ALIAS lista ORDER lista
ELSE
	SELECT lista
	SET ORDER TO lista
ENDIF

SELECT rubro

#REGION 1
DEFINE POPUP _s2r0kaxy9 ;
	PROMPT FIELD descripcio ;
	SCROLL

*       *********************************************************
*       *                                                         
*       *        L_LISPRE/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vsinfac")
	ACTIVATE WINDOW vsinfac SAME
ELSE
	ACTIVATE WINDOW vsinfac NOSHOW
ENDIF
@ 0.857,2.400 SAY "Lista:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 2.429,1.800 SAY "Rubros:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.857,48.800 SAY "Orden:" ;
	FONT "Arial", 8 ;
	STYLE "T"

@ 0.929,10.000 GET m.lista ;
	SIZE 1.000,3.200 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K 99" ;
	VALID _s2r0kaxz3()

@ 3.714,2.200 GET m.setkey ;
	SIZE 1.000,35.400 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXX" ;
	WHEN fhabky() ;
	VALID fdhabky()
@ 2.429,48.800 GET m.orden ;
	PICTURE "@*RVN Código;Alfabético" ;
	SIZE 1.308,12.200,0.308 ;
	DEFAULT 2 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" 
@ 5.429,1.800 GET m.rubro ;
 	PICTURE "@&N" ;
	POPUP _s2r0kaxy9 ;
	SIZE 4.571,44.000 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "" ;
	DISABLE
@ 5.500,50.400 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID SYS(1037)
*** *************************** PARA GUARDAR LA NUEVA CONFIGURACION
*** *************************** DE LA IMPRESORA EN EL REPORTE
*	VALID verepo() 
@ 8.071,50.400 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID _s2r0kay0r()

IF NOT WVISIBLE("vsinfac")
	ACTIVATE WINDOW vsinfac
ENDIF

READ CYCLE MODAL

RELEASE WINDOW vsinfac
RELEASE POPUPS _s2r0kaxy9

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
*       *           L_LISPRE/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 1
IF USED("fijo")
	SELECT fijo
	USE
ENDIF

IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("articulo")
	SELECT articulo
	USE
ENDIF

IF USED("rubro")
	SELECT rubro
	USE
ENDIF

IF USED("lista")
	SELECT lista
	USE
ENDIF
RELEASE m.mensaje, m.lista, dlispre, mlen, m.orden

RETURN




*       *********************************************************
*       *                                                         
*       * L_LISPRE/Windows Procedimientos y funciones de soporte  
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE fhabky
	ON KEY LABEL F1 DO nada
	ON KEY LABEL F2 DO nada
	ON KEY LABEL F3 DO nada
	ON KEY LABEL F4 DO nada
	ON KEY LABEL F5 DO nada
	ON KEY LABEL F6 DO nada
	ON KEY LABEL F7 DO nada
	ON KEY LABEL F8 DO nada
	ON KEY LABEL F9 DO nada
	ON KEY LABEL F10 DO nada
	ON KEY LABEL F11 DO nada
	ON KEY LABEL F12 DO nada
	ON KEY LABEL ESC DO fcancela
	ON KEY LABEL BACKSPACE DO ffiltro
	FOR i=32 TO 90
		ON KEY LABEL CHR(i) DO ffiltro
	ENDFOR
RETURN

PROCEDURE fdhabky
	ON KEY LABEL F1
	ON KEY LABEL F2
	ON KEY LABEL F3
	ON KEY LABEL F4
	ON KEY LABEL F5
	ON KEY LABEL F6
	ON KEY LABEL F7
	ON KEY LABEL F8
	ON KEY LABEL F9
	ON KEY LABEL F10
	ON KEY LABEL F11
	ON KEY LABEL F12
	ON KEY LABEL ESC
	ON KEY LABEL BACKSPACE
	FOR i=32 TO 90
		ON KEY LABEL CHR(i)
	ENDFOR
RETURN

PROCEDURE ffiltro
	IF EMPTY(m.setkey) OR LASTKEY()=127
		STORE ""	TO m.setkey
	ENDIF
	IF LASTKEY()#127
		m.setkey = m.setkey+CHR(LASTKEY())
	ENDIF
	SHOW GET m.setkey
	SELECT rubro
	IF !EMPTY(m.setkey)
		mlen = LEN(TRIM(m.setkey))
		SET FILTER TO UPPER(TRIM(m.setkey))=UPPER(SUBSTR(descripcio,1,mlen))
	ELSE
		SET FILTER TO 
	ENDIF
	SHOW GET m.rubro
RETURN

PROCEDURE fcancela
	DO fdhabky
	CLEAR READ
RETURN

PROCEDURE nada
RETURN

PROCEDURE g_lispre
	
	IF USED(dlispre)	
		SELECT (dlispre)
		USE
	ENDIF
	
	STORE "_D"+RIGHT(SYS(3),6)	TO dlispre
	
	SELECT 0
	CREATE CURSOR (dlispre) (rubro C(3), articulo C(4), des_rubro C(15), ;
					descripcio C(30), unitario1 N(12,4), unitario2 N(12,4), ;
					por_ivai N(8,4), por_ivani N(8,4), medida C(7))
					
	INDEX ON rubro+articulo       TAG rubro OF (dlispre)
	INDEX ON des_rubro+descripcio TAG rubro1 OF (dlispre)


	SELECT rubro
	GO TOP
	annear = SET('NEAR')
	SET NEAR ON

	SCAN

		SELECT articulo
		SEEK rubro.rubro
		SCAN WHILE articulo.rubro = rubro.rubro			
			SELECT (dlispre)
			APPEND BLANK
			REPLACE rubro 	    WITH rubro.rubro        ,;
					des_rubro	WITH rubro.descripcio   ,;
					articulo	WITH articulo.articulo  ,;
					descripcio	WITH articulo.descripcio,;
					medida		WITH articulo.medida
				
				IF m.lista = 1
					REPLACE unitario1	WITH articulo.unitario
					REPLACE unitario2	WITH articulo.unitario2
				ELSE
					REPLACE unitario1 	WITH articulo.unitario + ROUND(articulo.unitario * lista.contado/100,2)
					REPLACE unitario2	WITH articulo.unitario2 + ROUND(articulo.unitario2 * lista.ctacte/100,2)
				ENDIF
				
				ptotal = unitario1
				ppor = fijo.ivari / 100

				IF articulo.fijo ='$'
					ptotal = ptotal - articulo.interno
				ELSE
					ppor = ppor + (articulo.interno / 100)
				ENDIF
				
				pneto = ptotal / (1 + ppor)
				piva  = pneto * (fijo.ivari / 100)
				
				REPLACE por_ivai WITH ROUND((piva * 100) / unitario1,2)
				
			SELECT articulo
		ENDSCAN
					
		SELECT rubro
	ENDSCAN
	SET NEAR &annear

RETURN

PROCEDURE i_lispre
	SELECT (dlispre)
	
	IF m.orden = 1
		SET ORDER TO rubro
		REPOR FORM lispre TO PRINT NOCONSOLE
	ELSE
		SET ORDER TO rubro1
		REPOR FORM lispre1 TO PRINT NOCONSOLE
	ENDIF
	
	SET RELATION TO
	
RETURN




*       *********************************************************
*       *                                                         
*       * _S2R0KAXZ3           m.lista VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_LISPRE,     Record Number:    4  
*       * Variable:            m.lista                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2r0kaxz3     &&  m.lista VALID
#REGION 1
IF LASTKEY() = 5
	RETURN .T.
ENDIF

SELECT lista

COUNT TO creg FOR !DELETED()

IF creg > 0 AND m.lista # 1
	SEEK STR(m.lista,2)
	
	IF !FOUND()
		DO browenc WITH "descripcio :H='Listas'",29,"descripcio"
	ENDIF
	STORE lista.numero		TO m.lista
	STORE lista.descripcio	TO m.mensaje
ELSE
	STORE 1	TO m.lista
	STORE "Lista Nro. 1"	TO m.mensaje
ENDIF
@ 0.929,14.400 SAY m.mensaje ;
	SIZE 1.000,30.800 ;
	FONT "Arial", 8



*       *********************************************************
*       *                                                         
*       * _S2R0KAY0R           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_LISPRE,     Record Number:    9  
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2r0kay0r     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	DO g_lispre
	DO i_lispre
ELSE
	WAIT 'Impresora No activa ' WINDOW NOWAIT
ENDIF
RETURN .T.

PROCEDURE verepo
DEFINE WINDOW vreporte FROM 00,00 TO 01,01

ACTIVATE WINDOW vreporte NOSHOW

IF m.orden = 1
	MODI REPOR lispre IN WINDOW vreporte NOWAIT NOENVIRONMENT
ELSE
	MODI REPOR lispre1 IN WINDOW vreporte NOWAIT NOENVIRONMENT
ENDIF
=SYS(1037)
KEYBOARD CHR(23)
RELEASE WINDOW vreporte
CLEAR TYPEAHEAD
