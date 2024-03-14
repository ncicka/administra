SELECT varticulo
GO top
SCAN
	replace enviado WITH 0
	TABLEUPDATE(.t.,.t.)
	
ENDSCAN
