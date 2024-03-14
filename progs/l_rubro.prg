*       *********************************************************
*       *                                                         
*       * 22/02/1999            L_RUBRO.PRG              20:31:39 
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

IF NOT WEXIST("_s2q17zy6p")
	DEFINE WINDOW _s2q17zy6p ;
		AT  0.000, 0.000  ;
		SIZE 18.077,87.000 ;
		TITLE "Listado de Rubros" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
	MOVE WINDOW _s2q17zy6p CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   L_RUBRO/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1

PUBLIC m.ver, m.impresora, m.imprimir

STORE 1	TO m.ver, m.impresora, m.imprimir

IF USED("empresa")
	SELECT empresa
ELSE
	SELECT 0
	USE (LOCFILE("empresa.dbf", "DBF", "Buscar empresa?")) ;
		SHARED AGAIN ALIAS empresa
ENDIF

IF USED("rubro")
	SELECT rubro
	SET ORDER TO rubro
ELSE
	SELECT 0
	USE (LOCFILE("rubro.dbf", "DBF", "Buscar rubro?")) ;
		SHARED AGAIN ALIAS rubro ;
		ORDER rubro
ENDIF

IF TYPE("m.filt_expr")="U"
	REGIONAL m.filt_expr
	m.filt_expr=""
ENDIF

IF TYPE("srchterm") $ "UL" OR EMPTY(m.srchterm)
   m.srchterm = SPACE(60)
ENDIF
m.oksrch = 1
m.curord = ORDER()

IF EMPTY(m.curord)
   SET ORDER TO 1
   m.curord = ORDER()
ENDIF

skipvar = .T.

curs_stat = (UPPER(SET("CURSOR")) = "ON")
SET CURSOR ON



#REGION 1
DEFINE POPUP _s2q17zybf ;
	PROMPT FIELD fcampo() 
*	SCROLL

*       *********************************************************
*       *                                                         
*       *        L_RUBRO/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("_s2q17zy6p")
	ACTIVATE WINDOW _s2q17zy6p SAME
ELSE
	ACTIVATE WINDOW _s2q17zy6p NOSHOW
ENDIF
@ 2.462,1.600 GET m.filtro ;
	PICTURE "@*C \<Filtro..." ;
	SIZE 1.308,12.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	WHEN _s2q17zybu() ;
	VALID _s2q17zycd() ;
	COLOR ,,,,,,,,RGB(,,,255,255,255),RGB(,,,255,255,255)
@ 2.538,11.600 SAY ALLTRIM(m.filt_expr) ;
	SIZE 1.000,38.800 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 2.462,54.800 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)
@ 4.692,55.000 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID _s2q17zydj()
@ 7.538,0.200 GET m.ver ;
 	PICTURE "@&N" ;
	POPUP _s2q17zybf ;
	SIZE 8.077,86.600 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 8 ;
	STYLE "" 

IF NOT WVISIBLE("_s2q17zy6p")
	ACTIVATE WINDOW _s2q17zy6p
ENDIF


*       *********************************************************
*       *                                                         
*       *    WindowsREAD contiene cláusulas de SCREEN l_rubro     
*       *                                                         
*       *********************************************************
*

READ CYCLE ;
	SHOW _s2q17zyeh() ;
	MODAL

RELEASE WINDOW _s2q17zy6p
RELEASE POPUPS _s2q17zybf

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
*       *           L_RUBRO/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("rubro")
	SELECT rubro
	USE
ENDIF

RELEASE m.impresora, m.imprimir, m.ver

IF m.curs_stat
   SET CURSOR ON
ELSE
   SET CURSOR OFF
ENDIF
m.skipvar = .F.



*       *********************************************************
*       *                                                         
*       * L_RUBRO/Windows Procedimientos y funciones de soporte   
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE waitmsg
IF RECCOUNT() > 1000
   WAIT WINDOW "Buscando... Espere, por favor." NOWAIT
ELSE
   WAIT WINDOW "Buscando" NOWAIT
ENDIF


FUNCTION fcampo

RETURN RUBRO+' '+DESCRIPCIO+' '+MEDIDA


*       *********************************************************
*       *                                                         
*       * _S2Q17ZYBU           m.filtro WHEN                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_RUBRO,     Record Number:    2   
*       * Variable:            m.filtro                           
*       * Called By:           WHEN Clause                        
*       * Object Type:         Check Box                          
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2q17zybu     &&  m.filtro WHEN
#REGION 1
IF !EMPTY(m.filt_expr)
	STORE 1	TO m.filtro
ELSE
	STORE 0	TO m.filtro
ENDIF
SHOW GET m.filtro

*       *********************************************************
*       *                                                         
*       * _S2Q17ZYCD           m.filtro VALID                     
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_RUBRO,     Record Number:    2   
*       * Variable:            m.filtro                           
*       * Called By:           VALID Clause                       
*       * Object Type:         Check Box                          
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2q17zycd     &&  m.filtro VALID
#REGION 1
m.orig_rec = RECNO()
GETEXPR 'Expresión de filtro' TO m.filt_expr TYPE 'L' DEFAULT m.filt_expr
IF !EMPTY(m.filt_expr)
   SET FILTER TO &filt_expr
   GOTO TOP
   IF EOF()
      WAIT WINDOW "Ningún registro coincide con el filtro" NOWAIT
      SET FILTER TO
      IF m.orig_rec <= RECCOUNT()
         GOTO m.orig_rec
      ENDIF
   ENDIF
ELSE
	STORE 0 TO m.filter
	SET FILTER TO
ENDIF

SHOW GETS


*       *********************************************************
*       *                                                         
*       * _S2Q17ZYDJ           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_RUBRO,     Record Number:    5   
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      3                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2q17zydj     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	m.saverec = RECNO()
	REPOR FORM rubro TO PRINT NOCONSOLE
	IF m.saverec <= RECCOUNT()
		GO m.saverec
	ENDIF
ELSE
	WAIT 'Impresora No activa ' WINDOW NOWAIT
ENDIF
RETURN .T.


*       *********************************************************
*       *                                                         
*       * _S2Q17ZYEH           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_RUBRO                            
*       * Called By:           READ Statement                     
*       * Snippet Number:      4                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2q17zyeh     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: L_RUBRO
*
#REGION 1
IF SYS(2016) = "_S2Q17ZY6P" OR SYS(2016) = "*"
	ACTIVATE WINDOW _s2q17zy6p SAME
	@ 2.538,11.600 SAY ALLTRIM(m.filt_expr) ;
		SIZE 1.000,38.800, 0.000 ;
		FONT "MS Sans Serif", 8 ;
		COLOR RGB(,,,255,255,255)
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF

