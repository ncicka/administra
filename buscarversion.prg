SET CENTURY ON
SET DATE BRITISH 

*** Definición de constantes
#DEFINE INTERNET_OPEN_TYPE_PRECONFIG 0 
#define INTERNET_OPEN_TYPE_DIRECT 1 
#define INTERNET_OPEN_TYPE_PROXY 3 
#DEFINE INTERNET_DEFAULT_FTP_PORT 21
#DEFINE INTERNET_SERVICE_FTP 1 
#DEFINE INTERNET_FLAG_PASSIVE 14217728 
#DEFINE INTERNET_FLAG_RELOAD 2147483648   &&FUERZA A DESCARGAR EL ARCHIVO DE INTERNET Y NO DE CACHE
#DEFINE GENERIC_READ 2147483648

** variables para conectar
CLOSE DATABASES 

diractual = CURDIR()

OPEN DATABASE ('..'+diractual+'datos\administramysql') SHARED 
USE ('..'+diractual+'datos\administramysql!vconfig_datos') SHARED 

cservidorftp = ALLTRIM(vconfig_datos.servidorftp)
cusuario=ALLTRIM(vconfig_datos.usuario)
ccontrasena=ALLTRIM(vconfig_datos.contrasena)
vcarpetar=ALLTRIM(vconfig_datos.recibir)
USE 

CLOSE DATABASES 
*** Declaración de funciones del API

DECLARE LONG InternetOpen ; 
IN "wininet.dll" ; 
STRING lpszAgent, ; 
LONG dwAccessType, ; 
STRING lpszProxyName, ; 
STRING lpszProxyBypass, ; 
LONG dwFlags 

DECLARE LONG InternetConnect ; 
IN "wininet.dll" ; 
LONG hInternetSession, ; 
STRING lpszServerName, ; 
LONG nServerPort, ; 
STRING lpszUsername, ; 
STRING lpszPassword, ; 
LONG dwService, ; 
LONG dwFlags, ; 
LONG dwContext 

DECLARE INTEGER InternetCloseHandle ; 
IN "wininet.dll" ; 
LONG hInet 

DECLARE LONG GetLastError ; 
IN WIN32API 

DECLARE  INTEGER InternetReadFile ;
IN "wininet.dll";
long hFtpSession, ;
string @lpBuffer, ;
long dwNumberOfBytesToRead, ;
long @ lpNumberOfBytesRead 

DECLARE  INTEGER FtpOpenFile ;
IN "wininet.dll";
long hFtpSession, ;
string lpszFileName, ;
integer fdwAccess, ;
integer dwFlags,;
integer dwContext


*** Apertura del API
nInternet = InternetOpen( ;
"pruebavfp", ;
INTERNET_OPEN_TYPE_DIRECT, ;
"", "", 0 )
IF nInternet = 0 
*	MessageBox( "Error: " ; 
	+LTRIM( STR( GetLastError() ) ) ; 
	+ " en InternetOpen.", 16 )
	InternetCloseHandle( nFtp )
	RETURN
ENDIF
_vfp.StatusBar='Buscando actualizaciones...'

*** Conexión con el servicio FTP
nFtp = InternetConnect(nInternet, cservidorftp,INTERNET_DEFAULT_FTP_PORT,cusuario, ccontrasena,INTERNET_SERVICE_FTP,INTERNET_FLAG_PASSIVE,0 )
*--
IF nFtp = 0 
*	MessageBox( "No se pudo establecer conexión al servidor, quizas no tiene acceso ó el servidor no está en línea.", 16 ,'Error de conexión')
	 _vfp.StatusBar=''
	RETURN 
ENDIF

** recibir datos

#DEFINE FILE_ATTRIBUTE_NORMAL          128
# DEFINE FTP_TRANSFER_TYPE_ASCII    1 
# DEFINE FTP_TRANSFER_TYPE_BINARY   2

DECLARE INTEGER FtpGetFile IN wininet;
    INTEGER hFtpSession,;
    STRING  lpszRemoteFile,;
    STRING  lpszNewFile,;
    INTEGER fFailIfExists,;
    INTEGER dwFlagsAndAttributes,;
    INTEGER dwFlags,;
    INTEGER dwContext
		   			
	** metodo no controlado
	IF FtpGetFile ( nFtp , "\Actualiza\version.txt" , ".\bk\version.txt" , 0 , FILE_ATTRIBUTE_NORMAL, FTP_TRANSFER_TYPE_BINARY+INTERNET_FLAG_RELOAD, 0 ) = 0 
*		MESSAGEBOX("Error: "+LTRIM(STR(GetLastError()))+ " en FtpOpenFile.",16)
		 InternetCloseHandle( nFtp )
		 InternetCloseHandle( nInternet )
		 _vfp.StatusBar=''
		 RETURN 
	ENDIF
	 _vfp.StatusBar=''
	
 *** Cierre de la conexión FTP
 InternetCloseHandle( nFtp )
 *** Cierre del uso del API
 InternetCloseHandle( nInternet )
 
 siActualiza=.f.
 cString=''
 cStringNueva=''
 
 ** controlo las versiones
 IF FILE('version.cfg')
	nhandle=FOPEN('version.cfg',12)
	nSize =  FSEEK(nhandle, 0, 2)     && Move pointer to EOF
	IF nSize > 0
		 = FSEEK(nhandle, 0, 0)      && Move pointer to BOF
 		cString = ALLTRIM(FREAD(nhandle, nSize))
	ENDIF
	= FCLOSE(nhandle)  
	
	** busco la version recien bajada
	IF FILE('.\bk\version.txt')
		nhandle=FOPEN('.\bk\version.txt',12)
		nSize =  FSEEK(nhandle, 0, 2)     && Move pointer to EOF
		IF nSize > 0
			 = FSEEK(nhandle, 0, 0)      && Move pointer to BOF
 			cStringNueva = ALLTRIM(FREAD(nhandle, nSize))
		ENDIF
		= FCLOSE(nhandle)  
	ELSE
		MESSAGEBOX('no encontro version.txt')
	ENDIF 
	mfecant=CTOD(cString)
	mfecact=CTOD(cStringNueva)
	IF mfecant<mfecact
		** si existe nueva version pide actualizar el sistema
		siActualiza=.t.
	ENDIF 
ELSE
	nhandle=FCREATE('version.cfg')  
	FCLOSE(nhandle)

	nhandle=FOPEN('version.cfg',12)
	cString=DTOC(DATE())
	FWRITE(nhandle,cString+SPACE(40))
	FCLOSE(nhandle)
	siActualiza=.t.	     
ENDIF 
 
 ** llamar a bajar actualizacion
IF siActualiza 
	 DO FORM actualizar
ENDIF 
 
