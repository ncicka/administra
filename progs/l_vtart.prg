*       *********************************************************
*       *                                                         
*       * 13/07/2005            L_VTART.SPR              11:22:58 
*       *                                                         
*       *********************************************************
*       *                                                         
*       * Nombre del autor                                        
*       *                                                         
*       * Copyright (c) 2005 Nombre de la empresa                 
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

IF NOT WEXIST("vtartic") ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.PJX" ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.SCX" ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.MNX" ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.PRG" ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.FRX" ;
	OR UPPER(WTITLE("VTARTIC")) == "VTARTIC.QPR"
	DEFINE WINDOW vtartic ;
		AT  0.000, 0.000  ;
		SIZE 12.071,107.200 ;
		TITLE "Ventas por Artículo" ;
		FONT "Arial", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM
	MOVE WINDOW vtartic CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   L_VTART/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1
PRIVATE m.setkey
STORE ""	TO m.setkey
SET NEAR ON
SELECT 0
IF !USED("empresa")
	USE empresa SHARED ALIAS empresa
ELSE
	SELECT empresa
ENDIF

SELECT 0
IF !USED("clientes")
	USE clientes SHARED ALIAS clientes ORDER clientes2
ELSE
	SELECT clientes
	SET ORDER TO clientes2
ENDIF

SELECT 0
IF !USED("rubro")
	USE rubro SHARED ALIAS rubro ORDER rubro
ELSE
	SELECT rubro
	SET ORDER TO rubro
ENDIF

SELECT 0
IF !USED("articulo")
	USE articulo SHARED ALIAS articulo ORDER articulo1
ELSE
	SELECT articulo
	SET ORDER TO articulo1
ENDIF



#REGION 1
DEFINE POPUP _1kd0oebg1 ;
	PROMPT FIELD clientes.nombre ;
	SCROLL

*       *********************************************************
*       *                                                         
*       *        L_VTART/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vtartic")
	ACTIVATE WINDOW vtartic SAME
ELSE
	ACTIVATE WINDOW vtartic NOSHOW
ENDIF
@ 0.571,2.400 SAY "Rango de Fechas:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 3.286,1.800 SAY "Clientes:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.571,47.800 SAY "Rango de Artículos:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.786,2.800 GET m.fecdes ;
	SIZE 1.000,12.800 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE 99/99/9999" ;
	WHEN fdhabky() ;
	VALID LASTKEY()=5 OR fctrfech(m.fecdes,"m.fecdes")
@ 1.786,19.600 GET m.fechas ;
	SIZE 1.000,12.800 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE 99/99/9999" ;
	WHEN fdhabky() ;
	VALID LASTKEY()=5 OR fctrfech(m.fechas,"m.fechas") AND m.fechas>=m.fecdes
@ 1.786,48.200 GET m.rubdes ;
	SIZE 1.000,3.200 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K" ;
	WHEN fdhabky()
@ 1.786,53.000 GET m.articdes ;
	SIZE 1.000,4.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K" ;
	WHEN fdhabky() ;
	VALID LASTKEY()=5 OR fartic(m.rubdes+m.articdes)
@ 1.786,61.600 GET m.rubhas ;
	SIZE 1.000,3.200 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K" ;
	WHEN fdhabky()
@ 1.786,66.400 GET m.artichas ;
	SIZE 1.000,4.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K" ;
	WHEN fdhabky() ;
	VALID LASTKEY()=5 OR fartic(m.rubhas+m.artichas)
@ 6.214,1.800 GET m.cliente ;
 	PICTURE "@&N" ;
	POPUP _1kd0oebg1 ;
	SIZE 4.571,73.200 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "" ;
	DISABLE
@ 4.500,2.200 GET m.setkey ;
	SIZE 1.000,68.800 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN fhabky() ;
	VALID fdhabky()
@ 10.500,78.800 GET m.detmes ;
	PICTURE "@*C \<Detalle Mensual" ;
	SIZE 1.308,20.833 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT"
@ 0.857,78.800 GET m.Aceptar ;
	PICTURE "@*HN \<Aceptar" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID faceptar()
@ 3.429,78.800 GET m.cancelar ;
	PICTURE "@*HN \<Cancelar" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID fcancela()
@ 6.000,78.800 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID SYS(1037)
@ 8.571,78.800 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	WHEN fdhabky() ;
	VALID _1kd0oebg5()

IF NOT WVISIBLE("vtartic")
	ACTIVATE WINDOW vtartic
ENDIF

READ CYCLE

RELEASE WINDOW vtartic
RELEASE POPUPS _1kd0oebg1

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
*       *           L_VTART/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
	IF USED("empresa")
		SELECT empresa
		USE
	ENDIF
	
	IF USED("clientes")
		SELECT clientes
		USE
	ENDIF

	IF USED("rubro")
		SELECT rubro
		USE
	ENDIF

	IF USED("articulo")
		SELECT articulo
		USE
	ENDIF



*       *********************************************************
*       *                                                         
*       * L_VTART/Windows Procedimientos y funciones de soporte   
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
	SELECT clientes
	SET KEY TO m.setkey
	SHOW GET m.cliente
RETURN

PROCEDURE faceptar
	DO g_vtart
	HIDE WINDOW vtartic
	DO p_vtart1
	ACTIVATE WINDOW vtartic
RETURN

PROCEDURE fcancela
	DO fdhabky
	CLEAR READ
	IF USED("empresa")
		SELECT empresa
		USE
	ENDIF
	IF USED("vtart")
		SELECT vtart
		USE
	ENDIF
	IF USED("vtart2")
		SELECT vtart2
		USE
	ENDIF
RETURN

PROCEDURE fartic
PARAMETERS pclave
	SELECT articulo
	SEEK pclave
RETURN FOUND()

PROCEDURE nada
RETURN

PROCEDURE g_vtart
	
	RELEASE WINDOW vespera
	DEFINE WINDOW vespera AT 00,00 SIZE 7,50 ;
		FONT "Arial", 8 ;
		FLOAT ;
		NOCLOSE ;
		SYSTEM
		
	MOVE WINDOW vespera CENTER
	ACTIVATE WINDOW vespera
	@ 01,20 SAY "Agrupando Articulos"
	IF USED("vtart")
		SELECT vtart
		USE
	ENDIF
	STORE "_I"+RIGHT(SYS(3),6)	TO cdxvtart
	STORE "_I"+RIGHT(SYS(3),6)	TO cdxvtart2
	SELECT 0
	CREATE CURSOR vtart ( rubro C(3), articulo C(4), descripcio C(30), ;
						  medida C(5), cantidad N(12) )
	INDEX ON rubro + articulo		TAG vtart OF &cdxvtart

	SELECT 0
	CREATE CURSOR vtart2 ( rubro C(3), articulo C(4), ;
						   periodo C(6), cantidad N(12) )
	INDEX ON rubro + articulo + periodo		TAG vtart2 OF &cdxvtart2
	
	IF USED("contado1")
		SELECT contado1
		SET ORDER TO contado1
	ELSE
		SELECT 0
		USE contado1 SHARED AGAIN ALIAS contado1 ORDER contado1
	ENDIF
	
	IF USED("contado2")
		SELECT contado2
		SET ORDER TO contado2
	ELSE
		SELECT 0
		USE contado2 SHARED AGAIN ALIAS contado2 ORDER contado2
	ENDIF
	SELECT contado2
	SET RELATION TO DTOS(fecha)+STR(tipo,2)+STR(numero1,4)+STR(numero2,8);
						INTO contado1

	IF USED("ctacte1")
		SELECT ctacte1
		SET ORDER TO ctacte1
	ELSE
		SELECT 0
		USE ctacte1 SHARED AGAIN ALIAS ctacte1 ORDER ctacte1
	ENDIF
	
	IF USED("ctacte2")
		SELECT ctacte2
		SET ORDER TO ctacte2
	ELSE
		SELECT 0
		USE ctacte2 SHARED AGAIN ALIAS ctacte2 ORDER ctacte2
	ENDIF
	SELECT ctacte2
	SET RELATION TO DTOS(fecha)+STR(tipo,2)+STR(numero1,4)+STR(numero2,8);
						INTO ctacte1
	
	
	IF USED("comprob")
		SELECT comprob
		SET ORDER TO comprob
	ELSE
		SELECT 0
		USE comprob SHARED AGAIN ALIAS comprob ORDER comprob
	ENDIF
	
	STORE m.fecdes	TO m.fecha
************ RECORRO LAS BASES CONTADO Y CTACTE POR CADA FECHA	
	DO WHILE BETWEEN(m.fecha, m.fecdes, m.fechas)
		@ 03,20 SAY "Fecha: "+DTOC(m.fecha)
		SELECT contado2
		SEEK DTOS(m.fecha)+m.rubdes+m.articdes
		SCAN WHILE fecha = m.fecha AND ;
				   BETWEEN(rubro+articulo, m.rubdes+m.articdes, ;
				   						   m.rubhas+m.artichas)

			IF contado2.tipo=1 AND contado1.facturado
				LOOP
			ENDIF
			IF !EMPTY(m.setkey)
				SELECT clientes
				SEEK contado1.nombre
				IF !FOUND()
					SELECT contado2
					LOOP
				ENDIF
			ENDIF
			SELECT articulo
			SEEK contado2.rubro+contado2.articulo
			IF !FOUND()
				SELECT contado2
				LOOP
			ENDIF
			SELECT vtart
			SEEK contado2.rubro+contado2.articulo
			IF !FOUND()
				APPEND BLANK
				REPLACE rubro		WITH contado2.rubro,;
						articulo	WITH contado2.articulo,;
						descripcio	WITH articulo.descripcio,;
						medida		WITH articulo.medida
			ENDIF
			
			SELECT vtart2
			SEEK contado2.rubro+contado2.articulo+;
				 LEFT(DTOS(contado2.fecha),6)
			IF !FOUND()
				APPEND BLANK
				REPLACE rubro		WITH contado2.rubro,;
						articulo	WITH contado2.articulo,;
						periodo		WITH LEFT(DTOS(contado2.fecha),6)
			ENDIF
			IF INLIST(contado2.tipo,1,2,3,6,7)
				REPLACE cantidad	WITH cantidad + contado2.cantidad
				SELECT vtart
				REPLACE cantidad	WITH cantidad + contado2.cantidad
			ELSE
				REPLACE cantidad	WITH cantidad - contado2.cantidad
				SELECT vtart
				REPLACE cantidad	WITH cantidad - contado2.cantidad
			ENDIF
			SELECT contado2
		ENDSCAN
		IF !EOF()				&& guardo la fecha siguiente si no es eof
			IF contado2.fecha > m.fecha
				STORE contado2.fecha	TO m.fechactdo
			ELSE
				STORE m.fecha + 1		TO m.fechactdo
			ENDIF
		ELSE
			STORE ctod("31/12/9999")		TO m.fechactdo
		ENDIF
			
		SELECT ctacte2
		SEEK DTOS(m.fecha)+m.rubdes+m.articdes
		SCAN WHILE fecha = m.fecha AND ;
				   BETWEEN(rubro+articulo, m.rubdes+m.articdes, ;
				   						   m.rubhas+m.artichas)

			IF ctacte2.tipo=1 AND ctacte1.facturado
				LOOP
			ENDIF
			IF !EMPTY(m.setkey)
				SELECT clientes
				SEEK ctacte1.nombre
				IF !FOUND()
					SELECT contado2
					LOOP
				ENDIF
			ENDIF
			SELECT articulo
			SEEK ctacte2.rubro+ctacte2.articulo
			IF !FOUND()
				SELECT ctacte2
				LOOP
			ENDIF
			SELECT vtart
			SEEK ctacte2.rubro+ctacte2.articulo
			IF !FOUND()
				APPEND BLANK
				REPLACE rubro		WITH ctacte2.rubro,;
						articulo	WITH ctacte2.articulo,;
						descripcio	WITH articulo.descripcio,;
						medida		WITH articulo.medida
			ENDIF
			
			SELECT vtart2
			SEEK ctacte2.rubro+ctacte2.articulo+;
				 LEFT(DTOS(ctacte2.fecha),6)
			IF !FOUND()
				APPEND BLANK
				REPLACE rubro		WITH ctacte2.rubro,;
						articulo	WITH ctacte2.articulo,;
						periodo		WITH LEFT(DTOS(ctacte2.fecha),6)
			ENDIF
			IF INLIST(ctacte2.tipo,1,2,3,6,7)
				REPLACE cantidad	WITH cantidad + ctacte2.cantidad
				SELECT vtart
				REPLACE cantidad	WITH cantidad + ctacte2.cantidad
			ELSE
				REPLACE cantidad	WITH cantidad - ctacte2.cantidad
				SELECT vtart
				REPLACE cantidad	WITH cantidad - ctacte2.cantidad
			ENDIF
			SELECT ctacte2
		ENDSCAN
		IF !EOF()			&& guardo la fecha siguiente si no es eof
			IF ctacte2.fecha > m.fecha
				STORE ctacte2.fecha	TO m.fechaccte
			ELSE
				STORE m.fecha + 1	TO m.fechaccte
			ENDIF
		ELSE
			STORE CTOD("31/12/9999")	TO m.fechaccte
		ENDIF
**** CALCULO LA MENOR FECHA EXISTENTE PARA SEGUIR DESDE AHI ***
		IF m.fechactdo > m.fechaccte
			STORE m.fechaccte	TO m.fecha
		ELSE
			STORE m.fechactdo	TO m.fecha
		ENDIF
	ENDDO

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
	RELEASE WINDOW vespera	
RETURN

PROCEDURE p_vtart1
	SELECT vtart
	SET RELATION TO rubro+articulo INTO vtart2
	GO TOP
	DO p_vtart.prg
	SELECT vtart
	SET RELATION TO
RETURN

PROCEDURE i_vtart
	PRIVATE regant, errant, relant
	SELECT vtart
	relant=RELATION(1)
	regant=RECNO()
	SET RELATION TO
	SELECT vtart2
	SET RELATION TO rubro+articulo INTO vtart
	GO TOP
	IF m.detmes=1
		REPORT FORM l_vtart TO PRINT OFF
	ELSE
		REPORT FORM l_vtart TO PRINT OFF SUMMARY
	ENDIF
	SELECT vtart2
	SET RELATION TO
	SELECT vtart
	IF !EMPTY(relant)
		SET RELATION TO rubro+articulo INTO vtart2
	ENDIF
	errant=ON("ERROR")
	ON ERROR GO TOP
	GO regant
	ON ERROR &errant
RETURN


*       *********************************************************
*       *                                                         
*       * _1KD0OEBG5           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_VTART,     Record Number:   17   
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oebg5     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	DO g_vtart
	DO i_vtart
ELSE
	WAIT 'Impresora No activa ' WINDOW NOWAIT
ENDIF
RETURN .T.
