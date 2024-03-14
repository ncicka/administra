SET PROCEDURE TO LOCFILE("Source\FoxBarcode.prg"), LOCFILE("Source\gpImage2.prg") ADDITIVE

*--- Create FoxBarcode Object
LOCAL loFbc
loFbc = CREATEOBJECT("FoxBarcode")

LOCAL lnMethod
lnMethod = 1

IF lnMethod = 1
  *----------------------
  *-- Method 1
  *----------------------
  *-- Set properties
  loFbc.nBarcodeType = 159 && EAN-128
  loFbc.nFactor = 2
  loFbc.nMargin = 10
  lcImage = loFbc.BarcodeImage("(01)01234567890128(15)101231(10)123X")
  ELSE
  *----------------------
  *-- Method 2
  *----------------------
  *-- Generate the image with the 3rd parameter
  lcImage = loFbc.BarcodeImage("","",[nBarcodeType=159, cText="(01)01234567890128(15)101231(10)123X", nFactor=2, nMargin=10])
ENDIF


*-- Create form
LOCAL loForm AS FORM
loForm = CREATEOBJECT("Form")
loForm.CAPTION = "FoxBarcode Example 1"
loForm.WIDTH = 800
loForm.HEIGHT = 400
loForm.AUTOCENTER = .T.
loForm.ADDOBJECT("Image1", "MyImage") && The MyImage class definition is below
loForm.Image1.PICTURE = lcImage
loForm.Image1.VISIBLE = .T.
loForm.SHOW(1)
loForm = NULL
loFbc = NULL

RETURN

DEFINE CLASS MyImage AS IMAGE
  PROCEDURE DESTROY
    THIS.PICTURE = ""
  ENDPROC
ENDDEFINE


