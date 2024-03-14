*       *********************************************************
*       *                                                         
*       * 09/02/99            L_CLIENT.PRG               11:33:29 
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


PUBLIC campo
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

IF NOT WEXIST("_s2d0oruad")
	DEFINE WINDOW _s2d0oruad ;
		AT  0.000, 0.000  ;
		SIZE 26.538,120.000 ;
		TITLE "Listado de Clientes" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM
	MOVE WINDOW _s2d0oruad CENTER
ENDIF
DEFINE WINDOW vcli AT 7.538,0.200 SIZE 8.077,119.300 ;
		FONT "MS Sans Serif", 8 ;
		TITLE "Clientes" ;
		NOCLOSE ;
		NOZOOM ;
		NOMINIMIZE ;
		DOUBLE
		


*       *********************************************************
*       *                                                         
*       *  L_CLIENT/Windows Código de configuración - SECCION 2   
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

IF USED("clientes")
	SELECT clientes
	SET ORDER TO clientes1
ELSE
	SELECT 0
	USE (LOCFILE("clientes.dbf", "DBF", "Buscar clientes?")) ;
		SHARED AGAIN ALIAS clientes ;
		ORDER clientes1
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
DEFINE POPUP _s2d0orufd ;
	PROMPT FIELD fcampo() 
*	SCROLL

*       *********************************************************
*       *                                                         
*       *        L_CLIENT/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("_s2d0oruad")
	ACTIVATE WINDOW _s2d0oruad SAME
ELSE
	ACTIVATE WINDOW _s2d0oruad NOSHOW
ENDIF

DO mos_det

@ 0.769,9.800 SAY "Ordenación" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.462,9.800 GET m.orden ;
	PICTURE "@*RVN Código;Nombre;Cuit" ;
	SIZE 1.308,12.200,0.308 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	VALID _s2d0orug4()

@ 2.462,28.800 GET m.filtro ;
	PICTURE "@*C \<Filtro..." ;
	SIZE 1.308,12.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	WHEN _s2d0orugw() ;
	VALID _s2d0oruhf() ;
	COLOR ,,,,,,,,RGB(,,,255,255,255),RGB(,,,255,255,255)
@ 2.538,40.800 SAY ALLTRIM(m.filt_expr) ;
	SIZE 1.000,44.600 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)


@ 2.462,88.400 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)

@ 4.846,88.400 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID flistado()

@ 7.538,0.200 GET m.ver ;
	PICTURE "@*IHN " ;
	SIZE 8.077,119.600 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	WHEN ver() AND .F.

@ 16.692,4.800 SAY "Código:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 18.538,4.000 SAY "Nombre:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 20.385,4.000 SAY "C.U.I.T.:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 22.231,2.400 SAY "Dirección:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 24.077,2.200 SAY "Localidad:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 22.231,68.600 SAY "Iva:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 20.385,60.600 SAY "Documento:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 24.077,63.200 SAY "Teléfono:" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"

IF NOT WVISIBLE("_s2d0oruad")
	ACTIVATE WINDOW _s2d0oruad SAME
ENDIF


*       *********************************************************
*       *                                                         
*       *    WindowsREAD contiene cláusulas de SCREEN l_client    
*       *                                                         
*       *********************************************************
*

READ CYCLE ;
	SHOW _s2d0oruj1() ;
	MODAL

RELEASE WINDOW _s2d0oruad
RELEASE POPUPS _s2d0orufd

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
*       *           L_CLIENT/Windows Código de limpieza           
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

RELEASE m.impresora, m.imprimir, m.ver

IF m.curs_stat
   SET CURSOR ON
ELSE
   SET CURSOR OFF
ENDIF
m.skipvar = .F.



*       *********************************************************
*       *                                                         
*       * L_CLIENT/Windows Procedimientos y funciones de soporte  
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


*       *********************************************************
*       *                                                         
*       * _S2D0ORUG4           m.orden VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_CLIENT,     Record Number:    3  
*       * Variable:            m.orden                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Radio Button                       
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2d0orug4     &&  m.orden VALID
#REGION 1
DO CASE
	CASE m.orden = 1
		SET ORDER TO clientes1
	CASE m.orden = 2
		SET ORDER TO clientes2
		campo = "nombre +' '+cliente"
	OTHERWISE
		SET ORDER TO clientes3
		campo = "cuit + '  ' + nombre"
ENDCASE
SHOW GETS


*       *********************************************************
*       *                                                         
*       * _S2D0ORUGW           m.filtro WHEN                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_CLIENT,     Record Number:    4  
*       * Variable:            m.filtro                           
*       * Called By:           WHEN Clause                        
*       * Object Type:         Check Box                          
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2d0orugw     &&  m.filtro WHEN
#REGION 1
IF !EMPTY(m.filt_expr)
	STORE 1	TO m.filtro
ELSE
	STORE 0	TO m.filtro
ENDIF
SHOW GET m.filtro

*       *********************************************************
*       *                                                         
*       * _S2D0ORUHF           m.filtro VALID                     
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_CLIENT,     Record Number:    4  
*       * Variable:            m.filtro                           
*       * Called By:           VALID Clause                       
*       * Object Type:         Check Box                          
*       * Snippet Number:      3                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2d0oruhf     &&  m.filtro VALID
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
DO mos_det


*       *********************************************************
*       *                                                         
*       * _S2D0ORUJ1           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_CLIENT                           
*       * Called By:           READ Statement                     
*       * Snippet Number:      4                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2d0oruj1     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: L_CLIENT
*
#REGION 1
IF SYS(2016) = "_S2D0ORUAD" OR SYS(2016) = "*"
	ACTIVATE WINDOW _s2d0oruad 
	@ 1.385,55.800  SAY ALLTRIM(m.filt_expr) ;
		SIZE 1.000,44.600, 0.000 ;
		FONT "MS Sans Serif", 8 ;
		COLOR RGB(,,,255,255,255)
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) 
ENDIF


FUNCTION fcampo

IF ORDER() = 'CLIENTES2'
	IF _CUROBJ = OBJNUM(m.ver) AND OBJNUM(m.ver) # 0
		DO mos_det
	ENDIF
	RETURN NOMBRE+' '+CLIENTE
ENDIF

IF ORDER() = 'CLIENTES3'
	IF _CUROBJ = OBJNUM(m.ver) AND OBJNUM(m.ver) # 0
		DO mos_det
	ENDIF
	RETURN CUIT+' '+NOMBRE
ENDIF

*IF _CUROBJ = OBJNUM(m.ver) AND OBJNUM(m.ver) # 0
*	DO mos_det
*ENDIF

RETURN CLIENTE+' '+NOMBRE


PROCEDURE mos_det

@ 16.692,14.800 SAY Clientes.cliente ;
	SIZE 1.000,4.600 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 18.538,14.800 SAY Clientes.nombre ;
	SIZE 1.000,68.800 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 20.385,14.800 SAY Clientes.cuit ;
	SIZE 1.000,17.200 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 22.231,14.800 SAY Clientes.direccion ;
	SIZE 1.000,33.800 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 24.077,14.800 SAY Clientes.localidad ;
	SIZE 1.000,26.800 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 20.385,74.800 SAY Clientes.documento ;
	SIZE 1.000,13.000 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 22.231,74.800 SAY Clientes.iva ;
	SIZE 1.000,13.000 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 24.077,74.800 SAY Clientes.telefono ;
	SIZE 1.000,20.000 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)

RETURN 


PROCEDURE flistado
IF PRINTSTATUS()
	m.saverec = RECNO()
	REPOR FORM clientes TO PRINT NOCONSOLE
	IF m.saverec <= RECCOUNT()
		GO m.saverec
	ENDIF
ELSE
	WAIT 'Impresora No activa ' WINDOW NOWAIT
ENDIF
RETURN .T.



FUNCTION ver
	SHOW WINDOW vcli
	SELECT clientes
	BROWSE IN WINDOW vcli;
		NOMENU ;
		FIELD cliente :W=.f.,;
			  nombre  :R ,;
			  cuit    :W=.f.;
		FREEZE nombre
RETURN 