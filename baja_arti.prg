*** bajar datos prueba conexion directa con mysql
LOCAL idControla 

SET CLASSLIB TO e:\administra\clases\miclase ALIAS otraclase ADDITIVE 

oconexion=CREATEOBJECT("otraclase.libreria") 

idControla = oconexion.conectar()

IF idControla < 0
	MESSAGEBOX('Error al conectar a la base de datos')
	RELEASE CLASSLIB mi_clase
	RETURN 
ENDIF 


* comenzar la transaccion 
sComando = "START TRANSACTION"
siOk=SQLEXEC(idControla,sComando)

IF siOk < 0
	MESSAGEBOX('Error al conectar a la base de datos')
	RELEASE CLASSLIB mi_clase
	RETURN 
ENDIF 


SELECT tarticulo

SCAN 
	sComando = 'UPDATE articulo SET unitario = '+STR(unitario,10,2)+;
		', unitario2= '+STR(unitario,10,2)+;
		', descripcio= "'+ALLTRIM(descripcio)+'"'+;
		', anulado= '+ alltrim(STR(anulado))+;
		', idgrupo = '+ALLTRIM(STR(idgrupo))+;
		', minimo = '+STR(minimo,10,2)+;
		', codbarra = "'+ ALLTRIM(codbarra)+'"'+;
		', nroserie = "'+ALLTRIM(STR(nroserie))+'"'+;
		', articulo = "'+ALLTRIM(articulo)+'"'+;
		', medida = "'+ALLTRIM(medida)+'"'+;
		', margen = '+STR(margen,5,2)+;
		', margen2 = '+STR(margen2,5,2)	+;
		', costo ='+STR(costo,10,2)	
		
		IF !EMPTY(tarticulo.fec_modif)
		
			cfecmodif = '"'+STR(YEAR(fec_modif),4)+'-'+padl(MONTH(fec_modif),2,'0')+'-'+padl(day(fec_modif),2,'0')+'"'
			
			sComando = sComando +;
			', fec_modif= '+cfecmodif +;
			', usuario = "'+ALLTRIM(usuario)+'"'
		ENDIF 
		
		sComando = sComando + ' WHERE id = '+ALLTRIM(STR(tarticulo.id))

		SQLEXEC(idControla,sComando) 
ENDSCAN 

sComando = "COMMIT"
siOk=SQLEXEC(idControla,sComando)
IF siOk < 0
	sComando = "ROLLBACK"
	SQLEXEC(idControla,sComando)
	MESSAGEBOX('Error al modificar articulos- accion cancelada','Error')
ENDIF 
	

** los articulos recidos estan en tarticulo

*!*	** modifica los precios de los articulos y las descripciones
*!*		UPDATE varticulo SET varticulo.unitario=tarticulo.unitario,;
*!*			 varticulo.unitario2 = tarticulo.unitario2, ;
*!*			 varticulo.descripcio  = tarticulo.descripcio,;
*!*			 varticulo.anulado = tarticulo.anulado,;
*!*			 varticulo.idgrupo = tarticulo.idgrupo,;
*!*			 varticulo.minimo = tarticulo.minimo,;
*!*			 varticulo.codbarra = tarticulo.codbarra,;
*!*			 varticulo.nroserie = tarticulo.nroserie,;
*!*			 varticulo.articulo = tarticulo.articulo,;
*!*			 varticulo.medida = tarticulo.medida,;
*!*			 varticulo.margen = tarticulo.margen,;
*!*			 varticulo.margen2 = tarticulo.margen2;
*!*			from tarticulo ;
*!*			WHERE tarticulo.id = varticulo.id 

*!*	=TABLEUPDATE(.t.,.t.,'varticulo')
*!*	=REQUERY('varticulo')


*!*		** modificar las fechas de modificaciones
*!*		UPDATE varticulo SET varticulo.fec_modif=tarticulo.fec_modif,;
*!*				varticulo.usuario = tarticulo.usuario;
*!*			from tarticulo ;
*!*			WHERE tarticulo.id = varticulo.id  AND !EMPTY(tarticulo.fec_modif)

*!*	=TABLEUPDATE(.t.,.t.,'varticulo')
=REQUERY('varticulo')

SELECT varticulo 
SELECT 0
SELECT MAX(id) as id FROM varticulo INTO CURSOR ultimo
ult_id = ultimo.id
USE IN ultimo

IF NOT TABLEUPDATE(.t.,.t.,'varticulo')
	MESSAGEBOX('Error al modificar articulos',0,'Error')
ENDIF 
** agrega los nuevos articulos
SELECT 0

SELECT * FROM tarticulo WHERE Id NOT in (SELECT id FROM varticulo) AND id > ult_id INTO CURSOR temporal ORDER BY id 
	
	SELECT temporal
	GO top
	cSepara = ','
		
	sComando = 'START TRANSACTION'
	SQLEXEC(idControla,sComando)
	
	ult_id = ult_id +1
	DO WHILE !EOF()
		** cuando agrega un nuevo articulo en sucursal siempre con Stock en cero (actual)
		** y que actualice stock (stock=1)
		
		** controlar los registros que faltan de id
		
		IF ult_id = temporal.id
		
				
				IF !EMPTY(fec_modif)
				
					cfecmodif = ',"'+STR(YEAR(fec_modif),4)+'-'+padl(MONTH(fec_modif),2,'0')+'-'+padl(day(fec_modif),2,'0')+'"'
					
					sCampo = ', fec_modif '
				ELSE
					cfecmodif = ''
					sCampo = ''
				ENDIF 

				sComando = 'INSERT INTO articulo (idrubro,articulo, descripcio, medida, unitario, '+;
								'unitario2, costo, margen, margen2, '+;
								'actual, minimo, stock, anulado, nroserie, idgrupo, '+;
								'codbarra, valmedida, interno, fijo, digitos, redondeo, usuario'+sCampo+' ) '+ ;
								'VALUES ( '+ALLTRIM(STR(idrubro))+;
								cSepara+'"'+ALLTRIM(articulo)+ '"'+;
								cSepara+'"'+ALLTRIM(descripcio)+'"'+;
								cSepara+'"'+ALLTRIM(medida)+'"'+;
								cSepara+STR(unitario,10,2)+;
								cSepara+STR(unitario2,10,2)+;
								cSepara+STR(costo,10,2)+;
								cSepara+ STR(margen,5,2) +;
								cSepara+STR(margen2,5,2)+;
								cSepara+'0'+;
								cSepara+STR(minimo,10,2)+;
								cSepara+'1'+;
								cSepara+ALLTRIM(STR(anulado))+;
								cSepara+ALLTRIM(STR(nroserie))+;
								cSepara+ALLTRIM(STR(idgrupo))+;
								cSepara+'"'+ALLTRIM(codbarra)+'"'+;
								cSepara+STR(valmedida,7,3)+;
								cSepara+STR(interno,10,6)+;
								cSepara+'"'+fijo +'"'+;
								cSepara+STR(digitos,1)+;
								cSepara+STR(redondeo,4,2)+;
								cSepara+'"'+ALLTRIM(usuario)+'"'+;
								cfecmodif+')'
								
*!*				IF EMPTY(temporal.fec_modif)
*!*					INSERT INTO  varticulo (idrubro, articulo, descripcio , medida , unitario ,;
*!*									unitario2 , costo , margen , margen2 ,;
*!*									actual , minimo , stock , anulado,nroserie, idgrupo,;
*!*									codbarra, valmedida, interno, fijo, digitos, redondeo, usuario ) ;
*!*									VALUES (temporal.idrubro, temporal.articulo, temporal.descripcio , temporal.medida , temporal.unitario ,;
*!*									temporal.unitario2 , temporal.costo , temporal.margen , temporal.margen2 ,;
*!*									0 , temporal.minimo , 1, temporal.anulado,;
*!*									temporal.nroserie, temporal.idgrupo, temporal.codbarra, temporal.valmedida,;
*!*									temporal.interno, temporal.fijo, temporal.digitos, temporal.redondeo, ;
*!*									tarticulo.usuario )  
*!*				ELSE
*!*					INSERT INTO  varticulo (idrubro, articulo, descripcio , medida , unitario ,;
*!*									unitario2 , costo , margen , margen2 ,;
*!*									actual , minimo , stock , anulado,nroserie, idgrupo,;
*!*									codbarra, valmedida, interno, fijo, digitos, redondeo, usuario ,;
*!*									fec_modif) ;
*!*									VALUES (temporal.idrubro, temporal.articulo, temporal.descripcio , temporal.medida , temporal.unitario ,;
*!*									temporal.unitario2 , temporal.costo , temporal.margen , temporal.margen2 ,;
*!*									0 , temporal.minimo , 1, temporal.anulado,;
*!*									temporal.nroserie, temporal.idgrupo, temporal.codbarra, temporal.valmedida,;
*!*									temporal.interno, temporal.fijo, temporal.digitos, temporal.redondeo, ;
*!*									tarticulo.usuario, temporal.fec_modif )  
*!*				
*!*				ENDIF 
			SELECT temporal 
			SKIP
		ELSE
			IF ult_id < temporal.id
				** agrego los faltantes con otro codigo de articulo y anulados
				** para conservar el lugar
				
				sComando = 'INSERT INTO articulo (idrubro,articulo, descripcio, medida, unitario, '+;
								'unitario2, costo, margen, margen2, '+;
								'actual, minimo, stock, anulado, nroserie, idgrupo, '+;
								'codbarra, valmedida, interno, fijo, digitos, redondeo, usuario ) '+ ;
								'VALUES ( '+ALLTRIM(STR(idrubro))+;
								cSepara+'"BORRA'+ALLTRIM(STR(ULT_ID)) +'"'+;
								cSepara+'"BORRAR"'+;
								cSepara+'"'+ALLTRIM(medida)+'"'+;
								cSepara+STR(unitario,10,2)+;
								cSepara+STR(unitario2,10,2)+;
								cSepara+STR(costo,10,2)+;
								cSepara+STR(margen,5,2) +;
								cSepara+STR(margen2,5,2)+;
								cSepara+'0'+;
								cSepara+STR(minimo,10,2)+;
								cSepara+'1'+;
								cSepara+'1'+;
								cSepara+ALLTRIM(STR(nroserie))+;
								cSepara+ALLTRIM(STR(idgrupo))+;
								cSepara+'""'+;
								cSepara+STR(valmedida,7,3)+;
								cSepara+STR(interno,10,6)+;
								cSepara+'"'+fijo +'"'+;
								cSepara+STR(digitos,1)+;
								cSepara+STR(redondeo,4,2)+;
								cSepara+'"'+ALLTRIM(usuario)+'"'+')'								
												
*!*					INSERT INTO  varticulo (idrubro, articulo, descripcio , medida , unitario ,;
*!*									unitario2 , costo , margen , margen2 ,;
*!*									actual , minimo , stock , anulado,nroserie, idgrupo,;
*!*									codbarra, valmedida, interno, fijo, digitos, redondeo, usuario ) ;
*!*									VALUES (temporal.idrubro, 'BORRA'+ALLTRIM(STR(ULT_ID)),'BORRAR', temporal.medida , temporal.unitario ,;
*!*									temporal.unitario2 , temporal.costo , temporal.margen , temporal.margen2 ,;
*!*									0 , temporal.minimo , 1, 1,;
*!*									temporal.nroserie, temporal.idgrupo, ' ', temporal.valmedida,;
*!*									temporal.interno, temporal.fijo, temporal.digitos, temporal.redondeo, ;
*!*									tarticulo.usuario )  

			ENDIF 
			
		ENDIF 

		ult_id = ult_id + 1
		
		siOk=SQLEXEC(idControla,sComando)

*!*			IF siOk < 0
*!*					IF NOT TABLEUPDATE(.t.,.t.,'varticulo')

*!*				MESSAGEBOX('Error al agregar articulo ('+ALLTRIM(articulo)+') '+ALLTRIM(descripcio),0,'Modificar')
*!*			ENDIF 

		SELECT temporal
		
	ENDDO

USE IN temporal

sComando = 'COMMIT'
siOk = SQLEXEC(idControla,sComando)
IF siOk > 0 
*IF TABLEUPDATE(.t.,.t.,'varticulo')
	*COPY FILE (vcarpetar+'varticulo.txt') TO (vcarpetar+'resguardo\'+'varticulo_'+cfecha_hora+'.txt')
	
	DELETE FILE vcarpetar+'varticulo.txt'
ELSE
	sComando="ROLLBACK"
	SQLEXEC(idControla,sComando)
	MESSAGEBOX('Error al guardar articulos - accion cancelada','Error')

ENDIF 

RELEASE CLASSLIB ALIAS mi_clase 