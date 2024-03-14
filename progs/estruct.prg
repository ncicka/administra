** MODIFICA LA ESTRUCTURA DE LA TABLA ARTICULO.DBF SI NO
** TIENE EL CAMPO CODBARRA C(15)

mfield = 0
encontrado = .F.

IF USED("articulo")
	SELECT articulo
ELSE
	SELECT 0
	USE (LOCFILE("articulo.dbf", "DBF", "Buscar articulo?")) ;
		SHARED AGAIN ALIAS articulo 
ENDIF


mfield = AFIELDS(amatriz)

FOR i = 1	TO mfield 
	IF amatriz(i,1) = 'CODBARRA'
		encontrado = .T.
	ENDIF
NEXT


IF !encontrado
	** MODIFICAR LA ESTRUCTURA
	wzalrtmess = 'Modificando Estructura de Articulos'
		DEFINE WINDOW westructura ;
	  AT 0.000,0.000 ;
	  SIZE 09.500,59.000;
	  FLOAT NOCLOSE NOMINIMIZE DOUBLE SHADOW ;
	  TITLE " Estructura " ;
	  FONT "MS Sans Serif",8 ;
	  COLOR RGB(,,,192,192,192)
	MOVE WINDOW westructura CENTER
	ACTIVATE WINDOW westructura NOSHOW

	@ 2.000,(57.000-LEN(wzalrtmess))/2 SAY wzalrtmess ;
		FONT "MS Sans Serif", 10
		
	ACTIVATE WINDOW westructura
	SELECT 0
	CREATE TABLE artcam (rubro     C( 3)  ,;
						articulo   C( 4)  ,;
						codbarra   C(15)  ,;
						descripcio C(50)  ,;
					    medida 	   C( 5)  ,;
					    interno    N(10,6),;
					    unitario   N(11,6),;
					    unitario2  N(11,6),;
					    costo      N(11,4),;
					    margen     N( 5,2),;
					    margen2    N( 5,2),;
					    fijo       C( 1)  ,;
					    actual     N( 9,1),;
					    minimo     N( 9,1),;
					    digitos    N( 1,0),;
					    redondeo   N( 4,2),;
					    indice     L      ,;
					    stock L)
		
		SELECT articulo
		GO TOP
		SCAN 
			SELECT artcam
			APPEND BLANK
			REPLACE rubro		WITH articulo.rubro,;
					articulo	WITH articulo.articulo,;
					descripcio	WITH articulo.descripcio,;
					medida		WITH articulo.medida,;
					interno		WITH articulo.interno,;
					unitario	WITH articulo.unitario,;
					unitario2	WITH articulo.unitario2,;
					costo		WITH articulo.costo,;
					margen		WITH articulo.margen,;
					margen2		WITH articulo.margen2,;
					fijo		WITH articulo.fijo,;
					actual		WITH articulo.actual,;
					minimo		WITH articulo.minimo,;
					digitos		WITH articulo.digitos,;
					redondeo	WITH articulo.redondeo,;
					indice		WITH articulo.indice,;
					stock		WITH articulo.stock,;
					codbarra	WITH ALLTRIM(articulo.rubro)+ALLTRIM(articulo.articulo)
			SELECT articulo
		ENDSCAN	
	
	IF USED("artcam")
		SELECT artcam
		USE
	ENDIF
	
	IF USED("articulo")
		SELECT articulo
		USE
		DELETE FILE ARTICULO.DBF
		RENAME ARTCAM.DBF TO ARTICULO.DBF
	ENDIF

	DELETE FILE articulo.cdx
	USE articulo EXCLUSIVE
	INDEX ON rubro+articulo		TAG articulo1	OF articulo
	INDEX ON descripcio			TAG articulo2	OF articulo
	INDEX ON rubro+descripcio	TAG articulo3	OF articulo
	INDEX ON codbarra			TAG articulo4	OF articulo

	RELEASE WINDOW westructura

ENDIF


IF USED("articulo")	
	SELECT articulo
	USE
ENDIF

IF USED("comprob")
	SELECT comprob
ELSE
	SELECT 0
	USE (LOCFILE("comprob.dbf", "DBF", "Buscar comprob?")) ;
		SHARED AGAIN ALIAS comprob
ENDIF

LOCATE FOR tipo = 9

IF !FOUND()
	APPEND BLAN
	REPLACE tipo		WITH 9
	REPLACE descripcio 	WITH "Remito"
	REPLACE codigo		WITH "Rem"
	REPLACE imprime		WITH .F.
	REPLACE impresora	WITH 'LPT1'
	REPLACE letra		WITH 'r'
ENDIF

LOCATE FOR tipo = 10

IF !FOUND()
	APPEND BLAN
	REPLACE tipo		WITH 10
	REPLACE descripcio 	WITH "Factura C"
	REPLACE codigo		WITH "Fac C"
	REPLACE imprime		WITH .F.
	REPLACE impresora	WITH 'LPT1'
	REPLACE letra		WITH 'B'
ENDIF

LOCATE FOR tipo = 11

IF !FOUND()
	APPEND BLAN
	REPLACE tipo		WITH 11
	REPLACE descripcio 	WITH "Recibo C"
	REPLACE codigo		WITH "Rec C"
	REPLACE imprime		WITH .F.
	REPLACE impresora	WITH 'LPT1'
	REPLACE letra		WITH 'b'
ENDIF

IF USED("comprob")
	SELECT comprob
	USE
ENDIF