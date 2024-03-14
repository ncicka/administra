** programa para arreglar los totales de caja
** que estan defasados con los detalles

** abrir las vistas VCAJA1 y VCAJA2

SELECT IDCAJA1, SUM(TOTAL) FROM vcaja2 GROUP BY 1 INTO CURSOR total

SELECT total.idcaja1,total.sum_total,vcaja1.total ;
	FROM vcaja1 INNER JOIN total ON vcaja1.id = total.idcaja1 ;
	WHERE vcaja1.total <> total.sum_total ;
	into CURSOR resultado
	
	
SELECT resultado
GO top
SCAN
	MESSAGEBOX(sum_total)
	*UPDATE vcaja1 SET total=resultado.sum_total ;
		WHERE id = resultado.idcaja1
	*=TABLEUPDATE(.t.,.t.,'vcaja1')
	SELECT resultado 
ENDSCAN 