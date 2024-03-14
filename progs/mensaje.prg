*       *********************************************************
*       *                                                         
*       * 29/01/99             MENSAJE.PRG               17:48:38 
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


PARAMETERS elmensaje

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

IF NOT WEXIST("scmensaje") ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.PJX" ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.SCX" ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.MNX" ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.PRG" ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.FRX" ;
	OR UPPER(WTITLE("SCMENSAJE")) == "SCMENSAJE.QPR"
	DEFINE WINDOW scmensaje ;
		AT  0.000, 0.000  ;
		SIZE 8.188,49.857 ;
		FONT "MS Sans Serif", 10 ;
		TITLE "Mensaje" ;
		FLOAT ;
		CLOSE ;
		NOMINIMIZE ;
		DOUBLE ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW scmensaje CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   MENSAJE/Windows Código de configuración - SECCION 2   
*       *                                                         
*       *********************************************************
*

#REGION 1



*       *********************************************************
*       *                                                         
*       *        MENSAJE/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("scmensaje")
	ACTIVATE WINDOW scmensaje SAME
ELSE
	ACTIVATE WINDOW scmensaje NOSHOW
ENDIF
@ 2.500,1.143 SAY elmensaje ;
	SIZE 5.000,43.286 ;
	STYLE "B" ;
	FONT "MS Sans Serif", 10

IF NOT WVISIBLE("scmensaje")
	ACTIVATE WINDOW scmensaje
ENDIF

DO WHILE .T.
	inval1 = INKEY(.06,'HM')			&& Tomar INKEY(), ocultar 
													&& cursor, comprobar mouse
	IF inval1 = 0						&& No hay pulsación de 
													&& tecla ni mo	
		LOOP
	ENDIF
													&& salir de bucle principal
	EXIT

ENDDO 	Fin del bucle principal


RELEASE WINDOW scmensaje

#REGION 0

SET READBORDER &rborder

IF m.talkstat = "ON"
	SET TALK ON
ENDIF
IF m.compstat = "ON"
	SET COMPATIBLE ON
ENDIF
