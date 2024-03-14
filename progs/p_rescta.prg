*       *********************************************************
*       *                                                         
*       * 13/07/2005           P_RESCTA.SPR              11:22:58 
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
SET READBORDER OFF

*       *********************************************************
*       *                                                         
*       *             Windows Definiciones de ventana             
*       *                                                         
*       *********************************************************
*

IF NOT WEXIST("g_rescta") ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.PJX" ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.SCX" ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.MNX" ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.PRG" ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.FRX" ;
	OR UPPER(WTITLE("G_RESCTA")) == "G_RESCTA.QPR"
	DEFINE WINDOW g_rescta ;
		AT 0.000, 0.000 ;
		SIZE 7.313,102.833 ;
		TITLE "Resúmen de Cuentas de Clientes" ;
		FONT "Arial", 10 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF

IF NOT WEXIST("vbrowse") ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.PJX" ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.SCX" ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.MNX" ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.PRG" ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.FRX" ;
	OR UPPER(WTITLE("VBROWSE")) == "VBROWSE.QPR"
	DEFINE WINDOW vbrowse ;
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
*       *   VBROWSE/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 2
	ACTIVATE WINDOW vbrowse SAME
	SELECT rescta
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vbrowse ;
		FIELDS fecha	:H="Fecha " :15,;
			   tipocomp :H="Cmpte" ,;
			   numero1  :H="" :P="@ 9999",;
			   numero2	:H="Número" :P="@ 99999999",;
			   detalle /33,;
			   debe		:P="@Z 99999,999.99",;
			   haber	:P="@Z 99999,999.99",;
			   saldo	:P="@Z 99999,999.99" ;
		FREEZE fecha
	SELECT clientes


*       *********************************************************
*       *                                                         
*       *        P_RESCTA/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("g_rescta")
	ACTIVATE WINDOW g_rescta SAME
ELSE
	ACTIVATE WINDOW g_rescta NOSHOW
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
@ 1.188,2.333 GET Clientes.cliente ;
	SIZE 1.000,5.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,13.333 GET Clientes.direccion ;
	SIZE 1.000,40.800 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,48.333 GET Clientes.localidad ;
	SIZE 1.000,32.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,77.833 GET Clientes.telefono ;
	SIZE 1.000,24.000 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 2.250,2.333 GET Clientes.nombre ;
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
	WHEN !EOF("clientes") ;
	VALID _1kd0oebiw()
@ 5.500,27.667 GET m.ant ;
	PICTURE "@*HN \<Anterior" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("clientes") ;
	VALID _1kd0oebiy()
@ 5.500,55.333 GET m.imp ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("clientes") AND !EOF("clientes") ;
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
*       *        VBROWSE/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 2
IF WVISIBLE("vbrowse")
	ACTIVATE WINDOW vbrowse SAME
ELSE
	ACTIVATE WINDOW vbrowse NOSHOW
ENDIF

IF NOT WVISIBLE("vbrowse")
	ACTIVATE WINDOW vbrowse
ENDIF
IF NOT WVISIBLE("g_rescta")
	ACTIVATE WINDOW g_rescta
ENDIF


READ CYCLE

RELEASE WINDOW g_rescta
RELEASE WINDOW vbrowse

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
*       *           VBROWSE/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 2
IF USED("rescta")
	SELECT rescta
	USE
ENDIF

*       *********************************************************
*       *                                                         
*       * _1KD0OEBIW           m.sig VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_RESCTA,     Record Number:   11  
*       * Variable:            m.sig                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oebiw     &&  m.sig VALID
#REGION 1
SELECT clientes
SKIP
IF EOF()
	GO BOTTOM
ENDIF
SHOW GETS

*       *********************************************************
*       *                                                         
*       * _1KD0OEBIY           m.ant VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_RESCTA,     Record Number:   12  
*       * Variable:            m.ant                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oebiy     &&  m.ant VALID
#REGION 1
SELECT clientes
SKIP -1
IF BOF()
	GO TOP
ENDIF
SHOW GETS