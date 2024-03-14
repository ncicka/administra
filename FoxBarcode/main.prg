*--------------------------------------------------------------------------------------
* MAIN.PRG
*--------------------------------------------------------------------------------------
* Version: 0.16 Beta
* Date   : 2011.08.26
* Author : VFPEncoding
* Email  : vfpencoding@gmail.com
*
* Note   : VFPEncoding are 
*          Guillermo Carrero (Barcelona, Spain) and 
*          Luis Maria Guayan (Tucuman, Argentina)
*--------------------------------------------------------------------------------------
LOCAL lcPath

lcPath = ADDBS(JUSTPATH(SYS(16,1)))

SET DEFAULT TO (lcPath)
SET PROCEDURE TO Source\FoxBarcode, Source\gpImage2 ADDITIVE
DO FORM ("Forms\FoxBarcode")
READ EVENTS

CLEAR RESOURCES

*--------------------------------------------------------------------------------------