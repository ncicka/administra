**** IMPRESION DE COMPROBANTES FISCALES
** FACTURAS - A - B - NOTAS DB - A - B

** Si existe algun error colocar m.Ok a .F.

PUBLIC mtexto1, mtexto2, mtexto3
STORE ""	TO mtexto1, mtexto2, mtexto3
Sep = CHR(28)

STORE .T.	TO m.logica
STORE " "	TO m.mensaje

M.oFormulario = CREATE( 'Form' )
M.oFormulario.AddObject( 'ImpresorFiscal' , 'Caito.ClassImpresorFiscal' )

WITH M.oFormulario.ImpresorFiscal
	
	.nCom = empresa.com
	Handler = .OpenComFiscal()
	IF Handler < 0
		.CloseComFiscal()
		RETURN .T.
	ENDIF

	Comando = "*"
	.Vertodo = .t.
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
	ENDIF

	.Vertodo = .f.
	Respuesta=space(512)
	=UltimaRespuesta(Handler, @Respuesta)

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

	** enviar Datos Comprador

	= ImpFisc("COMPRADOR")

	IF m.ok
		** Borrar la línea nº 2 que se graba en presup
		= ImpFisc("TEXTO5B")	
	ENDIF
	

	** Abrir comprobante Fiscal

	IF ImpFisc("ABRIR") AND m.ok

		SELECT (tdetalle)
		GO TOP
		SCAN

			IF !EMPTY(&tdetalle..total)
				= ImpFisc("ITEM")
		
				IF !EMPTY(descuento)
					** Descuento por articulo
					= ImpFisc ("DESCITEM")
				ENDIF
			ENDIF
		
			IF !m.ok
				EXIT
			ENDIF
	
		ENDSCAN

		IF !EMPTY(m.descuento) AND m.ok
			** Descuento General
			= ImpFisc("DESCGRAL")
		ENDIF

		IF !EMPTY(m.ivarni) AND m.ok
			** Recargo a Responsable no Inscripto
			= ImpFisc("RECARGORNI")
		ENDIF
	
		IF !EMPTY(m.ivanoc) AND m.ok
			** Recargo a No Categorizado (Percepcion)
			= ImpFisc("PERCEPCION")
		ENDIF

		IF !EMPTY(ALLTRIM(m.condicion)) AND m.ok
			** ENVIO EL TEXTO
			= ImpFisc("TEXTO1")
		ELSE
			IF m.ok
				** BORRO EL TEXTO PARA ESTE COMPROBANTE
				= ImpFisc("TEXTO1B")
			ENDIF
		ENDIF

		IF USED(tselcomp)
		
			x = 1
			
			SELECT (tselcomp)
			GO TOP
	
			SCAN WHILE x <= 9
				IF selecciono = "S"

					DO CASE
					CASE x <= 3
						mtexto1 = mtexto1 + DTOC(fecha)+" "+TRAN(numero1,"@L 9999")+"-"+TRAN(numero2,"@L 99999999")+" "
					CASE x <= 6
						mtexto2 = mtexto2 + DTOC(fecha)+" "+TRAN(numero1,"@L 9999")+"-"+TRAN(numero2,"@L 99999999")+" "
					OTHERWISE
						mtexto3 = mtexto3 + DTOC(fecha)+" "+TRAN(numero1,"@L 9999")+"-"+TRAN(numero2,"@L 99999999")+" "
					ENDCASE

					x = x + 1
				ENDIF
			ENDSCAN
			UNLOCK ALL
		ENDIF

		IF !EMPTY(mtexto1) AND m.ok
			** ENVIO EL TEXTO
			= ImpFisc("TEXTO2")
		ELSE
			IF m.ok
				** BORRO EL TEXTO PARA ESTE COMPROBANTE
				= ImpFisc("TEXTO2B")
			ENDIF
		ENDIF

		IF !EMPTY(mtexto2) AND m.ok
			** ENVIO EL TEXTO
			= ImpFisc("TEXTO3")
		ELSE
			IF m.ok
				** BORRO EL TEXTO PARA ESTE COMPROBANTE
				= ImpFisc("TEXTO3B")
			ENDIF
		ENDIF
		IF !EMPTY(mtexto3) AND m.ok
			** ENVIO EL TEXTO
			= ImpFisc("TEXTO4")
		ELSE
			IF m.ok
				** BORRO EL TEXTO PARA ESTE COMPROBANTE
				= ImpFisc("TEXTO4B")
			ENDIF
		ENDIF

		IF m.ok
			= ImpFisc ("SUBTOTAL")
		ENDIF
		
		IF m.ok
			= ImpFisc ("PAGO")
		ENDIF

		IF m.ok
			= ImpFisc ("CERRAR")
		ENDIF

	ENDIF

	RELEASE mtexto1, mtexto2, mtexto3

	.CloseComFiscal()

ENDWITH

RELEASE M.oFormulario

RETURN


FUNCTION impfisc
PARAMETERS pQueHago

	DO CASE

		CASE TRIM(pQueHago) == "COMPRADOR"
			mcuit = SUBSTR(m.cuit,1,2)+SUBSTR(m.cuit,4,8)+SUBSTR(m.cuit,13,1)
			Comando = CHR(27)+"b" ;
					+Sep + m.nombre ;
					+Sep + IIF(tipoiva.letra="C",TRAN(VAL(m.documento),"@L 99999999999"),TRAN(VAL(mcuit),"@L 99999999999")) ;
					+Sep + tipoiva.letra ;
					+Sep + IIF(tipoiva.letra="C","2", "C");
					+Sep + m.direccion
		
		CASE TRIM(pQueHago) == "ABRIR"
			Comando = CHR(27)+"@" ;
					+Sep + comprob.letra ;
					+Sep 

		CASE TRIM(pQueHago) == "ITEM"
			Comando = chr(27)+"B";
    		    +Sep+&tdetalle..descripcio;
		        +Sep+TRAN(&tdetalle..cantidad,"@L 999.9999999999");
    		    +Sep+TRAN(ABS(&tdetalle..unitario),"@L 999999.9999");
		        +Sep+TRAN(fijo.ivari,"@L 99.99");
    		    +Sep+"M";
		        +Sep+TRAN(&tdetalle..impuesto,"@L 9.99999999");
    		    +Sep+"0";
		        +Sep+"T"

		CASE TRIM(pQueHago) == "DESCITEM"
			Comando = CHR(27)+"U";
				+Sep+" %"+TRAN(por_desc,"@ 99.99");
				+Sep+ TRAN(descuento,"@L 99999999.99");
				+Sep+ "m";
				+Sep+"0";
				+Sep+"T"
		
		CASE TRIM(pQueHago) == "DESCGRAL"
			Comando = CHR(27)+"T";
				+Sep+" %"+TRAN(m.por_desc,"@ 99.99");
				+Sep+ TRAN(m.descuento,"@L 99999999.99");
				+Sep+ "m";
				+Sep+"0";
				+Sep+"T"
		
		CASE TRIM(pQueHago) == "RECARGORNI"
			Comando = CHR(27)+"a";
				+Sep+TRAN(m.ivarni, "@L 999999.99")

						
		CASE TRIM(pQueHago) == "PERCEPCION"
			Comando = chr(27)+"`";
				+Sep+"**.**";
				+Sep+"Perc.DGR. %"+TRAN(fijo.ivanoc,"@L 99.99");
				+Sep+TRAN(m.ivanoc, "@L 999999.99")

		CASE TRIM(pQueHago) == "SUBTOTAL"
			Comando = CHR(27)+"C";
				+Sep+"P";
				+Sep+" ";
				+Sep+"0"
						
		CASE TRIM(pQueHago) == "PAGO"
			m.pagado = IIF(quecon="CONTADO",m.total,0)
			mcondicion = IIF(quecon="CONTADO","Efectivo","Cuenta Corriente")

			Comando = CHR(27)+"D";
				+Sep+mcondicion;
				+Sep+TRAN(m.pagado, "@L 999999999.99");
				+Sep+"T";
				+Sep+"0"

		CASE TRIM(pQueHago) == "TEXTO1"
			Comando = CHR(27)+CHR(93);
				+Sep+"11";
				+Sep+"Cond.:"+m.condicion

		CASE TRIM(pQueHago) == "TEXTO1B"
			Comando = CHR(27)+CHR(93);
				+Sep+"11";
				+Sep+CHR(127)
		
		CASE TRIM(pQueHago) == "TEXTO2"
			Comando = CHR(27)+CHR(93);
				+Sep+"12";
				+Sep+"N.Ent:"+mtexto1

		CASE TRIM(pQueHago) == "TEXTO2B"
			Comando = CHR(27)+CHR(93);
				+Sep+"12";
				+Sep+CHR(127)
				
		CASE TRIM(pQueHago) == "TEXTO3"
			Comando = CHR(27)+CHR(93);
				+Sep+"13";
				+Sep+"N.Ent:"+mtexto2

		CASE TRIM(pQueHago) == "TEXTO3B"
			Comando = CHR(27)+CHR(93);
				+Sep+"13";
				+Sep+CHR(127)

		CASE TRIM(pQueHago) == "TEXTO4"
			Comando = CHR(27)+CHR(93);
				+Sep+"14";
				+Sep+"N.Ent:"+mtexto3

		CASE TRIM(pQueHago) == "TEXTO4B"
			Comando = CHR(27)+CHR(93);
				+Sep+"14";
				+Sep+CHR(127)

		CASE TRIM(pQueHago) == "TEXTO5B"
			Comando = chr(27)+CHR(93);
				+Sep+"2";
				+Sep+CHR(127)
				

		CASE TRIM(pQueHago) == "CERRAR"
			Comando = CHR(27)+"E"
		
	ENDCASE

	IF .Enviar(Comando) < 0
		* Para cada llamada a Enviar
		* si devuelve < 0 es problemas de comunicaciones.
		* Además, hay que comprobar la respuesta del controlador.
		STORE .F.	TO m.ok
		RETURN .F.
	endif

	Respuesta=space(512)
	=UltimaRespuesta(Handler, @Respuesta)
	
	IF TRIM(pQueHago) = "ABRIR"
		* Tomar el nro de comprobate del impresor
		pos = AT(Sep,Respuesta,3)
		m.numero2 = VAL(SUBSTR(Respuesta,pos+1,8))
	ENDIF
	
	m.Mensaje = .cMensaje
	* En Respuesta se tiene la respuesta del controlador.
	* Esto hay que hacerlo para cada llamada a Enviar
	
	IF !EMPTY(m.Mensaje)
		WAIT WINDOW "Impfisc " + m.Mensaje 
		
		IF "Falta papel" $ m.Mensaje
			IF !confirma1("Falta Papel - Continúa?")
				STORE .F.	TO m.ok
				RETURN .F. 
			ENDIF
		ELSE
			STORE .F.	TO m.ok
			RETURN .F. 
		ENDIF
	ENDIF

RETURN


