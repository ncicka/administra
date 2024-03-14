*       *********************************************************
*       *                                                         
*       * 27/01/99              FIJO.PRG                 18:14:16 
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

IF NOT WEXIST("ventana") ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.PJX" ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.SCX" ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.MNX" ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.PRG" ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.FRX" ;
	OR UPPER(WTITLE("VENTANA")) == "VENTANA.QPR"
	DEFINE WINDOW ventana ;
		AT  0.000, 0.000  ;
		SIZE 16.154,83.333 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *    FIJO/Windows Código de configuración - SECCION 2     
*       *                                                         
*       *********************************************************
*

#REGION 1
PUBLIC m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7
PUBLIC m.filt_expr, m.fldnum
PUBLIC m.activar, m.modificar, m.fichero, m.time
PUBLIC c_topfile, c_endfile, c_delrec, c_mensaje

STORE " " TO m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7

c_topfile = "Principio de archivo"
c_endfile = "Fin de archivo"
c_delrec  = "¿Eliminar el registro seleccionado?"
c_mensaje = "Primero debe borrar los presupuestos de este Motor"


IF USED("fijo")
	SELECT fijo
ELSE
	SELECT 0
	USE (LOCFILE("fijo.dbf", "DBF", "Buscar fijo?")) ;
		SHARED AGAIN ALIAS fijo
ENDIF

IF USED("lista")
	SELECT lista
	SET ORDER TO lista
ELSE
	SELECT 0
	USE (LOCFILE("lista.dbf", "DBF", "Buscar lista?")) ;
		SHARED AGAIN ALIAS lista ;
		ORDER lista
ENDIF

SELECT fijo
m.fichero = ALIAS()
GO BOTTOM
SCATTER MEMVAR



*       *********************************************************
*       *                                                         
*       *          FIJO/Windows Distribución de pantalla          
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 0.538,4.500 SAY "Variables Numéricas" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,192,192,192)
@ 0.385,4.833 SAY "Variables Numéricas" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT"
@ 3.077,0.000 TO 3.077,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 3.923,31.333 TO 3.923,37.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 4.000,37.333 TO 5.154,37.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 5.154,31.500 TO 5.154,37.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.923,31.333 TO 5.231,31.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.000,31.333 TO 6.000,37.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.077,37.333 TO 7.231,37.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 7.231,31.500 TO 7.231,37.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.000,31.333 TO 7.308,31.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.077,31.333 TO 8.077,37.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.154,37.333 TO 9.308,37.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 9.308,31.500 TO 9.308,37.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 8.077,31.333 TO 9.385,31.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.154,31.333 TO 10.154,34.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.231,34.333 TO 11.385,34.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.385,31.500 TO 11.385,34.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.154,31.333 TO 11.462,31.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 12.385,0.000 TO 12.385,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 13.385,24.500 GET m.boton2 ;
	PICTURE "@*HN \<Modificar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton2)
@ 13.385,36.333 GET m.boton7 ;
	PICTURE "@*HN Sa\<lir" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton7)
@ 4.077,4.500 SAY "% Iva responsable inscripto:" ;
	SIZE 1.000,29.400 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 4.077,31.833 GET m.ivari ;
	SIZE 1.000,6.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99.99" ;
	WHEN m.modificar ;
	VALID LASTKEY()  # 5 AND m.ivari >= 0 ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 6.154,2.500 SAY "% Iva responsable no inscripto:" ;
	SIZE 1.000,31.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 6.154,31.833 GET m.ivarni ;
	SIZE 1.000,6.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99.99" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR m.ivarni >= 0 ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 8.231,8.500 SAY "% Iva no categorizado:" ;
	SIZE 1.000,24.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 8.231,31.833 GET m.ivanoc ;
	SIZE 1.000,6.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99.99" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR m.ivanoc >= 0 ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 10.308,2.500 SAY "Lista de precio predeterminada:" ;
	SIZE 1.000,31.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)

IF !EMPTY(m.lista)
	=_s2013399p()
ELSE
	@ 10.308,36.333 SAY " " ;
		SIZE 1.000,49.200 ;
		FONT "MS Sans Serif", 8
ENDIF

@ 10.308,31.833 GET m.lista ;
	SIZE 1.000,2.400 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99" ;
	WHEN m.modificar ;
	VALID _s2013399p() ;
	COLOR ,RGB(0,0,0,255,255,255)

IF NOT WVISIBLE("ventana")
	ACTIVATE WINDOW ventana
ENDIF

READ CYCLE MODAL;
	WHEN MUESTVEN() ;
	SHOW _s201339b6()

RELEASE WINDOW ventana

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
*       *             FIJO/Windows Código de limpieza             
*       *                                                         
*       *********************************************************
*

#REGION 1
RELEASE m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7, m.boton8, m.boton9
RELEASE m.filt_expr, m.fldnum, fldarry, m.activar, m.modificar, m.fichero
RELEASE c_topfile, c_endfile, c_delrec, c_mensaje

IF USED("fijo")
	SELECT fijo
	USE
ENDIF

IF USED("lista")
	SELECT lista
	USE
ENDIF



*       *********************************************************
*       *                                                         
*       *   FIJO/Windows Procedimientos y funciones de soporte    
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE boton
PARAMETERS m.boton
SELECT (m.fichero)
	DO CASE
		CASE ALLTRIM(UPPER(m.boton))=="MODIFICAR"
				m.modificar=.T.
				SHOW GET m.boton2,1 DISABLE
				SHOW GET m.boton7,1 DISABLE
				
				SHOW GET m.boton2,1 PROMPT "\<Guardar"
				SHOW GET m.boton7,1 PROMPT "\<Cancelar"
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton7,1 ENABLE
				_curobj=3
				ON KEY LABEL ESCAPE DO boton WITH "CANCELAR"
				
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				SHOW GET m.boton2,1 PROMPT "\<Modificar"
				SHOW GET m.boton7,1 PROMPT "Sa\<lir"

				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton7,1 ENABLE

				m.activar=.F.
				m.modificar=.F.
				DO muestven
				_curobj=1
				ON KEY LABEL ESCAPE
								
		CASE ALLTRIM(UPPER(m.boton))=="GUARDAR"
				DO guardar
				SHOW GET m.boton2,1 PROMPT "\<Modificar"
				SHOW GET m.boton7,1 PROMPT "Sa\<lir"
				SHOW GET m.boton7,1 ENABLE
				
				m.activar=.F.
				m.modificar=.F.
				DO muestven
				_curobj=1
				ON KEY LABEL ESCAPE

		CASE ALLTRIM(UPPER(m.boton))=="SALIR"
			CLEAR READ ALL			
	ENDCASE
RETURN

PROCEDURE guardar
	SELECT (m.fichero)
	IF m.activar AND m.modificar
		INSERT INTO (ALIAS()) FROM MEMVAR
	ELSE
		DO WHILE !RLOCK()
		ENDDO
		GATHER MEMVAR
		UNLOC ALL
	ENDIF
	DO cieroabr
RETURN

PROCEDURE borrac
barea=SELECT()
SELECT (barea)
RETURN .T.

PROCEDURE loc_dlog
	PRIVATE gfields,i
	DEFINE WINDOW wzlocate FROM 1,1 TO 20,40;
		SYSTEM GROW CLOSE ZOOM FLOAT FONT "MS Sans Serif",8
	MOVE WINDOW wzlocate CENTER
	m.gfields=SET('FIELDS',2)
	IF !EMPTY(RELATION(1))
		SET FIELDS ON
		IF m.gfields # 'GLOBAL'
			SET FIELDS GLOBAL
		ENDIF
		IF EMPTY(FLDLIST())
			m.i=1
			DO WHILE !EMPTY(OBJVAR(m.i))
				IF ATC('M.',OBJVAR(m.i))=0
					SET FIELDS TO (OBJVAR(m.i))
				ENDIF
				m.i = m.i + 1
			ENDDO
		ENDIF
	ENDIF
	BROWSE WINDOW wzlocate NOEDIT NODELETE ;
		NOMENU TITLE C_BRTITLE
	SET FIELDS &gfields
	SET FIELDS OFF
	RELEASE WINDOW wzlocate
RETURN



*       *********************************************************
*       *                                                         
*       * _S2013399P           m.lista VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         FIJO,     Record Number:   32      
*       * Variable:            m.lista                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2013399p     &&  m.lista VALID
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
	STORE lista.descripcio 	TO m.descripcio
ELSE
	STORE 1	TO m.lista
	STORE 'Lista Nro. 1'		TO m.descripcio
ENDIF

@ 10.308,36.333 SAY m.descripcio ;
		SIZE 1.000,49.200 ;
		FONT "MS Sans Serif", 8

RETURN .T.

*       *********************************************************
*       *                                                         
*       * _S201339B6           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         FIJO                               
*       * Called By:           READ Statement                     
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s201339b6     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: FIJO
*
#REGION 1
IF SYS(2016) = "VENTANA" OR SYS(2016) = "*"
	ACTIVATE WINDOW ventana SAME
	IF !EMPTY(m.lista)
		=_s2013399p()
	ELSE
		@ 10.308,36.333 SAY " " ;
			SIZE 1.000,49.200 ;
			FONT "MS Sans Serif", 8
	ENDIF
ENDIF

SELECT (m.fichero)
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF