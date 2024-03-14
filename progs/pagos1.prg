*       *********************************************************
*       *                                                         
*       * 11/01/05              PAGOS.PRG                17:04:49 
*       *          ** RECIBO X FISCAL                                               
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

RELEASE m.fecha, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.aceptar, m.cancelar, m.fichero, tdetalle, ;
	m.tipo, m.descuento, m.reimpre, m.ok, m.condicion

PUBLIC m.fecha, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.aceptar, m.cancelar, m.fichero, tdetalle, ;
	m.tipo, m.descuento, m.reimpre, m.ok, m.condicion
	

STORE " " 		TO m.aceptar, m.cancelar, m.condicion
STORE DATE()	TO m.fecha
STORE 0			TO m.numero1, m.numero2, m.total, m.descuento
STORE SPACE(4)	TO m.cliente
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(10)	TO m.documento
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono
STORE SPACE(8)	TO tdetalle
STORE "   "		TO m.iva
STORE 18		TO m.tipo
STORE .F.		TO m.reimpre
STORE .T.		TO m.ok


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
	DEFINE WINDOW ventana ;
		AT  0.000, 0.000  ;
		SIZE 16.688,88.714 ;
		TITLE "Recibos a Clientes" ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW ventana CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *         PAGOS1/Windows Distribución de pantalla         
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

IF USED("tipoiva")
	SELECT tipoiva
	SET ORDER TO tipoiva
ELSE
	SELECT 0
	USE (LOCFILE("tipoiva.dbf", "DBF", "Buscar tipoiva?")) ;
		SHARED AGAIN ALIAS tipoiva ;
		ORDER tipoiva
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

IF USED("pagos1")
	SELECT pagos1
	SET ORDER TO pagos1
ELSE
	SELECT 0
	USE (LOCFILE("pagos1.dbf", "DBF", "Buscar pagos1?")) ;
		SHARED AGAIN ALIAS pagos1 ;
		ORDER pagos1
ENDIF

IF USED("pagos2")
	SELECT pagos2
	SET ORDER TO pagos1
ELSE
	SELECT 0
	USE (LOCFILE("pagos2.dbf", "DBF", "Buscar pagos2?")) ;
		SHARED AGAIN ALIAS pagos2 ;
		ORDER pagos1
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

IF USED("aplicado")
	SELECT aplicado
	SET ORDER TO aplicado1
ELSE
	SELECT 0
	USE (LOCFILE("aplicado.dbf", "DBF", "Buscar aplicado?")) ;
		SHARED AGAIN ALIAS aplicado ;
		ORDER aplicado1
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

SEEK STR(18,2) && Comprobante de pago

=ftipoa()

SELECT pagos1
m.fichero = ALIAS()

IF WVISIBLE("ventana")
	ACTIVATE WINDOW ventana SAME
ELSE
	ACTIVATE WINDOW ventana NOSHOW
ENDIF
@ 14.063,0.000 TO 14.063,89.143 ;
	PEN 1, 8 ;
	STYLE "1"
@ 7.063,0.000 TO 7.063,88.429 ;
	PEN 1, 8 ;
	STYLE "1"
@ 8.375,0.000 TO 8.375,88.429 ;
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
@ 0.125,52.857 SAY "Número:" ;
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
@ 7.250,4.429 SAY "Fecha" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,22.857 SAY "Nro. Comp." ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,76.714 SAY "Importe" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,38.571 SAY "Detalle" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 7.250,12.000 SAY " Tipo" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 0.188,12.571 GET m.fecha ;
	SIZE 1.000,10.429 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@KE" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID fctrfech(m.fecha,"m.fecha") AND m.fecha <= DATE()
@ 0.188,60.857 GET m.numero1 ;
	SIZE 1.000,4.857 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 9999" ;
	COLOR ,RGB(,,,255,255,255) ;
	WHEN .F.
@ 0.188,66.714 GET m.numero2 ;
	SIZE 1.000,9.000 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K 99999999" ;
	COLOR ,RGB(,,,255,255,255) ;
	WHEN .F.
@ 1.375,12.571 GET m.cliente ;
	SIZE 1.000,4.857 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXX" ;
	COLOR ,RGB(,,,255,255,255) ;
	VALID LASTKEY() = 5 OR fcliente()
	
@ 1.375,18.429 GET m.nombre ;
	SIZE 1.000,60.429 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ;
	COLOR ,RGB(,,,255,255,255)
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
	SIZE 1.000,17.429 ;
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
	PICTURE "@KA XXX" ;
	VALID _s2m10ly1i() ;
	COLOR ,RGB(,,,255,255,255)
@ 4.938,60.857 SAY m.total ;
	SIZE 1.000,14.615 ;
	FONT "MS Sans Serif", 18 ;
	STYLE "B" ;
	PICTURE "9,999,999.99" ;
	COLOR RGB(,,,255,255,255)
@ 8.438,0.143 GET m.detalle ;
	PICTURE "@*IHN " ;
	SIZE 5.688,88.286,0.571 ;
	DEFAULT 0 ;
	FONT "MS Sans Serif", 10 ;
	WHEN vpagos() AND .F.
@ 14.938,24.714 GET m.aceptar ;
	PICTURE "@*HN \<Aceptar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.aceptar)
@ 14.938,38.857 GET m.cancelar ;
	PICTURE "@*HN \<Cancelar" ;
	SIZE 1.615,12.600,0.800 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID boton(m.cancelar)

IF NOT WVISIBLE("ventana")
	ACTIVATE WINDOW ventana
ENDIF

READ CYCLE  MODAL

RELEASE WINDOW ventana

#REGION 1

IF USED("empresa")
	SELECT empresa
	USE
ENDIF

IF USED("tipoiva")
	SELECT tipoiva
	USE
ENDIF

IF USED("ctacte1")
	SELECT ctacte1
	USE
ENDIF

IF USED("pagos1")
	SELECT pagos1
	USE
ENDIF

IF USED("pagos2")
	SELECT pagos2
	USE
ENDIF

IF USED("clientes")
	SELECT clientes
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF

IF USED("aplicado")
	SELECT aplicado
	USE
ENDIF

IF USED(tdetalle)
	SELECT (tdetalle)
	USE
ENDIF

RELEASE m.fecha, m.numero1, m.numero2, m.cliente, m.nombre, ;
	m.direccion, m.localidad, m.documento, m.cuit, m.telefono, ;
	m.iva, m.total, m.aceptar, m.cancelar, m.fichero, tdetalle,;
	m.descuento, m.reimpre, m.ok, m.condicion

#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF

#REGION 1


PROCEDURE boton
PARAMETERS m.boton
SELECT (m.fichero)
	DO CASE
		CASE ALLTRIM(UPPER(m.boton))=="ACEPTAR"

*					IF m.total # 0
*						DO guardar
*					ENDIF

				IF m.total # 0 AND control()

					DO CASE
					CASE EMPTY(empresa.impresor)

							DO guardar

							IF comprob.imprime
								DO imprimir
							ENDIF

					CASE empresa.impresor = "ARTJET20-F"
						** si es un RECIBO X se imprime
						** un comprobante no fiscal homologado
						
						IF comprob.tipo = 18
							DO imprnofh
							IF confirma("Imprime Copia?")
								STORE .T.	TO m.reimpre
								DO imprnofh
							ENDIF
							STORE .F.	TO m.reimpre
						ELSE
							DO imprfisc
						ENDIF
						** La Apertura del comprobante devuelve el nro.
						** Luego de imprimir entonces se guarda si OK

						IF MESSAGEBOX("Impresión Correcta?",36,"Impresión") = 7
							STORE .F.	TO m.ok
						ELSE
							STORE .T.	TO m.ok
						ENDIF

						IF m.ok
							DO guardar
						ENDIF
					ENDCASE
				ENDIF

					DO clearven

					=mosdet()

					DO ftotales IN vpagos
					_curobj=1
								
		CASE ALLTRIM(UPPER(m.boton))=="CANCELAR"
				DO clearven
				=mosdet()
				DO ftotales IN vpagos
				_curobj=1

	ENDCASE
RETURN


*       *********************************************************
*       *                                                         
*       * _S2M10LY1I           m.iva VALID                        
*       *                                                         
*       * Function Origin:                                        
*       *                                                         
*       * From Platform:       Windows                            
*       * From Screen:         PAGOS1,     Record Number:   30    
*       * Variable:            m.iva                              
*       * Called By:           VALID Clause                       
*       * Object Type:         Field                              
*       * Snippet Number:      1                                  
*       *                                                         
*       *********************************************************
*

FUNCTION _s2m10ly1i     &&  m.iva VALID
#REGION 1
IF EMPTY(m.iva)
	RETURN .T.
ENDIF
SELECT tipoiva

SEEK m.iva

IF !FOUND()
	SEEK 'RI'
	DO browenc WITH "descripcio :H='Tipos de Resp. Iva'",29,"descripcio"
ENDIF

STORE tipoiva.codigo	TO m.iva
@ 4.938,18.000 SAY Tipoiva.descripcio ;
	SIZE 1.000,24.429 ;
	FONT "MS Sans Serif", 10

RETURN .T.


FUNCTION mosdet
PRIVATE mlinea
STORE 8.500 TO mlinea
STORE ''    TO valim

ACTIVATE WINDOW ventana

IF USED(tdetalle)
	SELECT (tdetalle)
	GO TOP

	SCAN 
	
		IF mlinea <= 13.000 AND !EMPTY(importe)

			@ mlinea,0.857 SAY fecha ;
				SIZE 1.000,10.429 ;
				FONT "MS Sans Serif", 10
			@ mlinea,12.143 SAY codigo ;
				SIZE 1.000,6.286 ;
				FONT "MS Sans Serif", 10
			@ mlinea,19.286 SAY numero1 ;
				SIZE 1.000,4.857 ;
				FONT "MS Sans Serif", 10
			@ mlinea,25.000 SAY numero2 ;
				SIZE 1.000,10.429 ;
				FONT "MS Sans Serif", 10
			@ mlinea,36.286 SAY descripcio ;
				SIZE 1.000,37.429 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
			@ mlinea,74.571 SAY importe ;
				SIZE 1.000,13.286 ;
				FONT "MS Sans Serif", 10 ;
				PICTURE "999,999.99"
				
			STORE mlinea + 1.125 TO mlinea
		ENDIF
	

	ENDSCAN
ENDIF

DO WHILE mlinea <= 13.000
		@ mlinea,0.286 SAY valim ;
			SIZE 1.000,88.429 ;
			FONT "MS Sans Serif", 10
	STORE mlinea + 1.125 TO mlinea
ENDDO

RETURN .T.


FUNCTION fcliente

SELECT clientes
SET ORDER TO clientes1

SEEK m.cliente

IF !FOUND()
	SET ORDER TO clientes2
	DO browenc WITH "nombre :H='Clientes'",53,"nombre"
	SET ORDER TO clientes1
ENDIF

STORE clientes.cliente		TO m.cliente
STORE clientes.nombre		TO m.nombre
STORE clientes.documento	TO m.documento
STORE clientes.direccion	TO m.direccion
STORE clientes.localidad	TO m.localidad
STORE clientes.iva 			TO m.iva
STORE clientes.cuit			TO m.cuit
STORE clientes.telefono		TO m.telefono

SHOW GET m.cliente
SHOW GET m.nombre
SHOW GET m.documento
SHOW GET m.direccion
SHOW GET m.localidad
SHOW GET m.iva
SHOW GET m.cuit
SHOW GET m.telefono
SHOW GET m.tipo
SHOW GET m.numero1
SHOW GET m.numero2

=_s2m10ly1i()
_CUROBJ=OBJNUM(m.nombre)
RETURN .T.

FUNCTION ftipoa

SELECT comprob

STORE comprob.numero1	TO m.numero1
STORE comprob.numero2+1	TO m.numero2

SHOW GET m.numero1
SHOW GET m.numero2
_CUROBJ=OBJNUM(m.cliente)
RETURN .T.

PROCEDURE clearven
STORE " " 		TO m.aceptar, m.cancelar
STORE DATE()	TO m.fecha
STORE 0			TO m.total
STORE SPACE(4)	TO m.cliente
STORE SPACE(50)	TO m.nombre
STORE SPACE(25)	TO m.direccion
STORE SPACE(20)	TO m.localidad
STORE SPACE(10)	TO m.documento
STORE SPACE(13)	TO m.cuit
STORE SPACE(15)	TO m.telefono
STORE "   "		TO m.iva
STORE 18		TO m.tipo


IF USED(tdetalle)
	SELECT (tdetalle)
	USE
ENDIF

STORE SPACE(8)	TO tdetalle
=ftipoa()
SHOW GETS

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
		total		WITH m.total

UNLOCK ALL

SELECT (tdetalle)
GO TOP
SCAN
	IF !EMPTY(importe)	
		SELECT pagos2
		APPEND BLANK
		DO WHILE !RLOCK()
		ENDDO
		REPLACE fecha		WITH m.fecha			 ,;
				tipo		WITH m.tipo     		 ,;
				numero1		WITH m.numero1			 ,;
				numero2		WITH m.numero2			 ,;
				cfecha		WITH &tdetalle..fecha    ,;
				ctipo       WITH &tdetalle..tipo     ,;
				cnumero1   	WITH &tdetalle..numero1  ,;
				cnumero2    WITH &tdetalle..numero2  ,;
				importe     WITH &tdetalle..importe  ,;
				descripcio	WITH &tdetalle..descripcio
		UNLOCK ALL

		IF &tdetalle..importe = &tdetalle..saldo
			** Colocar la factura de ctacte como pagada

			SELECT ctacte1
			SET ORDER TO ctacte1
			SEEK DTOS(&tdetalle..fecha)+STR(&tdetalle..tipo,2)+;
				STR(&tdetalle..numero1,4)+STR(&tdetalle..numero2,8)

			IF FOUND()
				DO WHILE !RLOCK()
				ENDDO
				REPLACE pagado	WITH .t.
				UNLOCK ALL
			ENDIF

		ENDIF
		
	ENDIF
	
	SELECT (tdetalle)
ENDSCAN

DO act_cli WITH "B", m.fecha, m.cliente, m.total

SELECT comprob
DO WHILE !RLOCK()
ENDDO
REPLACE numero2	WITH m.numero2
UNLOCK ALL

RETURN


FUNCTION control

IF EMPTY(m.fecha)	
	_CUROBJ=OBJNUM(m.fecha)
	WAIT "La fecha No puede estar vacia" WINDOW NOWAIT
	RETURN .F.
ENDIF

IF EMPTY(m.numero2)
	_CUROBJ=OBJNUM(m.numero2)
	WAIT "La Número de comprobante No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF

IF EMPTY(m.cliente) 
	_CUROBJ=OBJNUM(m.cliente)
	WAIT "El código de cliente No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.nombre) 
	_CUROBJ=OBJNUM(m.nombre)
	WAIT "El nombre No puede estar vacio" WINDOW NOWAIT
	RETURN .F.
ENDIF	
IF EMPTY(m.direccion) AND INLIST(m.tipo,3,7) AND m.total > 1000
	_CUROBJ=OBJNUM(m.direccion)
	WAIT "La dirección No puede estar vacia" WINDOW NOWAIT
	RETURN .F.
ENDIF	

IF EMPTY(m.documento) AND INLIST(m.tipo,3,7) AND m.total > 1000
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

RETURN
