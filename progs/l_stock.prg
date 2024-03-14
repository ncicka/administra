PRIVATE m.currarea, m.talkstat,  ;
        m.compstat
SET DELETED ON
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
IF  .NOT. WEXIST("vstock") .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.PJX" .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.SCX" .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.MNX" .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.PRG" .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.FRX" .OR.  ;
    UPPER(WTITLE("VSTOCK")) ==  ;
    "VSTOCK.QPR"
     DEFINE WINDOW vstock AT    ;
            0.000 ,   0.000  SIZE   ;
            16.500 ,  84.000   ;
            FONT "Arial", 8 FLOAT  ;
            NOCLOSE TITLE  ;
            "Listado de Stock"  ;
            NOMINIMIZE SYSTEM
     MOVE WINDOW vstock CENTER
ENDIF
PUBLIC dstock
STORE SPACE(8) TO dstock
PRIVATE m.setkey, m.setkey1, mlen
STORE "" TO m.setkey, m.setkey1
STORE 0 TO mlen
SELECT 0
IF  .NOT. USED("empresa")
     USE SHARED empresa ALIAS  ;
         empresa
ELSE
     SELECT empresa
ENDIF
SELECT 0
IF  .NOT. USED("articulo")
     USE SHARED articulo ALIAS  ;
         articulo ORDER  ;
         articulo2
ELSE
     SELECT articulo
     SET ORDER TO articulo2
ENDIF
SELECT 0
IF  .NOT. USED("rubro")
     USE SHARED rubro ALIAS rubro  ;
         ORDER rubro
ELSE
     SELECT rubro
     SET ORDER TO rubro
ENDIF
SELECT rubro
DEFINE POPUP _s2r0njapo PROMPT  ;
       FIELDS rubro.descripcio  ;
       SCROLL
DEFINE POPUP _s2r0njapp PROMPT  ;
       FIELDS articulo.descripcio  ;
       SCROLL
IF WVISIBLE("vstock")
     ACTIVATE WINDOW SAME vstock
ELSE
     ACTIVATE WINDOW NOSHOW  ;
              vstock
ENDIF
@   0.286 ,   1.800  SAY  ;
    "Rubros:" FONT "Arial", 8  ;
    STYLE "T"
@   8.429 ,   2.000  SAY  ;
    "Artículos:" FONT "Arial", 8  ;
    STYLE "T"
@   1.571 ,   2.200  GET m.setkey  ;
    DEFAULT " " FONT "Arial", 8  ;
    SIZE 1.000 , 22.400  PICTURE  ;
    "@K XXXXXXXXXXXXXXX" VALID  ;
    fdhabky() WHEN fhabky()
@ 3.286,1.800 GET m.rubro  PICTURE "@&N";
 POPUP _s2r0njapo  SIZE 4.571,29.200;
 DEFAULT " "  FONT "Arial", 8  STYLE "";
 DISABLE
@   9.714 ,   2.400  GET  ;
    m.setkey1 DEFAULT " " FONT  ;
    "Arial", 8 SIZE 1.000 ,  ;
    40.800  PICTURE  ;
    "@K XXXXXXXXXXXXXXX" VALID  ;
    fdhabky() WHEN fhabky()
@ 11.429,2.000 GET m.articulo  PICTURE "@&N";
 POPUP _s2r0njapp  SIZE 4.571,46.000;
 DEFAULT " "  FONT "Arial", 8  STYLE "";
 DISABLE
@   1.214 ,  52.800  GET  ;
    m.aceptar DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Aceptar" VALID  ;
    faceptar() WHEN fdhabky()
@   3.786 ,  52.800  GET  ;
    m.cancelar DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Cancelar" VALID  ;
    fcancela() WHEN fdhabky()
@   6.429 ,  52.800  GET  ;
    m.impresora DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Especificar Impresora"  ;
    VALID SYS(1037) WHEN  ;
    fdhabky()
@   9.000 ,  52.800  GET  ;
    m.imprimir DEFAULT 1 FONT  ;
    "MS Sans Serif", 8 SIZE 1.769 ,  ;
    27.000 , 0.800  PICTURE  ;
    "@*HN \<Imprimir" VALID  ;
    _s2r0njard() WHEN fdhabky()
IF  .NOT. WVISIBLE("vstock")
     ACTIVATE WINDOW vstock
ENDIF
READ CYCLE MODAL
RELEASE WINDOW vstock
RELEASE POPUPS _s2r0njapo,  ;
        _s2r0njapp
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
IF USED("articulo")
     SELECT articulo
     USE
ENDIF
IF USED("rubro")
     SELECT rubro
     USE
ENDIF
IF USED(dstock)
     SELECT (dstock)
     USE
ENDIF
RELEASE dstock
RETURN
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
IF _CUROBJ = OBJNUM(m.setkey)
     IF EMPTY(m.setkey) .OR.  ;
        LASTKEY() = 127
          STORE "" TO m.setkey
     ENDIF
     IF LASTKEY() <> 127
          m.setkey = m.setkey +  ;
                     CHR(LASTKEY())
     ENDIF
     SHOW GET m.setkey
     SELECT rubro
     mlen = LEN(TRIM(m.setkey))
     IF  .NOT. EMPTY(m.setkey)
          SET FILTER TO UPPER(TRIM(m.setkey)) = UPPER(SUBSTR(descripcio, 1, mlen))
     ELSE
          SET FILTER TO
     ENDIF
     SHOW GET m.rubro
ELSE
     IF EMPTY(m.setkey1) .OR.  ;
        LASTKEY() = 127
          STORE "" TO m.setkey1
     ENDIF
     IF LASTKEY() <> 127
          m.setkey1 = m.setkey1 +  ;
                      CHR(LASTKEY())
     ENDIF
     SHOW GET m.setkey1
     SELECT articulo
     IF  .NOT. EMPTY(m.setkey1)
          SET KEY TO m.setkey1
     ELSE
          SET KEY TO
     ENDIF
     SHOW GET m.articulo
ENDIF
RETURN
ENDPROC
*
PROCEDURE fcancela
DO fdhabky
CLEAR READ
RETURN
ENDPROC
*
PROCEDURE nada
RETURN
ENDPROC
*
PROCEDURE g_stock
IF USED(dstock)
     SELECT (dstock)
     USE
ENDIF
STORE "_D" + RIGHT(SYS(3), 6) TO  ;
      dstock
SELECT 0
CREATE CURSOR (dstock) (rubro C  ;
       (3), articulo C (4),  ;
       des_rubro C (15),  ;
       descripcio C (30), actual  ;
       N (9, 1), minimo N (9, 1),  ;
       importe N (10, 2),  ;
       valmedida N (7, 3))
INDEX ON rubro + articulo TAG  ;
      rubro OF (dstock)
SELECT articulo
GOTO TOP
SCAN
     IF  .NOT.  ;
         SEEK(articulo.rubro,  ;
         'rubro')
          LOOP
     ENDIF
     SELECT (dstock)
     APPEND BLANK
     REPLACE rubro WITH  ;
             rubro.rubro,  ;
             des_rubro WITH  ;
             rubro.descripcio,  ;
             articulo WITH  ;
             articulo.articulo,  ;
             descripcio WITH  ;
             LEFT(ALLTRIM(articulo.descripcio) +  ;
             ' ' +  ;
             ALLTRIM(articulo.medida),  ;
             30), actual WITH  ;
             articulo.actual,  ;
             minimo WITH  ;
             articulo.minimo,  ;
             importe WITH  ;
             articulo.costo *  ;
             articulo.actual,  ;
             valmedida WITH  ;
             articulo.valmedida
     SELECT articulo
ENDSCAN
RETURN
ENDPROC
*
PROCEDURE i_stock
SELECT (dstock)
REPORT FORM stock TO PRINTER  ;
       NOCONSOLE
SET RELATION TO
RETURN
ENDPROC
*
PROCEDURE faceptar
DO g_stock
DO p_stock
RETURN
ENDPROC
*
PROCEDURE p_stock
DEFINE WINDOW pstock AT   0.000 ,    ;
       0.000  SIZE  23.000 ,  ;
       135.000  FONT  ;
       "Ms Sans Serif", 8 NOFLOAT  ;
       NOCLOSE TITLE  ;
       'Listado de Stock'  ;
       NOMINIMIZE DOUBLE COLOR  ;
       SCHEME 1
MOVE WINDOW pstock CENTER
ACTIVATE WINDOW pstock
SELECT (dstock)
BROWSE FIELDS rubro :H =  ;
       'Rubro  ' :R, des_rubro :H =  ;
       ' ' :R, articulo :H =  ;
       'Art.' :R, descripcio :H =  ;
       'Descripción' :R, actual  ;
       :H = 'Stk. Actual' :R,  ;
       minimo :H = 'Stk. Mínimo'  ;
       :R, stkmedida = actual *  ;
       valmedida :H =  ;
       'Stk. Unidad' :R :P =  ;
       "9999,999.999", importe :H =  ;
       'Importe Costo' :R NOMENU  ;
       NODELETE IN pstock
RELEASE WINDOW pstock
RETURN
ENDPROC
*
FUNCTION _s2r0njard
IF PRINTSTATUS()
     DO g_stock
     DO i_stock
ELSE
     WAIT WINDOW NOWAIT  ;
          'Impresora No activa '
ENDIF
RETURN .T.
ENDFUNC
*
