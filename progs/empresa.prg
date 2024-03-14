*       *********************************************************
*       *                                                         
*       * 27/01/99             EMPRESA.PRG               19:42:47 
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
		SIZE 20.308,83.333 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   EMPRESA/Windows Código de configuración - SECCION 2   
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
c_mensaje = " "


IF USED("empresa")
	SELECT empresa
ELSE
	SELECT 0
	USE (LOCFILE("empresa.dbf", "DBF", "Buscar empresa?")) ;
		SHARED AGAIN ALIAS empresa
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

SELECT empresa
m.fichero = ALIAS()
GO BOTTOM
SCATTER MEMVAR



*       *********************************************************
*       *                                                         
*       *        EMPRESA/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 0.538,4.500 SAY "Empresa" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,192,192,192)
@ 0.385,4.833 SAY "Empresa" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT"
@ 3.077,0.000 TO 3.077,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 3.923,16.500 TO 3.923,52.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 4.000,52.500 TO 5.154,52.500 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 5.154,16.667 TO 5.154,52.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.923,16.500 TO 5.231,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.000,16.500 TO 6.000,46.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.077,46.667 TO 7.231,46.667 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 7.231,16.667 TO 7.231,46.834 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.000,16.500 TO 7.308,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.077,16.500 TO 8.077,40.833 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.154,40.833 TO 9.308,40.833 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 9.308,16.667 TO 9.308,41.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 8.077,16.500 TO 9.385,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.154,16.500 TO 10.154,32.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.231,32.667 TO 11.385,32.667 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.385,16.667 TO 11.385,32.834 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.154,16.500 TO 11.462,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 12.231,16.500 TO 12.231,23.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 12.308,23.000 TO 13.462,23.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 13.462,16.667 TO 13.462,23.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 12.231,16.500 TO 13.539,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.308,16.500 TO 14.308,35.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.385,35.000 TO 15.539,35.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 15.538,16.667 TO 15.538,35.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 14.308,16.500 TO 15.616,16.500 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 16.538,0.000 TO 16.538,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 17.538,26.500 GET m.boton2 ;
	PICTURE "@*HN \<Modificar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton2)
@ 17.538,38.333 GET m.boton7 ;
	PICTURE "@*HN Sa\<lir" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton7)
@ 4.077,4.333 SAY "Nombre:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 4.077,17.000 GET m.nombre ;
	SIZE 1.000,42.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	VALID LASTKEY() # 5 AND !EMPTY(m.nombre);
	COLOR ,RGB(0,0,0,255,255,255)
@ 6.154,4.333 SAY "Dirección:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 6.154,17.000 GET m.direccion ;
	SIZE 1.000,35.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 8.231,4.333 SAY "Localidad:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 8.231,17.000 GET m.localidad ;
	SIZE 1.000,28.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 10.308,4.333 SAY "Cuit:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 10.308,17.000 GET m.cuit ;
	SIZE 1.000,18.200 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 12.385,24.333 SAY Tipoiva.descripcio ;
	SIZE 1.000,32.600 ;
	FONT "MS Sans Serif", 8
@ 12.385,4.333 SAY "Iva:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
	
@ 12.385,17.000 GET m.iva ;
	SIZE 1.000,6.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXX" ;
	WHEN m.modificar ;
	VALID _s201693ln() ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 14.462,4.333 SAY "Teléfono:" ;
	SIZE 1.000,11.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 14.462,17.000 GET m.telefono ;
	SIZE 1.000,21.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)

IF NOT WVISIBLE("ventana")
	ACTIVATE WINDOW ventana
ENDIF

READ CYCLE MODAL;
	WHEN MUESTVEN() ;
	SHOW _s201693o9()

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
*       *           EMPRESA/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
RELEASE m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7, m.boton8, m.boton9
RELEASE m.filt_expr, m.fldnum, fldarry, m.activar, m.modificar, m.fichero
RELEASE c_topfile, c_endfile, c_delrec, c_mensaje

IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("tipoiva")
	SELECT tipoiva
	USE
ENDIF



*       *********************************************************
*       *                                                         
*       * EMPRESA/Windows Procedimientos y funciones de soporte   
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
*       * _S201693LN           m.iva VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         EMPRESA,     Record Number:   43   
*       * Variable:            m.iva                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s201693ln     &&  m.iva VALID
#REGION 1
SELECT tipoiva

SEEK m.iva

IF !FOUND()
	DO browenc WITH "descripcio :H='Tipos de Resp. Iva'",29,"descripcio"
ENDIF

STORE tipoiva.codigo	TO m.iva
@ 12.385,24.333 SAY tipoiva.descripcio ;
	SIZE 1.000,32.600, 0.000 ;
	FONT "MS Sans Serif", 8

RETURN .T.



*       *********************************************************
*       *                                                         
*       * _S201693O9           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         EMPRESA                            
*       * Called By:           READ Statement                     
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s201693o9     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: EMPRESA
*
#REGION 1
IF SYS(2016) = "VENTANA" OR SYS(2016) = "*"
	ACTIVATE WINDOW ventana SAME
	IF !EMPTY(m.iva)
		=_s201693ln()
	ELSE
		@ 12.385,24.333 SAY " " ;
			SIZE 1.000,32.600, 0.000 ;
			FONT "MS Sans Serif", 8
	ENDIF
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF