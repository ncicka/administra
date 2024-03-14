*       *********************************************************
*       *                                                         
*       * 23/02/99            L_IVAVTA.PRG               18:59:30 
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

IF NOT WEXIST("vivavta") ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.PJX" ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.SCX" ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.MNX" ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.PRG" ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.FRX" ;
	OR UPPER(WTITLE("VIVAVTA")) == "VIVAVTA.QPR"
	DEFINE WINDOW vivavta ;
		AT  0.000, 0.000  ;
		SIZE 11.286,67.200 ;
		TITLE "Emisión de Libro Iva Ventas" ;
		FONT "Arial", 8 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM
	MOVE WINDOW vivavta CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *  L_IVAVTA/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1
PUBLIC m.fecdes, m.fechas, m.pagina, divavta

STORE SPACE(8)	TO divavta
STORE {}		TO m.fecdes, m.fechas
STORE 0			TO m.pagina

SELECT 0
IF !USED("empresa")
	USE empresa SHARED ALIAS empresa
ELSE
	SELECT empresa
ENDIF

SELECT 0
IF !USED("comprob")
	USE comprob SHARED ALIAS comprob ORDER comprob
ELSE
	SELECT comprob
	SET ORDER TO comprob
ENDIF

SELECT 0
IF !USED("ventas1")
	USE ventas1 SHARED ALIAS ventas1 ORDER ventas1
ELSE
	SELECT ventas1
	SET ORDER TO ventas1
ENDIF

SELECT ventas1

*       *********************************************************
*       *                                                         
*       *        L_IVAVTA/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vivavta")
	ACTIVATE WINDOW vivavta SAME
ELSE
	ACTIVATE WINDOW vivavta NOSHOW
ENDIF
@ 3.929,1.800 SAY "Página:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 0.643,2.000 SAY "Rango de Fechas:" ;
	FONT "Arial", 8 ;
	STYLE "T"
@ 1.857,2.400 GET m.fecdes ;
	SIZE 1.000,12.800 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE 99/99/9999" ;
	VALID LASTKEY()=5 OR fctrfech(m.fecdes,"m.fecdes")
@ 1.857,19.200 GET m.fechas ;
	SIZE 1.000,12.800 ;
	DEFAULT {  /  /  } ;
	FONT "Arial", 8 ;
	PICTURE "@KE 99/99/9999" ;
	VALID LASTKEY()=5 OR fctrfech(m.fechas,"m.fechas") AND m.fechas>=m.fecdes
@ 5.286,2.400 GET m.pagina ;
	SIZE 1.000,10.000 ;
	DEFAULT 0 ;
	FONT "Arial", 8 ;
	PICTURE "@K 99999999" ;
	VALID LASTKEY() = 5 OR m.pagina >= 0
@ 0.857,38.000 GET m.Aceptar ;
	PICTURE "@*HN \<Aceptar" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID faceptar()
@ 3.429,38.000 GET m.cancelar ;
	PICTURE "@*HN \<Cancelar" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID fcancela()
@ 6.000,38.000 GET m.impresora ;
	PICTURE "@*HN \<Especificar Impresora" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID SYS(1037)
@ 8.571,38.000 GET m.imprimir ;
	PICTURE "@*HN \<Imprimir" ;
	SIZE 1.769,27.000,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID _s2r14pez6()

IF NOT WVISIBLE("vivavta")
	ACTIVATE WINDOW vivavta
ENDIF

READ CYCLE MODAL

RELEASE WINDOW vivavta

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
*       *           L_IVAVTA/Windows Código de limpieza           
*       *                                                         
*       *********************************************************
*

#REGION 1
IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF

IF USED("ventas1")
	SELECT ventas1
	USE
ENDIF

IF USED(divavta)
	SELECT (divavta)
	USE
ENDIF

RELEASE m.fecdes, m.fechas, divavta

RETURN




*       *********************************************************
*       *                                                         
*       * L_IVAVTA/Windows Procedimientos y funciones de soporte  
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE faceptar
	DO g_ivavta
	DO p_ivavta
RETURN

PROCEDURE fcancela
	CLEAR READ
RETURN


PROCEDURE nada
RETURN

PROCEDURE g_ivavta
	PRIVATE m.perdes, m.total, m.ivari,  m.ivarni, m.ivanoc, m.subtotal,;
			m.impuesto
	STORE 0		TO m.total, m.ivari, m.ivarni, m.ivanoc, m.subtotal, m.impuesto			
	
	IF USED(divavta)	
		SELECT (divavta)
		USE
	ENDIF
	
	STORE "_D"+RIGHT(SYS(3),6)	TO divavta
	
	SELECT 0
	CREATE CURSOR (divavta) (fecha D, tipocomp C(5), tipo N(2), ;
						  numero1 N(4), numero2 N(8), nombre C(50), ;
						  total N(12,2), ivari N(10,2), ;
						  ivarni N(10,2), ivanoc N(10,2), subtotal N(10,2),;
						  impuesto N(10,2), tasaivari N(5,2), ;
						  tasaivarni N(5,2), tasaivanoc N(5,2),;
						  iva C(3), cuit C(13))
	INDEX ON DTOS(fecha)+tipocomp+STR(numero1,4)+STR(numero2,8) ;
					TAG divavta OF (divavta)


	SELECT ventas1
	annear = SET('NEAR')
	SET NEAR ON
	SET RELATION TO STR(tipo,2) INTO comprob
	
	SEEK DTOS(m.fecdes)
	
	SCAN WHILE BETWEEN(fecha,m.fecdes, m.fechas)

		SELECT (divavta)
		APPEND BLANK
		REPLACE fecha	 	WITH ventas1.fecha     ,;
				tipocomp 	WITH comprob.codigo    ,;
				tipo        WITH ventas1.tipo      ,;
				numero1  	WITH ventas1.numero1   ,;
				numero2		WITH ventas1.numero2   ,;
				nombre		WITH ventas1.nombre    ,;
				cuit 		WITH ventas1.cuit      ,;
				iva         WITH ventas1.iva       ,;
				subtotal 	WITH ventas1.subtotal  ,;
				tasaivari	WITH ventas1.tasaivari ,;
				ivari		WITH ventas1.ivari     ,;
				tasaivarni 	WITH ventas1.tasaivarni,;
				ivarni		WITH ventas1.ivarni    ,;
				tasaivanoc	WITH ventas1.tasaivanoc,;
				ivanoc		WITH ventas1.ivanoc    ,;
				impuesto	WITH ventas1.impuesto  ,;
				total		WITH ventas1.total
	
		IF INLIST(tipo,4,5)
			m.total = m.total - total
			m.ivari = m.ivari - ivari
			m.ivarni = m.ivarni - ivarni
			m.ivanoc = m.ivanoc - ivanoc
			m.subtotal = m.subtotal - subtotal
			m.impuesto = m.impuesto - impuesto
		ELSE
			m.total = m.total + total
			m.ivari = m.ivari + ivari
			m.ivarni = m.ivarni + ivarni
			m.ivanoc = m.ivanoc + ivanoc
			m.subtotal = m.subtotal + subtotal
			m.impuesto = m.impuesto + impuesto
		ENDIF
		SELECT ventas1
	ENDSCAN
	IF _CUROBJ = OBJNUM(m.aceptar)
		SELECT (divavta)
		APPEND BLANK
		REPLACE fecha	 	WITH m.fechas     ,;
				tipocomp 	WITH "Total"      ,;
				nombre		WITH "******* TOTAL GENERAL *******"    ,;
				subtotal 	WITH m.subtotal  ,;
				ivari		WITH m.ivari     ,;
				ivarni		WITH m.ivarni    ,;
				ivanoc		WITH m.ivanoc    ,;
				impuesto	WITH m.impuesto  ,;
				total		WITH m.total
	ENDIF
RETURN

PROCEDURE p_ivavta

DEFINE WINDOW peivavta AT  0.000, 0.000  SIZE 23.000,120.000 ;
	TITLE 'Libro Iva Ventas' ;
	FONT "Ms Sans Serif", 8 ;
	NOCLOSE NOMINIMIZE NOFLOAT;
	DOUBLE ;
	COLOR SCHEME 1

MOVE WINDOW peivavta CENTER
ACTIVATE WINDOW peivavta

SELECT (divavta)
		
BROWSE WINDOW peivavta;
	FIELD fecha      :H='Fecha '       :R,;
    	  tipocomp   :H='Tipo'        :R,;
	      numero     =TRAN(numero1,'@L 9999')+'-'+TRAN(numero2,'@L 99999999') :H='Número'       :R,;
		  nombre     :H='Nombre'      :R,;
		  cuit       :H='CUIT'        :R,;
		  iva		 :H='Res. Iva'    :R,;
	      subtotal   :H='Subtotal'    :R,;
	      ivari      :H='IVA ins.'    :R,;
	      ivarni     :H='IVA No ins.' :R,;
	      ivanoc     :H='Perc. DGI'   :R,;
	      impuesto   :H='Imp. Int.'   :R,;
    	  Total      :H='Total'       :R;
		NODELETE NOMENU

RELEASE WINDOW peivavta

RETURN


PROCEDURE i_ivavta
	SELECT (divavta)
	
	GO TOP
	REPOR FORM ivavta TO PRINT NOCONSOLE
	
	SET RELATION TO
	
RETURN

*       *********************************************************
*       *                                                         
*       * _S2R14PEZ6           m.imprimir VALID                   
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         L_IVAVTA,     Record Number:   10  
*       * Variable:            m.imprimir                         
*       * Called By:           VALID Clause                       
*       * Object Type:         Push Button                        
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*
FUNCTION _s2r14pez6     &&  m.imprimir VALID
#REGION 1
IF PRINTSTATUS()
	DO g_ivavta
	DO i_ivavta
ELSE
	WAIT 'Impresora No activa ' WINDOW NOWAIT
ENDIF
RETURN .T.
