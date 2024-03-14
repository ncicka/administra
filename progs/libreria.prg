******* PROCEDIMIENTOS PARA ACTUALIZACIONES *****************

FUNCTION fimpues_u
STORE 0	TO munitario, mimpuesto, mivari


IF t_impuesto = "%"
	munitario = unitario / (1 + (fijo.ivari + p_impuesto ) / 100)
	mimpuesto = mneto * p_impuesto / 100
ELSE
	mimpuesto = p_impuesto
	munitario = (unitario - p_impuesto) / (1 + fijo.ivari  / 100)
ENDIF
mivari = unitario - munitario - mimpuesto

RETURN .T.

PROCEDURE clearven
	SELECT (m.fichero)
	SCATTER MEMVAR MEMO BLANK
	SHOW GETS
RETURN

PROCEDURE muestven
	SELECT (m.fichero)
	SCATTER MEMVAR MEMO
	SHOW GETS
	IF (RECCOUNT() = 0 OR EOF()) AND !m.activar AND !m.modificar
		SHOW GET m.boton1,1 ENABLE
		SHOW GET m.boton2,1 DISABLE
		SHOW GET m.boton3,1 DISABLE
		SHOW GET m.boton4,1 DISABLE		
		SHOW GET m.boton5,1 DISABLE
		SHOW GET m.boton6,1 DISABLE
		SHOW GET m.boton7,1 ENABLE
	ENDIF	
RETURN

PROCEDURE cieroabr
	PRIVATE rega,ent, etiqueta
		
	SELECT (m.fichero)
	rega=RECNO()
	etiqueta = ORDER()
	entorno=SYS(3)
	CREATE VIEW (entorno)
	CLOSE DATABASES
	ent=entorno+".vue"
	IF FILE(ent)
	   SET VIEW TO (entorno)
	   SET TALK OFF
	   DELETE FILE (ent)
	ENDIF
	SELECT (m.fichero)
	SET ORDER TO (etiqueta)
	IF rega>RECCOUNT()
		GO BOTTOM
	ELSE
		GO rega
	ENDIF
RETURN

PROCEDURE buscando
	SELECT (m.fichero)
	DO buscar.spr
	SELECT (m.fichero)
	DO muestven
RETURN

PROCEDURE eliminar
	IF borrac()
		IF EOF() OR BOF()
			WAIT WINDOW C_ENDFILE NOWAIT
			RETURN
		ENDIF
		IF fox_alert(C_DELREC)
			DO WHILE NOT RLOCK()
			ENDDO
			DELETE
			UNLOCK ALL
			IF !EOF() AND DELETED()
				SKIP 1
			ENDIF
			IF EOF()
				WAIT WINDOW C_ENDFILE NOWAIT
				GO BOTTOM
			ENDIF
			DO cieroabr 
			DO muestven
		ENDIF
	ELSE
		WAIT WINDOW NOWAIT C_MENSAJE
	ENDIF
RETURN	

PROCEDURE fox_alert
    PARAMETER wzalrtmess
    PRIVATE alrtbtn
    m.alrtbtn=1
	DEFINE WINDOW _qec1ij2t7 ;
	  AT 0.000,0.000 ;
	  SIZE 09.500,59.000;
	  FLOAT NOCLOSE NOMINIMIZE DOUBLE SHADOW ;
	  TITLE " Eliminar " ;
	  FONT "MS Sans Serif",8 ;
	  COLOR RGB(,,,192,192,192)
	MOVE WINDOW _qec1ij2t7 CENTER
	ACTIVATE WINDOW _qec1ij2t7 NOSHOW

	@ 2.000,(57.000-LEN(wzalrtmess))/2 SAY wzalrtmess ;
		FONT "MS Sans Serif", 10
		
	@ 6.000,15.000 GET m.alrtbtn ;
		SIZE 1.615,12.600,2.800 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@*HNT \?\!\<Cancelar;\<Aceptar"
	ACTIVATE WINDOW _qec1ij2t7
	READ CYCLE MODAL
	RELEASE WINDOW _qec1ij2t7
RETURN m.alrtbtn=2

PROCEDURE confirma
    PARAMETER wzalrtmess
    PRIVATE alrtbtn
    m.alrtbtn=1
	DEFINE WINDOW _qec1ij2t7 ;
	  FROM 0.000,0.000 ;
	  SIZE 09.000,59.000;
	  FLOAT NOCLOSE NOMINIMIZE DOUBLE SHADOW ;
	  TITLE " Confirmar " ;
	  FONT "MS Sans Serif",8 ;
	  COLOR RGB(,,,192,192,192)
	MOVE WINDOW _qec1ij2t7 CENTER
	ACTIVATE WINDOW _qec1ij2t7 NOSHOW
	@ 2.000,(60.000-LEN(wzalrtmess))/2 SAY wzalrtmess ;
		FONT "MS Sans Serif", 10 
		
	@ 6.000,15.000 GET m.alrtbtn ;
		SIZE 1.615,12.600,0.800 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@*HNT \?\!\<Cancelar;\<Aceptar"
	ACTIVATE WINDOW _qec1ij2t7
	READ CYCLE MODAL
	RELEASE WINDOW _qec1ij2t7
RETURN m.alrtbtn=2


PROCEDURE confirma1
    PARAMETER wzalrtmess
    PRIVATE alrtbtn
    m.alrtbtn=1
	DEFINE WINDOW _qec1ij2t7 ;
	  FROM 0.000,0.000 ;
	  SIZE 09.000,59.000;
	  FLOAT NOCLOSE NOMINIMIZE DOUBLE SHADOW ;
	  TITLE " Confirmar " ;
	  FONT "MS Sans Serif",8 ;
	  COLOR RGB(,,,192,192,192)
	MOVE WINDOW _qec1ij2t7 CENTER
	ACTIVATE WINDOW _qec1ij2t7 NOSHOW
	@ 2.000,(60.000-LEN(wzalrtmess))/2 SAY wzalrtmess ;
		FONT "MS Sans Serif", 10 
		
	@ 6.000,15.000 GET m.alrtbtn ;
		SIZE 1.615,12.600,0.800 ;
		FONT "MS Sans Serif", 8 ;
		PICTURE "@*HNT \?\!\<Aceptar;\<Cancelar"
	ACTIVATE WINDOW _qec1ij2t7
	READ CYCLE MODAL
	RELEASE WINDOW _qec1ij2t7

RETURN m.alrtbtn=1

PROCEDURE fsalida
	IF UPPER(m.p_output)=="ARCHIVO"
		SHOW GET m.pname ENABLE
		_curobj = OBJNUM(m.pname)
	ELSE
		SHOW GET m.pname DISABLE
	ENDIF
RETURN

PROCEDURE fname
	IF '.' $ m.pname OR '\' $ m.pname ;
		OR ':'$m.pname OR '*'$m.pname OR '?'$m.pname 
			RETURN .F.
	ENDIF
RETURN .T.


******** FIN PROCEDIMIENTOS PARA ACTUALIZACIONES *******************

PROCEDURE encripta
PARAMETERS word,ecrp

STORE 50  TO skp
STORE 1   TO e
STORE "" TO wordecrp

DO WHILE e < LEN(TRIM(word))+1
   STORE wordecrp+CHR(ASC(SUBSTR(word,e,1))+IIF(ecrp,skp,-skp)) ;
   											TO wordecrp
   STORE e+1 TO e
ENDDO

IF !EMPTY(wordecrp)
   RETURN wordecrp
ELSE
   RETURN "+"
ENDIF

******************** FUNCIONES DEL FILTRO DE LAS CONSULTAS ***************
FUNCTION _rsy0zzj15    
PRIVATE currwind
STORE WOUTPUT() TO currwind
#REGION 1
IF SYS(2016) = "_RSY0ZZCYB" OR SYS(2016) = "*"
	ACTIVATE WINDOW _rsy0zzcyb SAME
	@ 5,15 SAY ALLTRIM(m.filt_expr) ;
		SIZE 1,27, 0
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF

FUNCTION vfiltro     
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
	STORE 0 TO m.filtro	
	SET FILTER TO
ENDIF

SHOW GETS


FUNCTION wfiltro    
#REGION 1
IF !EMPTY(m.filt_expr)
	STORE 1	TO m.filtro
ELSE
	STORE 0	TO m.filtro
ENDIF
SHOW GETS

FUNCTION sfilter    
PRIVATE currwind
STORE WOUTPUT() TO currwind
#REGION 1
IF SYS(2016) = "_GJN12ZBVH" OR SYS(2016) = "*"
	ACTIVATE WINDOW _qjn12zbvh SAME
	@ 7,18 SAY ALLTRIM(m.filt_expr) ;
		SIZE 1,27, 0
ENDIF
IF NOT EMPTY(currwind)
	ACTIVATE WINDOW (currwind) SAME
ENDIF

FUNCTION sino                                                
   PARAMETERS mensje                                          
   STORE 'No' TO msino                                         
   DEFINE WINDOW sino FROM 01,05 TO 05,75 SHADOW COLOR SCHEME 5
   ACTIVATE WINDOW sino TOP
   @ 00,01 SAY mensje                                         
   @ 02,01 SAY 'Continúa? Si/No:' GET msino PICTURE '@M No,Si '
   READ                                                       
   DEACTIVATE WINDOW sino                                     
   RELEASE WINDOW sino
   STORE IIF(msino='Si',.t.,.f.) TO retval                     
RETURN retval                                              

FUNCTION ready2pr                                                     
  DO WHILE .NOT. PRINTSTATUS()                                        
    IF .NOT. SINO('Impresora fuera de linea...!! ')                   
      RETURN .f.                                                      
    ENDIF                                                             
  ENDDO                                                               
RETURN .t.                                                          

FUNCTION salio
   STORE 'Si' TO msino                                         
   DEFINE WINDOW sino FROM 01,05 TO 05,40 SHADOW ;
   		COLOR R/W,W+/R,R/W,R/W
   MOVE WINDOW sino CENTER
   ACTIVATE WINDOW sino TOP
   @ 00,01 SAY 'Confirma Comp.'+TRAN(m.numero2,'@L 99999999')
   @ 02,01 SAY 'Continúa? Si/No:' GET msino PICTURE "@M Si,No"
   READ                                                       
   DEACTIVATE WINDOW sino                                     
   RELEASE WINDOW sino
   STORE IIF(msino='Si',.t.,.f.) TO retval                     
	
RETURN retval

FUNCTION fimpre
PARAMETERS var

	IF VAR = "B"
		IF m.p_output = 2
			SHOW GET m.impresora ENABLE
		ELSE
			SHOW GET m.impresora DISABLE
		ENDIF
	ENDIF
	IF VAR = 'I'
		= SYS(1037)
	ENDIF
RETURN

PROCEDURE fctrfech
PARAMETERS pfecha, pvar
	PRIVATE pmes, pdia, panio
	IF BETWEEN(YEAR(pfecha),1912,1997)
		RETURN .F.
	ENDIF
	IF YEAR(pfecha)<1950
		STORE DAY(pfecha)						TO pdia
		STORE MONTH(pfecha)						TO pmes
		STORE YEAR(pfecha)						TO panio
		STORE RIGHT(TRAN(panio,'@L 9999'),2)	TO panio
		IF AT('.',pvar) < 3
			STORE CTOD(TRAN(pdia,'@L 99')+'/'+TRAN(pmes,'@L 99')+;
					'/20'+panio)	TO &pvar
			SHOW GET &pvar
		ELSE
			REPLACE &pvar	WITH CTOD(TRAN(pdia,'@L 99')+'/'+TRAN(pmes,'@L 99')+;
					'/20'+panio)
		ENDIF
	ENDIF
	IF YEAR(pfecha) > 2012
		RETURN .F.
	ENDIF
RETURN


PROCEDURE fcuit
PARAMETERS pcuit

	STORE STR(pcuit,11) TO WCUIT
	STORE SUBSTR(WCUIT,11,1) TO POSI11
	STORE SUBSTR(WCUIT,10,1) TO POSI10
	STORE SUBSTR(WCUIT,09,1) TO POSI09
	STORE SUBSTR(WCUIT,08,1) TO POSI08
	STORE SUBSTR(WCUIT,07,1) TO POSI07
	STORE SUBSTR(WCUIT,06,1) TO POSI06
	STORE SUBSTR(WCUIT,05,1) TO POSI05
	STORE SUBSTR(WCUIT,04,1) TO POSI04
	STORE SUBSTR(WCUIT,03,1) TO POSI03
	STORE SUBSTR(WCUIT,02,1) TO POSI02
	STORE SUBSTR(WCUIT,01,1) TO POSI01
	X10 = 2
	X09 = 3
	X08 = 4
	X07 = 5
	X06 = 6
	X05 = 7
	X04 = 2
	X03 = 3
	X02 = 4
	X01 = 5
	STORE VAL(POSI11) TO DIGICARG
	M10 = VAL(POSI10) * X10
	M09 = VAL(POSI09) * X09
	M08 = VAL(POSI08) * X08
	M07 = VAL(POSI07) * X07
	M06 = VAL(POSI06) * X06
	M05 = VAL(POSI05) * X05
	M04 = VAL(POSI04) * X04
	M03 = VAL(POSI03) * X03
	M02 = VAL(POSI02) * X02
	M01 = VAL(POSI01) * X01
	SUMATORIA = M01 + M02 + M03 + M04 + M05 + M06 + M07 + M08 + M09 + M10
	DIVISION  = SUMATORIA / 11
	PIO = MOD(SUMATORIA,11) 
	DIGICALC = 11 - PIO
	IF DIGICALC = 11
	   DIGICALC =  0
	ENDIF
	IF DIGICALC <> DIGICARG
	   	WAIT WINDOW " CUIT ERRONEO "
	   	RETURN .f.
	ELSE
		RETURN .t.
	ENDIF
RETURN


*************************** CALCULO DE IVA DE COMPROBANTES ********************

PROCEDURE fiva
PRIVATE mneto, mtotal, vunit
mneto = 0
mtotal = 0
vunit = 0

SELECT (tdetalle)

** Calcular el neto 

IF cantidad <> 0
	vunit = unitario - impuesto - (descuento/cantidad)
ENDIF

	*mneto = vunit/ (1 + (fijo.ivari / 100))
	mneto = vunit / (1 + (m.porivari / 100))

	*REPLACE ivari 	 WITH (mneto * fijo.ivari / 100) * cantidad
	REPLACE ivari 	 WITH (mneto * m.porivari / 100) * cantidad

** calcular porc. iva NOC o RNI 

IF m.iva = "RNI"
	REPLACE ivanoc WITH 0	
	REPLACE ivarni WITH (mneto * fijo.ivarni / 100) * cantidad 
ENDIF

IF m.iva = "NOC"
	REPLACE ivarni WITH 0
	REPLACE ivanoc WITH (mneto * fijo.ivanoc / 100) * cantidad
ENDIF

IF m.iva = "RI "
	REPLACE ivarni WITH 0
	REPLACE ivanoc WITH 0
ENDIF

RETURN .T.

*************** DESCUENTO POR ARTICULO EN COMPROBANTES ************************

FUNCTION fdesc
PRIVATE  munitario
munitario = 0

** descuento por articulo

SELECT (tdetalle)
munitario = unitario - impuesto

IF &tdetalle..por_desc > 0
	* se hace el descuento por la unidad y luego se la multiplica por cantidad
	REPLACE descuento WITH ROUND((munitario * por_desc / 100) * cantidad,2)
ELSE
	REPLACE descuento WITH 0
ENDIF

RETURN .T.


*** FUNCION PARA BUSCAR ARTICULOS DESDE LOS DETALLES DE FACTURA
*** DE VENTAS Y COMPRAS 

FUNCTION farticulo
IF LASTKEY() = 5 OR LASTKEY() = 24 OR LASTKEY() = -6
	RETURN .T.
ENDIF

annear = SET('NEAR')
SET NEAR ON
SELECT articulo
SET ORDER TO articulo1

SEEK &tdetalle..rubro+&tdetalle..articulo
IF !FOUND()
	SET ORDER TO articulo3
	SET KEY TO &tdetalle..rubro
	DO browenc WITH "descripcio :H='Artículos'",40,"descripcio"
	SET KEY TO
ENDIF

SELECT (tdetalle)
REPLACE articulo	WITH articulo.articulo
REPLACE descripcio  WITH ALLTRIM(articulo.descripcio) + " " + ALLTRIM(articulo.medida)
REPLACE p_impuesto	WITH articulo.interno
REPLACE t_impuesto	WITH articulo.fijo
REPLACE stock		WITH articulo.stock
IF EMPTY(lista)
	REPLACE lista		WITH m.lista
ENDIF

vdetalle.REFRESH
vdetalle.activatecell(RECNO(),3)
SET NEAR &annear
RETURN .T.


*** FUNCION PARA BUSCAR RUBROS DESDE LOS DETALLES DE FACTURA
*** DE VENTAS Y COMPRAS 

FUNCTION frubro

IF LASTKEY() = 5 OR LASTKEY() = 24 OR LASTKEY() = -6 OR EMPTY(rubro)
	RETURN .T.
ENDIF

SELECT rubro

SEEK &tdetalle..rubro

IF !FOUND()
	DO browenc WITH "descripcio :H='Rubros'",29,"descripcio"
ENDIF

SELECT (tdetalle)
REPLACE rubro	WITH rubro.rubro

vdetalle.REFRESH
vdetalle.activatecell(RECNO(),2)

RETURN .T.


