** estas son las ventas en una cuota cuando habia un problema en el sistema
** tener abierto vventas1 y ventas3


SELECT vventas1.fecha, vventas1.id, vventas1.saldo, vventas1.pagado, vventas1.condicion ;
FROM vventas1 WHERE cant_cuotas= 1  AND vventas1.anulado=0 ;
AND vventas1.id NOT in (SELECT idventas1 FROM vventas3)INTO CURSOR consulta
BROWSE 