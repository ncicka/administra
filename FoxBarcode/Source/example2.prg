SET PROCEDURE TO LOCFILE("Source\FoxBarcode.prg"), LOCFILE("Source\gpImage2.prg") ADDITIVE

*--- Create FoxBarcode Object
LOCAL loFbc
loFbc = CREATEOBJECT("FoxBarcode")

*-- Set the properties
WITH loFbc
  .cImageType = "PNG"
  .nBarcodeType = 175 && Two Track Pharmacode
  .nFactor = 2
  .nImageHeight = 75
  .nMargin = 5
  .lShowHumanReadableText = .T.
   .nBackColor = RGB(0,0,0)
  .nBarsColor = RGB(255,255,255)
  .nFontColor = RGB(255,255,0)
ENDWITH

*-- Generate image
lcImage = loFbc.BarcodeImage("123456")

*-- Create form
LOCAL loForm AS FORM
loForm = CREATEOBJECT("Form")
loForm.CAPTION = "FoxBarcode Example 2"
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
