SELECT vcaja1
GO top
SCAN 
	replace  cerrada WITH 1 
	TABLEUPDATE(.t.,.t.)	
endscan

