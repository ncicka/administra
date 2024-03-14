SET TALK OFF
SET DELETED ON 
SET DATe BRITISH
SET EXCLUSIVE OFF 
SET CONFIRM ON 
PUBLIC paraidempresa,paratipocta
paraidempresa=18
paratipocta="CLIE"

SET PATH TO E:\administra\informes;E:\administra\formularios;E:\administra\datos;E:\administra\clases;E:\administra\bk
*SET DEFAULT TO C:\mimi\administra



*!*	set classlib to d:\mimi\administra\clases\administra  &&la clase que has creado
*!*	public obarra
*!*	obarra=createobject("herramientas") &&mibarra nombre de la barra que le has dado
*!*	obarra.visible=.t.

SET CLASSLIB TO e:\administra\clases\administra
PRIVATE paraidempresa
paraidempresa=17
_screen.AddProperty('usuario', '',1)
_screen.AddProperty('sistk', 0,1)
_screen.AddProperty('central',1,1)
_screen.AddProperty('nivel',0,1)
_screen.AddProperty('fiscal',1)
_screen.AddProperty('idcajero',1774)
_screen.AddProperty('idvendedor',963)
