PRIVATE m.currarea, m.talkstat,  ;
        m.compstat
IF SET("TALK") = "ON"
     SET TALK OFF
     m.talkstat = "ON"
ELSE
     m.talkstat = "OFF"
ENDIF
m.compstat = SET("COMPATIBLE")
SET COMPATIBLE OFF
m.rborder = SET("READBORDER")
SET READBORDER ON
IF  .NOT. WEXIST("vrescta") .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.PJX" .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.SCX" .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.MNX" .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.PRG" .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.FRX" .OR.  ;
    UPPER(WTITLE("VRESCTA")) ==  ;
    "VRESCTA.QPR"
     DEFINE WINDOW vrescta AT    ;
            0.000 ,   0.000  SIZE   ;
            13.000 , 107.000   ;
            FONT "Arial", 8 FLOAT  ;
            NOCLOSE TITLE  ;
            "Resúmen de Cuenta de Clientes"  ;
            MINIMIZE SYSTEM
     MOVE WINDOW vrescta CENTER
ENDIF
PRIVATE m.setkey
STORE "" TO m.setkey
SELECT 0
IF  .NOT. USED("empresa")
     USE SHARED empresa ALIAS  ;
         empresa
ELSE
     SELECT empresa
ENDIF
SELECT 0
IF  .NOT. USED("clientes")
     USE SHARED clientes ALIAS  ;
         clientes ORDER  ;
         clientes2
ELSE
     SELECT clientes
     SET ORDER TO clientes2
ENDIF
DEFINE POPUP _1kd0oebcu PROMPT  ;
       FIELDS nombre SCROLL
IF WVISIBLE("vrescta")
     ACTIVATE WINDOW SAME vrescta
ELSE
     ACTIVATE WINDOW NOSHOW  ;
              vrescta
ENDIF
@   0.571 ,   2.400  SAY  ;
    "Rango de Fechas:" FONT  ;
    "Arial", 8 STYLE "T"
@   3.929 ,   1.800  SAY  ;
    "Clientes:" FONT "Arial", 8  ;
    STYLE "T"
@   1.786 ,   2.800  GET m.fecdes  ;
    DEFAULT {} FONT "Arial", 8  ;
    SIZE 1.000 , 12.800  PICTURE  ;
    "@KE 99/99/9999" VALID  ;
    LASTKEY() = 5 .OR.  ;
    fctrfech(m.fecdes,"m.fecdes")  ;
    WHEN fdhabky()
@   1.786 ,  19.600  GET m.fechas  ;
    DEFAULT {} FONT "Arial", 8  ;
    SIZE 1.000 , 12.800  PICTURE  ;
    "@KE 99/99/9999" VALID  ;
    LASTKEY() = 5 .OR.  ;
    fctrfech(m.fechas,"m.fechas")  ;
    .AND. m.fechas >= m.fecdes  ;
    WHEN fdhabky()
@ 6.929,1.800 GET m.cliente  PICTURE "@&N";
 POPUP _1kd0oebcu  SIZE 4.571,73.200;
 DEFAULT " "  FONT "Arial", 8  STYLE "";
 DISABLE
@   5.214 ,   2.200  GET m.setkey  ;
    DEFAULT " " FONT "Arial", 8  ;
    SIZE 1.000 , 68.800  PICTURE  ;
    "@K XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"  ;
    VALID fdhabky() WHEN  ;
    fhabky()
@   0.857 ,  78.800  GET  ;
    m.aceptar DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Aceptar" VALID  ;
    faceptar() WHEN fdhabky()
@   3.429 ,  78.800  GET  ;
    m.cancelar DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Cancelar" VALID  ;
    fcancela() WHEN fdhabky()
@   6.000 ,  78.800  GET  ;
    m.impresora DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Especificar Impresora"  ;
    VALID SYS(1037) WHEN  ;
    fdhabky()
@   8.571 ,  78.800  GET  ;
    m.imprimir DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Imprimir" VALID  ;
    _1kd0oebcx() WHEN fdhabky()
IF  .NOT. WVISIBLE("vrescta")
     ACTIVATE WINDOW vrescta
ENDIF
READ CYCLE
RELEASE WINDOW vrescta
RELEASE POPUPS _1kd0oebcu
SET READBORDER &rborder
IF m.talkstat = "ON"
     SET TALK ON
ENDIF
IF m.compstat = "ON"
     SET COMPATIBLE ON
ENDIF
IF USED("empresa")
     SELECT empresa
     USE
ENDIF
IF USED("clientes")
     SELECT clientes
     USE
ENDIF
ENDPROC
*
PROCEDURE fhabky
ON KEY LABEL F1 DO NADA
ON KEY LABEL F2 DO NADA
ON KEY LABEL F3 DO NADA
ON KEY LABEL F4 DO NADA
ON KEY LABEL F5 DO NADA
ON KEY LABEL F6 DO NADA
ON KEY LABEL F7 DO NADA
ON KEY LABEL F8 DO NADA
ON KEY LABEL F9 DO NADA
ON KEY LABEL F10 DO NADA
ON KEY LABEL F11 DO NADA
ON KEY LABEL F12 DO NADA
ON KEY LABEL ESC DO FCANCELA
ON KEY LABEL BACKSPACE DO FFILTRO
FOR i = 32 TO 90
     ON KEY LABEL CHR(i) DO FFILTRO
ENDFOR
RETURN
ENDPROC
*
PROCEDURE fdhabky
ON KEY LABEL F1
ON KEY LABEL F2
ON KEY LABEL F3
ON KEY LABEL F4
ON KEY LABEL F5
ON KEY LABEL F6
ON KEY LABEL F7
ON KEY LABEL F8
ON KEY LABEL F9
ON KEY LABEL F10
ON KEY LABEL F11
ON KEY LABEL F12
ON KEY LABEL ESC
ON KEY LABEL BACKSPACE
FOR i = 32 TO 90
     ON KEY LABEL CHR(i)
ENDFOR
RETURN
ENDPROC
*
PROCEDURE ffiltro
IF EMPTY(m.setkey) .OR. LASTKEY() =  ;
   127
     STORE "" TO m.setkey
ENDIF
IF LASTKEY() <> 127
     m.setkey = m.setkey +  ;
                CHR(LASTKEY())
ENDIF
SHOW GET m.setkey
SELECT clientes
SET KEY TO m.setkey
SHOW GET m.cliente
RETURN
ENDPROC
*
PROCEDURE faceptar
DO g_rescta
DO p_rescta1
RETURN
ENDPROC
*
PROCEDURE fcancela
DO fdhabky
CLEAR READ
IF USED("empresa")
     SELECT empresa
     USE
ENDIF
IF USED("rescta")
     SELECT rescta
     USE
ENDIF
RETURN
ENDPROC
*
PROCEDURE nada
RETURN
ENDPROC
*
PROCEDURE g_rescta
PRIVATE m.perdes, m.debito,  ;
        m.credito, m.saldo,  ;
        m.detalle
STORE YEAR(m.fecdes) * 100 +  ;
      MONTH(m.fecdes) TO  ;
      m.perdes
IF USED("rescta")
     SELECT rescta
     USE
ENDIF
STORE "_I" + RIGHT(SYS(3), 6) TO  ;
      cdxresct
SELECT 0
CREATE CURSOR rescta (cliente C  ;
       (4), fecha D, tipocomp C  ;
       (5), numero1 N (4),  ;
       numero2 N (8), detalle C  ;
       (50), debe N (12, 2),  ;
       haber N (12, 2), saldo N  ;
       (12, 2))
INDEX ON cliente+DTOS(fecha)+tipocomp+STR(numero1,4)+STR(numero2,8);
 TAG rescta OF &cdxresct
IF USED("saldos")
     SELECT saldos
     SET ORDER TO saldos1 DESCENDING
ELSE
     SELECT 0
     USE SHARED saldos AGAIN  ;
         ALIAS saldos ORDER  ;
         saldos1 DESCENDING
ENDIF
IF USED("ctacte1")
     SELECT ctacte1
     SET ORDER TO ctacte4
ELSE
     SELECT 0
     USE SHARED ctacte1 AGAIN  ;
         ALIAS ctacte1 ORDER  ;
         ctacte4
ENDIF
IF USED("pagos1")
     SELECT pagos1
     SET ORDER TO pagos2
ELSE
     SELECT 0
     USE SHARED pagos1 AGAIN  ;
         ALIAS pagos1 ORDER  ;
         pagos2
ENDIF
IF USED("pagos2")
     SELECT pagos2
     SET ORDER TO pagos1
ELSE
     SELECT 0
     USE SHARED pagos2 AGAIN  ;
         ALIAS pagos2 ORDER  ;
         pagos1
ENDIF
IF USED("comprob")
     SELECT comprob
     SET ORDER TO comprob
ELSE
     SELECT 0
     USE SHARED comprob AGAIN  ;
         ALIAS comprob ORDER  ;
         comprob
ENDIF
SELECT clientes
annear = SET('NEAR')
SET NEAR ON
SCAN
     STORE "**** SALDO ANTERIOR ****"  ;
           TO m.detalle
     STORE 0 TO m.debito,  ;
           m.credito, m.saldo
     SELECT saldos
     SEEK clientes.cliente +  ;
          STR(m.perdes, 6) 
     IF FOUND()
          IF saldos.cliente =  ;
             clientes.cliente
               STORE saldos.anterior  ;
                     TO m.saldo
          ELSE
               STORE 0 TO m.saldo
          ENDIF
     ELSE
          IF saldos.cliente =  ;
             clientes.cliente  ;
             .AND. saldos.periodo <  ;
             STR(m.perdes, 6)
               STORE saldos.actual  ;
                     TO m.saldo
          ELSE
               STORE 0 TO m.saldo
          ENDIF
     ENDIF
     SELECT ctacte1
     SEEK clientes.cliente +  ;
          saldos.periodo + "00" 
     SCAN WHILE cliente =  ;
          clientes.cliente .AND.  ;
          fecha < m.fecdes .AND.  ;
          STR(YEAR(fecha) * 100 +  ;
          MONTH(fecha), 6) =  ;
          STR(m.perdes, 6)
          IF INLIST(ctacte1.tipo,  ;
             4, 5, 8, 18)
               STORE m.saldo -  ;
                     ctacte1.total  ;
                     TO m.saldo
          ELSE
               IF (ctacte1.tipo =  ;
                  1 .AND.  .NOT.  ;
                  ctacte1.facturado)  ;
                  .OR.  ;
                  (ctacte1.tipo <>  ;
                  1 .AND.  ;
                  ctacte1.facturado)
                    STORE m.saldo +  ;
                          ctacte1.total  ;
                          TO  ;
                          m.saldo
               ENDIF
          ENDIF
     ENDSCAN
     SELECT pagos1
     SEEK clientes.cliente +  ;
          saldos.periodo + "00" 
     SCAN WHILE cliente =  ;
          clientes.cliente .AND.  ;
          fecha < m.fecdes .AND.  ;
          STR(YEAR(fecha) * 100 +  ;
          MONTH(fecha), 6) =  ;
          STR(m.perdes, 6)
          IF sictacte()
               STORE m.saldo -  ;
                     pagos1.total  ;
                     TO m.saldo
          ENDIF
          SELECT pagos1
     ENDSCAN
     IF m.saldo < 0
          STORE ABS(m.saldo) TO  ;
                m.credito
          STORE 0 TO m.debito
     ELSE
          STORE 0 TO m.credito
          STORE m.saldo TO  ;
                m.debito
     ENDIF
     SELECT rescta
     APPEND BLANK
     REPLACE cliente WITH  ;
             clientes.cliente,  ;
             fecha WITH {},  ;
             tipocomp WITH "",  ;
             numero1 WITH 0,  ;
             numero2 WITH 0,  ;
             detalle WITH  ;
             m.detalle, debe WITH  ;
             m.debito, haber WITH  ;
             m.credito, saldo  ;
             WITH 0
     STORE .T. TO m.sinmovim
     SELECT ctacte1
     SEEK clientes.cliente +  ;
          DTOS(m.fecdes) 
     SCAN WHILE cliente =  ;
          clientes.cliente .AND.  ;
          BETWEEN(fecha, m.fecdes,  ;
          m.fechas)
          SELECT comprob
          SEEK STR(ctacte1.tipo,  ;
               2) 
          IF INLIST(ctacte1.tipo,  ;
             4, 5, 15)
               STORE ctacte1.total  ;
                     TO  ;
                     m.credito
               STORE 0 TO  ;
                     m.debito
          ELSE
               STORE 0 TO  ;
                     m.credito
               STORE ctacte1.total  ;
                     TO m.debito
          ENDIF
          IF (ctacte1.tipo = 1  ;
             .AND.  .NOT.  ;
             ctacte1.facturado)  ;
             .OR. (ctacte1.tipo <>  ;
             1 .AND.  ;
             ctacte1.facturado)
               STORE .F. TO  ;
                     m.sinmovim
               SELECT rescta
               APPEND BLANK
               REPLACE cliente  ;
                       WITH  ;
                       ctacte1.cliente,  ;
                       fecha WITH  ;
                       ctacte1.fecha,  ;
                       tipocomp  ;
                       WITH  ;
                       comprob.codigo,  ;
                       numero1  ;
                       WITH  ;
                       ctacte1.numero1,  ;
                       numero2  ;
                       WITH  ;
                       ctacte1.numero2,  ;
                       detalle  ;
                       WITH  ;
                       comprob.descripcio,  ;
                       debe WITH  ;
                       m.debito,  ;
                       haber WITH  ;
                       m.credito,  ;
                       saldo WITH  ;
                       0
          ENDIF
          SELECT ctacte1
     ENDSCAN
     SELECT pagos1
     SEEK clientes.cliente +  ;
          DTOS(m.fecdes) 
     SCAN WHILE cliente =  ;
          clientes.cliente .AND.  ;
          BETWEEN(fecha, m.fecdes,  ;
          m.fechas)
          IF sictacte()
               STORE .F. TO  ;
                     m.sinmovim
               SELECT comprob
               SEEK STR(pagos1.tipo,  ;
                    2) 
               IF INLIST(pagos1.tipo,  ;
                  8, 18)
                    STORE pagos1.total  ;
                          TO  ;
                          m.credito
                    STORE 0 TO  ;
                          m.debito
               ELSE
                    STORE 0 TO  ;
                          m.credito
                    STORE pagos1.total  ;
                          TO  ;
                          m.debito
               ENDIF
               SELECT rescta
               APPEND BLANK
               REPLACE cliente  ;
                       WITH  ;
                       pagos1.cliente,  ;
                       fecha WITH  ;
                       pagos1.fecha,  ;
                       tipocomp  ;
                       WITH  ;
                       comprob.codigo,  ;
                       numero1  ;
                       WITH  ;
                       pagos1.numero1,  ;
                       numero2  ;
                       WITH  ;
                       pagos1.numero2,  ;
                       detalle  ;
                       WITH  ;
                       comprob.descripcio,  ;
                       debe WITH  ;
                       m.debito,  ;
                       haber WITH  ;
                       m.credito,  ;
                       saldo WITH  ;
                       0
          ENDIF
          SELECT pagos1
     ENDSCAN
     IF m.sinmovim
          SELECT rescta
          APPEND BLANK
          REPLACE cliente WITH  ;
                  clientes.cliente,  ;
                  fecha WITH  ;
                  m.fecdes,  ;
                  tipocomp WITH  ;
                  "", numero1  ;
                  WITH 0, numero2  ;
                  WITH 0, detalle  ;
                  WITH  ;
                  "SIN MOVIMIENTOS EN EL PERIODO SOLICITADO",  ;
                  debe WITH 0,  ;
                  haber WITH 0,  ;
                  saldo WITH 0
     ENDIF
     STORE 0 TO m.saldoac
     SELECT rescta
     SEEK clientes.cliente 
     SCAN WHILE cliente =  ;
          clientes.cliente
          m.saldoac = ROUND(m.saldoac +  ;
                      rescta.debe -  ;
                      rescta.haber,  ;
                      2)
          REPLACE saldo WITH  ;
                  m.saldoac
     ENDSCAN
     APPEND BLANK
     REPLACE cliente WITH  ;
             clientes.cliente,  ;
             fecha WITH m.fechas,  ;
             tipocomp WITH  ;
             "Saldo", numero1  ;
             WITH 0, numero2 WITH  ;
             0, detalle WITH  ;
             "**** SALDO ACTUAL ****",  ;
             debe WITH 0, haber  ;
             WITH 0, saldo WITH  ;
             m.saldoac
     SELECT clientes
ENDSCAN
SET NEAR &annear
IF USED("saldos")
     SELECT saldos
     SET ORDER TO
     USE
ENDIF
IF USED("ctacte1")
     SELECT ctacte1
     USE
ENDIF
IF USED("pagos1")
     SELECT pagos1
     USE
ENDIF
IF USED("pagos2")
     SELECT pagos2
     USE
ENDIF
IF USED("comprob")
     SELECT comprob
     USE
ENDIF
RETURN
ENDPROC
*
PROCEDURE p_rescta1
SELECT clientes
SET RELATION TO cliente INTO rescta
GOTO TOP
DO p_rescta.prg
SELECT clientes
SET RELATION TO
RETURN
ENDPROC
*
PROCEDURE i_rescta
PRIVATE regant, errant, relant
SELECT clientes
relant = RELATION(1)
regant = RECNO()
SET RELATION TO
SET ORDER TO clientes1
SELECT rescta
SET RELATION TO cliente INTO clientes
GOTO TOP
REPORT FORM l_rescta TO PRINTER  ;
       OFF
SELECT rescta
SET RELATION TO
SELECT clientes
SET ORDER TO clientes2
SET KEY TO m.setkey
IF  .NOT. EMPTY(relant)
     SET RELATION TO cliente INTO rescta
ENDIF
errant = ON("ERROR")
ON ERROR GO TOP
GOTO regant
ON ERROR &errant
RETURN
ENDPROC
*
FUNCTION sictacte
SELECT ctacte1
anord = ORDER()
anreg = RECNO()
SET ORDER TO ctacte1
SELECT pagos2
SEEK DTOS(pagos1.fecha) +  ;
     STR(pagos1.tipo, 2) +  ;
     STR(pagos1.numero1, 4) +  ;
     STR(pagos1.numero2, 8) 
SCAN WHILE pagos1.fecha =  ;
     pagos2.fecha .AND.  ;
     pagos1.tipo = pagos2.tipo  ;
     .AND. pagos1.numero1 =  ;
     pagos2.numero1 .AND.  ;
     pagos1.numero2 =  ;
     pagos2.numero2
     SELECT ctacte1
     SEEK DTOS(pagos2.cfecha) +  ;
          STR(pagos2.ctipo, 2) +  ;
          STR(pagos2.cnumero1, 4) +  ;
          STR(pagos2.cnumero2, 8) 
     IF FOUND() .OR.  ;
        EMPTY(pagos2.cnumero2)
          SELECT ctacte1
          SET ORDER TO &anord
          IF anreg <= RECCOUNT()
               GOTO anreg
          ENDIF
          RETURN .T.
     ENDIF
     SELECT pagos2
ENDSCAN
SELECT ctacte1
SET ORDER TO &anord
IF anreg <= RECCOUNT()
     GOTO anreg
ENDIF
RETURN .F.
ENDFUNC
*
FUNCTION _1kd0oebcx
IF PRINTSTATUS()
     DO g_rescta
     DO i_rescta
ELSE
     WAIT WINDOW NOWAIT  ;
          'Impresora No activa '
ENDIF
RETURN .T.
ENDFUNC
*
