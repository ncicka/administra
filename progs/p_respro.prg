*       *********************************************************
*       *                                                         
*       * 13/07/2005           P_RESPRO.SPR              11:23:01 
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

IF NOT WEXIST("g_respro") ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.PJX" ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.SCX" ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.MNX" ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.PRG" ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.FRX" ;
	OR UPPER(WTITLE("G_RESPRO")) == "G_RESPRO.QPR"
	DEFINE WINDOW g_respro ;
		AT 0.000, 0.000 ;
		SIZE 7.313,102.833 ;
		TITLE "Resúmen de Cuentas de Proveedores" ;
		FONT "Arial", 10 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF

IF NOT WEXIST("vbrowsec") ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.PJX" ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.SCX" ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.MNX" ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.PRG" ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.FRX" ;
	OR UPPER(WTITLE("VBROWSEC")) == "VBROWSEC.QPR"
	DEFINE WINDOW vbrowsec ;
		AT 11.000, 0.000 ;
		SIZE 14.286,123.400 ;
		TITLE "Movimientos" ;
		FONT "Arial", 8 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF


*       *********************************************************
*       *                                                         
*       *  VBROWSEC/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 2
	ACTIVATE WINDOW vbrowsec SAME
	SELECT respro
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vbrowsec ;
		FIELDS fecha    :H="Fecha " :15,;
			   tipocomp :H="Cmpte" ,;
			   numero1  :H="" :P="@ 9999",;
			   numero2	:H="Número" :P="@ 99999999",;
			   detalle /33,;
			   debe		:P="@Z 99999,999.99",;
			   haber	:P="@Z 99999,999.99",;
			   saldo	:P="@Z 99999,999.99" ;
		FREEZE fecha
	SELECT provedor


*       *********************************************************
*       *                                                         
*       *        P_RESPRO/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("g_respro")
	ACTIVATE WINDOW g_respro SAME
ELSE
	ACTIVATE WINDOW g_respro NOSHOW
ENDIF
@ 0.125,2.000 SAY "Cuenta:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.125,13.000 SAY "Dirección:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.125,77.500 SAY "Teléfono:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.125,48.000 SAY "Localidad:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.188,2.333 GET provedor.proveedor ;
	SIZE 1.000,5.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,13.333 GET Provedor.direccion ;
	SIZE 1.000,40.800 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,48.333 GET provedor.localidad ;
	SIZE 1.000,32.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,77.833 GET provedor.telefono ;
	SIZE 1.000,24.000 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 2.250,2.333 GET provedor.nombre ;
	SIZE 0.957,63.667 ;
	DEFAULT " " ;
	FONT "Arial", 14 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 5.500,2.333 GET m.sig ;
	PICTURE "@*HN \<Siguiente" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !EOF("provedor") ;
	VALID _1kd0oed4x()
@ 5.500,27.667 GET m.ant ;
	PICTURE "@*HN \<Anterior" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("provedor") ;
	VALID _1kd0oed4y()
@ 5.500,55.333 GET m.imp ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("provedor") AND !EOF("provedor") ;
	VALID i_rescta()
@ 5.500,82.000 GET m.fin ;
	PICTURE "@*HT \<Fin" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
@ 3.875,39.167 GET m.fecdes ;
	SIZE 1.000,12.400 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE" ;
	WHEN .F.
@ 3.938,53.167 SAY "Hasta el:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 3.875,61.333 GET m.fechas ;
	SIZE 1.000,12.400 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE" ;
	WHEN .F.
@ 3.938,30.667 SAY "Desde el:" ;
	FONT "Arial", 8 ;
	STYLE "T"




*       *********************************************************
*       *                                                         
*       *        VBROWSEC/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 2
IF WVISIBLE("vbrowsec")
	ACTIVATE WINDOW vbrowsec SAME
ELSE
	ACTIVATE WINDOW vbrowsec NOSHOW
ENDIF

IF NOT WVISIBLE("vbrowsec")
	ACTIVATE WINDOW vbrowsec
ENDIF
IF NOT WVISIBLE("g_respro")
	ACTIVATE WINDOW g_respro
ENDIF


READ CYCLE

RELEASE WINDOW g_respro
RELEASE WINDOW vbrowsec

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
*       *           VBROWSEC/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 2
IF USED("respro")
	SELECT respro
	USE
ENDIF

*       *********************************************************
*       *                                                         
*       * _1KD0OED4X           m.sig VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_RESPRO,     Record Number:   11  
*       * Variable:            m.sig                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed4x     &&  m.sig VALID
#REGION 1
SELECT provedor
SKIP
IF EOF()
	GO BOTTOM
ENDIF
SHOW GETS

*       *********************************************************
*       *                                                         
*       * _1KD0OED4Y           m.ant VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_RESPRO,     Record Number:   12  
*       * Variable:            m.ant                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed4y     &&  m.ant VALID
#REGION 1
SELECT provedor
SKIP -1
IF EOF()
	GO TOP
ENDIF
SHOW GETS