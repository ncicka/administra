** 21-01-15
** busco y arreglo porque trajo renglones repetidos porque
** agregaba cuentas en lugar de modificarlas (ya arreglado

** tener vcaja1, vcuentast y vcaja3 abierto

SELECT vcaja1


SELECT id, idcuenta, idempresa, fecha, numero2, total;
 FROM vcaja1 WHERE INLIST(idcuenta,7670,7666,7725,7714,7768,7750,7685,7672,7673,7674,7675) ;
INTO CURSOR borrar

*brow
** id en vcaja1 a borrar 15055,15060,15063,

SELECT borrar
GO top
SCAN
	*SELECT vcaja3
	*SELECT * FROM vcaja3 WHERE idcaja1=borrar.id INTO CURSOR borrocaja3
	
	DELETE FROM vcaja1 WHERE id=borrar.id AND idempresa=13 
	=TABLEUPDATE(.t.,.t.,'vcaja1')
	
	DELETE FROM vcaja3 WHERE idcaja1=borrar.id 
	=TABLEUPDATE(.t.,.t.,'vcaja3')
	
	SELECT borrar
ENDSCAN 

	DELETE FROM vcuentast WHERE INLIST(id,7670,7666,7725,7714,7768,7750,7685,7672,7673,7674,7675) AND idempresa=13 
	=TABLEUPDATE(.t.,.t.,'vcuentast')
