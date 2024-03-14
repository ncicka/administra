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
IF  .NOT. WEXIST("vrespro") .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.PJX" .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.SCX" .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.MNX" .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.PRG" .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.FRX" .OR.  ;
    UPPER(WTITLE("VRESPRO")) ==  ;
    "VRESPRO.QPR"
     DEFINE WINDOW vrespro AT    ;
            0.000 ,   0.000  SIZE   ;
            13.000 , 107.000   ;
            FONT "Arial", 8 FLOAT  ;
            NOCLOSE TITLE  ;
            "Resúmen de Cuenta de Proveedores"  ;
            MINIMIZE SYSTEM
     MOVE WINDOW vrespro CENTER
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
IF  .NOT. USED("provedor")
     USE SHARED provedor ALIAS  ;
         provedor ORDER  ;
         provedor2
ELSE
     SELECT provedor
     SET ORDER TO provedor2
ENDIF
DEFINE POPUP _1kd0oed2o PROMPT  ;
       FIELDS nombre SCROLL
IF WVISIBLE("vrespro")
     ACTIVATE WINDOW SAME vrespro
ELSE
     ACTIVATE WINDOW NOSHOW  ;
              vrespro
ENDIF
@   0.571 ,   2.400  SAY  ;
    "Rango de Fechas:" FONT  ;
    "Arial", 8 STYLE "T"
@   3.929 ,   1.800  SAY  ;
    "Proveedores:" FONT "Arial",  ;
    8 STYLE "T"
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
@ 6.929,1.800 GET m.proveedor  PICTURE "@&N";
 POPUP _1kd0oed2o  SIZE 4.571,73.200;
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
    _1kd0oed2r() WHEN fdhabky()
IF  .NOT. WVISIBLE("vrespro")
     ACTIVATE WINDOW vrespro
ENDIF
READ CYCLE
RELEASE WINDOW vrespro
RELEASE POPUPS _1kd0oed2o
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
IF USED("provedor")
     SELECT provedor
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
SELECT provedor
SET KEY TO m.setkey
SHOW GET m.proveedor
RETURN
ENDPROC
*
PROCEDURE faceptar
DO g_respro
DO p_respro1
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
IF USED("respro")
     SELECT respro
     USE
ENDIF
RETURN
ENDPROC
*
PROCEDURE nada
RETURN
ENDPROC
*
PROCEDURE g_respro
PRIVATE m.perdes, m.debito,  ;
        m.credito, m.saldo,  ;
        m.detalle
STORE YEAR(m.fecdes) * 100 +  ;
      MONTH(m.fecdes) TO  ;
      m.perdes
IF USED("respro")
     SELECT respro
     USE
ENDIF
STORE "_I" + RIGHT(SYS(3), 6) TO  ;
      cdxresct
SELECT 0
CREATE CURSOR respro (proveedor C  ;
       (4), fecha D, tipocomp C  ;
       (5), numero1 N (4),  ;
       numero2 N (8), detalle C  ;
       (50), debe N (12, 2),  ;
       haber N (12, 2), saldo N  ;
       (12, 2))
INDEX ON proveedor+DTOS(fecha)+tipocomp+STR(numero1,4)+STR(numero2,8);
 TAG respro OF &cdxresct
IF USED("saldospr")
     SELECT saldospr
     SET ORDER TO saldospr1 DESCENDING
ELSE
     SELECT 0
     USE SHARED saldospr AGAIN  ;
         ALIAS saldospr ORDER  ;
         saldospr1 DESCENDING
ENDIF
IF USED("ctactpr1")
     SELECT ctactpr1
     SET ORDER TO ctactpr4
ELSE
     SELECT 0
     USE SHARED ctactpr1 AGAIN  ;
         ALIAS ctactpr1 ORDER  ;
         ctactpr4
ENDIF
IF USED("pagospr1")
     SELECT pagospr1
     SET ORDER TO pagospr2
ELSE
     SELECT 0
     USE SHARED pagospr1 AGAIN  ;
         ALIAS pagospr1 ORDER  ;
         pagospr2
ENDIF
IF USED("pagospr2")
     SELECT pagospr2
     SET ORDER TO pagospr1
ELSE
     SELECT 0
     USE SHARED pagospr2 AGAIN  ;
         ALIAS pagospr2 ORDER  ;
         pagospr1
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
SELECT provedor
annear = SET('NEAR')
SET NEAR ON
SCAN
     STORE "**** SALDO ANTERIOR ****"  ;
           TO m.detalle
     STORE 0 TO m.debito,  ;
           m.credito, m.saldo
     SELECT saldospr
     SEEK provedor.proveedor +  ;
          STR(m.perdes, 6) 
     IF FOUND()
          IF saldospr.proveedor =  ;
             provedor.proveedor
               STORE saldospr.anterior  ;
                     TO m.saldo
          ELSE
               STORE 0 TO m.saldo
          ENDIF
     ELSE
          IF saldospr.proveedor =  ;
             provedor.proveedor  ;
             .AND.  ;
             saldospr.periodo <  ;
             STR(m.perdes, 6)
               STORE saldospr.actual  ;
                     TO m.saldo
          ELSE
               STORE 0 TO m.saldo
          ENDIF
     ENDIF
     SELECT ctactpr1
     SEEK provedor.proveedor +  ;
          saldospr.periodo + "00" 
     SCAN WHILE proveedor =  ;
          provedor.proveedor  ;
          .AND. fecha < m.fecdes  ;
          .AND. STR(YEAR(fecha) *  ;
          100 + MONTH(fecha), 6) =  ;
          STR(m.perdes, 6)
          IF INLIST(ctactpr1.tipo,  ;
             4, 5, 8)
               STORE m.saldo -  ;
                     ctactpr1.total  ;
                     TO m.saldo
          ELSE
               IF (ctactpr1.tipo =  ;
                  9 .AND.  .NOT.  ;
                  ctactpr1.facturado)  ;
                  .OR.  ;
                  (ctactpr1.tipo <>  ;
                  9 .AND.  ;
                  ctactpr1.facturado)
                    STORE m.saldo +  ;
                          ctactpr1.total  ;
                          TO  ;
                          m.saldo
               ENDIF
          ENDIF
     ENDSCAN
     SELECT pagospr1
     SEEK provedor.proveedor +  ;
          saldospr.periodo + "00" 
     SCAN WHILE proveedor =  ;
          provedor.proveedor  ;
          .AND. fecha < m.fecdes  ;
          .AND. STR(YEAR(fecha) *  ;
          100 + MONTH(fecha), 6) =  ;
          STR(m.perdes, 6)
          IF sictacte()
               STORE m.saldo -  ;
                     pagospr1.total  ;
                     TO m.saldo
          ENDIF
          SELECT pagospr1
     ENDSCAN
     IF m.saldo >= 0
          STORE m.saldo TO  ;
                m.credito
          STORE 0 TO m.debito
     ELSE
          STORE 0 TO m.credito
          STORE ABS(m.saldo) TO  ;
                m.debito
     ENDIF
     SELECT respro
     APPEND BLANK
     REPLACE proveedor WITH  ;
             provedor.proveedor,  ;
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
     SELECT ctactpr1
     SEEK provedor.proveedor +  ;
          DTOS(m.fecdes) 
     SCAN WHILE proveedor =  ;
          provedor.proveedor  ;
          .AND. BETWEEN(fecha,  ;
          m.fecdes, m.fechas)
          SELECT comprob
          SEEK STR(ctactpr1.tipo,  ;
               2) 
          IF INLIST(ctactpr1.tipo,  ;
             4, 5, 15)
               STORE ctactpr1.total  ;
                     TO m.debito
               STORE 0 TO  ;
                     m.credito
          ELSE
               STORE 0 TO  ;
                     m.debito
               STORE ctactpr1.total  ;
                     TO  ;
                     m.credito
          ENDIF
          IF (ctactpr1.tipo = 9  ;
             .AND.  .NOT.  ;
             ctactpr1.facturado)  ;
             .OR. (ctactpr1.tipo <>  ;
             9 .AND.  ;
             ctactpr1.facturado)
               STORE .F. TO  ;
                     m.sinmovim
               SELECT respro
               APPEND BLANK
               REPLACE proveedor  ;
                       WITH  ;
                       ctactpr1.proveedor,  ;
                       fecha WITH  ;
                       ctactpr1.fecha,  ;
                       tipocomp  ;
                       WITH  ;
                       comprob.codigo,  ;
                       numero1  ;
                       WITH  ;
                       ctactpr1.numero1,  ;
                       numero2  ;
                       WITH  ;
                       ctactpr1.numero2,  ;
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
          SELECT ctactpr1
     ENDSCAN
     SELECT pagospr1
     SEEK provedor.proveedor +  ;
          DTOS(m.fecdes) 
     SCAN WHILE proveedor =  ;
          provedor.proveedor  ;
          .AND. BETWEEN(fecha,  ;
          m.fecdes, m.fechas)
          IF sictacte()
               STORE .F. TO  ;
                     m.sinmovim
               SELECT comprob
               SEEK STR(pagospr1.tipo,  ;
                    2) 
               IF INLIST(pagospr1.tipo,  ;
                  8)
                    STORE pagospr1.total  ;
                          TO  ;
                          m.credito
                    STORE 0 TO  ;
                          m.debito
               ELSE
                    STORE 0 TO  ;
                          m.credito
                    STORE pagospr1.total  ;
                          TO  ;
                          m.debito
               ENDIF
               SELECT respro
               APPEND BLANK
               REPLACE proveedor  ;
                       WITH  ;
                       pagospr1.proveedor,  ;
                       fecha WITH  ;
                       pagospr1.fecha,  ;
                       tipocomp  ;
                       WITH  ;
                       comprob.codigo,  ;
                       numero1  ;
                       WITH  ;
                       pagospr1.numero1,  ;
                       numero2  ;
                       WITH  ;
                       pagospr1.numero2,  ;
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
          SELECT pagospr1
     ENDSCAN
     IF m.sinmovim
          SELECT respro
          APPEND BLANK
          REPLACE proveedor WITH  ;
                  provedor.proveedor,  ;
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
     SELECT respro
     SEEK provedor.proveedor 
     SCAN WHILE proveedor =  ;
          provedor.proveedor
          m.saldoac = ROUND(m.saldoac +  ;
                      respro.debe -  ;
                      respro.haber,  ;
                      2)
          REPLACE saldo WITH  ;
                  m.saldoac
     ENDSCAN
     APPEND BLANK
     REPLACE proveedor WITH  ;
             provedor.proveedor,  ;
             fecha WITH m.fechas,  ;
             tipocomp WITH  ;
             "Saldo", numero1  ;
             WITH 0, numero2 WITH  ;
             0, detalle WITH  ;
             "**** SALDO ACTUAL ****",  ;
             debe WITH 0, haber  ;
             WITH 0, saldo WITH  ;
             m.saldoac
     SELECT provedor
ENDSCAN
SET NEAR &annear
IF USED("saldospr")
     SELECT saldospr
     SET ORDER TO
     USE
ENDIF
IF USED("ctactpr1")
     SELECT ctactpr1
     USE
ENDIF
IF USED("pagospr1")
     SELECT pagospr1
     USE
ENDIF
IF USED("pagospr2")
     SELECT pagospr2
     USE
ENDIF
IF USED("comprob")
     SELECT comprob
     USE
ENDIF
RETURN
ENDPROC
*
PROCEDURE p_respro1
SELECT provedor
SET RELATION TO proveedor INTO respro
GOTO TOP
DO p_respro.prg
SELECT provedor
SET RELATION TO
RETURN
ENDPROC
*
PROCEDURE i_respro
PRIVATE regant, errant, relant
SELECT provedor
relant = RELATION(1)
regant = RECNO()
SET RELATION TO
SET ORDER TO provedor1
SELECT respro
SET RELATION TO proveedor INTO provedor
GOTO TOP
REPORT FORM l_respro TO PRINTER  ;
       OFF
SELECT respro
SET RELATION TO
SELECT provedor
SET ORDER TO provedor2
SET KEY TO m.setkey
IF  .NOT. EMPTY(relant)
     SET RELATION TO proveedor INTO respro
ENDIF
errant = ON("ERROR")
ON ERROR GO TOP
GOTO regant
ON ERROR &errant
RETURN
ENDPROC
*
FUNCTION sictacte
SELECT ctactpr1
anord = ORDER()
anreg = RECNO()
SET ORDER TO ctactpr1
SELECT pagospr2
SEEK DTOS(pagospr1.fecha) +  ;
     STR(pagospr1.tipo, 2) +  ;
     STR(pagospr1.numero1, 4) +  ;
     STR(pagospr1.numero2, 8) 
SCAN WHILE pagospr1.fecha =  ;
     pagospr2.fecha .AND.  ;
     pagospr1.tipo =  ;
     pagospr2.tipo .AND.  ;
     pagospr1.numero1 =  ;
     pagospr2.numero1 .AND.  ;
     pagospr1.numero2 =  ;
     pagospr2.numero2
     SELECT ctactpr1
     SEEK DTOS(pagospr2.cfecha) +  ;
          STR(pagospr2.ctipo, 2) +  ;
          STR(pagospr2.cnumero1,  ;
          4) +  ;
          STR(pagospr2.cnumero2,  ;
          8) 
     IF FOUND() .OR.  ;
        EMPTY(pagospr2.cnumero2)
          SELECT ctactpr1
          SET ORDER TO &anord
          IF anreg <= RECCOUNT()
               GOTO anreg
          ENDIF
          RETURN .T.
     ENDIF
     SELECT pagospr2
ENDSCAN
SELECT ctactpr1
SET ORDER TO &anord
IF anreg <= RECCOUNT()
     GOTO anreg
ENDIF
RETURN .F.
ENDFUNC
*
FUNCTION _1kd0oed2r
IF PRINTSTATUS()
     DO g_respro
     DO i_respro
ELSE
     WAIT WINDOW NOWAIT  ;
          'Impresora No activa '
ENDIF
RETURN .T.
ENDFUNC
*
