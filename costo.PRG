SELECT varticulo
*GO top
SCAN
	replace costo WITH unitario
	=TABLEUPDATE(.t.,.t.)
ENDSCAN 
