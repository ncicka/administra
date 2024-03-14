*       *********************************************************
*       *                                                         
*       * 26/01/99              RUBRO.PRG                09:53:21 
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
		SIZE 14.077,83.333 ;
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
*       *    RUBRO/Windows Código de configuración - SECCION 2    
*       *                                                         
*       *********************************************************
*

#REGION 1
PUBLIC m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7
PUBLIC m.filt_expr, m.fldnum
PUBLIC m.activar, m.modificar, m.fichero, m.time
PUBLIC c_topfile, c_endfile, c_delrec, c_mensaje
PUBLIC ARRAY fldarry(1,2)

STORE " " TO m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7
DIMENSION fldarry(1,4)
fldarry(1,1) = "RUBRO"
fldarry(1,2) = "RUBRO"
fldarry(1,3) = "RUBRO"
fldarry(1,4) = 0

m.filt_expr = SPACE(27)
m.fldnum = 1

c_topfile = "Principio de archivo"
c_endfile = "Fin de archivo"
c_delrec  = "¿Eliminar el registro seleccionado?"
c_mensaje = "Existen artículos con este Rubro"


IF USED("rubro")
	SELECT rubro
	SET ORDER TO rubro
ELSE
	SELECT 0
	USE (LOCFILE("rubro.dbf", "DBF", "Buscar rubro?")) ;
		SHARED AGAIN ALIAS rubro ;
		ORDER rubro
ENDIF


SELECT rubro
m.fichero = ALIAS()
GO BOTTOM
SCATTER MEMVAR



*       *********************************************************
*       *                                                         
*       *         RUBRO/Windows Distribución de pantalla          
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 0.538,4.500 SAY "Rubro" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.385,4.833 SAY "Rubro" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT"
@ 3.077,0.000 TO 3.077,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 4.077,4.333 SAY "Rubro:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 4.077,17.833 GET m.rubro ;
	SIZE 1.000,6.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXX" ;
	WHEN m.modificar AND m.activar ;
	VALID _s1z0l72bx() ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 3.923,17.333 TO 3.923,23.833 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 4.000,23.833 TO 5.154,23.833 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 5.154,17.500 TO 5.154,24.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.923,17.333 TO 5.231,17.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.154,4.333 SAY "Descripción:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 6.154,17.833 GET m.descripcio ;
	SIZE 1.000,21.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR !EMPTY(m.descripcio) ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 6.000,17.333 TO 6.000,35.833 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.077,35.833 TO 7.231,35.833 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 7.231,17.500 TO 7.231,36.000 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.000,17.333 TO 7.308,17.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.231,4.333 SAY "Medida:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 8.231,17.833 GET m.medida ;
	SIZE 1.000,11.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 8.077,17.333 TO 8.077,27.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.154,27.500 TO 9.308,27.500 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 9.308,17.500 TO 9.308,27.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 8.077,17.333 TO 9.385,17.333 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.308,0.000 TO 10.308,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 11.231,2.333 GET m.boton1 ;
	PICTURE "@*HN \<Agregar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton1)
@ 11.231,13.667 GET m.boton2 ;
	PICTURE "@*HN \<Modificar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton2)
@ 11.231,25.000 GET m.boton3 ;
	PICTURE "@*HN \<Eliminar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton3)
@ 11.231,36.333 GET m.boton4 ;
	PICTURE "@*HN An\<terior" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton4)
@ 11.231,47.667 GET m.boton5 ;
	PICTURE "@*HN \<Siguiente" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton5)
@ 11.231,59.000 GET m.boton6 ;
	PICTURE "@*HN \<Buscar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton6)
@ 11.231,70.167 GET m.boton7 ;
	PICTURE "@*HN Sa\<lir" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton7)

IF NOT WVISIBLE("ventana")
	ACTIVATE WINDOW ventana
ENDIF

READ CYCLE MODAL;
	WHEN MUESTVEN()

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
*       *            RUBRO/Windows Código de limpieza             
*       *                                                         
*       *********************************************************
*

#REGION 1
RELEASE m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7, m.boton8, m.boton9
RELEASE m.filt_expr, m.fldnum, fldarry, m.activar, m.modificar, m.fichero
RELEASE c_topfile, c_endfile, c_delrec, c_mensaje

IF USED("rubro")
	SELECT rubro
	USE
ENDIF



*       *********************************************************
*       *                                                         
*       *  RUBRO/Windows Procedimientos y funciones de soporte    
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE boton
PARAMETERS m.boton
SELECT (m.fichero)
	DO CASE
		CASE ALLTRIM(UPPER(m.boton))=="AGREGAR"
				m.activar=.T.
				m.modificar=.T.
				SHOW GET m.boton1,1 DISABLE
				SHOW GET m.boton2,1 DISABLE
				SHOW GET m.boton3,1 DISABLE
				SHOW GET m.boton4,1 DISABLE
				SHOW GET m.boton5,1 DISABLE
				SHOW GET m.boton6,1 DISABLE
				SHOW GET m.boton7,1 DISABLE
				
				SHOW GET m.boton2,1 PROMPT "\<Guardar"
				SHOW GET m.boton3,1 PROMPT "\<Cancelar"
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton3,1 ENABLE
				DO clearven
				_curobj=8
				ON KEY LABEL ESCAPE DO boton WITH "CANCELAR"
								
		CASE ALLTRIM(UPPER(m.boton))=="MODIFICAR"
				m.modificar=.T.
				SHOW GET m.boton1,1 DISABLE
				SHOW GET m.boton2,1 DISABLE
				SHOW GET m.boton3,1 DISABLE
				SHOW GET m.boton4,1 DISABLE
				SHOW GET m.boton5,1 DISABLE
				SHOW GET m.boton6,1 DISABLE
				SHOW GET m.boton7,1 DISABLE
				
				SHOW GET m.boton2,1 PROMPT "\<Guardar"
				SHOW GET m.boton3,1 PROMPT "\<Cancelar"
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton3,1 ENABLE
				_curobj=8
				ON KEY LABEL ESCAPE DO boton WITH "CANCELAR"
								
		CASE ALLTRIM(UPPER(m.boton))=="ELIMINAR"
				DO eliminar
				_curobj=4
				
				
		CASE ALLTRIM(UPPER(m.boton))=="BUSCAR"
				DO buscando
				_curobj=5
				
		CASE ALLTRIM(UPPER(m.boton))=="ANTERIOR"
				IF !BOF()
					SKIP -1
			 	ENDIF
			 	IF BOF()
					WAIT WINDOW C_TOPFILE NOWAIT
					GO TOP
				ENDIF
				SCATTER MEMVAR MEMO
				SHOW GETS
			
		CASE ALLTRIM(UPPER(m.boton))=="SIGUIENTE"
				IF !EOF()
					SKIP 1
				ENDIF
				IF EOF()
					WAIT WINDOW C_ENDFILE NOWAIT
					GO BOTTOM
				ENDIF
				SCATTER MEMVAR MEMO
				SHOW GETS
				
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				SHOW GET m.boton2,1 PROMPT "\<Modificar"
				SHOW GET m.boton3,1 PROMPT "\<Eliminar"

				SHOW GET m.boton1,1 ENABLE
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton3,1 ENABLE
				SHOW GET m.boton4,1 ENABLE
				SHOW GET m.boton5,1 ENABLE
				SHOW GET m.boton6,1 ENABLE
				SHOW GET m.boton7,1 ENABLE

				m.activar=.F.
				m.modificar=.F.
				DO muestven
				_curobj=1
				ON KEY LABEL ESCAPE
								
		CASE ALLTRIM(UPPER(m.boton))=="GUARDAR"
				DO guardar
				SHOW GET m.boton2,1 PROMPT "\<Modificar"
				SHOW GET m.boton3,1 PROMPT "\<Eliminar"
				SHOW GET m.boton1,1 ENABLE
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton3,1 ENABLE
				SHOW GET m.boton4,1 ENABLE
				SHOW GET m.boton5,1 ENABLE
				SHOW GET m.boton6,1 ENABLE
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
PRIVATE musado, mretorno
STORE .T.	TO mretorno
barea=SELECT()

IF USED("articulo")
	SELECT articulo
	SET ORDER TO articulo1
	STORE .T.	TO musado
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo ;
		ORDER articulo1
	STORE .F.	TO musado
ENDIF

SELECT articulo
annear = SET('NEAR')
SET NEAR ON

SEEK m.rubro

IF articulo.rubro = m.rubro
	STORE .F.	TO mretorno
ENDIF

IF !musado
	SELECT articulo
	USE
ENDIF

SELECT (barea)
RETURN mretorno

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
*       * _S1Z0L72BX           m.rubro VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         RUBRO,     Record Number:    7     
*       * Variable:            m.rubro                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s1z0l72bx     &&  m.rubro VALID
#REGION 1
PRIVATE mretorno
STORE .F. TO mretorno

IF EMPTY(m.rubro)
	RETURN mretorno
ENDIF

anreg = RECNO()

SELECT rubro
SEEK m.rubro

IF !FOUND()
	STORE .T. TO mretorno
ELSE
	STORE .F. TO mretorno
ENDIF

IF anreg <= RECCOUNT()
	GO anreg
ENDIF

RETURN mretorno