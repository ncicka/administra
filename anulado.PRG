** abrir la tabla de varticulo

SELECT varticulo
GO top
SCAN
	replace anulado WITH 0
	
	TABLEUPDATE(.t.,.t.)
ENDSCAN 
