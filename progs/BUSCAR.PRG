*** FUNCION PARA BUSCAR Y POSICIONARSE EN EL REGISTRO ENCONTRADO
*** PARAMETROS 
****** pbase = Nombre de la base a realizar la busqueda
****** pclave = Clave con la que se va a buscar en pbase
****** pcampo = String que contiene los campos a visualizar
****** pordenb = Orden por el cual se va a buscar
****** pordenv = Orden con el que se van a visualizar los campos

PARAMETERS pbase, pclave, pordenb, pordenv, pcampo
anex = SET('EXACT')
SET EXACT OFF
SELECT (pbase)
SET ORDER TO (pordenb) 
SEEK (pclave)
IF FOUND()
	SET EXACT &anex
	RETURN .T.
ELSE
	IF !EMPTY(RECCOUNT())
		SET ORDER TO (pordenv)
   	   	SET CONFIRM ON                                         
   	   	anescape = ON('KEY','ESCAPE')
   	   	ON KEY LABEL ESCAPE
   		DEFINE POPUP ppopup FROM 06,41;         
		TITLE ' Encontrar ' IN SCREEN;
		FOOTER '[ENTER] Selecciona' SHADOW;
        PROMPT FIELD &pcampo. COLOR SCHEME 8
   	    ON SELECTION POPUP ppopup DEACTIVATE POPUP ppopup      
        ACTIVATE POPUP ppopup                                  
   	    SET CONFIRM OFF                                        
   	    ON KEY LABEL ESCAPE &anescape.
       	RELEASE POPUP ppopup                                   
        IF LASTKEY() = 27                                       
        	SET EXACT &anex
			RETURN .F.
		ENDIF
	ELSE
       	SET EXACT &anex
       	WAIT 'No hay registros a seleccionar' WINDOW
		RETURN .F.
	ENDIF
ENDIF
SET EXACT &anex
RETURN .T.