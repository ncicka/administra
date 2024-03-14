** FECHA: 30/03/2013
************** programa que arregla la refinanciacion
**** de gomez santos florentino cuenta:7 comprobante de venta 6814

** ABRIR LAS TABLAS las tablas de vventas1, vventas2, vventas3
** colocar en la carpeta \datos las tablas de tventas1, tventas2, tventas3

SELECT 0 
USE tventas1 

SELECT 0
USE tventas2

SELECT 0
USE tventas3

SELECT vventas1
LOCATE FOR id = tventas1.id
IF FOUND()
*	MESSAGEBOX('encontro')
	IF 'REFIN' $ vventas1.observacio
		replace pagado WITH tventas1.pagado ,;
			saldo WITH  tventas1.saldo,;
			observacio WITH  tventas1.observacio 
		= TABLEUPDATE(.t.,.t.,'vventas1')
		
		SELECT vventas3
		LOCATE FOR idventas1 = tventas1.id
		SCAN FOR idventas1 = tventas1.id
			DELETE 
		ENDSCAN
		= TABLEUPDATE(.t.,.t.,'vventas3')
	ENDIF 

ENDIF 

** controlar que no esten los registos del vventas2
SELECT * FROM vventas2 WHERE idventas1 = tventas1.id INTO CURSOR encontro

SELECT encontro
*BROWSE

IF RECCOUNT('encontro') <= 0
	** no encontro nada
	*MESSAGEBOX('vventas2')
	SELECT tventas2
	SCAN 
	INSERT INTO vventas2 (idventas1,idarticulo,descripcio,cantidad, por_interes, unitario,;
		impuesto,idlista,por_desc,descuento,ivari,ivanoc,total,stock) VALUES ;
		(tventas2.idventas1,tventas2.idarticulo,tventas2.descripcio,tventas2.cantidad,;
		 tventas2.por_intere, tventas2.unitario,;
		tventas2.impuesto,tventas2.idlista,tventas2.por_desc,tventas2.descuento,tventas2.ivari,;
		tventas2.ivanoc,tventas2.total,tventas2.stock)
		=TABLEUPDATE(.t.,.t.,'vventas2')
		SELECT tventas2
	endscan
ENDIF 
IF USED('econtro')
	USE encontro
ENDIF  

** controlar que no esten los registos del vventas3
SELECT * FROM vventas3 WHERE idventas1 = tventas1.id INTO CURSOR encontro

*BROWSE 
*RETURN 

IF RECCOUNT('encontro') <= 0
	** no encontro nada
	*MESSAGEBOX('vventas3')
	SELECT tventas3
	SCAN 
	INSERT INTO vventas3 (nro_cuota,importe,interes,vencimiento,recargo,saldo,pagado,idventas1);
	VALUES (tventas3.nro_cuota,tventas3.importe,tventas3.interes,tventas3.vencimient,;
		tventas3.recargo,tventas3.saldo,tventas3.pagado,tventas3.idventas1)
		=TABLEUPDATE(.t.,.t.,'vventas3')
		SELECT tventas3
	endscan
ENDIF 