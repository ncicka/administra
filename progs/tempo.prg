**** busca los cdx temporales y los borra

LOCAL gnCdxnumber

gnCdxnumber = ADIR(gaContenedor, '_*.CDX')

CLEAR
FOR nCount = 1 TO gnCdxnumber  
	IF gaContenedor(nCount,5) <> "R"
		DELETE FILE (gaContenedor(nCount,1)) 
	ENDIF
ENDFOR
