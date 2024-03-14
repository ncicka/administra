

****
* FUNCTION GetErrors
*
* Esta funcion levanta la respuesta del printer e imprime en 
* el mensaje de error si es que existe.
****

FUNCTION GetErros

PARAMETERS Resp, vError
** IF vError = .t. muestro los errores unicamente
** SINO muestro todos los mensajes


PRIVATE Origen, OffsetSep, i, c, pMensaje

Resp = ALLTRIM(Resp)
pMensaje = ''
DECLARE FiscalErrors [16]
DECLARE PrinterErrors[16]

FiscalErrors[1] = 	"Error en chequeo de memoria fiscal"
FiscalErrors[2] = 	"Error en chequeo de la memoria de trabajo"
FiscalErrors[3] = 	"Carga de bateria baja"
FiscalErrors[4] = 	"Comando desconocido"
FiscalErrors[5] = 	"Datos no validos en un campo"
FiscalErrors[6] = 	"Comando no valido para el estado fiscal actual"
FiscalErrors[7] = 	"Desborde del total"
FiscalErrors[8] = 	"Memoria fiscal llena"
FiscalErrors[9] = 	"Memoria fiscal a punto de llenarse"
FiscalErrors[10] = 	""
FiscalErrors[11] = 	""
FiscalErrors[12] = 	"Error en ingreso de fecha"
FiscalErrors[13] = 	"Recibo fiscal abierto"
FiscalErrors[14] = 	"Recibo abierto"
FiscalErrors[15] = 	"Factura abierta"
FiscalErrors[16] = 	""

PrinterErrors[1]  = ""
PrinterErrors[2]  = ""
PrinterErrors[3]  = "Error de Impresora"
PrinterErrors[4]  = "Impresora Offline"
PrinterErrors[5]  = "Falta papel del diario"
PrinterErrors[6]  = "Falta papel de tickets"
PrinterErrors[7]  = "Buffer de Impresora lleno"
PrinterErrors[8]  = ""
PrinterErrors[9]  = ""
PrinterErrors[10] = ""
PrinterErrors[11] = ""
PrinterErrors[12] = ""
PrinterErrors[13] = ""
PrinterErrors[14] = ""
PrinterErrors[15] = ""
PrinterErrors[16] = ""

Origen = AT ( '', Resp, 1 ) + 1


OffsetSep = AT ( '', Resp, 2 )

* Convierte en entero el status del impresor
PrinterStatus = HexaToInt (SUBSTR ( Resp, Origen, OffsetSep - 1))

IF PrinterStatus < 0 
	RETURN -1
ENDIF

Origen = OffsetSep

* Analiza los bits comenzando del menos significativo

FOR i = 1 TO 16
	IF ( INT (PrinterStatus % 2) == 1 )
		IF ( LEN (PrinterErrors[i]) > 0 )
			IF "P: " $ pMensaje
				pMensaje = pMensaje + ', '+ PrinterErrors[i]
			ELSE
				pMensaje = "P: " + PrinterErrors[i]
			ENDIF
		ENDIF
	ENDIF
	PrinterStatus = PrinterStatus / 2	
ENDFOR

OffsetSep = AT ( '', SUBSTR (Resp, Origen + 1) )

IF OffsetSep == 0 
	OffsetSep = LEN(Resp)
ENDIF

* Convierte en entero el status fiscal
FiscalStatus = HexaToInt (SUBSTR(Resp,Origen + 1,OffsetSep - 1))

IF FiscalStatus < 0 
	RETURN -1
ENDIF

* Analiza los bits comenzando del menos significativo
FOR i = 1 TO 16
	IF IIF(vError,!INLIST(i,13,14,15),.t.)
		IF ( INT (FiscalStatus % 2) == 1 )
			IF ( LEN (FiscalErrors[i]) > 0 )
				IF " F: " $ pMensaje
					pMensaje = pMensaje + ', '+FiscalErrors[i]
				ELSE
					pMensaje = pMensaje +" F: " + FiscalErrors[i]
				ENDIF
			ENDIF
		ENDIF
	ENDIF
	FiscalStatus = FiscalStatus / 2	
ENDFOR

RETURN pMensaje


* FUNCTION HexaToInt 
*
* Esta funcion convierte un numero hexadecimal en su equivalente
* en binario.
****

FUNCTION HexaToInt 

PARAMETERS HexValue

PRIVATE i, Value, Status

*WAIT WINDOW  'HexValue = ' + HexValue

Status = 0

FOR i = 4 TO 1 STEP -1

	S = SUBSTR(HexValue, i, 1)

	Value = ASC (S)

	DO CASE 
		CASE ( Value >= ASC('A') AND Value <= ASC('F') )

			Value = Value - ASC('A') + 10
			Status = Status + Value * (16 ** ( 4 - i ))

		CASE ( Value >= ASC('a') AND Value <= ASC('f') )

			Value = Value - ASC('a') + 10
			Status = Status + Value * (16 ** ( 4 - i ))

		CASE  ( Value >= ASC('0') AND Value <= ASC('9') )

			Value = Value - ASC('0')
			Status = Status + Value * (16 ** ( 4 - i ))
	
		OTHERWISE
			WAIT  "HexaToInt: Numero hexadecimal incorrecto: " + HexValue WINDOW NOWAIT
			RETURN -1
	
	ENDCASE	

ENDFOR

RETURN Status

FUNCTION MensajeErrorDLLS
	
		LPARAMETERS nError , cMensaje2
		
		PRIVATE cMensaje , cMensaje3
		LOCAL cMensaje , cMensaje3
		
		IF UPPER( TYPE( 'M.nError' ) ) == 'N'
			
			IF UPPER( TYPE( 'M.cMensaje2' ) ) == 'C'
				M.cMensaje3 = M.cMensaje2
			ELSE
				M.cMensaje3 = ''
			ENDIF
			
			DO CASE
				CASE M.nError == - 1
					M.cMensaje = 'Error general'
				CASE M.nError == - 2
					M.cMensaje = 'Handler Inválido'
				CASE M.nError == - 3
					M.cMensaje = 'Intento de Superposición'
				CASE M.nError == - 4
					M.cMensaje = 'Error de Comunicación'
				CASE M.nError == - 5
					M.cMensaje = 'Puerto ya Abierto'
				CASE M.nError == - 6
					M.cMensaje = 'No hay Memoria'
				OTHERWISE
					M.cMensaje = 'Error Desconocido'
			ENDCASE

			M.cMensaje = M.cMensaje + '(' + ;
ALLTRIM(STR(ABS(M.nError))) + ')' + ;
'  ' + M.cMensaje3 

			= MESSAGEBOX (M.cMensaje , 0 + 48 + 0 , ;
'Mensaje de Error en DLL Fiscal')

		ENDIF
	
RETURN
