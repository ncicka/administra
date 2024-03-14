** 16-01-2015
** tener abierto el vcaja1
** arregla el idcuenta de la sucursal los datos que trae


SELECT vcaja1
GO top
SCAN FOR idempresa = 13	
	IF idcomprob = 13
		replace idcuenta WITH idempresa
		=TABLEUPDATE(.t.,.t.,'vcaja1'))
	ENDIF 
ENDSCAN

