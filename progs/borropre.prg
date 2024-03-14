*       *********************************************************
*       *                                                         
*       * 11/01/05            BORROPRESU.PRG               20:42:24 
*       * BORRAR PRESUPUESTOS POR RANGO DE FECHA DE VENCIMIENTO                                                   
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

IF NOT WEXIST("vblanqueo") ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.PJX" ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.SCX" ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.MNX" ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.PRG" ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.FRX" ;
	OR UPPER(WTITLE("VBLANQUEO")) == "VBLANQUEO.QPR"
	DEFINE WINDOW vblanqueo ;
		AT  0.000, 0.000  ;
		SIZE 10.313,58.857 ;
		TITLE "Eliminar Presupuestos Vencidos" ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW vblanqueo CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *  BLANQUEO/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1
PRIVATE m.confirma

STORE 1		TO m.confirma

*       *********************************************************
*       *                                                         
*       *        BLANQUEO/Windows Distribución de pantalla        
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vblanqueo")
	ACTIVATE WINDOW vblanqueo SAME
ELSE
	ACTIVATE WINDOW vblanqueo NOSHOW
ENDIF
@ 0.688,12.857 SAY "Rango de Fechas" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 2.688,13.143 GET m.fecdes ;
	SIZE 1.000,13.429 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@KE 99/99/9999" ;
	VALID LASTKEY()=5 OR fctrfech(m.fecdes,"m.fecdes") ;
	COLOR ,RGB(,,,255,255,255)
@ 2.688,29.571 GET m.fechas ;
	SIZE 1.000,13.429 ;
	DEFAULT {  /  /  } ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@KE 99/99/9999" ;
	VALID LASTKEY()=5 OR fctrfech(m.fechas,"m.fechas") AND m.fechas>=m.fecdes ;
	COLOR ,RGB(,,,255,255,255)
@ 7.500,17.000 GET m.confirma ;
	PICTURE "@*HT \<Cancelar;\<Aceptar" ;
	SIZE 1.769,12.600,4.000 ;
	DEFAULT 1 ;
	FONT "MS Sans Serif", 8 ;
	VALID fconfirma()

IF NOT WVISIBLE("vblanqueo")
	ACTIVATE WINDOW vblanqueo
ENDIF

READ CYCLE MODAL

RELEASE WINDOW vblanqueo

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
*       * BLANQUEO/Windows Procedimientos y funciones de soporte  
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE fconfirma

IF m.confirma = 2
						&& Eliminacion de presupuestos
	IF USED("presup")
		SELECT presup1
		USE
	ENDIF

	IF USED("presup2")
		SELECT presup2
		USE
	ENDIF


	andele = SET('DELETE')
	annear = SET('NEAR')
	SET DELETE OFF
	SET NEAR ON
	
	SELECT 0
	USE presup1 EXCLUSIVE
	SET ORDER TO presup3

	SELECT 0
	USE presup2 EXCLUSIVE
	SET ORDER TO presup1
	
	
	SELECT presup1
	SEEK DTOS(m.fecdes)
	
	SCAN WHILE BETWEEN(vencimient, m.fecdes, m.fechas)

		SELECT presup2
		SEEK DTOS(presup1.fecha)+STR(presup1.tipo,2)+;
			STR(presup1.numero1,4)+STR(presup1.numero2,8)
	
		SCAN WHILE fecha = presup1.fecha AND tipo = presup1.tipo AND ;
				numero1 = presup1.numero1 AND numero2 = presup1.numero2

			DELETE
					
		ENDSCAN

		SELECT presup1
		DELETE
					
	ENDSCAN


	SELECT presup1
	USE
	
	SELECT presup2
	USE

	SET DELETE &andele
	SET NEAR &annear
ENDIF

RETURN

