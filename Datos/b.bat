@echo oof
FOR /F "tokens=1,2,3 delims=/ " %%i IN ('date /T') do (set DIA=%%k%%j%%i)
FOR /F "tokens=1,2 delims=: " %%n IN ('time /T') do (set HORA=%%n%%o)


C:\"Program Files (x86)"\MySQL\"MySQL Server 5.5"\bin\mysqldump -u .imi -p.imi administra > "c:\administra_%DIA%_%HORA%.sql"
