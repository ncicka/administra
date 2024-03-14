*       *********************************************************
*       *                                                         
*       * 20/01/99            provedor.PRG               20:58:35 
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
		SIZE 24.462,83.333 ;
		FONT "MS Sans Serif", 8 ;
		STYLE "B" ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *  provedor/Windows Código de configuración - SECCION 2   
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
DIMENSION fldarry(3,4)
fldarry(1,1) = "PROVEEDOR"
fldarry(1,2) = "PROVEEDOR"
fldarry(1,3) = "PROVEDOR1"
fldarry(1,4) = 4
fldarry(2,1) = "NOMBRE"
fldarry(2,2) = "NOMBRE"
fldarry(2,3) = "PROVEDOR2"
fldarry(2,4) = 0
fldarry(3,1) = "CUIT"
fldarry(3,2) = "CUIT"
fldarry(3,3) = "PROVEDOR3"
fldarry(3,4) = 13

m.filt_expr = SPACE(27)
m.fldnum = 1

c_topfile = "Principio de archivo"
c_endfile = "Fin de archivo"
c_delrec  = "¿Eliminar el registro seleccionado?"
c_mensaje = "Primero debe borrar los presupuestos de este Motor"


IF USED("provedor")
	SELECT provedor
	SET ORDER TO provedor1
ELSE
	SELECT 0
	USE (LOCFILE("provedor.dbf", "DBF", "Buscar provedor?")) ;
		SHARED AGAIN ALIAS provedor ;
		ORDER provedor1
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

SELECT provedor
m.fichero = ALIAS()
GO BOTTOM
SCATTER MEMVAR



*       *********************************************************
*       *                                                         
*       *        provedor/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 0.538,4.500 SAY "Proveedor" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT" ;
	COLOR RGB(128,128,128,128,128,128)
@ 0.385,4.667 SAY "proveedor" ;
	FONT "MS Sans Serif", 14 ;
	STYLE "BT"
@ 3.077,0.000 TO 3.077,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 3.923,18.000 TO 3.923,26.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 4.000,26.333 TO 5.154,26.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 5.154,18.167 TO 5.154,26.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 3.923,18.000 TO 5.231,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.000,18.000 TO 6.000,77.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 6.077,77.333 TO 7.231,77.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 7.231,18.167 TO 7.231,77.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 6.000,18.000 TO 7.308,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.077,18.000 TO 8.077,32.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 8.154,32.333 TO 9.308,32.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 9.308,18.167 TO 9.308,32.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 8.077,18.000 TO 9.385,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.154,18.000 TO 10.154,48.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 10.231,48.167 TO 11.385,48.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 11.385,18.167 TO 11.385,48.334 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 10.154,18.000 TO 11.462,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 12.231,18.000 TO 12.231,42.333 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 12.308,42.333 TO 13.462,42.333 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 13.462,18.167 TO 13.462,42.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 12.231,18.000 TO 13.539,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.308,18.000 TO 14.308,24.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 14.385,24.500 TO 15.539,24.500 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 15.538,18.167 TO 15.538,24.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 14.308,18.000 TO 15.616,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 16.385,18.000 TO 16.385,34.167 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 16.462,34.167 TO 17.616,34.167 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 17.615,18.167 TO 17.615,34.334 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 16.385,18.000 TO 17.693,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 18.462,18.000 TO 18.462,36.500 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 18.538,36.500 TO 19.692,36.500 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 19.692,18.167 TO 19.692,36.667 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 18.462,18.000 TO 19.770,18.000 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)
@ 20.692,0.000 TO 20.692,83.333 ;
	PEN 1, 8 ;
	STYLE "1"
@ 18.538,43.667 SAY "Crédito Máximo:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 18.615,58.333 GET m.credito ;
	SIZE 1.000,15.800 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@KZ 999,999.99" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR m.credito >= 0 ;
	COLOR ,RGB(,,,255,255,255)
@ 18.462,57.833 TO 18.462,72.166 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(128,128,128,128,128,128)
@ 18.462,72.000 TO 19.616,72.000 ;
	PEN 1, 8 ;
	COLOR RGB(255,255,255,255,255,255)
@ 19.692,57.833 TO 19.692,72.166 ;
	PEN 1, 8 ;
	STYLE "1" ;
	COLOR RGB(255,255,255,255,255,255)
@ 18.462,57.833 TO 19.770,57.833 ;
	PEN 1, 8 ;
	COLOR RGB(128,128,128,128,128,128)


@ 21.692,2.000 GET m.boton1 ;
	PICTURE "@*HN \<Agregar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton1)
@ 21.692,13.333 GET m.boton2 ;
	PICTURE "@*HN \<Modificar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton2)
@ 21.692,24.667 GET m.boton3 ;
	PICTURE "@*HN \<Eliminar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton3)
@ 21.692,36.000 GET m.boton4 ;
	PICTURE "@*HN An\<terior" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton4)
@ 21.692,47.333 GET m.boton5 ;
	PICTURE "@*HN \<Siguiente" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton5)
@ 21.692,58.667 GET m.boton6 ;
	PICTURE "@*HN \<Buscar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton6)
@ 21.692,69.833 GET m.boton7 ;
	PICTURE "@*HN Sa\<lir" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.boton7)
@ 4.077,4.333 SAY "Proveedor:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 4.077,18.500 GET m.proveedor ;
	SIZE 1.000,8.800 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXX" ;
	WHEN m.activar  AND m.modificar ;
	VALID _s1t18ykkv() ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 6.154,4.333 SAY "Nombre:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 6.154,18.500 GET m.nombre ;
	SIZE 1.000,70.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	VALID !EMPTY(m.nombre) ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 8.231,4.333 SAY "Documento:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 8.231,18.500 GET m.documento ;
	SIZE 1.000,16.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 9999999999" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 10.308,4.333 SAY "Dirección:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 10.308,18.500 GET m.direccion ;
	SIZE 1.000,35.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 12.385,4.333 SAY "Localidad:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 12.385,18.500 GET m.localidad ;
	SIZE 1.000,28.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXX" ;
	WHEN m.modificar ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 14.462,4.333 SAY "Iva:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 14.462,18.500 GET m.iva ;
	SIZE 1.000,6.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K XXX" ;
	WHEN m.modificar ;
	VALID _s1t18ykno() ;
	COLOR ,RGB(0,0,0,255,255,255)

@ 16.538,4.333 SAY "Cuit:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 16.538,18.500 GET m.cuit ;
	SIZE 1.000,18.200 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	PICTURE "@K 99-99999999-9" ;
	WHEN m.modificar ;
	VALID LASTKEY() = 5 OR fcuit() ;
	COLOR ,RGB(0,0,0,255,255,255)
@ 18.615,4.333 SAY "Teléfono:" ;
	SIZE 1.000,13.600 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	PICTURE "@J" ;
	COLOR RGB(,,,255,255,255)
@ 18.615,18.500 GET m.telefono ;
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
	SHOW _s1t18ykpp()

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
*       *           provedor/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 1
RELEASE m.boton1, m.boton2, m.boton3, m.boton4, m.boton5, m.boton6, m.boton7, m.boton8, m.boton9
RELEASE m.filt_expr, m.fldnum, fldarry, m.activar, m.modificar, m.fichero
RELEASE c_topfile, c_endfile, c_delrec, c_mensaje

IF USED("provedor")
	SELECT provedor
	USE
ENDIF

IF USED("tipoiva")
	SELECT tipoiva
	USE
ENDIF



*       *********************************************************
*       *                                                         
*       * provedor/Windows Procedimientos y funciones de soporte  
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
				DO ultimo
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
*       * _S1T18YKKV           m.proveedor VALID                    
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         provedor,     Record Number:   46  
*       * Variable:            m.proveedor                          
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s1t18ykkv     &&  m.proveedor VALID
#REGION 1

IF EMPTY(m.proveedor)
	RETURN .F.
ENDIF

SELECT 	provedor
anreg = RECNO()
anord = ORDER()

SET ORDER TO provedor1

SEEK m.proveedor

IF FOUND()
	STORE .F.  	TO mreturn
ELSE
	STORE .T.	TO mreturn
ENDIF

IF anreg <= RECCOUNT()
	GO anreg
ENDIF

SET ORDER TO &anord

RETURN mreturn


*       *********************************************************
*       *                                                         
*       * _S1T18YKNO           m.iva VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         provedor,     Record Number:   56  
*       * Variable:            m.iva                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s1t18ykno     &&  m.iva VALID
#REGION 1
SELECT tipoiva

SEEK m.iva

IF !FOUND()
	SEEK 'RI'
	DO browenc WITH "descripcio :H='Tipos de Resp. Iva'",29,"descripcio"
ENDIF

STORE tipoiva.codigo	TO m.iva
@ 14.462,25.667 SAY Tipoiva.descripcio ;
	SIZE 1.000,32.600 ;
	FONT "MS Sans Serif", 8


RETURN .T.

*       *********************************************************
*       *                                                         
*       * _S1T18YKPP           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         provedor                           
*       * Called By:           READ Statement                     
*       * Snippet Number:      3                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s1t18ykpp     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: provedor
*
#REGION 1
IF SYS(2016) = "VENTANA" OR SYS(2016) = "*"
	ACTIVATE WINDOW ventana SAME
	IF !EMPTY(m.iva)
		=_s1t18ykno() 
	ELSE
		@ 14.462,25.667 SAY "                    " ;
			SIZE 1.000,32.600 ;
			FONT "MS Sans Serif", 8
	ENDIF
	
ENDIF

SELECT (m.fichero)

IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF

PROCEDURE ultimo
SELECT provedor
antor=ORDER()
antreg=RECNO()
SET ORDER TO provedor4
GO BOTTOM
STORE ALLTRIM(STR(VAL(proveedor)+1,4))	TO m.proveedor
SET ORDER TO &antor
IF antreg <= RECCOUNT()
	GO antreg
ENDIF
RETURN

FUNCTION fcuit
SELECT provedor
antor=ORDER()
antreg=RECNO()
SET ORDER TO provedor3
SEEK m.cuit
IF FOUND() AND proveedor # m.proveedor
	DO MENSAJE WITH "YA EXISTE EL CUIT EN OTRO PROVEEDOR"
ENDIF
SET ORDER TO &antor
IF antreg <= RECCOUNT()
	GO antreg
ENDIF
RETURN .T.
