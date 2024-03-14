SET DELETE ON
USE VENTAS1

GO TOP
SCAN FOR !EMPTY(DESCUENTO)

	REPLACE subtotal	WITH ROUND(total / 1.21,2)
	REPLACE ivari		WITH ROUND(subtotal * 21 /100,2)
	REPLACE subtotal 	WITH total - ivari
ENDSCAN

GO TOP
SCAN FOR !EMPTY(descuento1)

	REPLACE subtotal	WITH ROUND(total / 1.21,2)
	REPLACE ivari		WITH ROUND(subtotal * 21 /100,2)
	REPLACE subtotal 	WITH total - ivari
ENDSCAN
