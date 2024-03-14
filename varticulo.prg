** buscar los codigos faltantes de id

CREATE CURSOR faltante( id i, ) 
SELECT carti
GO top

i=1

DO WHILE !EOF()
	IF i = carti.id
		SELECT carti 
		SKIP 
	ELSE
		SELECT faltante
		APPEND BLANK
		replace id WITH i
	ENDIF 
	i = i+1
	SELECT carti
ENDDO 
