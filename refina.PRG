** 10-04-14

** verificando refinanciacion
SELECT vborrado_ventas3

SELECT distinc idaplicado FROM vborrado_ventas3 INTO CURSOR aplicado
*BROWSE

SELECT * FROM vventas1 INNER JOIN aplicado ON vventas1.id = aplicado.idaplicado INTO CURSOR cventa1


SELECT * FROM vventas3 INNER JOIN aplicado ON vventas3.idventas1 = aplicado.idaplicado INTO CURSOR cventa31


SELECT  idventas1,id, nro_cuota, vencimiento, importe, pagado, 'v3' as tabla  FROM vventas3 ;
	UNION select idventas1,id, nro_cuota, vencimiento, importe,pagado,'bo' as tabla FROM vborrado_ventas3 ;
	ORDER BY 1,4 INTO CURSOR cventa3