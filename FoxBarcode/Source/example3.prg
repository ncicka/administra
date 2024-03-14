SET PROCEDURE TO LOCFILE("Source\FoxBarcode.prg"), LOCFILE("Source\gpImage2.prg") ADDITIVE

*--- Create FoxBarcode Object
LOCAL loFbc
loFbc = CREATEOBJECT("FoxBarcode")

*-- Generate a test (Ej: EAN-8 -> nBarcodeType = 150)
IF loFbc.BarcodeTest("123456", "", [nBarcodeType = 150]) 
  MESSAGEBOX(["] + loFbc.cText + ["] + " Ok", 64, "Example BarcodeTest()")
ELSE
  MESSAGEBOX(loFbc.cMsgError, 16, "Example BarcodeTest()")
ENDIF

RETURN
