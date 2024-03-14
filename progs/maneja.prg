*       *********************************************************
*       *                                                         
*       * 19/02/1999            MANEJA.PRG              11:06:37  
*       *                                                         
*       *********************************************************
*       *                                                         
*       * Eduardo R. López - Noemi M. Cicka
*       *                                                         
*       * Copyright (c) 1998 Sistemas de Infrmación               
*       * 25 de Mayo 66                                           
*       * Sáenz Peña, Chaco  3700                                    
*       * Argentina                                         
*       *                                                         
*       * Description:                                            
*       * Este programa lo ha generado automáticamente GENMENU.    
*       *                                                         
*       *********************************************************


*       *********************************************************
*       *                                                         
*       *                  Código de configuración                
*       *                                                         
*       *********************************************************
*

SET COMPATIBLE  ON
IF !FILE("\WINDOWS\WIN.LOG")
	DEFINE WINDOW scerror AT 00,00 SIZE 20,50 ;
			COLOR RGB(,,,255,0,0) ;
			TITLE "ERROR GRAVE"
	MOVE WINDOW scerror CENTER
	ACTIVATE WINDOW  scerror
	@ 00,00 SAY  "                                           " ;
			COLOR RGB(255,255,255,,,,)
	@ 01,00 SAY "    ¡ CUIDADO ! ¡ CUIDADO ! ¡ CUIDADO !     " ;
			COLOR RGB(255,255,255,,,,)
	@ 02,00 SAY "                                            " ;
			COLOR RGB(255,255,255,,,,)
	@ 03,00 SAY " USTED ESTA INTENTANDO UTILIZAR UN PROGRAMA " ;
			COLOR RGB(255,255,255,,,,)
	@ 04,00 SAY " EN FORMA ILEGAL.                           " ;
			COLOR RGB(255,255,255,,,,)
	@ 05,00 SAY "                                            " ;
			COLOR RGB(255,255,255,,,,)
	@ 06,00 SAY " PARA OBTENER LA LICENCIA DE USO, PONGASE EN"
	@ 07,00 SAY " CONTACTO CON NOEMI CICKA "
	@ 08,00 SAY "            O EDUARDO LOPEZ"
	@ 09,00 SAY "              25 DE MAYO 66"
	@ 10,00 SAY "              SAENZ PEÑA - CHACO"
	@ 11,00 SAY "              TEL. 03732 - 420670"
	@ 12,00 SAY "                                            "
	@ 13,00 SAY "                         MUCHAS GRACIAS"
	@ 14,00 SAY  "                                           "
	READ TIMEOUT 15
	QUIT
ENDIF

CLOSE DATABASES
SET DATE TO BRITISH
SET CENTURY		ON
SET MULTILOCKS  ON
SET REPROCESS TO 30
SET CONSOLE 	ON
SET DELETED 	ON
SET READBORDER  ON
SET CONFIRM 	OFF
SET PRINTER 	OFF
SET TALK 		OFF
SET ESCAPE 		OFF
SET ECHO 		OFF
SET STATUS BAR	OFF
SET SCOREBOARD 	OFF
SET BELL 		OFF
SET SAFETY 		OFF
SET FIXED		ON
SET POINT		TO
SET PROCEDURE 	TO LIBRERIA
*SET LIBRARY TO "lib_fis.prg" 
SET EXCLUSIVE	OFF
SET DECIMAL 	TO 4
*SET HELP 		TO HLPESSO
SET HELP OFF
*ON KEY LABEL F1 Help

PUBLIC micono 
micono = "fldropen2.ico"
SELECT 0
IF !USED("empresa")
	USE empresa SHARED
	GO TOP
ENDIF

MODIFY WINDOW SCREEN ;
	AT  0.000, 1.000  ;
	SIZE 30.000,103.000 ;
	TITLE empresa.nombre + "    Fecha: "+DTOC(DATE())+" Sistemas de Información " ;
	FONT "MS Sans Serif", 8 ;
	STYLE "BT" ;
	NOFLOAT ;
	NOCLOSE ;
	MINIMIZE ;
	COLOR RGB(,,,0,128,128)
	*
CLEAR

ZOOM WINDOW SCREEN MAX

SET SYSMENU TO

IF EMPTY(fecha)
	REPLACE fecha WITH GOMONTH(DATE(),3)
ELSE
	IF DATE() > fecha
		*** PARA DEMOSTRACIÓN
		
		DEFINE WINDOW vdemos ;
		AT  0.000, 0.000  ;
		SIZE 7.500,50.000 ;
		TITLE "Error" ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
		MOVE WINDOW vdemos CENTER
		ACTIVATE WINDOW vdemos
		
		@ 1.438,1.143 SAY "Finalizó el tiempo de Demostración" ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T"
		@ 2.438,1.143 SAY "Presione una tecla para continuar..." ;
		FONT "MS Sans Serif", 10 ;
		STYLE "T"
		WAIT ''
		RELEASE WINDOW vdemos
		CLOS ALL
		QUIT
	ENDIF
ENDIF

DO acceso

*****************************************************************
*               INICIALIZACION DE LA LIBRERIA
*               PARA IMPRESORA FISCAL

DO FORM frmactualiza
DO tempo

SET LIBRARY TO "FOXTOOLS.FLL" ADDITIVE
SET CLASSLIB TO Caito ADDITIVE

DECLARE INTEGER UltimaRespuesta IN WinFis32.dll ;
		AS UltimaRespuesta ;
		INTEGER nHandler , STRING  @ cBuffer
DECLARE INTEGER OpenComFiscal IN WinFis32.dll ;
		AS mOpenComFiscal ;
		INTEGER nCom , INTEGER nModo
DECLARE INTEGER InitFiscal IN WinFis32.dll ;
		AS InitFiscal ;
		INTEGER nHandler
DECLARE CloseComFiscal IN WinFis32.dll ;
		AS mCloseComFiscal ;
		INTEGER nHandler
DECLARE INTEGER MandaPaqueteFiscal IN WinFis32.dll ;
		AS mMandaPaqueteFiscal ;
		INTEGER nHandler , STRING  @ cBuffer
DECLARE INTEGER UltimoStatus IN WinFis32.dll ;
		AS UltimoStatus ;
		INTEGER nHandler ;
		, INTEGER @ nFiscalStatus , INTEGER @ nPrinterStatus
DECLARE INTEGER VersionDLLFiscal IN WinFis32.dll ;
		AS VersionDLLFiscal
DECLARE BusyWaitingMode IN WinFis32.dll ;
		AS BusyWaitingMode ;
		INTEGER nMode



SELECT 0

*       *********************************************************
*       *                                                         
*       *                    Definición de menú                   
*       *                                                         
*       *********************************************************
*


*SET SYSMENU AUTOMATIC

*DEFINE PAD _rza0ntb3p OF _MSYSMENU PROMPT "\<Actualizaciones" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3r OF _MSYSMENU PROMPT "\<Ventas" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3a OF _MSYSMENU PROMPT "\<Compras" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3s OF _MSYSMENU PROMPT "\<Listados" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3x OF _MSYSMENU PROMPT "I\<nformes" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3u OF _MSYSMENU PROMPT "\<Mantenimiento" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3t OF _MSYSMENU PROMPT "L\<ista de Precios" COLOR SCHEME 3
*DEFINE PAD _rza0ntb3v OF _MSYSMENU PROMPT "\<Salir" COLOR SCHEME 3
*ON PAD _rza0ntb3p OF _MSYSMENU ACTIVATE POPUP actualizac
*ON PAD _rza0ntb3r OF _MSYSMENU ACTIVATE POPUP ventas
*ON PAD _rza0ntb3a OF _MSYSMENU ACTIVATE POPUP compras
*ON PAD _rza0ntb3s OF _MSYSMENU ACTIVATE POPUP listados
*ON PAD _rza0ntb3x OF _MSYSMENU ACTIVATE POPUP informes
*ON PAD _rza0ntb3u OF _MSYSMENU ACTIVATE POPUP mantenimie
*ON SELECTION PAD _rza0ntb3t OF _MSYSMENU DO listapre
*ON SELECTION PAD _rza0ntb3v OF _MSYSMENU DO salir


*DEFINE POPUP actualizac MARGIN RELATIVE SHADOW COLOR SCHEME 4 
*DEFINE BAR 1 OF actualizac PROMPT "Rubros"
*DEFINE BAR 2 OF actualizac PROMPT "Artículos"
*DEFINE BAR 3 OF actualizac PROMPT "Clientes"
*DEFINE BAR 4 OF actualizac PROMPT "Proveedores"
*DEFINE BAR 5 OF actualizac PROMPT "Variables Numéricas"
*DEFINE BAR 6 OF actualizac PROMPT "Listas de Precios"
*DEFINE BAR 7 OF actualizac PROMPT "Empresas"
*DEFINE BAR 8 OF actualizac PROMPT "Comprobantes"
*DEFINE BAR 9 OF actualizac PROMPT "Usuarios"

*ON SELECTION BAR 1 OF actualizac DO rubro
*ON SELECTION BAR 2 OF actualizac DO articulo.spr
*ON SELECTION BAR 3 OF actualizac DO clientes
*ON SELECTION BAR 4 OF actualizac DO provedor.spr
*ON SELECTION BAR 5 OF actualizac DO fijo
*ON SELECTION BAR 6 OF actualizac DO lista
*ON SELECTION BAR 7 OF actualizac DO empresa
*ON SELECTION BAR 8 OF actualizac DO comprob
*ON SELECTION BAR 9 OF actualizac DO usuario.spr

*DEFINE POPUP ventas MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF ventas PROMPT "Contado"
*DEFINE BAR 2 OF ventas PROMPT "Cuenta corriente"
*DEFINE BAR 3 OF ventas PROMPT "\-"
*DEFINE BAR 4 OF ventas PROMPT "Anulación de Facturas"
*DEFINE BAR 5 OF ventas PROMPT "Anulación de Notas de Débito"
*DEFINE BAR 6 OF ventas PROMPT "Anulación de Notas de Entrega"
*DEFINE BAR 7 OF ventas PROMPT "Anulación de Notas de Crédito"
*DEFINE BAR 8 OF ventas PROMPT "Anulación de Cobros"
*DEFINE BAR 9 OF ventas PROMPT "\-"
*DEFINE BAR 10 OF ventas PROMPT "Reimpresión de Comprobantes"
*DEFINE BAR 11 OF ventas PROMPT "\-"
*DEFINE BAR 12 OF ventas PROMPT "Impresora Fiscal"
*DEFINE BAR 13 OF ventas PROMPT "\-"
*DEFINE BAR 14 OF ventas PROMPT "Eliminar Presupuestos"


*ON BAR 1 OF ventas ACTIVATE POPUP vcontado
*ON BAR 2 OF ventas ACTIVATE POPUP vctacte
*ON SELECTION BAR 4 OF ventas DO anulacio WITH "Facturas"
*ON SELECTION BAR 5 OF ventas DO anulacio WITH "N. Debito"
*ON SELECTION BAR 6 OF ventas DO anulacio WITH "N. Entrega"
*ON SELECTION BAR 7 OF ventas DO anulacio WITH "N. Credito"
*ON SELECTION BAR 8 OF ventas DO anulapag
*ON SELECTION BAR 10 OF ventas DO reimpre
*ON BAR 12 OF ventas ACTIVATE POPUP fiscal
*ON SELECTION BAR 14 OF ventas DO borropre

*DEFINE POPUP vcontado MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF vcontado PROMPT "Facturas"
*DEFINE BAR 2 OF vcontado PROMPT "Notas de Débito"
*DEFINE BAR 3 OF vcontado PROMPT "\-"
*DEFINE BAR 4 OF vcontado PROMPT "Notas de Entrega"
*DEFINE BAR 5 OF vcontado PROMPT "Notas de Crédito"
*DEFINE BAR 6 OF vcontado PROMPT "\-"
*DEFINE BAR 7 OF vcontado PROMPT "Facturas Manuales"
*DEFINE BAR 8 OF vcontado PROMPT "\-"
*DEFINE BAR 9 OF vcontado PROMPT "Presupuestos"

*ON SELECTION BAR 1 OF vcontado DO factura 	WITH "FACTURA","CONTADO"
*ON SELECTION BAR 2 OF vcontado DO notadb  	WITH "N. DEBITO", "CONTADO"
*ON SELECTION BAR 4 OF vcontado DO factura 	WITH "N. ENTREGA","CONTADO"
*ON SELECTION BAR 5 OF vcontado DO notadb  	WITH "N. CREDITO","CONTADO"
*ON SELECTION BAR 7 OF vcontado DO facturam 	WITH "FACTURA","CONTADO"
*ON SELECTION BAR 9 OF vcontado DO presup	WITH "PRESUP"


*DEFINE POPUP vctacte MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF vctacte PROMPT "Facturas"
*DEFINE BAR 2 OF vctacte PROMPT "Notas de Débito"
*DEFINE BAR 3 OF vctacte PROMPT "\-"
*DEFINE BAR 4 OF vctacte PROMPT "Notas de Entrega"
*DEFINE BAR 5 OF vctacte PROMPT "Notas de Crédito"
*DEFINE BAR 6 OF vctacte PROMPT "Cobros"
*DEFINE BAR 7 OF vctacte PROMPT "Recibos"
*DEFINE BAR 8 OF vctacte PROMPT "\-"
*DEFINE BAR 9 OF vctacte PROMPT "Facturas Manuales"

*ON SELECTION BAR 1 OF vctacte DO factura 	WITH "FACTURA","CUENTA CORRIENTE"
*ON SELECTION BAR 2 OF vctacte DO notadb  	WITH "N. DEBITO", "CUENTA CORRIENTE"
*ON SELECTION BAR 4 OF vctacte DO factura 	WITH "N. ENTREGA","CUENTA CORRIENTE"
*ON SELECTION BAR 5 OF vctacte DO notadb  	WITH "N. CREDITO","CUENTA CORRIENTE"
*ON SELECTION BAR 6 OF vctacte DO pagos
*ON SELECTION BAR 7 OF vctacte DO pagos1
*ON SELECTION BAR 9 OF vctacte DO facturam 	WITH "FACTURA","CUENTA CORRIENTE"

*DEFINE POPUP listados MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF listados PROMPT "Rubros"
*DEFINE BAR 2 OF listados PROMPT "Artículos"
*DEFINE BAR 3 OF listados PROMPT "Clientes"
*DEFINE BAR 4 OF listados PROMPT "Proveedores"
*DEFINE BAR 5 OF listados PROMPT "\-"
*DEFINE BAR 6 OF listados PROMPT "Lista de Precios"
*DEFINE BAR 7 OF listados PROMPT "Estadística de Ventas por Artículo"
*DEFINE BAR 8 OF listados PROMPT "Stock"
*DEFINE BAR 9 OF listados PROMPT "Comprobantes sin facturar"
*DEFINE BAR 10 OF listados PROMPT "Facturas"
*DEFINE BAR 11 OF listados PROMPT "Notas de Créditos"
*DEFINE BAR 12 OF listados PROMPT "Notas de Débitos"
*DEFINE BAR 13 OF listados PROMPT "Presupuestos"
*DEFINE BAR 15 OF listados PROMPT "\-"
*DEFINE BAR 16 OF listados PROMPT "Comprobantes de Compras"
*DEFINE BAR 17 OF listados PROMPT "\-"
*DEFINE BAR 18 OF listados PROMPT "Etiquetas de Código de Barras"


*ON SELECTION BAR 1 OF listados  DO l_rubro
*ON SELECTION BAR 2 OF listados  DO l_artic.prg
*ON SELECTION BAR 3 OF listados  DO l_client.PRG
*ON SELECTION BAR 4 OF listados  DO l_proved.PRG
*ON SELECTION BAR 6 OF listados  DO l_lispre
*ON SELECTION BAR 7 OF listados  DO L_vtart.PRG
*ON SELECTION BAR 8 OF listados  DO l_stock
*ON SELECTION BAR 9 OF listados  DO l_sinfac
*ON SELECTION BAR 10 OF listados DO l_facncr WITH 'F'
*ON SELECTION BAR 11 OF listados DO l_facncr WITH 'C'
*ON SELECTION BAR 12 OF listados DO l_facncr WITH 'D'
*ON SELECTION BAR 13 OF listados DO l_presup
*ON SELECTION BAR 16 OF listados DO l_facncc
*ON SELECTION BAR 18 OF listados DO etiqueta.spr

*DEFINE POPUP informes MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF informes PROMPT "Resúmen de Cuenta Clientes"
*DEFINE BAR 2 OF informes PROMPT "Saldos Clientes"
*DEFINE BAR 3 OF informes PROMPT "\-"
*DEFINE BAR 4 OF informes PROMPT "Resúmen de Proveedores"
*DEFINE BAR 5 OF informes PROMPT "Saldos Proveedores"
*DEFINE BAR 6 OF informes PROMPT "\-"
*DEFINE BAR 7 OF informes PROMPT "Emisión Libro Iva Ventas"
*DEFINE BAR 8 OF informes PROMPT "Emisión Libro Iva Compras"
*DEFINE BAR 9 OF informes PROMPT "\-"
*DEFINE BAR 10 OF informes PROMPT "Planilla de Caja"

*ON SELECTION BAR 1 OF informes  DO l_rescta.prG
*ON SELECTION BAR 2 OF informes  DO l_salcta.spr
*ON SELECTION BAR 4 OF informes  DO l_respro.PRG
*ON SELECTION BAR 5 OF informes  DO l_salpro.spr
*ON SELECTION BAR 7 OF informes DO l_ivavta
*ON SELECTION BAR 8 OF informes DO l_ivacpr.spr
*ON SELECTION BAR 10 OF informes DO l_caja.spr

*DEFINE POPUP mantenimie MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF mantenimie PROMPT "Recrear Indices"
*DEFINE BAR 2 OF mantenimie PROMPT "Compactar Sistema"
*DEFINE BAR 3 OF mantenimie PROMPT "Blanquear Movimientos"
*DEFINE BAR 4 OF mantenimie PROMPT "Modificar diseño de factura"
*DEFINE BAR 5 OF mantenimie PROMPT "Cierre de Caja"
*DEFINE BAR 6 OF mantenimie PROMPT "\-"
*DEFINE BAR 7 OF mantenimie PROMPT "Re-Calculo Saldo Clientes"
*DEFINE BAR 8 OF mantenimie PROMPT "Re-Calculo Saldo Proveedores"
*DEFINE BAR 9 OF mantenimie PROMPT "\-"
*DEFINE BAR 10 OF mantenimie PROMPT "Enviar actualizaciones"

**DEFINE BAR 4 OF mantenimie PROMPT "Manual de Ayuda"

*ON SELECTION BAR 1 OF mantenimie ;
*	DO mantenim WITH "¿Está Seguro de Recrear Indices?",.f.
*ON SELECTION BAR 2 OF mantenimie ;
*	DO mantenim WITH "¿Está Seguro de Compactar Sistema?",.t.
*ON SELECTION BAR 3 OF mantenimie ;
*	DO blanqueo 
*ON SELECTION BAR 4 OF mantenimie ;
*	MODI REPOR factura
*ON SELECTION BAR 5 OF mantenimie ;
*	DO cier_caj
*ON SELECTION BAR 7 OF mantenimie DO act_sal
*ON SELECTION BAR 8 OF mantenimie DO act_sapr
*ON SELECTION BAR 10 OF mantenimie DO FORM enviar
**ON SELECTION BAR 4 OF mantenimie Help

*DEFINE POPUP compras MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF compras PROMPT "Contado"
*DEFINE BAR 2 OF compras PROMPT "Cuenta corriente"
*DEFINE BAR 3 OF compras PROMPT "\-"
*DEFINE BAR 4 OF compras PROMPT "Anulación de Facturas"
*DEFINE BAR 5 OF compras PROMPT "Anulación de Notas de Débito"
*DEFINE BAR 6 OF compras PROMPT "Anulación de Remitos"
*DEFINE BAR 7 OF compras PROMPT "Anulación de Notas de Crédito"
*DEFINE BAR 8 OF compras PROMPT "Anulación de Pagos"

*ON BAR 1 OF compras ACTIVATE POPUP ccontado
*ON BAR 2 OF compras ACTIVATE POPUP cctacte
*ON SELECTION BAR 4 OF compras DO anulacpr WITH "Facturas"
*ON SELECTION BAR 5 OF compras DO anulacpr WITH "N. Debito"
*ON SELECTION BAR 6 OF compras DO anulacpr WITH "Remitos"
*ON SELECTION BAR 7 OF compras DO anulacpr WITH "N. Credito"
*ON SELECTION BAR 8 OF compras DO anulappr

*DEFINE POPUP ccontado MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF ccontado PROMPT "Facturas"
*DEFINE BAR 2 OF ccontado PROMPT "Notas de Débito"
*DEFINE BAR 3 OF ccontado PROMPT "\-"
*DEFINE BAR 4 OF ccontado PROMPT "Remitos"
*DEFINE BAR 5 OF ccontado PROMPT "Notas de Crédito"
*ON SELECTION BAR 1 OF ccontado DO facturco WITH "FACTURA","CONTADO"
*ON SELECTION BAR 2 OF ccontado DO notadbpr WITH "N. DEBITO", "CONTADO"
*ON SELECTION BAR 4 OF ccontado DO facturco WITH "REMITOS","CONTADO"
*ON SELECTION BAR 5 OF ccontado DO notadbpr WITH "N. CREDITO","CONTADO"


*DEFINE POPUP cctacte MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF cctacte PROMPT "Facturas"
*DEFINE BAR 2 OF cctacte PROMPT "Notas de Débito"
*DEFINE BAR 3 OF cctacte PROMPT "\-"
*DEFINE BAR 4 OF cctacte PROMPT "Remitos"
*DEFINE BAR 5 OF cctacte PROMPT "Notas de Crédito"
*DEFINE BAR 6 OF cctacte PROMPT "Pagos "
*ON SELECTION BAR 1 OF cctacte DO facturco WITH "FACTURA","CUENTA CORRIENTE"
*ON SELECTION BAR 2 OF cctacte DO notadbpr WITH "N. DEBITO", "CUENTA CORRIENTE"
*ON SELECTION BAR 4 OF cctacte DO facturco WITH "REMITOS","CUENTA CORRIENTE"
*ON SELECTION BAR 5 OF cctacte DO notadbpr WITH "N. CREDITO","CUENTA CORRIENTE"
*ON SELECTION BAR 6 OF cctacte DO pagospr


*DEFINE POPUP fiscal MARGIN RELATIVE SHADOW COLOR SCHEME 4
*DEFINE BAR 1 OF fiscal PROMPT "Solicitud de Estado"
*DEFINE BAR 2 OF fiscal PROMPT "Cierre X"
*DEFINE BAR 3 OF fiscal PROMPT "Cierre Z"
*DEFINE BAR 4 OF fiscal PROMPT "Cancelar Comprobante"
*DEFINE BAR 5 OF fiscal PROMPT "Configuracion"
**DEFINE BAR 6 OF fiscal PROMPT "Cerrar Comp. NFH"

*ON SELECTION BAR 1 OF fiscal DO estado.spr
*ON SELECTION BAR 2 OF fiscal DO cerrar WITH "X"
*ON SELECTION BAR 3 OF fiscal DO cerrar WITH "Z"
*ON SELECTION BAR 4 OF fiscal DO cancelar.spr
*ON SELECTION BAR 5 OF fiscal DO config.spr
**ON SELECTION BAR 6 OF fiscal DO cerrarn.spr

** Modificar la estructura de articulos
*DO estruct

*DO WHILE .T.
*	padant=PAD()
*	IF !EMPTY(padant)
*		ACTIVATE MENU _MSYSMENU PAD (padant)
*	ELSE
*		ACTIVATE MENU _MSYSMENU
*	ENDIF
*ENDDO

DO maneja.mpr
*ACTIVATE MENU _MSYSMENU


PROCEDURE CERRAR
PARAMETER m.var
PUBLIC m.reporte
m.reporte = m.var
DO cierre.spr

RELEASE m.reporte
RETURN

PROCEDURE salir
MODIFY WINDOW SCREEN
SET LIBRARY TO 
SET CLASSLIB TO
CLEAR EVENTS
QUIT
RETURN
