** tener abieto vbarrio
** y en la misma carpeta barrios.dbf del otro sistema

SELECT id,descripcio,cod_barrio ;
	FROM vbarrio INNER JOIN barrios ON ALLTRIM(vbarrio.descripcio) == ALLTRIM(barrios.det_barrio);
	INTO CURSOR cbarrios
	

SELECT vcliente.id,cbarrios.id as idbarrio, vcliente.nombre ;
FROM vcliente LEFT JOIN clientes ON ALLTRIM(vcliente.nombre)== ALLTRIM(clientes.cli_nombre);
			INNER JOIN cbarrios ON clientes.cod_barrio = cbarrios.cod_barrio ;
	GROUP BY 1,2,3 ;
	INTO CURSOR cclientes
	
SELECT cclientes
GO top
SCAN
	UPDATE vcuentas SET vcuentas.idbarrio = cclientes.idbarrio ;
		WHERE vcuentas.id = cclientes.id
	SELECT cclientes
ENDSCAN 

IF TABLEUPDATE(.t.,.t.,'vcuentas')
	MESSAGEBOX('actualizo')
ENDIF 
