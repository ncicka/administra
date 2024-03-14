*       *********************************************************
*       *                                                         
*       * 13/07/2005            P_VTART.SPR              11:22:58 
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

IF NOT WEXIST("g_vtart") ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.PJX" ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.SCX" ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.MNX" ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.PRG" ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.FRX" ;
	OR UPPER(WTITLE("G_VTART")) == "G_VTART.QPR"
	DEFINE WINDOW g_vtart ;
		AT 0.000, 8.000 ;
		SIZE 8.500,83.667 ;
		TITLE "Ventas por Artículo" ;
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
		AT 13.000, 30.000 ;
		SIZE 16.429,48.200 ;
		TITLE "Subtotales por Período" ;
		FONT "Arial", 8 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF


*       *********************************************************
*       *                                                         
*       *  BRWVTART/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 2
	ACTIVATE WINDOW vbrowse SAME
	SELECT vtart2
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vbrowse ;
		FIELDS anio=LEFT(periodo,4) :h="Año" ,;
			   mes=RIGHT(periodo,2) ,;
			   cantidad	:p="@Z 999,999,999,999" ;
		FREEZE anio
	SELECT vtart


*       *********************************************************
*       *                                                         
*       *        P_VTART/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("g_vtart")
	ACTIVATE WINDOW g_vtart SAME
ELSE
	ACTIVATE WINDOW g_vtart NOSHOW
ENDIF
@ 0.125,17.167 SAY "Medida:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.188,17.500 GET vtart.medida ;
	SIZE 1.000,24.000 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 0.125,8.500 SAY "Artículo:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.188,2.333 GET vtart.rubro ;
	SIZE 1.000,5.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 1.188,8.833 GET vtart.articulo ;
	SIZE 1.000,6.600 ;
	DEFAULT " " ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 2.250,2.333 GET vtart.descripcio ;
	SIZE 0.957,52.556 ;
	DEFAULT " " ;
	FONT "Arial", 14 ;
	STYLE "B" ;
	PICTURE "@K" ;
	WHEN .F.
@ 6.500,2.000 GET m.sig ;
	PICTURE "@*HN \<Siguiente" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !EOF("vtart") ;
	VALID _1kd0oebkt()
@ 6.500,22.667 GET m.ant ;
	PICTURE "@*HN \<Anterior" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("vtart") ;
	VALID _1kd0oebkv()
@ 6.500,44.167 GET m.imp ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B" ;
	WHEN !BOF("vtart") AND !EOF("vtart") ;
	VALID i_vtart()
@ 6.500,65.500 GET m.fin ;
	PICTURE "@*HT \<Fin" ;
	SIZE 1.769,16.167,0.667 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "B"
@ 4.375,10.000 GET m.fecdes ;
	SIZE 1.000,12.400 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE" ;
	WHEN .F.
@ 4.438,21.667 SAY "al:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 4.375,24.167 GET m.fechas ;
	SIZE 1.000,12.400 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE" ;
	WHEN .F.
@ 4.438,2.000 SAY "Desde el:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.125,2.000 SAY "Rubro:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.125,40.167 SAY "Clientes:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.188,40.500 SAY IIF(EMPTY(m.setkey),"TODOS", m.setkey) ;
	SIZE 1.000,48.800 ;
	FONT "Arial", 8 ;
	STYLE "B" ;
	PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
@ 4.313,35.833 SAY "Cantidad Vendida:" ;
	FONT "Arial", 10 ;
	STYLE "T"
@ 3.875,54.667 GET vtart.cantidad ;
	SIZE 0.957,17.667 ;
	DEFAULT 0 ;
	FONT "Arial", 14 ;
	STYLE "B" ;
	PICTURE "@K 999,999,999,999" ;
	WHEN .F.




*       *********************************************************
*       *                                                         
*       *        BRWVTART/Windows Distribución de pantalla        
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
IF NOT WVISIBLE("g_vtart")
	ACTIVATE WINDOW g_vtart
ENDIF


READ CYCLE

RELEASE WINDOW g_vtart
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
*       *           BRWVTART/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 2
IF USED("vtart2")
	SELECT vtart2
	USE
ENDIF

*       *********************************************************
*       *                                                         
*       * _1KD0OEBKT           m.sig VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_VTART,     Record Number:    8   
*       * Variable:            m.sig                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oebkt     &&  m.sig VALID
#REGION 1
SELECT vtart
SKIP
SHOW GETS

*       *********************************************************
*       *                                                         
*       * _1KD0OEBKV           m.ant VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         P_VTART,     Record Number:    9   
*       * Variable:            m.ant                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oebkv     &&  m.ant VALID
#REGION 1
SELECT vtart
SKIP -1
SHOW GETS