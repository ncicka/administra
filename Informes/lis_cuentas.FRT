   X   @                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              %ORIENTATION=0
PAPERSIZE=9
COLOR=2
UTPUT=pdfcmon
ORIE      `Top = 333
Left = 31
Width = 520
Height = 200
DataSource = .NULL.
Name = "Dataenvironment"
                              dataenvironment                                               Arial                                                         Arial                                                         DATE()                                                        Arial                                                         "Listado de Cuentas"                                          Arial                                                         Cuenta                                                        Arial                                                         Nombre                                                        Arial                                                         Cuit                                                          Arial                                                         STR(_pageno,5)                                                Arial                                                         "Fecha:"                                                      Arial                                                         	"P�gina:"                                                     Arial                                                         "Total de cuentas"                                            Arial                                                         Cuenta                                                        Arial                                                         
"C.U.I.T."                                                    Arial                                                         "Documento"                                                   Arial                                                         "Nombre"                                                      Arial                                                         "Cuenta"                                                      Arial                                                         	documento                                                     	documento                                                     "@Z"                                                          Arial                                                         	direccion                                                     	direccion                                                     Arial                                                         telefono                                                      telefono                                                      Arial                                                         "Direccion"                                                   Arial                                                         
"Tel�fono"                                                    Arial                                                         (iif(empty(cfiltro),'','Filtro '+cfiltro)                      Arial                                                         ltrabajo                                                      ltrabajo                                                      Arial                                                         "Lugar de trabajo"                                            Arial                                                         vEmpresa.nombre                                               Arial                                                         vEmpresa.direccion                                            Arial                                                         ctipocta                                                      Arial                                                         ltrabajo                                                      barrio                                                        Arial                                                         "Barrio"                                                      Arial                                                         Arial                                                         Arial                                                         Arial                                                         Arial                                                         Arial                                                         Arial                                                        �* WIZARD = QREPORT
* WIZNAME = D:\FPW26\WIZARDS\WZ_QREPO.APP
* WIZCLASS = REPORT
* VERSION = 1.0
* TIMESTAMP = 642425021.00
* STYLE = EXECUTIVE
* LAYOUT = COLUMNAR
* TITLE = Clientes
* COLUMNS = 1.00
* TABLE = "C:\SERVICEN\CLIENTES.DBF"
* FIELDS = Cliente;Nombre;Documento;Direccion;Localidad;Iva;Cuit;Telefono;
* SORTS = ;
* GROUPS = ;
* MODIFIERS = ;
* TOTALS = 0.00
* SUBTOTALS = 0.00
* TOPBOTTOM = 1.00
* LABELS = ;
* AVERY = 1.00
* TAGASCEND = 1.00
                              