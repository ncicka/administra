_screen.Visible=.f.

SET EXCLUSIVE OFF 
SET REPROCESS TO 10
SET MULTILOCKS ON 
SET REPORTBEHAVIOR 90

SET DEFAULT TO SYS(5)+SYS(2003)
SET PATH TO SYS(5)+SYS(2003)+"\imagenes\",SYS(5)+SYS(2003)+"\datos",SYS(5)+SYS(2003)+"\clases\source",SYS(5)+SYS(2003)+"\listados"


*_SCREEN.AddProperty("System", NEWOBJECT("xfcSystem", LOCFILE(SYS(5)+SYS(2003)+"\clases\source\system.vcx","vcx"))) 
*_SCREEN.AddProperty("System", NEWOBJECT("xfcSystem",SYS(5)+SYS(2003)+"\clases\source\system.vcx")) 
DO MANEJA
READ events