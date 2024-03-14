*       *********************************************************
*       *                                                         
*       * 23/02/99             ACCESO.PRG                19:54:38 
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


PUBLIC m.sistk
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

IF NOT WEXIST("vacceso") ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.PJX" ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.SCX" ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.MNX" ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.PRG" ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.FRX" ;
	OR UPPER(WTITLE("VACCESO")) == "VACCESO.QPR"
	DEFINE WINDOW vacceso ;
		AT  0.000, 0.000  ;
		SIZE 7.500,50.000 ;
		TITLE "Ingreso al Sistema" ;
		FONT "MS Sans Serif", 10 ;
		FLOAT ;
		NOCLOSE ;
		NOMINIMIZE ;
		SYSTEM ;
		COLOR RGB(,,,192,192,192)
	MOVE WINDOW vacceso CENTER
ENDIF


*       *********************************************************
*       *                                                         
*       *   ACCESO/Windows Código de configuración - SECCION 2    
*       *                                                         
*       *********************************************************
*

#REGION 1

PRIVATE m.usuario, m.clave
STORE SPACE(10)	TO m.usuario, m.clave

SELECT 0

IF !USED("usuario")
	USE usuario SHARED AGAIN ALIAS usuario
ELSE
	SELECT usuario
ENDIF

*       *********************************************************
*       *                                                         
*       *         ACCESO/Windows Distribución de pantalla         
*       *                                                         
*       *********************************************************
*

#REGION 1
IF WVISIBLE("vacceso")
	ACTIVATE WINDOW vacceso SAME
ELSE
	ACTIVATE WINDOW vacceso NOSHOW
ENDIF
@ 1.438,11.143 SAY "Usuario" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 1.438,20.000 GET m.usuario ;
	SIZE 1.000,15.714 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "@K XXXXXXXXXX" ;
	VALID LASTKEY()# 5 AND fusuario() ;
	COLOR ,RGB(,,,255,255,255)
@ 3.625,11.143 SAY "Clave" ;
	FONT "MS Sans Serif", 10 ;
	STYLE "T"
@ 3.625,20.000 GET m.clave ;
	SIZE 1.000,15.714 ;
	DEFAULT " " ;
	FONT "MS Sans Serif", 10 ;
	PICTURE "XXXXXXXXXX" ;
	VALID LASTKEY() = 5 OR fclave() ;
	COLOR ,RGB(255,255,255,255,255,255)

IF NOT WVISIBLE("vacceso")
	ACTIVATE WINDOW vacceso
ENDIF

READ MODAL

RELEASE WINDOW vacceso

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
*       *            ACCESO/Windows Código de limpieza            
*       *                                                         
*       *********************************************************
*

#REGION 1
IF LASTKEY() = 27
	DO salir
ENDIF



*       *********************************************************
*       *                                                         
*       *  ACCESO/Windows Procedimientos y funciones de soporte   
*       *                                                         
*       *********************************************************
*

#REGION 1
PROCEDURE fusuario

SELECT usuario
GO TOP
LOCATE FOR usuario.usuario == m.usuario

IF FOUND()
	STORE usuario.sistk	TO m.sistk
	RETURN .T.
ENDIF
RETURN .F.

PROCEDURE fclave

IF usuario.clave == m.clave
	RETURN .T.
ENDIF

RETURN .F.