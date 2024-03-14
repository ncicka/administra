*       *********************************************************
*       *                                                         
*       * 28/01/99             FACTURA.PRG               17:21:50 
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
** quecom = "FACTURA", "N. ENTREGA"
PARAMETERS quecom, quecon

RELEASE m.fecha, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, tselcomp, m.seleccio, m.credito, m.saldo, ;
	munitario, mimpuesto, mivari, m.ok, m.reimpre

PUBLIC m.fecha, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva,  ;
	mfichero2, tselcomp, m.seleccio, m.credito, m.saldo, ;
	munitario, mimpuesto, mivari, m.ok, m.reimpre

STORE .F.	TO m.reimpre

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
	IF UPPER(quecom) = "N. ENTREGA"
		STORE "NOTA DE ENTREGA"	TO quecompte
	ELSE
		STORE quecom			TO quecompte
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
*       *        FACTURA/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1

IF USED("empresa")
	SELECT empresa
ELSE
	SELECT 0
	USE (LOCFILE("empresa.dbf", "DBF", "Buscar empresa?")) ;
		SHARED AGAIN ALIAS empresa
ENDIF

IF USED("ventas1")
	SELECT ventas1
ELSE
	SELECT 0
	USE (LOCFILE("ventas1.dbf", "DBF", "Buscar ventas1?")) ;
		SHARED AGAIN ALIAS ventas1
ENDIF

IF USED("ventas2")
	SELECT ventas2
ELSE
	SELECT 0
	USE (LOCFILE("ventas2.dbf", "DBF", "Buscar ventas2?")) ;
		SHARED AGAIN ALIAS ventas2
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
		STORE 13 	TO m.tipo
	OTHERWISE
		STORE 1		TO m.tipo
ENDCASE

IF m.tipo = 1
	SET KEY TO STR(m.tipo,2)
ELSE
	SET KEY TO RANGE STR(13,2),STR(14,2))
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

STORE fijo.ivari	TO m.porivari
STORE fijo.ivarni	TO m.porivarni
STORE fijo.ivanoc	TO m.porivanoc

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
	STORE "contado1" 	TO m.fichero
	STORE "contado2"	TO mfichero2

	IF USED("contado1")
		SELECT contado1
		SET ORDER TO contado1
	ELSE
		SELECT 0
		USE (LOCFILE("contado1.dbf", "DBF", "Buscar contado1?")) ;
			SHARED AGAIN ALIAS contado1 ;
			ORDER contado1
	ENDIF

	IF USED("contado2")
		SELECT contado2
		SET ORDER TO contado1
	ELSE
		SELECT 0
		USE (LOCFILE("contado2.dbf", "DBF", "Buscar contado2?")) ;
			SHARED AGAIN ALIAS contado2 ;
			ORDER contado1
	ENDIF
ELSE
	STORE "ctacte1"		TO m.fichero
	STORE "ctacte2"		TO mfichero2

	IF USED("ctacte1")
		SELECT ctacte1
		SET ORDER TO ctacte1
	ELSE
		SELECT 0
		USE (LOCFILE("ctacte1.dbf", "DBF", "Buscar ctacte1?")) ;
			SHARED AGAIN ALIAS ctacte1 ;
			ORDER ctacte1
	ENDIF

	IF USED("ctacte2")
		SELECT ctacte2
		SET ORDER TO ctacte1
	ELSE
		SELECT 0
		USE (LOCFILE("ctacte2.dbf", "DBF", "Buscar ctacte2?")) ;
			SHARED AGAIN ALIAS ctacte2 ;
			ORDER ctacte1
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

IF USED("clientes")
	SELECT clientes
	SET ORDER TO clientes1
ELSE
	SELECT 0
	USE (LOCFILE("clientes.dbf", "DBF", "Buscar clientes?")) ;
		SHARED AGAIN ALIAS clientes ;
		ORDER clientes1
ENDIF


STORE " " 		TO m.aceptar, m.cancelar
STORE DATE()	TO m.fecha
STORE 0			TO m.numero1, m.numero2, m.total, ;
				m.por_desc, m.subtotal, m.ivari, m.ivarni, m.ivanoc, ;
				m.impuesto, m.descuento, m.descuento1, m.iva, m.seleccio, ;
				m.credito, m.saldo
STORE 1			TO m.lista
STORE SPACE(4)	TO m.cliente
STORE SPACE(3)	TO aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(10)	TO m.documento
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion
STORE SPACE(8)	TO tdetalle, tselcomp
STORE "RI "		TO m.iva
STORE .T.		TO m.ok

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
@ 8.500,67.429 SAY "% Desc." ;
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
@ 1.313,5.714 SAY "Cliente:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 2.500,3.429 SAY "Dirección:" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 3.688,1.714 SAY "Documento:" ;
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
@ 18.313,79.000 SAY "Desc. x art." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,66.714 SAY "Desc. gral." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,28.714 SAY "Iva No insc." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,57.143 SAY "Imp. int." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 18.313,42.143 SAY "Iva no Cat." ;
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
	WHEN LASTKEY()=5 ;
	VALID m.numero1>=0
@ 0.188,70.571 GET m.numero2 ;
	SIZE 1.000,9.000 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99999999" ;
	COLOR ,RGB(,,,255,255,255);
	WHEN m.numero1 # comprob.numero1 ;
	VALID fnumero2()
@ 1.375,12.571 GET m.cliente ;
	SIZE 1.000,4.857 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXX" ;
	COLOR ,RGB(,,,255,255,255);
	VALID LASTKEY() = 5 OR fcliente()
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
@ 3.750,12.571 GET m.documento ;
	SIZE 1.000,13.143 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 9999999999" ;
	COLOR ,RGB(,,,255,255,255)
@ 3.750,33.429 GET m.cuit ;
	SIZE 1.000,14.429 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99-99999999-9" ;
	COLOR ,RGB(,,,255,255,255);
	VALID LASTKEY() = 5 OR IIF(!EMPTY(m.cuit),fcuit(VAL(SUBSTR(m.cuit,1,2)+SUBSTR(m.cuit,4,8)+SUBSTR(m.cuit,13,1))),.t.)
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

@ 4.938,60.857 SAY m.total ;
	SIZE 1.000,14.615 ;
	FONT "MS Sans Serif", 18 ;
	STYLE "B" ;
	PICTURE "9,999,999.99" ;
	COLOR RGB(,,,255,255,255)

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
@ 9.625,0.143 GET m.detalle ;
	PICTURE "@*IHN " ;
	SIZE 8.500,88.143,0.571 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	WHEN m.seleccio = 0 AND vdetalle() AND .F.
@ 19.438,0.714 SAY m.subtotal ;
	SIZE 1.000,13.143 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,14.714 SAY m.ivari ;
	SIZE 1.000,11.429 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,27.000 SAY m.ivarni ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,39.429 SAY m.ivanoc ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,51.857 SAY m.impuesto ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,64.286 SAY m.descuento ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 19.438,76.714 SAY m.descuento1 ;
	SIZE 1.000,11.571 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "999,999.99" ;
	COLOR RGB(,,,255,255,255)
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

IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("ventas1")
	SELECT ventas1
	USE
ENDIF

IF USED("ventas2")
	SELECT ventas2
	USE
ENDIF

IF USED("contado1")
	SELECT contado1
	USE
ENDIF

IF USED("contado2")
	SELECT contado2
	USE
ENDIF

IF USED("ctacte1")
	SELECT ctacte1
	USE
ENDIF

IF USED("ctacte2")
	SELECT ctacte2
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

IF USED("clientes")
	SELECT clientes
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

RELEASE m.fecha, m.tipo, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.lista, m.condicion, m.por_desc, m.subtotal, ;
	m.ivari, m.ivarni, m.ivanoc, m.impuesto, m.descuento, m.descuento1, ;
	m.aceptar, m.cancelar, m.fichero, tdetalle, aniva, ;
	mfichero2, tselcomp, m.seleccio, m.credito, m.saldo, ;
	munitario, mimpuesto, mivari, m.ok, m.reimpre


#REGION 1
PROCEDURE boton
PARAMETERS m.boton
SELECT (m.fichero)
	DO CASE
		CASE ALLTRIM(UPPER(m.boton))=="ACEPTAR"
				IF control()
					DO CASE
					CASE EMPTY(empresa.impresor)
						IF m.total # 0
							DO guardar
							IF comprob.imprime
								DO imprimir
							ENDIF

						ENDIF
					CASE empresa.impresor = "ARTJET20-F"
						** si es una nota de entrega se imprime
						** un comprobante no fiscal homologado
						STORE .T.	TO m.ok
						
						IF comprob.tipo = 1 AND comprob.imprime
							DO imprnofh
							IF confirma("Imprime Copia?")
								STORE .T.	TO m.reimpre
								DO imprnofh
							ENDIF
							STORE .F.	TO m.reimpre
						ELSE	
							IF comprob.imprime
								DO imprfisc
							ENDIF
						ENDIF
						** La Apertura del comprobante devuelve el nro.
						** Luego de imprimir entonces se guarda si OK
						IF m.ok
							DO guardar
						ENDIF
					ENDCASE
					DO clearven
					
					=mosdet()
					DO ftotales IN vdetalle
					_curobj=1
				ENDIF
								
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				DO clearven
				=mosdet()
				DO ftotales IN vdetalle
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
		cliente		WITH m.cliente,;
		nombre		WITH m.nombre,;
		documento	WITH m.documento,;
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
		por_desc	WITH m.por_desc,;
		descuento	WITH m.descuento,;
		descuento1	WITH m.descuento1,;
		total		WITH m.total,;
		facturado	WITH IIF(m.tipo=1,.F.,.T.)

	IF quecon # "CONTADO"
		IF m.saldo + m.total <= 0
			IF Confirma1("Asigna Saldo a Favor a la Factura")
				REPLACE pagado WITH .T.
			ENDIF
		ELSE
			REPLACE pagado		WITH .F.
		ENDIF
	ENDIF

	IF USED("usuario")
		REPLACE	usuario		WITH usuario.usuario
	ENDIF
		
UNLOCK ALL

*** Guardar para el libro iva ventas

IF BETWEEN(m.tipo,2,7) OR BETWEEN(m.tipo,13,14)
	SELECT ventas1
	APPEND BLANK
	DO WHILE !RLOCK()
	ENDDO
	REPLACE fecha		WITH m.fecha, ;
			tipo		WITH comprob.tipo,;
			numero1 	WITH m.numero1,;
			numero2		WITH m.numero2,;
			cliente		WITH m.cliente,;
			nombre		WITH m.nombre,;
			documento	WITH m.documento,;
			direccion	WITH m.direccion,;
			localidad	WITH m.localidad,;
			iva			WITH m.iva,;
			cuit		WITH m.cuit,;
			telefono	WITH m.telefono,;
			condicion	WITH m.condicion,;
			subtotal	WITH m.subtotal,;
			impuesto	WITH m.impuesto,;
			tasaivari   WITH fijo.ivari,;
			ivari		WITH m.ivari,;
			tasaivarni  WITH fijo.ivarni,;
			ivarni		WITH m.ivarni,;
			tasaivanoc  WITH fijo.ivanoc,;
			ivanoc		WITH m.ivanoc,;
			por_desc	WITH m.por_desc,;
			descuento	WITH m.descuento,;
			descuento1	WITH m.descuento1,;
			total		WITH m.total

	UNLOCK ALL
ENDIF

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
		
		IF BETWEEN(m.tipo,2,7) OR BETWEEN(m.tipo,13,14)
			SELECT ventas2
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
			REPLACE actual	WITH actual - &tdetalle..cantidad
			UNLOCK ALL
		ENDIF

	ENDIF

	SELECT (tdetalle)
ENDSCAN

IF UPPER(quecon) # "CONTADO" AND m.seleccio = 0
	** Actualizar saldos de clientes
	** si es ctacte y no es comp. seleccionado para facturar
	
	DO act_cli WITH "A", m.fecha, m.cliente, m.total

ELSE

	** Actualizar el pago al comprobante si es de contado
	IF m.seleccio = 0
			SELECT comprob
			gregis = RECNO()
			SET KEY TO
			SEEK STR(8,2)
	
			DO act_pago WITH "A", m.fecha, m.tipo, m.numero1, m.numero2, ;
				m.cliente, m.nombre, m.documento, m.direccion, ;
				m.localidad, m.iva, m.cuit, m.telefono, m.total, ;
				m.fecha, comprob.tipo, comprob.numero1, comprob.numero2+1
	
			SELECT comprob
			DO WHILE !RLOCK()
			ENDDO
			REPLACE numero2	WITH numero2 + 1
			UNLOCK ALL

			IF m.tipo = 1
				SET KEY TO STR(m.tipo,2)
			ELSE
				SET KEY TO RANGE STR(13,2),STR(14,2))
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

SELECT comprob
	DO WHILE !RLOCK()
	ENDDO
	REPLACE numero2	WITH m.numero2
	UNLOCK ALL
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

IF m.tipo = 13
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		STORE 3		TO m.tipo
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	IF m.tipo # 1
		IF INLIST(tipoiva.codigo,"RI ","RNI")
			STORE 	13	TO m.tipo
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
*AND m.iva # aniva
	** Volver a calcular los importes del comprobante
	DO v_calcular IN vdetalle
ENDIF

RETURN .T.


FUNCTION mosdet
PRIVATE mlinea
STORE 9.625 TO mlinea
STORE ''    TO valim

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
IF comprob.numero1 = m.numero1 OR m.numero1 = 0
	STORE comprob.numero1	TO m.numero1
	STORE comprob.numero2+1	TO m.numero2
ENDIF

@ 0.188,81.000 SAY comprob.codigo ;
	SIZE 1.000,9.000 ;
	FONT "MS Sans Serif", 10

SHOW GET m.numero1
SHOW GET m.numero2
*_CUROBJ=OBJNUM(m.cliente)
RETURN .T.

FUNCTION fcliente

IF EMPTY(m.cliente)
	RETURN .T.
ENDIF

SELECT clientes
SET ORDER TO clientes1

SEEK m.cliente

IF !FOUND()
	SET ORDER TO clientes2
	DO browenc WITH "nombre :H='Clientes'",53,"nombre"
	SET ORDER TO clientes1
ENDIF

IF m.tipo = 13
	IF !INLIST(clientes.iva,"RI ","RNI")
		STORE 3		TO m.tipo
		=ftipoa()
		SHOW GET m.tipo
		SHOW GET m.numero1
		SHOW GET m.numero2
	ENDIF
ELSE
	IF m.tipo # 1
		IF INLIST(clientes.iva,"RI ","RNI")
			STORE 	13	TO m.tipo
			=ftipoa()
			SHOW GET m.tipo
			SHOW GET m.numero1
			SHOW GET m.numero2
		ENDIF
	ENDIF
ENDIF


STORE clientes.cliente		TO m.cliente
STORE clientes.nombre		TO m.nombre
STORE clientes.documento	TO m.documento
STORE clientes.direccion	TO m.direccion
STORE clientes.localidad	TO m.localidad
STORE clientes.iva 			TO m.iva
STORE clientes.cuit			TO m.cuit
STORE clientes.telefono		TO m.telefono
STORE clientes.credito		TO m.credito
m.saldo = fsaldo()

SHOW GET m.cliente
SHOW GET m.nombre
SHOW GET m.documento
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

DO ftotales IN vdetalle

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

IF USED(IIF(m.fichero="ctacte1","contado1","ctacte1"))
	SELECT IIF(m.fichero="ctacte1","contado1","ctacte1")
	STORE .t.		TO usado
	STORE RECNO()	TO registro
	STORE ORDER()	TO orden
	SET ORDER TO IIF(m.fichero="ctacte1","contado1","ctacte1")
ELSE
	SELECT 0
	IF m.fichero = "ctacte1"
		USE contado1 SHARED AGAIN ORDER contado1
	ELSE
		USE ctacte1	SHARED AGAIN ORDER ctacte1
	ENDIF
	
ENDIF

SEEK DTOS(m.fecha)+STR(comprob.tipo,2)+STR(m.numero1,4)+STR(m.numero2,8)

IF FOUND()
	STORE .T.	TO cta2
ENDIF


IF usado
	SELECT IIF(m.fichero="ctacte1","contado1","ctacte1")
	SET ORDER TO (orden)
	IF registro <= RECCOUNT()
		GO registro
	ENDIF
ENDIF

RETURN !cta1 AND !cta2


PROCEDURE clearven
STORE 0			TO m.total, m.por_desc, m.subtotal, m.ivari, m.ivarni, ;
				m.ivanoc, m.impuesto, m.descuento, m.descuento1, m.iva,;
				m.seleccio
STORE SPACE(4)	TO m.cliente
STORE SPACE(3)	TO m.iva, aniva
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(10)	TO m.documento
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono, m.condicion

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

IF EMPTY(m.cliente) AND quecon # "CONTADO"
	_CUROBJ=OBJNUM(m.cliente)
	WAIT "El código de cliente No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.nombre) 
	_CUROBJ=OBJNUM(m.nombre)
	WAIT "El nombre No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.direccion) AND INLIST(m.tipo,3,7,14) AND m.total > 1000
	_CUROBJ=OBJNUM(m.direccion)
	WAIT "La dirección No puede estar vacia" WINDOW NOWAIT
	RETURN .F.
ENDIF	
*IF EMPTY(m.localidad) 
*	_CUROBJ=OBJNUM(m.localidad)
*	WAIT "La Localidad No puede estar vacia" WINDOW NOWAIT
*	RETURN .F.
*ENDIF
IF EMPTY(m.documento) AND INLIST(m.tipo,3,7,14) AND m.total > 1000
	_CUROBJ=OBJNUM(m.documento)
	WAIT "El documento No puede estar vacio" WINDOW NOWAIT
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

IF INLIST(m.tipo,2,4,6,13)
	IF !INLIST(tipoiva.codigo,"RI ","RNI")
		WAIT "Iva no corresponde a Comp. A" WINDOW NOWAIT
		_CUROBJ=OBJNUM(m.iva)
		RETURN .F.
	ENDIF
ELSE
	IF m.tipo # 1
		IF INLIST(tipoiva.codigo,"RI ","RNI")
			WAIT "Iva no corresponde a Comp. B" WINDOW NOWAIT
			_CUROBJ=OBJNUM(m.iva)
			RETURN .F.
		ENDIF
	ENDIF
ENDIF


RETURN


FUNCTION factivar
IF INLIST(m.tipo,2,3,13,14)
	** Activar tecla para seleccionar comprobantes a facturar
	ON KEY LABEL F12 DO vercomp
	@ 21.063,55.429 SAY "F12 = Sel. Comp. a Facturar " ;
		FONT "MS Sans Serif", 10 ;
		STYLE "BT"
	
ENDIF
RETURN .T.

FUNCTION fdesac
IF INLIST(m.tipo,2,3,13,14)
	** Desactivar tecla para seleccionar comprobantes a facturar
	ON KEY LABEL F12
	@ 21.063,55.429 SAY " " ;
		SIZE 1.000, 30.000 ;
		FONT "MS Sans Serif", 10 ;
		STYLE "B"
ENDIF
RETURN .T.


FUNCTION fsaldo
PRIVATE psaldo, pperiodo
STORE 0	TO psaldo

IF USED("saldos")
	SELECT saldos
	STORE .t.	  TO vusado
	STORE ORDER() TO vorden
	
	SET ORDER TO saldos DESCENDING
ELSE
	SELECT 0
	
	USE (LOCFILE("saldos.dbf", "DBF", "Buscar saldos?")) ;
		SHARED AGAIN ALIAS saldos ;
		ORDER saldos DESCENDING
	STORE .F. TO vusado
ENDIF

pperiodo = TRAN(YEAR(m.fecha),'@L 9999')+TRAN(MONTH(m.fecha),'@L 99')

pannear = SET('NEAR')
SET NEAR ON
SEEK pperiodo+m.cliente
IF saldos.cliente = m.cliente
	STORE saldos.actual	TO psaldo
ENDIF

SET NEAR &pannear

IF vusado
	SELECT saldos
	SET ORDER TO (vorden)
ELSE
	SELECT saldos
	USE
ENDIF

RETURN psaldo


FUNCTION fversaldo

IF quecon = "CONTADO"
	RETURN .T.
ENDIF

IF m.credito > 0 AND !EMPTY(m.cliente)
	IF m.saldo + m.total > m.credito
		DO MENSAJE WITH "El total supera al crédito máximo del Cliente" +;
			CHR(13)+"Crédito Máximo: " +TRAN(m.credito,'@$ 999,999.99') + ;
			CHR(13)+"Saldo Actual: "+TRAN(m.saldo,'@$ 999,999.99')+;
			chr(13)+"Saldo + Comprobante: "+ TRAN(m.saldo+m.total,'@$ 999,999.99')
	ENDIF
ENDIF


FUNCTION cierabro
** CERRAR Y ABRIR LAS BASES NUEVAMENTE PARA QUE NO DE ERROR "TABLA NO VALIDA"
** CUANDO SE CORTA LA LUZ O SE CUELGA

IF USED("ventas1")
	SELECT ventas1
	USE
ENDIF

IF USED("ventas2")
	SELECT ventas2
	USE
ENDIF

IF USED("ventas1")
	SELECT ventas1
ELSE
	SELECT 0
	USE (LOCFILE("ventas1.dbf", "DBF", "Buscar ventas1?")) ;
		SHARED AGAIN ALIAS ventas1
ENDIF

IF USED("ventas2")
	SELECT ventas2
ELSE
	SELECT 0
	USE (LOCFILE("ventas2.dbf", "DBF", "Buscar ventas2?")) ;
		SHARED AGAIN ALIAS ventas2
ENDIF

IF quecon = "CONTADO"

	IF USED("contado1")
		SELECT contado1
		USE
	ENDIF

	IF USED("contado2")
		SELECT contado2
		USE
	ENDIF

	IF USED("contado1")
		SELECT contado1
		SET ORDER TO contado1
	ELSE
		SELECT 0
		USE (LOCFILE("contado1.dbf", "DBF", "Buscar contado1?")) ;
			SHARED AGAIN ALIAS contado1 ;
			ORDER contado1
	ENDIF

	IF USED("contado2")
		SELECT contado2
		SET ORDER TO contado1
	ELSE
		SELECT 0
		USE (LOCFILE("contado2.dbf", "DBF", "Buscar contado2?")) ;
			SHARED AGAIN ALIAS contado2 ;
			ORDER contado1
	ENDIF
ELSE

	IF USED("ctacte1")
		SELECT ctacte1
		USE
	ENDIF

	IF USED("ctacte2")
		SELECT ctacte2
		USE
	ENDIF

	IF USED("ctacte1")
		SELECT ctacte1
		SET ORDER TO ctacte1
	ELSE
		SELECT 0
		USE (LOCFILE("ctacte1.dbf", "DBF", "Buscar ctacte1?")) ;
			SHARED AGAIN ALIAS ctacte1 ;
			ORDER ctacte1
	ENDIF

	IF USED("ctacte2")
		SELECT ctacte2
		SET ORDER TO ctacte1
	ELSE
		SELECT 0
		USE (LOCFILE("ctacte2.dbf", "DBF", "Buscar ctacte2?")) ;
			SHARED AGAIN ALIAS ctacte2 ;
			ORDER ctacte1
	ENDIF
ENDIF

RETURN 