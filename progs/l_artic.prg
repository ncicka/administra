*       *********************************************************
*       *                                                         
*       * 13/07/2005            L_ARTIC.SPR              11:22:59 
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

IF NOT WEXIST("vvartic") ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.PJX" ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.SCX" ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.MNX" ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.PRG" ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.FRX" ;
	OR UPPER(WTITLE("VVARTIC")) == "VVARTIC.QPR"
	DEFINE WINDOW vvartic ;
		AT 1.000, 6.000 ;
		SIZE 9.462,109.800 ;
		TITLE "Listado de Artículos" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM
ENDIF

IF NOT WEXIST("vartic") ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.PJX" ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.SCX" ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.MNX" ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.PRG" ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.FRX" ;
	OR UPPER(WTITLE("VARTIC")) == "VARTIC.QPR"
	DEFINE WINDOW vartic ;
		AT 12.000, 0.000 ;
		SIZE 14.286,123.400 ;
		TITLE "Artículos" ;
		FONT "Arial", 8 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF


*       *********************************************************
*       *                                                         
*       *   L_ARTIC/Windows Código de configuración - SECCION 2   
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

IF USED("articulo")
	SELECT articulo
	SET ORDER TO articulo1
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo ;
		ORDER articulo1
ENDIF

IF TYPE("m.filt_expr")="U"
	REGIONAL m.filt_expr
	m.filt_expr=""
ENDIF

IF TYPE("srchterm") $ "UL" OR EMPTY(m.srchterm)
   m.srchterm = SPACE(60)
ENDIF
m.oksrch = 1

m.startord = ORDER()
m.startalias = ALIAS()

m.curord = ORDER()
IF EMPTY(m.curord)
   SET ORDER TO 1
   m.curord = ORDER()
ENDIF

skipvar = .T.

curs_stat = (UPPER(SET("CURSOR")) = "ON")
SET CURSOR ON


*       *********************************************************
*       *                                                         
*       *   VARTIC/Windows Código de configuración - SECCION 2    
*       *                                                         
*       *********************************************************
*

#REGION 2
	ACTIVATE WINDOW vartic SAME
	SELECT articulo
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vartic ;
		FIELDS rubro  		:W=.f.,;
			   articulo   	:W=.f.,;
			   descripcio 	:R,;
			   medida 		:W=.f. :H='Un. Med.',;
			   interno 		:W=.f. :H='Imp. Int.',;
			   fijo  		:W=.f. :H=' ',;
			   unitario  	:W=.f. :H='P. Contado',;
			   unitario2	:W=.f. :H='P. Cta.Cte.',;
			   codbarra     :W=.f. :H='Cod. Barra',;
			   costo 		:W=.f. :H='Costo',;
			   margen 		:W=.f. :H='%Gan. Contado',;
			   margen2 		:W=.f. :H='%Gan. Cta.Cte.',;
			   digitos 		:W=.f. :H='Dígitos' ,;
			   redondeo 	:W=.f. :H='Redondeo' ,;
			   indice 		=IIF(indice,'Si','No') :W=.f. :H='Inf. ind.p/iva' ,;
			   stock 		=IIF(stock,'Si','No') :W=.f. :H='Lleva Stock',;
			   actual 		:W=.f. :H='Stk. actual' ,;
			   minimo 		:W=.f. :H='Stk. mínimo';
		FREEZE descripcio



*       *********************************************************
*       *                                                         
*       *        L_ARTIC/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vvartic")
	ACTIVATE WINDOW vvartic SAME
ELSE
	ACTIVATE WINDOW vvartic NOSHOW
ENDIF
@ 0.769,3.200 SAY "Ordenación" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.462,3.200 GET m.orden ;
	PICTURE "@*RVN Rubro-Artículo;Descripción;Rubro-Descripción" ;
	SIZE 1.308,22.400,0.308 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	VALID _1kd0oec31()
@ 2.462,25.800 GET m.filtro ;
	PICTURE "@*C \<Filtro..." ;
	SIZE 1.308,12.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	WHEN _1kd0oec33() ;
	VALID _1kd0oec35() ;
	COLOR ,,,,,,,,RGB(,,,255,255,255),RGB(,,,255,255,255)
@ 2.538,35.400 SAY ALLTRIM(m.filt_expr) ;
	SIZE 1.000,44.600 ;
	FONT "MS Sans Serif", 8 ;
	COLOR RGB(,,,255,255,255)
@ 2.308,80.800 GET m.cancelar ;
	PICTURE "@*HN \<Cancelar" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID fcancela()
@ 7.077,80.800 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID _1kd0oec37()
@ 4.692,80.800 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)




*       *********************************************************
*       *                                                         
*       *         VARTIC/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 2
IF WVISIBLE("vartic")
	ACTIVATE WINDOW vartic SAME
ELSE
	ACTIVATE WINDOW vartic NOSHOW
ENDIF

IF NOT WVISIBLE("vartic")
	ACTIVATE WINDOW vartic
ENDIF
IF NOT WVISIBLE("vvartic")
	ACTIVATE WINDOW vvartic
ENDIF


READ CYCLE ;
	SHOW _1kd0oec39()

RELEASE WINDOW vartic
RELEASE WINDOW vvartic

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
*       *           L_ARTIC/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
IF USED("empresa")
	SELECT empresa
ENDIF

IF USED("articulo")
	SELECT articulo
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
*       * L_ARTIC/Windows Procedimientos y funciones de soporte   
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

FUNCTION fcancela
CLEAR READ
RETURN

FUNCTION fvcli
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vartic ;
		FIELDS rubro  		:W=.f.,;
			   articulo   	:W=.f.,;
			   descripcio 	:R,;
			   medida 		:W=.f. :H='Un. Med.',;
			   interno 		:W=.f. :H='Imp. Int.',;
			   fijo  		:W=.f. :H=' ',;
			   unitario  	:W=.f. :H='P. Contado',;
			   unitario2	:W=.f. :H='P. Cta.Cte.',;
			   costo 		:W=.f. :H='Costo',;
			   margen 		:W=.f. :H='%Gan. Contado',;
			   margen2 		:W=.f. :H='%Gan. Cta.Cte.',;
			   digitos 		:W=.f. :H='Dígitos' ,;
			   redondeo 	:W=.f. :H='Redondeo' ,;
			   indice 		=IIF(indice,'Si','No') :W=.f. :H='Inf. ind.p/iva' ,;
			   stock 		=IIF(stock,'Si','No') :W=.f. :H='Lleva Stock',;
			   actual 		:W=.f. :H='Stk. actual' ,;
			   minimo 		:W=.f. :H='Stk. mínimo';
		FREEZE descripcio


*       *********************************************************
*       *                                                         
*       * _1KD0OEC31           m.orden VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_ARTIC,     Record Number:    3   
*       * Variable:            m.orden                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Radio Button                       
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oec31     &&  m.orden VALID
#REGION 1
DO CASE
	CASE m.orden = 1
		SET ORDER TO articulo1
	CASE m.orden = 2
		SET ORDER TO articulo2
	OTHERWISE
		SET ORDER TO articulo3
ENDCASE

SHOW GETS

=fvcli()


*       *********************************************************
*       *                                                         
*       * _1KD0OEC33           m.filtro WHEN                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_ARTIC,     Record Number:    4   
*       * Variable:            m.filtro                           
*       * Called By:           WHEN Clause                        
*       * Object Type:         Check Box                          
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oec33     &&  m.filtro WHEN
#REGION 1
IF !EMPTY(m.filt_expr)
	STORE 1	TO m.filtro
ELSE
	STORE 0	TO m.filtro
ENDIF
SHOW GETS

*       *********************************************************
*       *                                                         
*       * _1KD0OEC35           m.filtro VALID                     
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_ARTIC,     Record Number:    4   
*       * Variable:            m.filtro                           
*       * Called By:           VALID Clause                       
*       * Object Type:         Check Box                          
*       * Snippet Number:      3                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oec35     &&  m.filtro VALID
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
=fvcli()

*       *********************************************************
*       *                                                         
*       * _1KD0OEC37           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_ARTIC,     Record Number:    7   
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      4                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oec37     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	SELECT articulo
	saverec = RECNO()
	GO TOP
	REPOR FORM articulo TO PRINT NOCONSOLE
	IF saverec <= RECCOUNT()
		GO saverec
	ENDIF
ENDIF

*       *********************************************************
*       *                                                         
*       * _1KD0OEC39           Nivel de lectura SHOW              
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         Multiple Screens                   
*       * Called By:           READ Statement                     
*       * Snippet Number:      5                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oec39     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: L_ARTIC
*
#REGION 1
IF SYS(2016) = "VVARTIC" OR SYS(2016) = "*"
	ACTIVATE WINDOW vvartic SAME
	@ 2.538,35.400 SAY ALLTRIM(m.filt_expr) ;
		SIZE 1.000,44.600, 0.000 ;
		FONT "MS Sans Serif", 8 ;
		COLOR RGB(,,,255,255,255)
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF