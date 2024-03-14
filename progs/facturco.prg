*       *********************************************************
*       *                                                         
*       * 28/01/99             FACTURCO.PRG               17:21:50 
*       * FACTURA DE COMPRAS                                                        
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
** quecom = "FACTURA", "REMITOS"
PARAMETERS quecom, quecon

RELEASE m.fecha, m.numero1, m.numero2, m.Proveedor, m.nombre, ;
	m.direccion, m.localidad, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, tselcomp, m.seleccio,  ;
	munitario, mimpuesto, mivari, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr

PUBLIC m.fecha, m.numero1, m.numero2, m.Proveedor, m.nombre, ;
	m.direccion, m.localidad, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, tselcomp, m.seleccio, ;
	munitario, mimpuesto, mivari, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr

STORE .F.	TO m.haydet
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
	STORE quecom			TO quecompte
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
*       *        FACTURA/Windows Distribución de pantalla         
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

DO CASE
	CASE quecom = "FACTURA"
		STORE 2		TO m.tipo
	OTHERWISE
		STORE 9		TO m.tipo
ENDCASE

IF m.tipo = 9
	SET FILTER TO tipo = 9
ELSE
	SET FILTER TO INLIST(tipo,2,3,10,11,16)
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

IF USED("Provedor")
	SELECT Provedor
	SET ORDER TO Provedor1
ELSE
	SELECT 0
	USE (LOCFILE("Provedor.dbf", "DBF", "Buscar Provedor?")) ;
		SHARED AGAIN ALIAS Provedor ;
		ORDER Provedor1
ENDIF


STORE " " 		TO m.aceptar, m.cancelar
STORE DATE()	TO m.fecha
STORE 0			TO m.numero1, m.numero2, m.total, ;
				m.por_desc, m.subtotal, m.ivari, m.ivarni, m.ivanoc, ;
				m.impuesto, m.descuento, m.descuento1, m.iva, m.seleccio, ;
				m.dgr
STORE 1			TO m.lista
STORE SPACE(4)	TO m.Proveedor
STORE SPACE(3)	TO aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion
STORE SPACE(8)	TO tdetalle, tselcomp
STORE "RI "		TO m.iva
STORE fijo.ivari	TO m.porivari
STORE fijo.ivarni	TO m.porivarni
STORE fijo.ivanoc	TO m.porivanoc

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
*@ 8.500,67.429 SAY "% Desc." ;
*	FONT "MS Sans Serif", 10 ;
*	STYLE "T"

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
@ 7.250,52.571 SAY "% Desc.:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,72.571 SAY "% Iva:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"

@ 18.313,79.000 SAY "Desc. x art." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,66.714 SAY "Desc. gral." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,28.714 SAY "Perc.DGR" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
*@ 18.313,57.143 SAY "Imp. int." ;
*	FONT "MS Sans Serif", 10 ;
*	STYLE "T"
@ 18.313,42.143 SAY "Perc. DGI" ;
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
	VALID LASTKEY() = 5 OR ftipoa()
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
	COLOR ,RGB(,,,255,255,255)
@ 1.375,12.571 GET m.Proveedor ;
	SIZE 1.000,4.857 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXX" ;
	COLOR ,RGB(,,,255,255,255);
	VALID LASTKEY() = 5 OR fProveedor() AND fnumero2()
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
	WHEN m.seleccio = 0;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR flista()

@ 7.313,12.571 GET m.condicion ;
	SIZE 1.000,20.143 ;
	DEFAULT " " ;
	WHEN m.seleccio = 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K" ;
	COLOR ,RGB(,,,255,255,255)
@ 7.313,60.714 GET m.por_desc ;
	SIZE 1.000,6.286 ;
	DEFAULT 0 ;
	WHEN m.seleccio = 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99.99" ;
	VALID fverdes() ;
	COLOR ,RGB(,,,255,255,255)

@ 7.313,80.714 GET m.porivari ;
	SIZE 1.000,6.286 ;
	DEFAULT 0 ;
	WHEN m.seleccio = 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99.99" ;
	VALID fiva() AND fverdes() ;
	COLOR ,RGB(,,,255,255,255)

@ 9.625,0.143 GET m.detalle ;
	PICTURE "@*IHN " ;
	SIZE 8.500,88.143,0.571 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND vdetallc() AND .F.

@ 4.938,60.857 GET m.total ;
	SIZE 1.000,14.615 ;
	FONT "MS Sans Serif", 18 ;
	STYLE "B" ;
	WHEN m.seleccio = 0 AND !m.haydet;
	PICTURE "9,999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,0.714 GET m.subtotal ;
	SIZE 1.000,13.143 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND !m.haydet;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,14.714 GET m.ivari ;
	SIZE 1.000,11.429 ;
	WHEN m.seleccio = 0 AND !m.haydet;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 

@ 19.438,27.000 GET m.DGR ;
	SIZE 1.000,11.571 ;
	WHEN m.seleccio = 0 AND !m.haydet ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 

*@ 19.438,27.000 GET m.ivarni ;
*	SIZE 1.000,11.571 ;
*	WHEN m.seleccio = 0 AND !m.haydet AND EMPTY(m.ivanoc);
*	FONT "MS Sans Serif", 10 ;
*	PICTURE "999,999.99" ;
*	COLOR ,RGB(,,,255,255,255) ;
*	VALID LASTKEY() = 5 OR ftotalsd() 

** impuesto se utiliza para guardar la perc.dgr

@ 19.438,39.429 GET m.impuesto ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND !m.haydet ;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 
*@ 19.438,51.857 GET m.impuesto ;
*	SIZE 1.000,11.571 ;
*	FONT "MS Sans Serif", 10 ;
*	WHEN m.seleccio = 0 AND !m.haydet;
*	PICTURE "999,999.99" ;
*	COLOR ,RGB(,,,255,255,255) ;
*	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,64.286 GET m.descuento ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND !m.haydet;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 
@ 19.438,76.714 GET m.descuento1 ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND !m.haydet;
	PICTURE "999,999.99" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR ftotalsd() 
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
	ACTIVATE WINDOW ventana SAME
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
	SET FILTER TO 
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

IF USED("Provedor")
	SELECT Provedor
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

RELEASE m.fecha, m.tipo, m.numero1, m.numero2, m.Proveedor, m.nombre, ;
	m.direccion, m.localidad,  m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva, ;
	mfichero2, tselcomp, m.seleccio,  ;
	munitario, mimpuesto, mivari, m.porivari, m.porivarni, m.porivanoc, ;
	m.haydet, m.dgr


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
					DO ftotales IN vdetallc
					_curobj=1
				ENDIF
								
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				DO clearven
				=mosdet()
				DO ftotales IN vdetallc
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
		Proveedor	WITH m.Proveedor,;
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
		por_desc	WITH m.por_desc,;
		descuento	WITH m.descuento,;
		descuento1	WITH m.descuento1,;
		total		WITH m.total,;
		facturado	WITH IIF(m.tipo=9,.F.,.T.)

	IF quecon # "CONTADO"
		REPLACE pagado		WITH .F.
	ENDIF

	IF USED("usuario")
		REPLACE	usuario		WITH usuario.usuario
	ENDIF
		
UNLOCK ALL

*** Guardar para el libro iva compras

IF INLIST(m.tipo,2,3,4,5,6,7,10,11,16)
	SELECT compras1
	APPEND BLANK
	DO WHILE !RLOCK()
	ENDDO
	REPLACE fecha		WITH m.fecha, ;
			tipo		WITH comprob.tipo,;
			numero1 	WITH m.numero1,;
			numero2		WITH m.numero2,;
			Proveedor	WITH m.Proveedor,;
			nombre		WITH m.nombre,;
			direccion	WITH m.direccion,;
			localidad	WITH m.localidad,;
			iva			WITH m.iva,;
			cuit		WITH m.cuit,;
			telefono	WITH m.telefono,;
			condicion	WITH m.condicion,;
			subtotal	WITH m.subtotal,;
			impuesto	WITH m.impuesto,;
			tasaivari   WITH m.porivari,;
			ivari		WITH m.ivari,;
			tasaivarni  WITH m.porivarni,;
			ivarni		WITH m.ivarni,;
			tasaivanoc  WITH m.porivanoc,;
			ivanoc		WITH m.ivanoc,;
			dgr			WITH m.dgr,;
			por_desc	WITH m.por_desc,;
			descuento	WITH m.descuento,;
			descuento1	WITH m.descuento1,;
			total		WITH m.total

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
					descripcio  WITH &tdetalle..descripcio ,;
					cantidad    WITH &tdetalle..cantidad ,;
					articulo	WITH &tdetalle..articulo ,;
					unitario	WITH &tdetalle..unitario ,;
					impuesto	WITH &tdetalle..impuesto ,;
					lista		WITH &tdetalle..lista	 ,;
					por_desc	WITH &tdetalle..por_desc ,;
					descuento	WITH &tdetalle..descuento,;
					ivari		WITH &tdetalle..ivari	 ,;
					ivarni		WITH &tdetalle..ivarni	 ,;
					total		WITH &tdetalle..total
		
			UNLOCK ALL
		
		IF INLIST(m.tipo,2,3,4,5,6,7,10,11,16)
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
					por_desc	WITH &tdetalle..por_desc ,;
					descuento	WITH &tdetalle..descuento,;
					ivari		WITH &tdetalle..ivari	 ,;
					ivarni		WITH &tdetalle..ivarni	 ,;
					total		WITH &tdetalle..total
		
			UNLOCK ALL
		ENDIF				
	ENDIF
	
	IF &tdetalle..stock  AND m.seleccio = 0
		** Si se actualiza el stock de artículos y no es comp. seleccionado
		** para facturar

		SELECT articulo
		SET ORDER TO articulo1
		SEEK &tdetalle..rubro + &tdetalle..articulo

		IF FOUND()
			DO WHILE !RLOCK()
			ENDDO
			REPLACE actual	WITH actual + &tdetalle..cantidad
			UNLOCK ALL
		ENDIF

	ENDIF

	SELECT (tdetalle)
	ENDSCAN
ENDIF

IF UPPER(quecon) # "CONTADO" AND m.seleccio = 0
	** Actualizar saldos de Proveedores
	** si es ctacte y no es comp. seleccionado para facturar
	
	DO act_pro WITH "A", m.fecha, m.Proveedor, m.total

ELSE

	** Actualizar el pago al comprobante si es de contado
	IF m.seleccio = 0
			SELECT comprob
			gregis = RECNO()
			SET FILTER TO
			SEEK STR(15,2)

			DO act_papr WITH "A", m.fecha, m.tipo, m.numero1, m.numero2, ;
				m.Proveedor, m.nombre, ' ', m.direccion,;
				m.localidad, m.iva, m.cuit, m.telefono, m.total, ;
				m.fecha, comprob.tipo, comprob.numero1, comprob.numero2+1
	
			SELECT comprob
			DO WHILE !RLOCK()
			ENDDO
			REPLACE numero2	WITH numero2 + 1
			UNLOCK ALL

			IF m.tipo = 9
				SET FILTER TO tipo = 9
			ELSE
				SET FILTER TO INLIST(tipo,2,3,10,11,16)
			ENDIF
			GO gregis
	ELSE
		** Colocar a la nota de entrega como facturado

		IF USED(tselcomp)

			SELECT (tselcomp)
			GO TOP

			SCAN
				SELECT (m.fichero)
				SEEK DTOS(&tselcomp..fecha)+STR(&tselcomp..tipo,2)+ ;
					STR(&tselcomp..numero1,4)+STR(&tselcomp..numero2,8)
				IF FOUND()
					DO WHILE !RLOCK()
					ENDDO
					REPLACE facturado WITH .T.
				ENDIF
				SELECT (tselcomp)
			ENDSCAN
			UNLOCK ALL
		ENDIF
		
	ENDIF
	
ENDIF

DO cierabro

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
*       * From Screen:         FACTURA,     Record Number:   46   
*       * Variable:            m.iva                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION faniva

IF m.seleccio # 0
	RETURN .F.
ENDIF
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

IF m.tipo = 2 OR m.tipo = 16
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		STORE 10	TO m.tipo
		STORE 0		TO m.porivari
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	STORE fijo.ivari	TO m.porivari
	IF m.tipo # 9
		IF INLIST(tipoiva.codigo,"RI ","RNI")
			STORE 	2	TO m.tipo
			=ftipoa()
			SHOW GET m.tipo
			SHOW GET m.numero1
			SHOW GET m.numero2
		ENDIF
	ENDIF
ENDIF

STORE tipoiva.codigo	TO m.iva
@ 4.938,18.000 SAY Tipoiva.descripcio ;
	SIZE 1.000,24.429 ;
	FONT "MS Sans Serif", 10


IF USED(tdetalle) 
	** Volver a calcular los importes del comprobante
	DO v_calcular IN vdetallc
ENDIF

RETURN .T.


FUNCTION mosdet
PRIVATE mlinea
STORE 9.625 TO mlinea
STORE ''    TO valim
STORE .F.	TO m.haydet
ACTIVATE WINDOW ventana SAME

IF USED(tdetalle)
	SELECT (tdetalle)
	GO TOP

	SCAN 
	
		IF mlinea <= 17.063 AND !EMPTY(total)

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
			@ mlinea,67.857 SAY por_desc ;
				SIZE 1.000,6.571 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "99.99"
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

FUNCTION fProveedor

IF EMPTY(m.Proveedor)
	RETURN .T.
ENDIF

SELECT Provedor
SET ORDER TO Provedor1

SEEK m.Proveedor

IF !FOUND()
	SET ORDER TO Provedor2
	DO browenc WITH "nombre :H='Proveedores'",53,"nombre"
	SET ORDER TO Provedor1
ENDIF

IF m.tipo = 2 OR m.tipo = 16
	IF !INLIST(Provedor.iva,"RI ","RNI")
		STORE 10	TO m.tipo
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	IF m.tipo # 9
		IF INLIST(Provedor.iva,"RI ","RNI")
			STORE 	2	TO m.tipo
			=ftipoa()
			SHOW GET m.tipo
			SHOW GET m.numero1
			SHOW GET m.numero2
		ENDIF
	ENDIF
ENDIF


STORE Provedor.Proveedor	TO m.Proveedor
STORE Provedor.nombre		TO m.nombre
STORE Provedor.direccion	TO m.direccion
STORE Provedor.localidad	TO m.localidad
STORE Provedor.iva 			TO m.iva
STORE Provedor.cuit			TO m.cuit
STORE Provedor.telefono		TO m.telefono

SHOW GET m.Proveedor
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

FUNCTION fverdes

DO ftotales IN vdetallc

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
	IF m.fichero ="contapr1"
		SET ORDER TO contapr4
	ELSE
		SET ORDER TO ctactpr4
	ENDIF
	*SET ORDER TO (m.fichero)
ELSE
	SELECT 0
	USE (LOCFILE(m.fichero+".dbf", "DBF", "Buscar"+m.fichero+"?")) ;
		SHARED AGAIN ALIAS (m.fichero) 
*		ORDER (m.fichero)
	IF m.fichero ="contapr1"
		SET ORDER TO contapr4
	ELSE
		SET ORDER TO ctactpr4
	ENDIF
	
ENDIF

SEEK m.proveedor+DTOS(m.fecha)+STR(m.numero1,4)+STR(m.numero2,8)

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
		SET ORDER TO contapr4
	ELSE
		SET ORDER TO ctactpr4
	ENDIF

ELSE
	SELECT 0
	IF m.fichero = "ctactpr1"
		USE contapr1 SHARED AGAIN ORDER contapr4
	ELSE
		USE ctactpr1	SHARED AGAIN ORDER ctactpr4
	ENDIF
	
ENDIF

SEEK m.proveedor+DTOS(m.fecha)+STR(m.numero1,4)+STR(m.numero2,8)

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
STORE 0			TO m.total, m.por_desc, m.subtotal, m.ivari, m.ivarni, ;
				m.ivanoc, m.impuesto, m.descuento, m.descuento1, m.iva,;
				m.seleccio, m.porivari, m.porivarni, m.porivanoc, m.dgr
STORE SPACE(4)	TO m.Proveedor
STORE SPACE(3)	TO m.iva, aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion
STORE fijo.ivari	TO m.porivari
STORE fijo.ivarni	TO m.porivarni
STORE fijo.ivanoc	TO m.porivanoc
STORE 0				TO m.dgr

IF USED(tdetalle)
	SELECT (tdetalle)
	USE
ENDIF
IF USED(tselcomp)
	SELECT (tselcomp)
	USE
ENDIF
STORE SPACE(8)	TO tdetalle, tselcomp
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

IF EMPTY(m.Proveedor) AND quecon # "CONTADO"
	_CUROBJ=OBJNUM(m.Proveedor)
	WAIT "El código de Proveedor No puede estar vacio" WINDOW NOWAIT
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

IF INLIST(m.tipo,2,4,6, 16)
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		WAIT "Iva no corresponde a Comp. A" WINDOW NOWAIT
		_CUROBJ=OBJNUM(m.iva)
		RETURN .F.
	ENDIF
ELSE
	IF m.tipo # 9
		IF INLIST(tipoiva.codigo,"RI ","RNI")
			WAIT "Iva no corresponde a Comp. B o C" WINDOW NOWAIT
			_CUROBJ=OBJNUM(m.iva)
			RETURN .F.
		ENDIF
	ENDIF
ENDIF

RETURN


FUNCTION factivar
IF m.tipo = 2 OR m.tipo = 3 OR m.tipo = 10 OR m.tipo = 16
	** Activar tecla para seleccionar comprobantes a facturar
	ON KEY LABEL F12 DO vercompc

	anventana = WONTOP()
	ACTIVATE WINDOW VENTANA SAME
	@ 21.063,55.429 SAY "F12 = Sel. Comp. a Facturar " ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	ACTIVATE WINDOW (anventana) SAME
	
ENDIF
RETURN .T.

FUNCTION fdesac
IF m.tipo = 2 OR m.tipo = 3 OR m.tipo = 10  OR m.tipo = 16
	** Desactivar tecla para seleccionar comprobantes a facturar
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

FUNCTION fiva

m.porivarni = ROUND(m.porivari / 2,2)
m.porivanoc = ROUND(m.porivari / 2,2)

RETURN .T.

PROCEDURE ftotalsd
PRIVATE mneto, mtotal
STORE 0	TO mneto, mtotal

** Calcular el neto 
mtotal = m.total - m.impuesto - m.descuento - m.descuento1 - m.dgr

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

m.subtotal = m.total - m.ivarni - m.ivari - m.ivanoc - m.impuesto - m.descuento ;
			- m.descuento1 - m.dgr

SHOW GETS

RETURN .T.


FUNCTION cierabro
** CERRAR Y ABRIR LAS BASES NUEVAMENTE PARA QUE NO DE ERROR "TABLA NO VALIDA"
** CUANDO SE CORTA LA LUZ O SE CUELGA


IF USED("compras1")
	SELECT compras1
	USE
ENDIF

IF USED("compras2")
	SELECT compras2
	USE
ENDIF

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

IF quecon = "CONTADO"

	IF USED("contapr1")
		SELECT contapr1
		USE
	ENDIF

	IF USED("contapr2")
		SELECT contapr2
		USE
	ENDIF

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

	IF USED("ctactpr1")
		SELECT ctactpr1
		USE
	ENDIF

	IF USED("ctactpr2")
		SELECT ctactpr2
		USE
	ENDIF

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
RETURN 