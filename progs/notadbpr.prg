*       *********************************************************
*       *                                                         
*       * 28/01/99             NOTADBPR.PRG               17:21:50 
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

** quecon = "CONTADO"  
**          "CUENTA CORRIENTE" 
** quecom = "N. CREDITO", "N. DEBITO"
PARAMETERS quecom, quecon

RELEASE m.fecha, m.numero1, m.numero2, m.proveedor, m.nombre, ;
	m.direccion, m.localidad, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr, m.totsel, m.tselcomp

PUBLIC m.fecha, m.numero1, m.numero2, m.proveedor, m.nombre, ;
	m.direccion, m.localidad, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr, m.totsel, m.tselcomp

m.totsel = 0
m.tselcomp = SPACE(8)
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
	IF UPPER(quecom)="N. CREDITO"
		STORE "NOTA DE CREDITO" TO quecompte
	ELSE
		STORE "NOTA DE DEBITO"	TO quecompte
	ENDIF
	DEFINE WINDOW ventana ;
		AT  0.000, 0.000  ;
		SIZE 23.000,89.429 ;
		TITLE quecompte+" "+quecon ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *        NOTADBPR/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1

IF USED("compras1")
	SELECT compras1
ELSE
	SELECT 0
	USE (LOCFILE("compras1.dbf", "DBF", "Buscar compras1?")) ;
		SHARED AGAIN ALIAS compras1
ENDIF

IF USED("compras2")
	SELECT compras2
ELSE
	SELECT 0
	USE (LOCFILE("compras2.dbf", "DBF", "Buscar compras2?")) ;
		SHARED AGAIN ALIAS compras2
ENDIF

IF USED("comprob")
	SELECT comprob
	SET ORDER TO comprob
ELSE
	SELECT 0
	USE (LOCFILE("comprob.dbf", "DBF", "Buscar comprob?")) ;
		SHARED AGAIN ALIAS comprob ;
		ORDER comprob
ENDIF

IF quecom = "N. CREDITO"
	STORE 4		TO m.tipo
ELSE
	STORE 5		TO m.tipo
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

IF USED("fijo")
	SELECT fijo
ELSE
	SELECT 0
	USE (LOCFILE("fijo.dbf", "DBF", "Buscar fijo?")) ;
		SHARED AGAIN ALIAS fijo 
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

IF USED("articulo")
	SELECT articulo
	SET ORDER TO articulo1
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo ;
		ORDER articulo1
ENDIF

IF USED("aplicadc")
	SELECT aplicadc
	SET ORDER TO aplicadc1
ELSE
	SELECT 0
	USE (LOCFILE("aplicadc.dbf", "DBF", "Buscar aplicadc?")) ;
		SHARED AGAIN ALIAS aplicadc ;
		ORDER aplicadc1
ENDIF

IF quecon = "CONTADO"
	STORE "contapr1" 	TO m.fichero
	STORE "contapr2"	TO mfichero2

	IF USED("contapr1")
		SELECT contapr1
		SET ORDER TO contapr1
	ELSE
		SELECT 0
		USE (LOCFILE("contapr1.dbf", "DBF", "Buscar contapr1?")) ;
			SHARED AGAIN ALIAS contapr1 ;
			ORDER contapr1
	ENDIF

	IF USED("contapr2")
		SELECT contapr2
		SET ORDER TO contapr1
	ELSE
		SELECT 0
		USE (LOCFILE("contapr2.dbf", "DBF", "Buscar contapr2?")) ;
			SHARED AGAIN ALIAS contapr2 ;
			ORDER contapr1
	ENDIF
ELSE
	STORE "ctactpr1"		TO m.fichero
	STORE "ctactpr2"		TO mfichero2

	IF USED("ctactpr1")
		SELECT ctactpr1
		SET ORDER TO ctactpr1
	ELSE
		SELECT 0
		USE (LOCFILE("ctactpr1.dbf", "DBF", "Buscar ctactpr1?")) ;
			SHARED AGAIN ALIAS ctactpr1 ;
			ORDER ctactpr1
	ENDIF

	IF USED("ctactpr2")
		SELECT ctactpr2
		SET ORDER TO ctactpr1
	ELSE
		SELECT 0
		USE (LOCFILE("ctactpr2.dbf", "DBF", "Buscar ctactpr2?")) ;
			SHARED AGAIN ALIAS ctactpr2 ;
			ORDER ctactpr1
	ENDIF
ENDIF

IF USED("lista")
	SELECT lista
	SET ORDER TO lista
ELSE
	SELECT 0
	USE (LOCFILE("lista.dbf", "DBF", "Buscar lista?")) ;
		SHARED AGAIN ALIAS lista ;
		ORDER lista
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


STORE " " 		TO m.aceptar, m.cancelar
STORE DATE()	TO m.fecha
STORE 0			TO m.numero1, m.numero2, m.total, ;
				m.subtotal, m.ivari, m.ivarni, m.ivanoc, ;
				m.impuesto, m.iva, m.dgr
STORE 1			TO m.lista
STORE SPACE(4)	TO m.proveedor
STORE SPACE(3)	TO aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion
STORE SPACE(8)	TO tdetalle
STORE "RI "		TO m.iva
STORE fijo.ivari	TO m.porivari
STORE fijo.ivarni	TO m.porivarni
STORE fijo.ivanoc	TO m.porivanoc
STORE .F.			TO m.haydet

SELECT (m.fichero)


IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 18.188,0.000 TO 18.188,89.143 ;
	PEN 1, 8 ;
	STYLE "1"
@ 8.438,0.000 TO 8.438,89.143 ;
	PEN 1, 8 ;
	STYLE "1"
@ 20.563,0.000 TO 20.563,89.143 ;
	PEN 1, 8 ;
	STYLE "1"
@ 8.500,4.714 SAY "Cant." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,10.714 SAY "Rubro" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,16.857 SAY "Art." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,21.143 SAY "Descripción" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,47.857 SAY "Lista" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,61.000 SAY "P. Unit." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 8.500,84.000 SAY "Total" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 9.500,0.000 TO 9.500,89.143 ;
	PEN 1, 8 ;
	STYLE "1"
@ 0.125,6.143 SAY "Fecha:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 1.313,2.614 SAY "Proveedor:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 2.500,3.429 SAY "Dirección:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 3.688,52.143 SAY "Teléfono:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,0.000 SAY "Condición vta:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 0.125,52.857 SAY "Número:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,6.857 SAY "Subtotal" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,19.286 SAY "Iva insc." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 3.688,28.000 SAY "CUIT:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 4.875,9.000 SAY "Iva:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 2.500,51.286 SAY "Localidad:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 4.875,55.286 SAY "Total" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,28.714 SAY "Perc. DGI" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
*@ 18.313,57.143 SAY "Imp. int." ;
*	FONT "MS Sans Serif", 10 ;
*	STYLE "T"
@ 18.313,42.143 SAY "Perc. DGR" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 6.063,7.571 SAY "Lista:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
	
=ftipoa()
=fnumero2()

@ 0.188,12.571 GET m.fecha ;
	SIZE 1.000,10.429 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@KE" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID fctrfech(m.fecha,"m.fecha")	AND m.fecha <= DATE()
@ 0.188,60.857 GET m.tipo ;
	SIZE 1.000,2.857 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99" ;
	COLOR ,RGB(,,,255,255,255) ;
	WHEN .F. 
*	VALID LASTKEY() = 5 OR ftipoa()
@ 0.188,64.714 GET m.numero1 ;
	SIZE 1.000,4.857 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 9999" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID m.numero1>=0
@ 0.188,70.571 GET m.numero2 ;
	SIZE 1.000,9.000 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99999999" ;
	COLOR ,RGB(,,,255,255,255);
	VALID fnumero2()
@ 1.375,12.571 GET m.proveedor ;
	SIZE 1.000,4.857 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXX" ;
	COLOR ,RGB(,,,255,255,255);
	VALID LASTKEY() = 5 OR fprovedor()
@ 1.375,18.429 GET m.nombre ;
	SIZE 1.000,60.429 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	WHEN factivar() ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID fdesac()
@ 2.563,12.571 GET m.direccion ;
	SIZE 1.000,34.143 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXX" ;
	COLOR ,RGB(,,,255,255,255)
@ 2.563,60.857 GET m.localidad ;
	SIZE 1.000,21.000 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXX" ;
	COLOR ,RGB(,,,255,255,255)
@ 3.750,33.429 GET m.cuit ;
	SIZE 1.000,14.429 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99-99999999-9" ;
	COLOR ,RGB(,,,255,255,255)
@ 3.750,60.857 GET m.telefono ;
	SIZE 1.000,20.143 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K" ;
	COLOR ,RGB(,,,255,255,255)
@ 4.938,12.571 GET m.iva ;
	SIZE 1.000,4.429 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	WHEN faniva() ;
	PICTURE "@KA XXX" ;
	VALID _s21117tx7() ;
	COLOR ,RGB(,,,255,255,255)

@ 6.125,12.571 GET m.lista ;
	SIZE 1.000,2.000 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR flista()

@ 7.313,12.571 GET m.condicion ;
	SIZE 1.000,20.143 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K" ;
	COLOR ,RGB(,,,255,255,255)

@ 7.313,80.714 GET m.porivari ;
	SIZE 1.000,6.286 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99.99" ;
	VALID LASTKEY() = 5 OR fiva() ;
	COLOR ,RGB(,,,255,255,255)

@ 9.625,0.143 GET m.detalle ;
	PICTURE "@*IHN " ;
	SIZE 8.500,88.143,0.571 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	WHEN vnotadb() AND .F.
	
@ 4.938,60.857 GET m.total ;
	SIZE 1.000,14.615 ;
	FONT "MS Sans Serif", 18 ;
	STYLE "B" ;
	PICTURE "9,999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	WHEN !m.haydet;
	VALID LASTKEY() = 5 OR ftotalsd() 

@ 19.438,0.714 GET m.subtotal ;
	SIZE 1.000,13.143 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255);
	WHEN  !m.haydet;
	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,14.714 GET m.ivari ;
	SIZE 1.000,11.429 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255);
	WHEN !m.haydet;
	VALID LASTKEY() = 5 OR ftotalsd() 

@ 19.438,27.000 GET m.impuesto ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255);
	WHEN !m.haydet ;
	VALID LASTKEY() = 5 OR ftotalsd() 

*@ 19.438,27.000 GET m.ivarni ;
*	SIZE 1.000,11.571 ;
*	FONT "MS Sans Serif", 10 ;
*	PICTURE "999,999.99" ;
*	COLOR ,RGB(,,,255,255,255);
*	WHEN !m.haydet AND EMPTY(m.ivanoc);
*	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,39.429 GET m.dgr ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255);
	WHEN !m.haydet AND EMPTY(m.ivarni);
	VALID LASTKEY() = 5 OR ftotalsd() 
*@ 19.438,51.857 GET m.impuesto ;
*	SIZE 1.000,11.571 ;
*	FONT "MS Sans Serif", 10 ;
*	PICTURE "999,999.99" ;
*	COLOR ,RGB(,,,255,255,255);
*	WHEN !m.haydet;
*	VALID LASTKEY() = 5 OR ftotalsd() 
@ 21.063,21.286 GET m.aceptar ;
	PICTURE "@*HN \<Aceptar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.aceptar)
@ 21.063,35.429 GET m.cancelar ;
	PICTURE "@*HN \<Cancelar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.cancelar)

IF NOT WVISIBLE("ventana")
	ACTIVATE WINDOW ventana
ENDIF

READ CYCLE MODAL

RELEASE WINDOW ventana

#REGION 1

IF USED("compras1")
	SELECT compras1
	USE
ENDIF

IF USED("compras2")
	SELECT compras2
	USE
ENDIF

IF USED("contapr1")
	SELECT contapr1
	USE
ENDIF

IF USED("contapr2")
	SELECT contapr2
	USE
ENDIF

IF USED("ctactpr1")
	SELECT ctactpr1
	USE
ENDIF

IF USED("ctactpr2")
	SELECT ctactpr2
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	SET KEY TO 
	USE
ENDIF

IF USED("tipoiva")
	SELECT tipoiva
	USE
ENDIF

IF USED("fijo")
	SELECT fijo
	USE
ENDIF

IF USED("rubro")
	SELECT rubro
	USE
ENDIF

IF USED("articulo")
	SELECT articulo
	USE
ENDIF

IF USED("aplicadc")
	SELECT aplicadc
	USE
ENDIF

IF USED(m.fichero)
	SELECT (m.fichero)
	USE
ENDIF

IF USED(mfichero2)
	SELECT (mfichero2)
	USE
ENDIF

IF USED("lista")
	SELECT lista
	USE
ENDIF

IF USED("provedor")
	SELECT provedor
	USE
ENDIF

IF USED(tdetalle)
	SELECT (tdetalle)
	USE
ENDIF

IF USED(tselcomp)
	SELECT (tselcomp)
	USE
	DELETE FILE &tselcomp..+'.CDX'
ENDIF


RELEASE m.fecha, m.tipo, m.numero1, m.numero2, m.proveedor, m.nombre, ;
	m.direccion, m.localidad, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva, ;
	mfichero2, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr, m.totsel, m.tselcomp


#REGION 1
PROCEDURE boton
PARAMETERS m.boton
SELECT (m.fichero)
	DO CASE
		CASE ALLTRIM(UPPER(m.boton))=="ACEPTAR"
				IF control()
					IF m.total # 0
						DO guardar
					ENDIF
					DO clearven
					=mosdet()
					DO ftotales IN vnotadb
					_curobj=1
				ENDIF
								
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				DO clearven
				=mosdet()
				DO ftotales IN vnotadb
				_curobj=1

	ENDCASE
RETURN

PROCEDURE guardar


SELECT (m.fichero)
APPEND BLANK
DO WHILE !RLOCK()
ENDDO
REPLACE fecha		WITH m.fecha, ;
		tipo		WITH comprob.tipo,;
		numero1 	WITH m.numero1,;
		numero2		WITH m.numero2,;
		proveedor	WITH m.proveedor,;
		nombre		WITH m.nombre,;
		direccion	WITH m.direccion,;
		localidad	WITH m.localidad,;
		iva			WITH m.iva,;
		cuit		WITH m.cuit,;
		telefono	WITH m.telefono,;
		condicion	WITH m.condicion,;
		subtotal	WITH m.subtotal,;
		impuesto	WITH m.impuesto,;
		ivari		WITH m.ivari,;
		ivarni		WITH m.ivarni,;
		ivanoc		WITH m.ivanoc,;
		dgr			WITH m.dgr,;
		por_desc	WITH 0 ,;
		descuento	WITH 0 ,;
		descuento1	WITH 0 ,;
		total		WITH m.total,;
		facturado	WITH .T.

	IF quecon # "CONTADO"
		IF m.tipo = 4 OR m.tipo = 5
			REPLACE pagado WITH .T.
		ELSE	
			REPLACE pagado WITH .F.
		ENDIF
	ENDIF

	IF USED("usuario")
		REPLACE	usuario		WITH usuario.usuario
	ENDIF
		
UNLOCK ALL

*** Guardar para el libro iva compras

IF BETWEEN(m.tipo,4,7)
	SELECT compras1
	APPEND BLANK
	DO WHILE !RLOCK()
	ENDDO
	REPLACE fecha		WITH m.fecha
	REPLACE tipo		WITH comprob.tipo
	REPLACE	numero1 	WITH m.numero1
	REPLACE	numero2		WITH m.numero2
	REPLACE	proveedor	WITH m.proveedor
	REPLACE	nombre		WITH m.nombre
	REPLACE	direccion	WITH m.direccion
	REPLACE	localidad	WITH m.localidad
	REPLACE	iva			WITH m.iva
	REPLACE	cuit		WITH m.cuit
	REPLACE	telefono	WITH m.telefono
	REPLACE	condicion	WITH m.condicion
	REPLACE	subtotal	WITH m.subtotal
	REPLACE	impuesto	WITH m.impuesto
	REPLACE	tasaivari   WITH m.porivari
	REPLACE	ivari		WITH m.ivari
	REPLACE	tasaivarni  WITH m.porivarni
	REPLACE	ivarni		WITH m.ivarni
	REPLACE dgr			WITH m.dgr
	REPLACE	tasaivanoc  WITH m.porivanoc
	REPLACE	ivanoc		WITH m.ivanoc
	REPLACE	por_desc	WITH 0
	REPLACE	descuento	WITH 0 
	REPLACE	descuento1	WITH 0 
	REPLACE	total		WITH m.total

	UNLOCK ALL
ENDIF

IF USED(tdetalle)
	SELECT (tdetalle)
	GO TOP
	SCAN
		IF !EMPTY(total)	
			SELECT (mfichero2)
			APPEND BLANK
			DO WHILE !RLOCK()
			ENDDO
			REPLACE fecha		WITH m.fecha			 ,;
					tipo		WITH comprob.tipo		 ,;
					numero1		WITH m.numero1			 ,;
					numero2		WITH m.numero2			 ,;
					rubro		WITH &tdetalle..rubro	 ,;
					descripcio  WITH &tdetalle..descripcio,;
					cantidad    WITH &tdetalle..cantidad ,;
					articulo	WITH &tdetalle..articulo ,;
					unitario	WITH &tdetalle..unitario ,;
					impuesto	WITH &tdetalle..impuesto ,;
					lista		WITH &tdetalle..lista	 ,;
					por_desc	WITH 0                   ,;
					descuento	WITH 0                   ,;
					ivari		WITH &tdetalle..ivari	 ,;
					ivarni		WITH &tdetalle..ivarni	 ,;
					total		WITH &tdetalle..total
		
			UNLOCK ALL
		
			IF BETWEEN(m.tipo,4,7)
				SELECT compras2
				APPEND BLANK
				DO WHILE !RLOCK()
				ENDDO
				REPLACE fecha		WITH m.fecha			 ,;
						tipo		WITH comprob.tipo		 ,;
						numero1		WITH m.numero1			 ,;
						numero2		WITH m.numero2			 ,;
						rubro		WITH &tdetalle..rubro	 ,;
						articulo	WITH &tdetalle..articulo ,;
						descripcio  WITH &tdetalle..descripcio,;
						cantidad    WITH &tdetalle..cantidad ,;
						unitario	WITH &tdetalle..unitario ,;
						impuesto	WITH &tdetalle..impuesto ,;
						lista		WITH &tdetalle..lista	 ,;
						por_desc	WITH 0                   ,;
						descuento	WITH 0                   ,;
						ivari		WITH &tdetalle..ivari	 ,;
						ivarni		WITH &tdetalle..ivarni	 ,;
						total		WITH &tdetalle..total
		
				UNLOCK ALL
			ENDIF				
		ENDIF
	
		IF !EMPTY(&tdetalle..rubro)    AND ;
		   !EMPTY(&tdetalle..articulo) AND ;
		   &tdetalle..stock  
			** Si se actualiza el stock de artículos 

			SELECT articulo
			SET ORDER TO articulo1
			SEEK &tdetalle..rubro + &tdetalle..articulo

			IF FOUND()
				DO WHILE !RLOCK()
				ENDDO
				IF m.tipo = 4 OR m.tipo = 5
					REPLACE actual WITH actual - &tdetalle..cantidad
				ELSE
					REPLACE actual WITH actual + &tdetalle..cantidad
				ENDIF
				UNLOCK ALL
			ENDIF

		ENDIF

		SELECT (tdetalle)
	ENDSCAN
ENDIF

IF UPPER(quecon) # "CONTADO" 
	** Actualizar saldos de proveedores
	** si es ctactpr 

	DO act_pro WITH IIF(INLIST(m.tipo,4,5),"B","A"), m.fecha, m.proveedor, m.total

	IF m.tipo = 4 OR m.tipo = 5
		IF USED(tselcomp) AND m.totsel <> 0

			SELECT (tselcomp)
			GO TOP

			SCAN
				IF Selecciono = "S" AND descuento > 0
					** agrego los datos en aplicado
					SELECT aplicadc
					APPEND BLANK
					DO WHILE NOT RLOCK()
					ENDDO
					REPLACE 	fecha		WITH m.fecha,;
								tipo		WITH m.tipo,;
								numero1		WITH m.numero1,;
								numero2		WITH m.numero2,;
								importe		WITH &tselcomp..descuento,;
								cfecha		WITH &tselcomp..fecha,;
								ctipo		WITH &tselcomp..tipo,;
								cnumero1	WITH &tselcomp..numero1,;
								cnumero2	WITH &tselcomp..numero2
				ENDIF
				SELECT (tselcomp)
			ENDSCAN
			UNLOCK ALL
		ENDIF
	ENDIF

ELSE
		SELECT comprob
		gregis = RECNO()


		IF m.tipo = 4 OR m.tipo = 5

			SEEK STR(8,2)

			DO act_papr WITH "A", m.fecha, m.tipo, m.numero1, m.numero2, ;
					m.proveedor, m.nombre, ' ', m.direccion, ;
					m.localidad, m.iva, m.cuit, m.telefono, m.total, ;
					m.fecha, comprob.tipo, comprob.numero1, comprob.numero2+1

			** la nota de credito va a ingreso
		ELSE

			SEEK STR(15,2)

			DO act_papr WITH "A", m.fecha, m.tipo, m.numero1, m.numero2, ;
					m.proveedor, m.nombre, ' ', m.direccion, ;
					m.localidad, m.iva, m.cuit, m.telefono, m.total, ;
					m.fecha, comprob.tipo, comprob.numero1, comprob.numero2+1

			** la nota de debito va a egreso

		ENDIF
	
		SELECT comprob
		DO WHILE !RLOCK()
		ENDDO
		REPLACE numero2	WITH numero2 + 1
		UNLOCK ALL

		GO gregis
ENDIF

RETURN


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
*       * _S21117TX7           m.iva VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         NOTADBPR,     Record Number:   46   
*       * Variable:            m.iva                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION faniva

aniva = m.iva


FUNCTION _s21117tx7     &&  m.iva VALID
#REGION 1
IF EMPTY(m.iva)
	@ 4.938,18.000 SAY " " ;
		SIZE 1.000,24.429 ;
		FONT "MS Sans Serif", 10
	RETURN .T.
ENDIF
SELECT tipoiva

SEEK m.iva

IF !FOUND()
	SEEK 'RI'
	DO browenc WITH "descripcio :H='Tipos de Resp. Iva'",29,"descripcio"
ENDIF

IF m.tipo = 4 OR m.tipo = 6
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		IF m.tipo = 4
			STORE 5		TO m.tipo
		ELSE
			STORE 7		TO m.tipo
		ENDIF
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	IF INLIST(tipoiva.codigo,"RI ","RNI")
		IF m.tipo = 5
			STORE 	4	TO m.tipo
		ELSE
			STORE 6		TO m.tipo
		ENDIF
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ENDIF

STORE tipoiva.codigo	TO m.iva
@ 4.938,18.000 SAY Tipoiva.descripcio ;
	SIZE 1.000,24.429 ;
	FONT "MS Sans Serif", 10


IF USED(tdetalle) 
*AND m.iva # aniva
	** Volver a calcular los importes del comprobante
	DO v_calcular IN vnotadb
ENDIF

RETURN .T.


FUNCTION mosdet
PRIVATE mlinea
STORE 9.625 TO mlinea
STORE ''    TO valim

ACTIVATE WINDOW ventana

IF USED(tdetalle)
	SELECT (tdetalle)
	GO TOP

	SCAN 
	
		IF mlinea <= 17.063 AND !EMPTY(descripcio)

			@ mlinea,0.286 SAY cantidad ;
				SIZE 1.000,10.429 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "9999999.9"
			@ mlinea,11.429 SAY rubro ;
				SIZE 1.000,3.429 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "XXX"
			@ mlinea,15.571 SAY articulo ;
				SIZE 1.000,4.857 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "XXXX"
			@ mlinea,21.143 SAY descripcio ;
				SIZE 1.000,28.000 ;
				FONT "MS Sans Serif", 10
			@ mlinea,49.857 SAY lista ;
				SIZE 1.000,2.000 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "99"
			@ mlinea,52.571 SAY unitario ;
				SIZE 1.000,14.571 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "9999.999999"
			@ mlinea,75.143 SAY total ;
				SIZE 1.000,13.286 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "999,999.99"
	
			STORE mlinea + 1.063 TO mlinea
			STORE .T.			 TO m.haydet
		ENDIF
	

	ENDSCAN
ENDIF

DO WHILE mlinea <= 17.063
		@ mlinea,0.286 SAY valim ;
			SIZE 1.000,88.429 ;
			FONT "MS Sans Serif", 10
	STORE mlinea + 1.063 TO mlinea
ENDDO

RETURN .T.


FUNCTION ftipoa

SELECT comprob

SEEK STR(m.tipo,2)
IF !FOUND()
	DO browenc WITH "descripcio :H='Comprobantes'",20,"descripcio"
ENDIF
STORE comprob.tipo 	TO m.tipo

@ 0.188,81.000 SAY comprob.codigo ;
	SIZE 1.000,9.000 ;
	FONT "MS Sans Serif", 10

SHOW GET m.numero1
SHOW GET m.numero2
RETURN .T.

FUNCTION fprovedor

IF EMPTY(m.proveedor)
	RETURN .T.
ENDIF

SELECT provedor
SET ORDER TO provedor1

SEEK m.proveedor

IF !FOUND()
	SET ORDER TO provedor2
	DO browenc WITH "nombre :H='Proveedores'",53,"nombre"
	SET ORDER TO provedor1
ENDIF

IF m.tipo = 5 OR m.tipo = 7
	IF INLIST(provedor.iva,"RI ","RNI")
		IF quecom = "N. CREDITO"
			STORE 4		TO m.tipo
		ELSE
			STORE 6		TO m.tipo
		ENDIF
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	IF !INLIST(provedor.iva,"RI ","RNI")
		IF quecom = "N. CREDITO"
			STORE 5		TO m.tipo
		ELSE
			STORE 7		TO m.tipo
		ENDIF
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ENDIF


STORE provedor.proveedor		TO m.proveedor
STORE provedor.nombre		TO m.nombre
STORE provedor.direccion	TO m.direccion
STORE provedor.localidad	TO m.localidad
STORE provedor.iva 			TO m.iva
STORE provedor.cuit			TO m.cuit
STORE provedor.telefono		TO m.telefono

SHOW GET m.proveedor
SHOW GET m.nombre
SHOW GET m.direccion
SHOW GET m.localidad
SHOW GET m.iva
SHOW GET m.cuit
SHOW GET m.telefono

=_s21117tx7()
_CUROBJ=OBJNUM(m.nombre)
RETURN .T.


FUNCTION flista

IF LASTKEY() = 5
	RETURN .T.
ENDIF

SELECT lista

COUNT TO creg FOR !DELETED()

IF creg > 0 AND m.lista # 1
	SEEK STR(m.lista,2)
	
	IF !FOUND()
		DO browenc WITH "descripcio :H='Listas'",29,"descripcio"
	ENDIF
	STORE lista.numero		TO m.lista
	@ 6.125,15.571 SAY lista.descripcio ;
		SIZE 1.000,41.286 ;
		FONT "MS Sans Serif", 10
ELSE
	STORE 1	TO m.lista
	@ 6.125,15.571 SAY "Lista Nro. 1" ;
		SIZE 1.000,41.286 ;
		FONT "MS Sans Serif", 10
ENDIF

RETURN .T.

FUNCTION fnumero2
PRIVATE usado, registro, orden, cta1, cta2
STORE .F.	TO cta1, cta2, usado

IF m.numero2 = 0
	RETURN .F.
ENDIF

** Buscar en m.fichero si existe este número de comprobante

IF USED(m.fichero)
	SELECT (m.fichero)
	STORE .t.		TO usado
	STORE RECNO()	TO registro
	STORE ORDER()	TO orden
	SET ORDER TO (m.fichero)
ELSE
	SELECT 0
	USE (LOCFILE(m.fichero+".dbf", "DBF", "Buscar"+m.fichero+"?")) ;
		SHARED AGAIN ALIAS (m.fichero) ;
		ORDER (m.fichero)
	
ENDIF

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE .T.	TO cta1
ENDIF


IF usado
	SELECT (m.fichero)
	SET ORDER TO (orden)
	IF registro <= RECCOUNT()
		GO registro
	ENDIF
ENDIF

STORE .F. 	TO usado

IF USED(IIF(m.fichero="ctactpr1","contapr1","ctactpr1"))
	SELECT IIF(m.fichero="ctactpr1","contapr1","ctactpr1")
	STORE .t.		TO usado
	STORE RECNO()	TO registro
	STORE ORDER()	TO orden
	IF m.fichero = "ctactpr1"
		SET ORDER TO contapr1
	ELSE
		SET ORDER TO ctactpr1
	ENDIF
ELSE
	SELECT 0
	IF m.fichero = "ctactpr1"
		USE contapr1 SHARED AGAIN ORDER contapr1
	ELSE
		USE ctactpr1	SHARED AGAIN ORDER ctactpr1
	ENDIF
	
ENDIF

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE .T.	TO cta2
ENDIF

IF usado
	SELECT IIF(m.fichero="ctactpr1","contapr1","ctactpr1")
	SET ORDER TO (orden)
	IF registro <= RECCOUNT()
		GO registro
	ENDIF
ENDIF

RETURN !cta1 AND !cta2


PROCEDURE clearven
STORE 0			TO m.total, m.subtotal, m.ivari, m.ivarni, ;
				m.ivanoc, m.impuesto, m.iva, m.dgr
STORE SPACE(4)	TO m.proveedor
STORE SPACE(3)	TO m.iva, aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion

IF USED(tdetalle)
	SELECT (tdetalle)
	USE
ENDIF
STORE SPACE(8)	TO tdetalle
SHOW GETS
=ftipoa()
RETURN

FUNCTION control

IF EMPTY(m.fecha)	
	_CUROBJ=OBJNUM(m.fecha)
	WAIT "La fecha No puede estar vacia" WINDOW NOWAIT
	RETURN .F.
ENDIF

IF EMPTY(m.numero2)
	=ftipoa()
ENDIF

IF EMPTY(m.proveedor) AND quecon # "CONTADO"
	_CUROBJ=OBJNUM(m.proveedor)
	WAIT "El código de proveedor No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.nombre) 
	_CUROBJ=OBJNUM(m.nombre)
	WAIT "El nombre No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.cuit) 
	IF INLIST(m.iva,'RI ','RNI','MON','EXE')
		_CUROBJ=OBJNUM(m.cuit)
		WAIT "El C.U.I.T. No puede estar vacio" WINDOW NOWAIT
		RETURN .F.
	ENDIF
ENDIF
IF EMPTY(m.iva) 
	_CUROBJ=OBJNUM(m.iva)
	WAIT "Iva No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	

IF INLIST(m.tipo,2,4,6)
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		WAIT "Iva no corresponde a Comp. A" WINDOW NOWAIT
		_CUROBJ=OBJNUM(m.iva)
		RETURN .F.
	ENDIF
ELSE
	IF INLIST(tipoiva.codigo,"RI ","RNI")
		WAIT "Iva no corresponde a Comp. B" WINDOW NOWAIT
		_CUROBJ=OBJNUM(m.iva)
		RETURN .F.
	ENDIF
ENDIF

RETURN

FUNCTION fiva

m.porivarni = ROUND(m.porivari / 2,2)
m.porivanoc = ROUND(m.porivari / 2,2)

RETURN .T.

PROCEDURE ftotalsd
PRIVATE mneto, mtotal
STORE 0	TO mneto, mtotal

** Calcular el neto 
mtotal = m.total - m.impuesto - m.dgr

mneto = ROUND(mtotal/ (1 + (m.porivari / 100)),2)

m.ivari = ROUND(mneto * m.porivari / 100,2)

** calcular porc. iva NOC o RNI 

IF m.iva = "RNI"
	m.ivanoc = 0	
	m.ivarni = ROUND(mneto * (m.porivarni / 100),2)
ENDIF

IF m.iva = "NOC"
	m.ivarni = 0
	mivanoc = ROUND(mneto * (m.porivanoc / 100),2)
ENDIF

IF m.iva = "RI "
	m.ivarni = 0
	m.ivanoc = 0
ENDIF

m.subtotal = m.total - m.ivarni - m.ivari - m.ivanoc - m.impuesto - m.dgr

SHOW GETS

RETURN .T.

FUNCTION factivar
IF m.tipo = 4 OR m.tipo = 5
	** Activar tecla para seleccionar facturas
	** solo cuando sea nota de credito
	ON KEY LABEL F12 DO vernotcc
	
	anventana = WONTOP()
	ACTIVATE WINDOW VENTANA SAME
	@ 21.063,55.429 SAY "F12 = Sel. Facturas " ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	
	ACTIVATE WINDOW (anventana) SAME
ENDIF
RETURN .T.

FUNCTION fdesac
IF m.tipo = 4 OR m.tipo = 5
	** Desactivar tecla para seleccionar facturas
	** solo cuando sea nota de credito
	ON KEY LABEL F12

	anventana = WONTOP()
	ACTIVATE WINDOW VENTANA SAME

	@ 21.063,55.429 SAY " " ;
		SIZE 1.000, 30.000 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B"
	ACTIVATE WINDOW (anventana) SAME

ENDIF
RETURN .T.
