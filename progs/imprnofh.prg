*** IMPRESION DE COMPROBANTES NO FISCALES HOMOLOGADOS
** NOTAS DE CREDITO  - A - B - REMITOS - RECIBOS x

** Si existe algun error colocar m.Ok a .F.

STORE .T.	TO m.logica
STORE " "	TO m.mensaje
Sep = CHR(28)

M.oFormulario = CREATE( 'Form' )
M.oFormulario.AddObject( 'ImpresorFiscal' , 'Caito.ClassImpresorFiscal' )

WITH M.oFormulario.ImpresorFiscal
	
	.nCom = empresa.com
	Handler = .OpenComFiscal()
	IF Handler < 0
		.CloseComFiscal()
		RETURN .T.
	ENDIF

	IF m.reimpre
		= ImpFisc("REIMPRE")
	ELSE
		Comando = "*"
		.vertodo = .t.
		IF .Enviar(Comando) < 0
			* Para cada llamada a Enviar
			* si devuelve < 0 es problemas de comunicaciones.
			* Además, hay que comprobar la respuesta del controlador.
			WAIT WINDOW "Problemas de comunicaciones" NOWAIT
			* Cierre del puerto.
			.CloseComFiscal()
			STORE .F.	TO m.ok
			RELEASE M.oFormulario
			RETURN
		endif
		.vertodo = .f.
		m.Mensaje = .cMensaje
	
		IF ("Recibo fiscal abierto" $ m.Mensaje OR "Recibo abierto" $ m.Mensaje ;
 			OR "Factura abierta" $ m.Mensaje)
			* No entra si hay un ticket abierto
			WAIT WINDOW "Existe un Comprobante Abierto" NOWAIT
			* Cierre del puerto.
			.CloseComFiscal()
			STORE.F. 	TO m.ok
			RELEASE M.oFormulario
			RETURN 
		ENDIF	

		DO CASE
			CASE comprob.tipo = 4
				pos = AT(Sep,Respuesta,7)
				m.numero2 = VAL(SUBSTR(Respuesta,pos+1,8)) + 1
			CASE comprob.tipo = 5
				pos = AT(Sep,Respuesta,6)
				m.numero2 = VAL(SUBSTR(Respuesta,pos+1,8)) + 1
			CASE comprob.tipo = 9
				pos = AT(Sep,Respuesta,8)
				m.numero2 = VAL(SUBSTR(Respuesta,pos+1,8)) + 1
		ENDCASE
	


		** enviar Datos Comprador

		= ImpFisc("COMPRADOR")

	
		* ENVIAR SIEMPRE COMO FORMA DE PAGO TARJETA

		IF !EMPTY(m.condicion)
			= ImpFisc("TEXTO1")
		ELSE
			** BORRO EL TEXTO PARA ESTE COMPROBANTE
			= ImpFisc("TEXTO1B")
		ENDIF

		IF comprob.tipo = 17
			** ENVIAR LA FECHA DE VENCIMIENTO PARA EL PRESUPUESTO
			= ImpFisc("TEXTO2")
		ELSE
			** BORRO EL TEXTO PARA ESTE COMPROBANTE
			= ImpFisc("TEXTO2B")
		ENDIF
		** Abrir comprobante NO Fiscal HOMOLOGADO

		IF m.ok AND ImpFisc("ABRIR")

			* SI EL COMPROBANTE ES RECIBO X ENVIO UN ITEM CON EL TOTAL
	
			IF comprob.tipo = 18
				= ImpFisc("ITEMRE")
			ENDIF

			IF comprob.tipo = 17
				= ImpFisc("ITEME")
			ENDIF

			SELECT (tdetalle)
			GO TOP
			SCAN
		
				IF !EMPTY(&tdetalle..total) AND comprob.tipo # 18
					DO CASE
					CASE comprob.tipo = 4 OR comprob.tipo = 5 &&nota credito
						= ImpFisc("ITEM")
					CASE comprob.tipo = 1 OR comprob.tipo = 9 && nota entrega o remito
						= ImpFisc("ITEMR")
			
					CASE comprob.tipo = 17  && item de presupuesto
						= ImpFisc("ITEMP")
					ENDCASE
				ELSE	
	
					IF comprob.tipo = 18 AND (!EMPTY(descripcio) OR !EMPTY(numero2))
						** IMPRIMIR COMO EL ITEM DE LA FACTURA CON CANTIDAD SIEMPRE A UNO
						** COLOCAR LA DESCRIPCION O EL COMPROBANTE SELECCIONADO SEGUN CORRESPONDA
						= ImpFisc("TEXTORE")

					ENDIF
		
				ENDIF
				SELECT (tdetalle)
				IF !m.ok
					EXIT
				ENDIF	
			ENDSCAN

			IF comprob.tipo = 17
				= ImpFisc("ITEMPT")
			ENDIF
	
			IF !EMPTY(m.descuento) AND m.ok AND comprob.tipo # 17
				** Descuento General
				= ImpFisc("DESCGRAL")
			ENDIF

			IF m.ok AND comprob.tipo # 1 AND comprob.tipo # 9 AND comprob.tipo # 18 ;
				AND comprob.tipo # 17
				= ImpFisc ("SUBTOTAL")
			ENDIF

			IF m.ok
				= ImpFisc ("CERRAR")
			ENDIF

		ENDIF

	ENDIF
	.CloseComFiscal()
ENDWITH

RELEASE M.oFormulario

RETURN



FUNCTION impfisc
PARAMETERS pQueHago
	
	DO CASE

		CASE pQueHago == "COMPRADOR"
			mcuit = SUBSTR(m.cuit,1,2)+SUBSTR(m.cuit,4,8)+SUBSTR(m.cuit,13,1)
			Comando = "b" ;
					+Sep+ m.nombre ;
					+Sep+ IIF(tipoiva.letra="C",TRAN(VAL(m.documento),"@L 99999999999"),TRAN(VAL(mcuit),"@L 99999999999")) ;
					+Sep+ tipoiva.letra ;
					+Sep+ IIF(tipoiva.letra="C","2", "C");
					+Sep+ m.direccion
		
		** comprobante de ingreso (8) no se imprime por impresora fiscal solo 18 que es Recibo X
		
		CASE pQueHago == "ABRIR"
			Comando = "€" ;
					+Sep + comprob.letra ;
					+Sep + "T";
					+Sep + IIF(INLIST(comprob.tipo,1,17,18), ;
						TRAN(m.numero1,"@L 999")+"-"+TRAN(m.numero2,"@L 99999999"),"")

		* ITEM de la nota de credito
		CASE pQueHago == "ITEM"
			Comando = "B";
    		    +Sep+ descripcio;
		        +Sep+ TRAN(cantidad,"@L 999.9999999999");
    		    +Sep+ TRAN(ABS(unitario),"@L 999999.9999");
		        +Sep+ TRAN(fijo.ivari,"@L 99.99");
    		    +Sep+ "M";
		        +Sep+ TRAN(impuesto,"@L 9.99999999");
    		    +Sep+ "0";
		        +Sep+ "T"

		* ITEM de remito u nota de entrega
		CASE pQueHago == "ITEMR"

			Comando = "‚";
    		    +Sep+ descripcio;
		        +Sep+ TRAN(cantidad,"@L 999.9999");
	   		    +Sep+ "0"


		* ITEM de Presupuesto o Cotizacion

		CASE pQueHago == "ITEME"
			** MANDO EL ENCABEZADO CON LOS TITULOS
			Comando = CHR(132);
    		    +Sep+ "Cant.   "+" "+"Descripcion                           Desc.               "+;
    		    		"P.Unit.   "+SPACE(30)+"Importe" ;
    		    +Sep+ "0"

		CASE pQueHago == "ITEMP"
			** SI TIENE DESCUENTO POR ARTICULO INFORMAR
			IF !EMPTY(por_desc)
				mdescrip = descripcio+" Desc."+STR(por_desc,5,2)
				espacio = 9
			ELSE
				mdescrip = descripcio
				espacio = 20
			ENDIF
			Comando = CHR(132);
    		    +Sep+ TRAN(cantidad,"@L 999.9999")+" "+mdescrip+SPACE(espacio)+;
    		    		STR(unitario,10,4)+SPACE(30)+STR((cantidad*unitario)-descuento,10,2);
    		    +Sep+ "0"


		CASE pQueHago == "ITEMPT"
			** ENVIAR EL TOTAL DEL PRESUPUESTO
			mdescrip = "----------------------------------------------------"
			Comando = CHR(132);
    		    +Sep+ mdescrip+SPACE(54)+STR(m.total,10,2);
    		    +Sep+ "0"


		* ITEM de recibo x
		CASE pQueHago == "ITEMRE"
		
			** ESTE COMANDO ES COMO EL ITEM DE LA FACTURA, EL ITEM DEL RECIBO ENVIO EL IMPORTE TOTAL
			Comando = "B";
    		    +Sep+ "DESCRIPCIO";
		        +Sep+ TRAN(1,"@L 999.9999999999");
    		    +Sep+ TRAN(ABS(m.total),"@L 999999.9999");
		        +Sep+ TRAN(0,"@L 99.99");
    		    +Sep+ "M";
		        +Sep+ TRAN(0,"@L 9.99999999");
    		    +Sep+ "0";
		        +Sep+ "T"

		CASE pQueHago == "TEXTORE"
		
			** IMPRIME EL TEXTO DEL RECIBO, MAXIMO TOTAL POR RECIBO 9 LÍNEAS, MÍNIMO 1 LINEA
			
			IF EMPTY(numero2)
				mdescrip = ALLTRIM(descripcio) + IIF(!EMPTY(importe),STR(importe,10,2),"")
			ELSE
				mdescrip = ALLTRIM(DTOC(fecha)+" "+codigo+" "+;
						TRAN(numero1,"@L 9999")+"-"+TRAN(numero2,"@L 99999999")+" "+ALLTRIM(descripcio)+ ;
						IIF(!EMPTY(importe),STR(importe,10,2),""))
			ENDIF
			
			Comando = CHR(151);
    		    +Sep+ mdescrip

			
		CASE pQueHago == "DESCGRAL"
			Comando = "T";
				+Sep+" %"+TRAN(m.por_desc,"@ 99.99");
				+Sep+ TRAN(m.descuento,"@L 99999999.99");
				+Sep+ "m";
				+Sep+"0";
				+Sep+"T"
		
		CASE pQueHago == "SUBTOTAL"
			Comando = "C";
				+Sep+"P";
				+Sep+" ";
				+Sep+"0"
						
		CASE pQueHago == "TEXTO1"
			Comando = CHR(147);
				+Sep+ "1";
				+Sep+ m.condicion

		CASE pQueHago == "TEXTO1B"
			Comando = CHR(147);
				+Sep+"1";
				+Sep+CHR(127)
				** COMANDO DEL

		CASE pQueHago == "TEXTO2"
			Comando = CHR(93);
				+Sep+ "2";
				+Sep+ "Vencimiento: "+DTOC(m.vencimient)

		CASE pQueHago == "TEXTO2B"
			Comando = CHR(93);
				+Sep+"2";
				+Sep+CHR(127)
				** COMANDO DEL


		CASE pQueHago == "REIMPRE"
			Comando = chr(153)
		
		CASE pQueHago == "CERRAR"
			Comando = chr(129)
		
	ENDCASE


	IF .Enviar(Comando) < 0 
		* Para cada llamada a Enviar
		* si devuelve < 0 es problemas de comunicaciones.
		* Además, hay que comprobar la respuesta del controlador.
		STORE .F.	TO m.ok
		RETURN .F.
	endif

	m.Mensaje = .cMensaje

*	* En Respuesta se tiene la respuesta del controlador.
*	* Esto hay que hacerlo para cada llamada a pMandaPaqueteFiscal.
*
	IF !EMPTY(m.Mensaje)
		WAIT WINDOW "Impfisc " + m.Mensaje 
		STORE .F.	TO m.ok
		RETURN .F. 
	ENDIF

RETURN


