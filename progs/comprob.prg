*       *********************************************************
*       *                                                         
*       * 27/01/99             COMPROB.PRG               10:41:25 
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
		SIZE 20.231,83.667 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		FLOAT ;
		CLOSE ;
		MINIMIZE ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   COMPROB/Windows Código de configuración - SECCION 2   
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
fldarry(1,1) = "NUMERO"
fldarry(1,2) = "TIPO"
fldarry(1,3) = "COMPROB"
fldarry(1,4) = 2

m.filt_expr = SPACE(27)
m.fldnum = 1

c_topfile = "Principio de archivo"
c_endfile = "Fin de archivo"
c_delrec  = "¿Eliminar el registro seleccionado?"
c_mensaje = "Primero debe borrar los presupuestos de este Motor"


IF USED("comprob")
	SELECT comprob
	SET ORDER TO comprob
ELSE
	SELECT 0
	USE (LOCFILE("comprob.dbf", "DBF", "Buscar comprob?")) ;
		SHARED AGAIN ALIAS comprob ;
		ORDER comprob
ENDIF


SELECT comprob
m.fichero = ALIAS()
GO BOTTOM
SCATTER MEMVAR



*       *********************************************************
*       *                                                         
*       *        COMPROB/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 0.538,4.500 SAY "Comprobantes" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,192,192,192)
@ 0.385,4.833 SAY "Comprobantes" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT"
@ 3.077,0.000 TO 3.077,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 3.923,21.167 TO 3.923,24.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 4.000,24.167 TO 5.154,24.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 5.154,21.333 TO 5.154,24.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.923,21.167 TO 5.231,21.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.000,21.167 TO 6.000,39.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.077,39.667 TO 7.231,39.667 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 7.231,21.333 TO 7.231,39.833 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.000,21.167 TO 7.308,21.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.077,21.167 TO 8.077,31.334 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.154,31.333 TO 9.308,31.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 9.308,21.333 TO 9.308,31.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 8.077,21.167 TO 9.385,21.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.154,21.167 TO 10.154,27.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.231,27.167 TO 11.385,27.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.385,21.333 TO 11.385,27.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.154,21.167 TO 11.462,21.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.154,29.167 TO 10.154,40.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.231,40.167 TO 11.385,40.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.385,29.333 TO 11.385,40.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.154,29.167 TO 11.462,29.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.385,21.167 TO 14.385,29.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.462,29.500 TO 15.616,29.500 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 15.615,21.333 TO 15.615,29.666 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 14.385,21.167 TO 15.693,21.167 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 16.769,0.000 TO 16.769,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 17.692,12.333 GET m.boton2 ;
	PICTURE "@*HN \<Modificar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton2)
@ 17.692,23.667 GET m.boton4 ;
	PICTURE "@*HN An\<terior" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton4)
@ 17.692,35.000 GET m.boton5 ;
	PICTURE "@*HN \<Siguiente" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton5)
@ 17.692,46.333 GET m.boton6 ;
	PICTURE "@*HN \<Buscar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton6)
@ 17.692,57.500 GET m.boton7 ;
	PICTURE "@*HN Sa\<lir" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton7)
@ 4.077,8.167 SAY "Número:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 4.077,21.667 GET m.tipo ;
	SIZE 1.000,2.400 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99" ;
	WHEN .f. ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 6.154,8.167 SAY "Descripción:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 6.154,21.667 GET m.descripcio ;
	SIZE 1.000,21.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXX" ;
	WHEN .f. ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 8.231,8.167 SAY "Código:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 8.231,21.667 GET m.codigo ;
	SIZE 1.000,11.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXX" ;
	WHEN m.modificar ;
	VALID LASTKEY() # 5 AND !EMPTY(m.codigo) ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 10.308,4.333 SAY "Ultimo número:" ;
	SIZE 1.000,17.400 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 10.308,21.667 GET m.numero1 ;
	SIZE 1.000,6.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 9,999" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR m.numero1 >= 0 ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 10.308,29.667 GET m.numero2 ;
	SIZE 1.000,12.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99,999,999" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR m.numero2 >= 0 ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 12.462,8.167 SAY "Imprime:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 12.308,21.333 GET m.imprime ;
	PICTURE "@*C  " ;
	SIZE 1.308,5.400 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	WHEN m.modificar ;
	VALID _s200mwwdl() ;
	COLOR ,,,,,,,,RGB(0,0,0,255,255,255),RGB(0,0,0,255,255,255)
@ 14.538,8.167 SAY "Impresora:" ;
	SIZE 1.000,12.800 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 14.538,21.667 GET m.impresora ;
	SIZE 1.000,8.800 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@M LPT1, LPT2, LPT3, LPT4" ;
	WHEN m.modificar AND m.imprime ;
	COLOR ,RGB(0,0,0,255,255,255)

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
*       *           COMPROB/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
RELEASE m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7, m.boton8, m.boton9
RELEASE m.filt_expr, m.fldnum, fldarry, m.activar, m.modificar, m.fichero
RELEASE c_topfile, c_endfile, c_delrec, c_mensaje

IF USED("comprob")
	SELECT comprob
	USE
ENDIF



*       *********************************************************
*       *                                                         
*       * COMPROB/Windows Procedimientos y funciones de soporte   
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
				SHOW GET m.boton2,1 DISABLE
				SHOW GET m.boton4,1 DISABLE
				SHOW GET m.boton5,1 DISABLE
				SHOW GET m.boton6,1 DISABLE
				SHOW GET m.boton7,1 DISABLE
				
				SHOW GET m.boton2,1 PROMPT "\<Guardar"
				SHOW GET m.boton4,1 PROMPT "\<Cancelar"
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton4,1 ENABLE
				DO clearven
				_curobj=6
				ON KEY LABEL ESCAPE DO boton WITH "CANCELAR"
								
		CASE ALLTRIM(UPPER(m.boton))=="MODIFICAR"
				m.modificar=.T.
				SHOW GET m.boton2,1 DISABLE
				SHOW GET m.boton4,1 DISABLE
				SHOW GET m.boton5,1 DISABLE
				SHOW GET m.boton6,1 DISABLE
				SHOW GET m.boton7,1 DISABLE
				
				SHOW GET m.boton2,1 PROMPT "\<Guardar"
				SHOW GET m.boton4,1 PROMPT "\<Cancelar"
				SHOW GET m.boton2,1 ENABLE
				SHOW GET m.boton4,1 ENABLE
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
				SHOW GET m.boton4,1 PROMPT "An\<terior"

				SHOW GET m.boton2,1 ENABLE
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
				SHOW GET m.boton4,1 PROMPT "An\<terior"
				SHOW GET m.boton2,1 ENABLE
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
*       * _S200MWWDL           m.imprime VALID                    
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         COMPROB,     Record Number:   46   
*       * Variable:            m.imprime                          
*       * Called By:           VALID Clause                       
*       * Object Type:         Check Box                          
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s200mwwdl     &&  m.imprime VALID
#REGION 1
IF !m.imprime
	STORE '    ' TO m.impresora
	SHOW GET m.impresora
ENDIF