*       *********************************************************
*       *                                                         
*       * 13/07/2005           L_PROVED.SPR              11:23:00 
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

IF NOT WEXIST("vvcli") ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.PJX" ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.SCX" ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.MNX" ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.PRG" ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.FRX" ;
	OR UPPER(WTITLE("VVCLI")) == "VVCLI.QPR"
	DEFINE WINDOW vvcli ;
		AT 1.231, 7.167 ;
		SIZE 9.462,109.800 ;
		TITLE "Listado de Proveedores" ;
		FONT "MS Sans Serif", 8 ;
		FLOAT ;
		NOCLOSE ;
		MINIMIZE ;
		SYSTEM
ENDIF

IF NOT WEXIST("vcli") ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.PJX" ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.SCX" ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.MNX" ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.PRG" ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.FRX" ;
	OR UPPER(WTITLE("VCLI")) == "VCLI.QPR"
	DEFINE WINDOW vcli ;
		AT 12.615, 1.833 ;
		SIZE 14.286,123.400 ;
		TITLE "Proveedores" ;
		FONT "Arial", 8 ;
		NOFLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
ENDIF


*       *********************************************************
*       *                                                         
*       *  L_PROVED/Windows Código de configuración - SECCION 2   
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

IF USED("provedor")
	SELECT provedor
	SET ORDER TO provedor1
ELSE
	SELECT 0
	USE (LOCFILE("provedor.dbf", "DBF", "Buscar provedor?")) ;
		SHARED AGAIN ALIAS provedor ;
		ORDER provedor1
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
*       *    VPROV/Windows Código de configuración - SECCION 2    
*       *                                                         
*       *********************************************************
*

#REGION 2
	ACTIVATE WINDOW vcli SAME
	SELECT provedor
	BROWSE NOAPPEND NODELETE NOEDIT NOMENU NOWAIT;
		FONT "Arial", 8 ;
		WINDOW vcli ;
		FIELDS proveedor   :W=.f.,;
			   nombre    :R ,;
			   cuit      :W=.f.,;
			   direccion :W=.f.,;
			   localidad :W=.f.,;
			   iva	     :W=.f.,;
			   telefono	 :W=.f.,;
			   email     :W=.f.;
		FREEZE nombre



*       *********************************************************
*       *                                                         
*       *        L_PROVED/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vvcli")
	ACTIVATE WINDOW vvcli SAME
ELSE
	ACTIVATE WINDOW vvcli NOSHOW
ENDIF
@ 0.769,9.800 SAY "Ordenación" ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T"
@ 2.462,9.800 GET m.orden ;
	PICTURE "@*RVN Código;Nombre;Cuit" ;
	SIZE 1.308,12.200,0.308 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	STYLE "T" ;
	VALID _1kd0oed05()
@ 2.462,25.800 GET m.filtro ;
	PICTURE "@*C \<Filtro..." ;
	SIZE 1.308,12.200 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 8 ;
	WHEN _1kd0oed07() ;
	VALID _1kd0oed09() ;
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
	VALID _1kd0oed0b()
@ 4.692,80.800 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)




*       *********************************************************
*       *                                                         
*       *         VPROV/Windows Distribución de pantalla          
*       *                                                         
*       *********************************************************
*

#REGION 2
IF WVISIBLE("vcli")
	ACTIVATE WINDOW vcli SAME
ELSE
	ACTIVATE WINDOW vcli NOSHOW
ENDIF

IF NOT WVISIBLE("vcli")
	ACTIVATE WINDOW vcli
ENDIF
IF NOT WVISIBLE("vvcli")
	ACTIVATE WINDOW vvcli
ENDIF


READ CYCLE ;
	SHOW _1kd0oed0d()

RELEASE WINDOW vcli
RELEASE WINDOW vvcli

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
*       *           L_PROVED/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 1
IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("provedor")
	SELECT provedor
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
*       * L_PROVED/Windows Procedimientos y funciones de soporte  
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
		WINDOW vcli ;
		FIELDS proveedor  :W=.f.,;
			   nombre    :R ,;
			   cuit      :W=.f.,;
			   direccion :W=.f.,;
			   localidad :W=.f.,;
			   iva	     :W=.f.,;
			   telefono	 :W=.f.,;
			   email     :W=.f. ;
		FREEZE nombre


*       *********************************************************
*       *                                                         
*       * _1KD0OED05           m.orden VALID                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_PROVED,     Record Number:    3  
*       * Variable:            m.orden                            
*       * Called By:           VALID Clause                       
*       * Object Type:         Radio Button                       
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed05     &&  m.orden VALID
#REGION 1
DO CASE
	CASE m.orden = 1
		SET ORDER TO provedor1
	CASE m.orden = 2
		SET ORDER TO provedor2
	OTHERWISE
		SET ORDER TO provedor3
ENDCASE

SHOW GETS

=fvcli()


*       *********************************************************
*       *                                                         
*       * _1KD0OED07           m.filtro WHEN                      
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_PROVED,     Record Number:    4  
*       * Variable:            m.filtro                           
*       * Called By:           WHEN Clause                        
*       * Object Type:         Check Box                          
*       * Snippet Number:      2                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed07     &&  m.filtro WHEN
#REGION 1
IF !EMPTY(m.filt_expr)
	STORE 1	TO m.filtro
ELSE
	STORE 0	TO m.filtro
ENDIF
SHOW GETS

*       *********************************************************
*       *                                                         
*       * _1KD0OED09           m.filtro VALID                     
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_PROVED,     Record Number:    4  
*       * Variable:            m.filtro                           
*       * Called By:           VALID Clause                       
*       * Object Type:         Check Box                          
*       * Snippet Number:      3                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed09     &&  m.filtro VALID
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
*       * _1KD0OED0B           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_PROVED,     Record Number:    7  
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      4                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _1kd0oed0b     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	SELECT provedor
	saverec = RECNO()
	GO TOP
	REPOR FORM provedor TO PRINT NOCONSOLE
	IF saverec <= RECCOUNT()
		GO saverec
	ENDIF
ENDIF

*       *********************************************************
*       *                                                         
*       * _1KD0OED0D           Nivel de lectura SHOW              
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
FUNCTION _1kd0oed0d     && Read Level Show
PRIVATE currwind
STORE WOUTPUT() TO currwind
*
* Código SHOW de la pantalla: L_PROVED
*
#REGION 1
IF SYS(2016) = "VVCLI" OR SYS(2016) = "*"
	ACTIVATE WINDOW vvcli SAME
	@ 2.538,35.400 SAY ALLTRIM(m.filt_expr) ;
		SIZE 1.000,44.600, 0.000 ;
		FONT "MS Sans Serif", 8 ;
		COLOR RGB(,,,255,255,255)
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF