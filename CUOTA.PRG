
SELECT vventas1.id, fecha,  vcomprob.codigo+vcomprob.letra,vventas1.numero1, vventas1.numero2, vcuentas.nombre, vcuentas.cuenta, total, saldo  ;
	FROM vventas1 INNER JOIN vcuentas ON vventas1.idcuenta = vcuentas.id;
				INNER JOIN vcomprob ON vventas1.idcomprob = vcomprob.id;
WHERE vventas1.cant_cuotas=1 AND !'SIST.ANT'$VVENTAS1.observacio AND anulado=0 AND pagado=0;
	AND vventas1.id NOT in (SELECT vventas1.id ;
	FROM vventas1 INNER JOIN vventas3 ON vventas1.id = vventas3.idventas1 AND vventas3.nro_cuota>0 ;
			WHERE vventas1.cant_cuotas = 1 AND !'SIST.ANT'$VVENTAS1.observacio) ;
	ORDER BY 2 INTO TABLE cuota1
	


*!*	SELECT vventas1.id ;
*!*		FROM vventas1 INNER JOIN vventas3 ON vventas1.id = vventas3.idventas1 AND vventas3.nro_cuota>0 ;
*!*				WHERE vventas1.cant_cuotas = 1 AND !'SIST.ANT'$VVENTAS1.observacio