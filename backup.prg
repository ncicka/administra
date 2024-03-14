** COPIAS DE SEGURIDAD
*lcEx = '"C:\Archivos de programa\mysql\MySQL Server 5.5\bin\mysqldump.exe" "-uroot" "-p123456" "MyDB" "-rc:\test.sql"'
*lcEx = '"F:\MySQL Workbench 6.0 CE\mysqldump.exe" "-umimi" "-pmimi" "--host=192.168.56.1" "-P 3306" "administra" "-rc:\administra\bk\administ.sql"'
lcEx = '"c:\administra\bk\ba.bat"'
oShell = createobject("WScript.Shell")
oShell.Run(lcEx,0,.t.)

