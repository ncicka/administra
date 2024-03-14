*** COMPLETAR LOS ARTICULOS SIN CODIGO EN VVENTAS2
** tener abiertas las  bases de varticulo y vventas2

SELECT vventas2.id, varticulo.id as idarticulo, vventas2.descripcio ;
	FROM vventas2 INNER JOIN varticulo ON ALLTRIM(vventas2.descripcio)==ALLTRIM(varticulo.descripcio) ;
	WHERE vventas2.idarticulo = 0;
	INTO CURSOR agregar
*	BROWSE

SELECT agregar
GO top
SCAN 	
	UPDATE vventas2 SET idarticulo = agregar.idarticulo ;
	WHERE agregar.id=vventas2.id
	SELECT agregar
ENDSCAN 
	
IF NOT TABLEUPDATE(.t.,.t.,'vventas2')
	MESSAGEBOX('no actualizo')
ENDIF 

UPDATE VVENTAS2 SET descripcio = "CASCO ADULTO";
	WHERE ALLTRIM(vventas2.descripcio)=="CASCO ADULTOS" AND vventas2.idarticulo = 0

UPDATE VVENTAS2 SET descripcio = 'TELEVISOR  14" RCA';
	WHERE ALLTRIM(vventas2.descripcio)=='TELEVISOR  14" RCA' AND vventas2.idarticulo = 0

UPDATE VVENTAS2 SET descripcio = 'TELEVISOR 32" LCD NOBLEX';
	WHERE ALLTRIM(vventas2.descripcio)=='TELEVISOR 32"LCD NOBLEX' AND vventas2.idarticulo = 0

UPDATE VVENTAS2 SET descripcio = 'CELU NOKIA 5130';
	WHERE ALLTRIM(vventas2.descripcio)=='CELU NOKIA 5130 P' AND vventas2.idarticulo = 0
 
UPDATE VVENTAS2 SET descripcio = 'VENT. 26 PIE IMPERIO';
	WHERE ALLTRIM(vventas2.descripcio)=='VENT. 26 DE PIE IMPERIO' AND vventas2.idarticulo = 0

UPDATE VVENTAS2 SET IDARTICULO=91;
	WHERE vventas2.idarticulo = 0

IF NOT TABLEUPDATE(.t.,.t.,'vventas2')
	MESSAGEBOX('no actualizo')
ENDIF 


*********** agregar los renglones que faltan en vventas2

SELECT vventas1.id, vventas1.total FROM vventas1 ;
	LEFT JOIN vventas2 ON vventas1.id = vventas2.idventas1 ;
		WHERE ISNULL(vventas2.id) INTO CURSOR adetalle

SELECT adetalle
GO top
SCAN
	INSERT INTO vventas2 (idventas1,idarticulo,cantidad,descripcio,total) VALUES ;
		(adetalle.id,91,1,'NEUTRO',adetalle.total)
	SELECT adetalle
ENDSCAN 



IF NOT TABLEUPDATE(.t.,.t.,'vventas1')
	MESSAGEBOX('no actualizo vventas1')
ENDIF 

