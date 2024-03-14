*--------------------------------------------------------------------------------------
* FoxBarcode.prg
*--------------------------------------------------------------------------------------
* FoxBarcode is a application free software and offers a Barcode tool for
* the Visual FoxPro Community.
* This software is provided "as is" without express or implied warranty.
* Use it at your own risk
*--------------------------------------------------------------------------------------
* Version: 0.16
* Date   : 2011.08.26
* Author : VFPEncoding
* Email  : vfpencoding@gmail.com
*
* Note   : VFPEncoding are
*          Guillermo Carrero (Barcelona, Spain) and
*          Luis Maria Guayan (Tucuman, Argentina)
*--------------------------------------------------------------------------------------
* Note   : This application use GPIMAGE2 (http://sites.google.com/site/gpimage2)
*          of Alexander Golovlev (Russian Federation) and Cesar Chalom (Brazil)
*--------------------------------------------------------------------------------------

*--------------------------------------------------------------------------------------
* FoxBarcode Language
* To add or correct a language send an email to: vfpencoding@gmail.com
*--------------------------------------------------------------------------------------

*--------------------------------
* AVAILABLE LANGUAGE
* Uncomment your choice
* Language by default: "ENGLISH"
*--------------------------------
#DEFINE FBC_LANGUAGE "ENGLISH"
* #DEFINE FBC_LANGUAGE "SPANISH"
* #DEFINE FBC_LANGUAGE "CZECH"
* #DEFINE FBC_LANGUAGE "DUTCH"
* #DEFINE FBC_LANGUAGE "PORTUGUESE"
* #DEFINE FBC_LANGUAGE "TURKISH"
* #DEFINE FBC_LANGUAGE "INDONESIAN"
* #DEFINE FBC_LANGUAGE "GERMAN"
* #DEFINE FBC_LANGUAGE "FILIPINO"
* #DEFINE FBC_LANGUAGE "FRENCH"
* #DEFINE FBC_LANGUAGE "SERBIAN"


#IF FBC_LANGUAGE = "SPANISH"
  *--------------------------------
  * SPANISH LANGUAGE
  * Translate by VFPEncoding
  *--------------------------------
  #DEFINE FBC_FBC_01		"Fuente o estilo no permitido por GDI+"
  #DEFINE FBC_FBC_02		"Simbología de código de barras no implementada."
  #DEFINE FBC_FBC_03		"El texto a codificar está en blanco."
  #DEFINE FBC_I2O5_01		"El código Interleaved 2 of 5 solo acepta caracteres numéricos."
  #DEFINE FBC_S2O5_01		"El código Standard 2 of 5 solo acepta caracteres numéricos."
  #DEFINE FBC_CODABAR_01	"El código Codabar solo acepta los siguientes caracteres: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Caracteres inválidos para el Código 128 Set A."
  #DEFINE FBC_128B_01		"Caracteres inválidos para el Código 128 Set B."
  #DEFINE FBC_128C_01		"El Código 128 Set C solo acepta caracteres numéricos."
  #DEFINE FBC_39EXT_01		"Caracteres inválidos para el Código 39 Full ASCII."
  #DEFINE FBC_39_01			"Caracteres inválidos para el Código Code 39."
  #DEFINE FBC_93EXT_01		"Caracteres inválidos para el Código 93 Full ASCII."
  #DEFINE FBC_93_01			"Caracteres inválidos para el Código 93."
  #DEFINE FBC_ITF14_01		"El código ITF-14 solo acepta caracteres numéricos."
  #DEFINE FBC_ITF14_02		"ITF-14: El largo de la cadena debe ser 13 ó 14."
  #DEFINE FBC_ITF14_03		"ITF-14: El dígito de verificación correcto es "
  #DEFINE FBC_EAN13_01		"El código EAN-13 solo acepta caracteres numéricos."
  #DEFINE FBC_EAN13_02		"EAN13: El largo de la cadena debe ser 12 ó 13. Con suplemento entre 14 y 18."
  #DEFINE FBC_EAN13_03		"EAN-13: El dígito de verificación correcto es "
  #DEFINE FBC_EAN8_01		"El código EAN-8 solo acepta caracteres numéricos"
  #DEFINE FBC_EAN8_02		"EAN-8: El largo de la cadena debe ser 7 ú 8. Con suplemento entre 9 y 13."
  #DEFINE FBC_EAN8_03		"EAN-8:  El dígito de verificación correcto es "
  #DEFINE FBC_UPCA_01		"El código UPC-A solo acepta caracteres numéricos"
  #DEFINE FBC_UPCA_02		"UPC-A: El largo de la cadena debe ser 11 ó 12. Con suplemento entre 13 y 17."
  #DEFINE FBC_UPCA_03		"UPC-A: El dígito de verificación correcto es "
  #DEFINE FBC_UPCB_01		"El código UPC-E solo acepta caracteres numéricos"
  #DEFINE FBC_UPCB_02		"UPC-E: El largo de la cadena debe ser 6 ó 7. Con suplemento entre 8 y 12."
  #DEFINE FBC_UPCB_03		"UPC-E: El dígito de verificación correcto es "
  #DEFINE FBC_MSI_01		"El código  MSI/Plessey solo acepta caracteres numéricos"
  #DEFINE FBC_11_01			"El Código 11 solo acepta caracteres numéricos y - (guión)"
  #DEFINE FBC_POSTNET_01	"El código PostNet solo acepta caracteres numéricos"
  #DEFINE FBC_POSTNET_02	"PostNet: El largo de la cadena debe ser 5, 9 ú 11"
  #DEFINE FBC_IMB_01		"El código Intelligent Mail Barcode solo acepta caracteres numéricos"
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: El largo de la cadena debe ser 5, 9 ú 11"
  #DEFINE FBC_IMB_99		"El código Intelligent Mail Barcode muy pronto ..."
  #DEFINE FBC_TELEPEN_01	"Caracter inválido para el código Telepen"
  #DEFINE FBC_PHARMA1_01	"El código Pharmacode solo acepta caracteres numéricos"
  #DEFINE FBC_PHARMA1_02	"El código Pharmacode acepta valores entre 3 y 131070"
  #DEFINE FBC_PHARMA1_03	"El código Pharmacode solo acepta caracteres numéricos"
  #DEFINE FBC_PHARMA2_01	"El código Two Track Pharmacode acepta valores entre 4 y 64570080"
  #DEFINE FBC_SUPP5_01		"El código Supplemental 5 solo acepta caracteres numéricos"
  #DEFINE FBC_SUPP2_01		"El código Supplemental 2 solo acepta caracteres numéricos"
  #DEFINE FBC_EAN128_01		"Caracter inválido para el Código EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Caracteres inválidos para el Código RM4SCC"
  #DEFINE FBC_KIX_01		"Caracteres inválidos para el Código KIX"


#ELIF FBC_LANGUAGE = "CZECH"
  *--------------------------------
  * CZECH LANGUAGE
  * Translate by Martin Krivka
  *--------------------------------
  #DEFINE FBC_FBC_01		"Font nebo styl není dostupný v GDI+"
  #DEFINE FBC_FBC_02		"Symboly èárového kódu nejsou implementovány."
  #DEFINE FBC_FBC_03		"Text je prázdný."
  #DEFINE FBC_I2O5_01		"Interleaved 2 of 5 code podporuje pouze numerické znaky."
  #DEFINE FBC_S2O5_01		"Standard 2 of 5 code podporuje pouze numerické znaky."
  #DEFINE FBC_CODABAR_01	"Codabar podporuje pouze znaky: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Neplatné znaky pro Code 128 Set A."
  #DEFINE FBC_128B_01		"Neplatné znaky pro Code 128 Set B."
  #DEFINE FBC_128C_01		"Code 128 Set C podporuje pouze numerické znaky."
  #DEFINE FBC_39EXT_01		"Neplatné znaky pro Code 39 Full ASCII."
  #DEFINE FBC_39_01			"Neplatné znaky pro Code 39."
  #DEFINE FBC_93EXT_01		"Neplatné znaky pro Code 93 Full ASCII."
  #DEFINE FBC_93_01			"Neplatné znaky pro Code 93."
  #DEFINE FBC_ITF14_01		"ITF-14: podporuje pouze numerické znaky."
  #DEFINE FBC_ITF14_02		"ITF-14: délka øetìzce musí být 13 nebo 14 znakù."
  #DEFINE FBC_ITF14_03		"ITF-14: správné kontrolní èíslo je "
  #DEFINE FBC_EAN13_01		"EAN-13 podporuje pouze numerické znaky."
  #DEFINE FBC_EAN13_02		"Délka øetìzce musí být 12 nebo 13 znakù. S pøíplatkem mezi 14 až 18."
  #DEFINE FBC_EAN13_03		"EAN-13: správné kontrolní èíslo je "
  #DEFINE FBC_EAN8_01		"The EAN-8 podporuje pouze numerické znaky."
  #DEFINE FBC_EAN8_02		"EAN-8: délka øetìzce musí být 7 nebo 8 znakù. S pøíplatkem mezi 9 až 13."
  #DEFINE FBC_EAN8_03		"EAN-8: správné kontrolní èíslo je "
  #DEFINE FBC_UPCA_01		"UPC-A: podporuje pouze numerické znaky."
  #DEFINE FBC_UPCA_02		"UPC-A: délka øetìzce musí být 11 nebo 12 znakù. S pøíplatkem mezi 13 až 17."
  #DEFINE FBC_UPCA_03		"UPC-A: správné kontrolní èíslo je "
  #DEFINE FBC_UPCB_01		"UPC-E: podporuje pouze numerické znaky."
  #DEFINE FBC_UPCB_02		"UPC-E: délka øetìzce musí být 6 nebo 7 znakù. S pøíplatkem mezi 8 až 12."
  #DEFINE FBC_UPCB_03		"UPC-E: správné kontrolní èíslo je "
  #DEFINE FBC_MSI_01		"MSI/Plessey podporuje pouze numerické znaky."
  #DEFINE FBC_11_01			"Code 11 podporuje pouze numerické znaky a - (minus)."
  #DEFINE FBC_POSTNET_01	"PostNet podporuje pouze numerické znaky."
  #DEFINE FBC_POSTNET_02	"PostNet: délka øetìzce musí být 5,9,11"
  #DEFINE FBC_IMB_01		"Intelligent Mail Barcode podporuje pouze numerické znaky."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: délka øetìzce musí být 5, 9, 11."
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode brzdy ..."
  #DEFINE FBC_TELEPEN_01	"Neplatný znak pro Telepen code."
  #DEFINE FBC_PHARMA1_01	"Pharmacode podporuje pouze numerické znaky."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: vstupní hodnoty mezi 3 a 131070."
  #DEFINE FBC_PHARMA1_03	"Pharmacode podporuje pouze numerické znaky."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: vstupní hodnoty mezi 4 až 64570080."
  #DEFINE FBC_SUPP5_01		"Supplemental 5 code podporuje pouze numerické znaky."
  #DEFINE FBC_SUPP2_01		"Supplemental 2 code podporuje pouze numerické znaky."
  #DEFINE FBC_EAN128_01		"Neplatné znaky pro EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Neplatné znaky pro Code RM4SCC."
  #DEFINE FBC_KIX_01		"Neplatné znaky pro KIX-Code."

#ELIF FBC_LANGUAGE = "DUTCH"
  *--------------------------------
  * DUTCH LANGUAGE
  * Translate by Koen Piller
  *--------------------------------
  #DEFINE FBC_11_01		    "Code 11 is slechts voor cijfers en liggend streepje"
  #DEFINE FBC_128A_01		"Niet toegestane tekens voor Code 128 Set A"
  #DEFINE FBC_128B_01		"Niet toegestane tekens voor Cose 128 Set B"
  #DEFINE FBC_128C_01		"Code 128 is slechts voor cijfers"
  #DEFINE FBC_39_01		   	"Niet toegestane tekens voor Code 39"
  #DEFINE FBC_39EXT_01		"Niet toegestane tekens voor Code 39 Full ASCII"
  #DEFINE FBC_93_01			"Niet toegestane tekens voor Code 93"
  #DEFINE FBC_93EXT_01		"Niet toegestane tekens voor Code 39 Full ASCII"
  #DEFINE FBC_CODABAR_01	"Voor Codabar zijn slechts de volgende tekens toegestaan:  0123456789-$:/.+"
  #DEFINE FBC_EAN128_01		"Niet toegestane tekens voor EAN/UCC?GS 128"
  #DEFINE FBC_EAN13_01		"De EAN-13 code is slechts voor cijfers."
  #DEFINE FBC_EAN13_02		"De lengte van de reeks moet 12 of 13 zijn. Met een toevoeging van 14 en 18"
  #DEFINE FBC_EAN13_03		"EAN-13: Het juiste teken is "
  #DEFINE FBC_EAN8_01		"The EAN-8 code is slechts voor cijfers"
  #DEFINE FBC_EAN8_02		"EAN-8: De lengte van de tekenreeks moet 7 of 8 zijn. Met een toevoeging tussen 9 en 13"
  #DEFINE FBC_EAN8_03		"EAN-8: Het juiste teken is "
  #DEFINE FBC_FBC_01		"Lettertype of -opmaak is niet toegestaan in GDI+"
  #DEFINE FBC_FBC_02		"Barcode symbolen werden niet geimplementeerd"
  #DEFINE FBC_FBC_03		"De te coderen tekst is niet gegeven."
  #DEFINE FBC_I2O5_01		"Interleaved 2 van 5 (ook wel Ik heb 2 van 5)  is slechts voor cijfers"
  #DEFINE FBC_IMB_01		"De Intelligent Mail Barcode  is slechts voor cijfers."
  #DEFINE FBC_IMB_02		"De Intelligent Mail Barcode: De lengte van de tekenreeks moet 5, 9 of 11 zijn."
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode  binnenkort....."
  #DEFINE FBC_ITF14_01		"The ITF-14 code is slechts voor cijfers"
  #DEFINE FBC_ITF14_02		"ITF-14: De lengte van de tekenreeks moet 13 of 14 zijn"
  #DEFINE FBC_ITF14_03		"ITF-14: Het controle getal moet zijn"
  #DEFINE FBC_MSI_01		"The MSI/Plessey code is slechts voor cijfers"
  #DEFINE FBC_PHARMA1_01	"The Pharmacode is slechts voor cijfers"
  #DEFINE FBC_PHARMA1_02	"Pharmacode: waarde moet in de reeks 13 t/m 131070 zijn"
  #DEFINE FBC_PHARMA1_03	"The Pharmacode is slechts voor cijfers"
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Waarde moet liggen tussen 4 en 64570080."
  #DEFINE FBC_POSTNET_01	"The PostNet is slechts voor cijfers"
  #DEFINE FBC_POSTNET_02	"PostNet: De lengte van de tekenreeks moet 5, 9 of 11 zijn"
  #DEFINE FBC_S2O5_01		"The Standard 2 of 5 code is slechts voor cijfers"
  #DEFINE FBC_SUPP2_01		"The Supplemental 2 code is slechts voor cijfers"
  #DEFINE FBC_SUPP5_01		"The Supplemental 5 is slechts voor cijfers"
  #DEFINE FBC_TELEPEN_01	"Ongeldig teken voor Telepen code."
  #DEFINE FBC_UPCA_01		"The UPC-A code is slechts voor cijfers."
  #DEFINE FBC_UPCA_02		"UPC-A: De tekenreeks is 11 of 12 lang. Het toevoegsel tussen 13 en 17 lang."
  #DEFINE FBC_UPCA_03		"UPC-A: Het juiste controle getal is "
  #DEFINE FBC_UPCB_01		"The UPC-E code is slechts voor cijfers"
  #DEFINE FBC_UPCB_02		"UPC-E: De tekenreeks moet 6 of 7 lang zijn. Het toevoegsel tussen 8 en 12 lang."
  #DEFINE FBC_UPCB_03		"UPC-E:Het juiste controle getal is "
  #DEFINE FBC_RM4SCC_01		"Niet toegestane tekens voor Code RM4SCC"
  #DEFINE FBC_KIX_01		"Niet toegestane tekens voor KIX-Code"


#ELIF FBC_LANGUAGE = "PORTUGUESE"
  *--------------------------------
  * PORTUGUESE LANGUAGE
  * Translate by Cesar Chalom
  *--------------------------------
  #DEFINE FBC_FBC_01		"Fonte ou estilo não permitido pela biblioteca GDI+"
  #DEFINE FBC_FBC_02		"Simbología de código de barras não implementada."
  #DEFINE FBC_FBC_03		"O texto a codificar está vazio."
  #DEFINE FBC_I2O5_01		"O código Interleaved 2 of 5 somente aceita caracteres numéricos."
  #DEFINE FBC_S2O5_01		"O código Standard 2 of 5 somente aceita caracteres numéricos."
  #DEFINE FBC_CODABAR_01	"O código Codabar somente aceita os seguintes caracteres: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Caracteres inválidos para o Código 128 Set A."
  #DEFINE FBC_128B_01		"Caracteres inválidos para o Código 128 Set B."
  #DEFINE FBC_128C_01		"O Código 128 Set C somente aceita caracteres numéricos."
  #DEFINE FBC_39EXT_01		"Caracteres inválidos para o Código 39 Full ASCII."
  #DEFINE FBC_39_01			"Caracteres inválidos para o Código Code 39."
  #DEFINE FBC_93EXT_01		"Caracteres inválidos para o Código 93 Full ASCII."
  #DEFINE FBC_93_01			"Caracteres inválidos para o Código 93."
  #DEFINE FBC_ITF14_01		"O código ITF-14 somente aceita caracteres numéricos."
  #DEFINE FBC_ITF14_02		"ITF-14: O tamanho da cadeia deve ser 13 ou 14."
  #DEFINE FBC_ITF14_03		"ITF-14: O dígito de verificação correto é "
  #DEFINE FBC_EAN13_01		"O código EAN-13 somente aceita caracteres numéricos."
  #DEFINE FBC_EAN13_02		"EAN13: O tamanho da cadeia deve ser 12 ou 13. Com suplemento entre 14 e 18."
  #DEFINE FBC_EAN13_03		"EAN-13: O dígito de verificação correto é "
  #DEFINE FBC_EAN8_01		"O código EAN-8 somente aceita caracteres numéricos"
  #DEFINE FBC_EAN8_02		"EAN-8: O tamanho da cadeia deve ser 7 ou 8. Com suplemento entre 9 e 13."
  #DEFINE FBC_EAN8_03		"EAN-8:  O dígito de verificação correto é "
  #DEFINE FBC_UPCA_01		"O código UPC-A somente aceita caracteres numéricos"
  #DEFINE FBC_UPCA_02		"UPC-A: O tamanho da cadeia deve ser 11 ou 12. Com suplemento entre 13 e 17."
  #DEFINE FBC_UPCA_03		"UPC-A: O dígito de verificação correto é "
  #DEFINE FBC_UPCB_01		"O código UPC-E somente aceita caracteres numéricos"
  #DEFINE FBC_UPCB_02		"UPC-E: O tamanho da cadeia deve ser 6 ou 7. Com suplemento entre 8 e 12."
  #DEFINE FBC_UPCB_03		"UPC-E: O dígito de verificação correto é "
  #DEFINE FBC_MSI_01		"O código  MSI/Plessey somente aceita caracteres numéricos"
  #DEFINE FBC_11_01			"O Código 11 somente aceita caracteres numéricos e - (guión)"
  #DEFINE FBC_POSTNET_01	"O código PostNet somente aceita caracteres numéricos"
  #DEFINE FBC_POSTNET_02	"PostNet: O tamanho da cadeia deve ser 5, 9 ou 11"
  #DEFINE FBC_IMB_01		"O código Intelligent Mail Barcode somente aceita caracteres numéricos"
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: O tamanho da cadeia deve ser 5, 9 ou 11"
  #DEFINE FBC_IMB_99		"O código Intelligent Mail Barcode muy pronto ..."
  #DEFINE FBC_TELEPEN_01	"Caracter inválido para o código Telepen"
  #DEFINE FBC_PHARMA1_01	"O código Pharmacode somente aceita caracteres numéricos"
  #DEFINE FBC_PHARMA1_02	"O código Pharmacode aceita valores entre 3 e 131070"
  #DEFINE FBC_PHARMA1_03	"O código Pharmacode somente aceita caracteres numéricos"
  #DEFINE FBC_PHARMA2_01	"O código Two Track Pharmacode aceita valores entre 4 e 64570080"
  #DEFINE FBC_SUPP5_01		"O código Supplemental 5 somente aceita caracteres numéricos"
  #DEFINE FBC_SUPP2_01		"O código Supplemental 2 somente aceita caracteres numéricos"
  #DEFINE FBC_EAN128_01		"Caracter inválido para o Código EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Caracteres inválidos para o Código RM4SCC."
  #DEFINE FBC_KIX_01		"Caracteres inválidos para o KIX-Code."

#ELIF FBC_LANGUAGE = "TURKISH"
  *--------------------------------
  * TURKISH LANGUAGE
  * Translate by Ugur Yilmaz
  *--------------------------------
  #DEFINE FBC_FBC_01		"Font yada font stili GD+ da desteklenmiyor."
  #DEFINE FBC_FBC_02		"Barkod alfabesine uygulanamadý."
  #DEFINE FBC_FBC_03		"Metin kodlamasý boþ."
  #DEFINE FBC_I2O5_01		"Interleaved 2 of 5 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_S2O5_01		"Standard 2 of 5 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_CODABAR_01	"Codabar kodu sadece izleyen deðerleri kabul eder:  0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Code 128 Set A için geçersiz karakter."
  #DEFINE FBC_128B_01		"Code 128 Set B  için geçersiz karakter."
  #DEFINE FBC_128C_01		"Code 128 Set C sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_39EXT_01		"Code 39 Full ASCII için geçersiz karakter."
  #DEFINE FBC_39_01			"Code 39 için geçersiz karakter."
  #DEFINE FBC_93EXT_01		"Code 93 Full ASCII için geçersiz karakter."
  #DEFINE FBC_93_01			"Code 93 için geçersiz karakter."
  #DEFINE FBC_ITF14_01		"ITF-14 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_ITF14_02		"ITF-14: Dizi uzunluðu 13 yada 14 olmalý."
  #DEFINE FBC_ITF14_03		"ITF-14: Doðru kontrol hanesi."
  #DEFINE FBC_EAN13_01		"The EAN-13 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_EAN13_02		"Dizi uzunluðu 12 yada 13 karakter olmalý. 14 ile 18 arasýna tamamlanýr."
  #DEFINE FBC_EAN13_03		"EAN-13: Doðru kontrol hanesi "
  #DEFINE FBC_EAN8_01		"The EAN-8 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_EAN8_02		"EAN-8: Dizi uzunluðu 7 yada 8 olmalý. 9 ile 13 arasýna tamamlanýr."
  #DEFINE FBC_EAN8_03		"EAN-8: Doðru kontrol hanesi "
  #DEFINE FBC_UPCA_01		"The UPC-A kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_UPCA_02		"UPC-A: Dizi uzunluðu 11 yada 12 olmalý. 13 ile 17 arasýna tamamlanýr."
  #DEFINE FBC_UPCA_03		"UPC-A: Doðru kontrol hanesi "
  #DEFINE FBC_UPCB_01		"The UPC-E kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_UPCB_02		"UPC-E: Dizi uzunluðu 6 yada 7 olmalý. 8 ile 12 arasýna tamamlanýr."
  #DEFINE FBC_UPCB_03		"UPC-E: Doðru kontrol hanesi "
  #DEFINE FBC_MSI_01		"The MSI/Plessey kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_11_01			"Code 11 sadece sayýsal deðerleri ve - (Tire) kabul eder."
  #DEFINE FBC_POSTNET_01	"PostNet kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_POSTNET_02	"PostNet: Dizi uzunluðu 5,9 yada 11 karakter olmalý"
  #DEFINE FBC_IMB_01		"Intelligent Mail Barcode kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode:  Dizi uzunluðu 5, 9 yada 11 karakter olmalý"
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode (Yakýnda) ..."
  #DEFINE FBC_TELEPEN_01	"Telepen kodu için geçersiz karakter."
  #DEFINE FBC_PHARMA1_01	"Pharmacode sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: 3 ile 131070 arasýnda bir deðer girin."
  #DEFINE FBC_PHARMA1_03	"Pharmacode sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: 4 ile 64570080 arasýnda bir deðer girin."
  #DEFINE FBC_SUPP5_01		"Supplemental 5 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_SUPP2_01		"The Supplemental 2 kodu sadece sayýsal deðerleri kabul eder."
  #DEFINE FBC_EAN128_01		"EAN/UCC/GS1 128 için geçersiz karakter."
  #DEFINE FBC_RM4SCC_01		"Code RM4SCC için geçersiz karakter."
  #DEFINE FBC_KIX_01		"KIX-Code için geçersiz karakter."

#ELIF FBC_LANGUAGE = "INDONESIAN"
  *--------------------------------
  * INDONESIAN LANGUAGE
  * Translate by Samir H.
  *--------------------------------
  #DEFINE FBC_FBC_01		"Font atau style tidak diperbolehkan di GDI+"
  #DEFINE FBC_FBC_02		"Simbologi barcode belum terimplementasi."
  #DEFINE FBC_FBC_03		"Teks pengkodean kosong."
  #DEFINE FBC_I2O5_01		"Interleaved 2 of 5 hanya menerima karakter numerik."
  #DEFINE FBC_S2O5_01		"Standard 2 of 5 hanya menerima karakter numerik."
  #DEFINE FBC_CODABAR_01	"Codabar hanya menerima karakter berikut: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Karakter tidak valid untuk Code 128 Set A."
  #DEFINE FBC_128B_01		"Karakter tidak valid untuk Code 128 Set B."
  #DEFINE FBC_128C_01		"Code 128 Set C hanya menerima karakter numerik."
  #DEFINE FBC_39EXT_01		"Karakter tidak valid untuk Code 39 Full ASCII."
  #DEFINE FBC_39_01			"Karakter tidak valid untuk Code 39."
  #DEFINE FBC_93EXT_01		"Karakter tidak valid untuk Code 93 Full ASCII."
  #DEFINE FBC_93_01			"Karakter tidak valid untuk Code 93."
  #DEFINE FBC_ITF14_01		"Kode ITF-14 hanya menerima karakter numerik."
  #DEFINE FBC_ITF14_02		"ITF-14: Panjang kode harus 13 or 14."
  #DEFINE FBC_ITF14_03		"ITF-14: Cek digit yang benar adalah "
  #DEFINE FBC_EAN13_01		"Kode EAN-13 hanya menerima karakter numerik."
  #DEFINE FBC_EAN13_02		"Panjang kode harus 12 or 13. Dengan suplemen antara 14 dan 18."
  #DEFINE FBC_EAN13_03		"EAN-13: Cek digit yang benar adalah "
  #DEFINE FBC_EAN8_01		"Kode EAN-8 hanya menerima karakter numerik."
  #DEFINE FBC_EAN8_02		"EAN-8: Panjang kode harus 7 or 8. With supplement between 9 dan 13."
  #DEFINE FBC_EAN8_03		"EAN-8: Cek digit yang benar adalah "
  #DEFINE FBC_UPCA_01		"Kode UPC-A hanya menerima karakter numerik."
  #DEFINE FBC_UPCA_02		"UPC-A: Panjang kode harus 11 or 12. Dengan suplemen antara 13 dan 17."
  #DEFINE FBC_UPCA_03		"UPC-A: Cek digit yang benar adalah "
  #DEFINE FBC_UPCB_01		"Kode UPC-E hanya menerima karakter numerik."
  #DEFINE FBC_UPCB_02		"UPC-E: Panjang kode harus 6 or 7. Dengan suplemen antara 8 dan 12."
  #DEFINE FBC_UPCB_03		"UPC-E: Cek digit yang benar adalah "
  #DEFINE FBC_MSI_01		"Kode MSI/Plessey hanya menerima karakter numerik."
  #DEFINE FBC_11_01			"Code 11 hanya menerima karakter numerik dan - (Strip)."
  #DEFINE FBC_POSTNET_01	"Kode PostNet hanya menerima karakter numerik."
  #DEFINE FBC_POSTNET_02	"PostNet: Panjang kode harus 5,9,11"
  #DEFINE FBC_IMB_01		"Intelligent Mail Barcode hanya menerima karakter numerik."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: Panjang kode harus 5, 9, 11"
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode segera..."
  #DEFINE FBC_TELEPEN_01	"Karacter tidak valid untuk kode Telepen."
  #DEFINE FBC_PHARMA1_01	"Kode Pharmacode hanya menerima karakter numerik."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Masukan nilai antara 3 dan 131070."
  #DEFINE FBC_PHARMA1_03	"Kode Pharmacode hanya menerima karakter numerik."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Masukan nilai antara 3 dan 131070."
  #DEFINE FBC_SUPP5_01		"Kode Supplemental 5 hanya menerima karakter numerik."
  #DEFINE FBC_SUPP2_01		"Kode Supplemental 2 hanya menerima karakter numerik."
  #DEFINE FBC_EAN128_01		"Karacter tidak valid untuk EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Karakter tidak valid untuk Code RM4SCC."
  #DEFINE FBC_KIX_01		"Karakter tidak valid untuk KIX-Code."

#ELIF FBC_LANGUAGE = "GERMAN"
  *--------------------------------
  * GERMAN LANGUAGE
  * Translate by Stefan Wuebbe
  *--------------------------------
  #DEFINE FBC_FBC_01		"Schriftart oder -schnitt wird von GDI+ nicht unterstützt."
  #DEFINE FBC_FBC_02		"Barcode-Symbologie nicht implementiert."
  #DEFINE FBC_FBC_03		"Die Text-Encodierung ist leer."
  #DEFINE FBC_I2O5_01		"'Interleaved 2 of 5' akzeptiert nur numerische Zeichen."
  #DEFINE FBC_S2O5_01		"Der 'Standard 2 of 5' Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_CODABAR_01	"Der Codabar Code akzeptiert nur folgende Zeichen: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Ungültige Zeichen für Code 128 Set A."
  #DEFINE FBC_128B_01		"Ungültige Zeichen für Code 128 Set B."
  #DEFINE FBC_128C_01		"Code 128 Set C akzeptiert nur numerische Zeichen."
  #DEFINE FBC_39EXT_01		"Ungültige Zeichen für Code 39 Full ASCII."
  #DEFINE FBC_39_01			"Ungültige Zeichen für Code 39."
  #DEFINE FBC_93EXT_01		"Ungültige Zeichen für Code 93 Full ASCII."
  #DEFINE FBC_93_01			"Ungültige Zeichen für Code 93."
  #DEFINE FBC_ITF14_01		"Der ITF-14 Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_ITF14_02		"ITF-14: Die Länge der Zeichenkette muss 13 oder 14 sein."
  #DEFINE FBC_ITF14_03		"ITF-14: Die korrekte Prüfziffer ist "
  #DEFINE FBC_EAN13_01		"Der EAN-13 Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_EAN13_02		"Die Länge der Zeichenkette muss 12 oder 13 sein. Mit Zusatz zwischen 14 und 18."
  #DEFINE FBC_EAN13_03		"EAN-13: Die korrekte Prüfziffer ist "
  #DEFINE FBC_EAN8_01		"Der EAN-8 Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_EAN8_02		"EAN-8: Die Länge der Zeichenkette muss 7 oder 8 sein. Mit Zusatz zwischen 9 und 13."
  #DEFINE FBC_EAN8_03		"EAN-8: Die korrekte Prüfziffer ist "
  #DEFINE FBC_UPCA_01		"Der UPC-A Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_UPCA_02		"UPC-A: Die Länge der Zeichenkette muss 11 oder 12 sein. Mit Zusatz zwischen 13 und 17."
  #DEFINE FBC_UPCA_03		"UPC-A: Die korrekte Prüfziffer ist "
  #DEFINE FBC_UPCB_01		"Der UPC-E Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_UPCB_02		"UPC-E: Die Länge der Zeichenkette muss 6 oder 7 sein. Mit Zusatz zwischen 8 und 12."
  #DEFINE FBC_UPCB_03		"UPC-E: Die korrekte Prüfziffer ist "
  #DEFINE FBC_MSI_01		"Der MSI/Plessey Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_11_01			"Code 11 akzeptiert nur numerische Zeichen und - (Querstrich)."
  #DEFINE FBC_POSTNET_01	"Der PostNet Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_POSTNET_02	"PostNet: Die Länge der Zeichenkette muss 5, 9 oder 11 sein."
  #DEFINE FBC_IMB_01		"Der Intelligent Mail Barcode akzeptiert nur numerische Zeichen."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: Die Länge der Zeichenkette muss 5, 9 oder 11 sein."
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode wird sofort ..."
  #DEFINE FBC_TELEPEN_01	"Ungültige Zeichen für den Telepen Code."
  #DEFINE FBC_PHARMA1_01	"Der Pharmacode akzeptiert nur numerische Zeichen."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Eingabewerte zwischen 3 und 131070."
  #DEFINE FBC_PHARMA1_03	"Pharmacode akzeptiert nur numerische Zeichen."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Eingabewerte zwischen 4 und 64570080."
  #DEFINE FBC_SUPP5_01		"Der Supplemental 5 Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_SUPP2_01		"Der Supplemental 2 Code akzeptiert nur numerische Zeichen."
  #DEFINE FBC_EAN128_01		"Ungültige Zeichen für EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Ungültige Zeichen für Code RM4SCC."
  #DEFINE FBC_KIX_01		"Ungültige Zeichen für KIX-Code."

#ELIF FBC_LANGUAGE = "FILIPINO"
  *--------------------------------
  * FILIPINO LANGUAGE
  * Translate by Glenn Gevero
  *--------------------------------
  #DEFINE FBC_FBC_01		"Ang font o stilo ay hindi maaari sa GDI+"
  #DEFINE FBC_FBC_02		"Simbolo ng barcode ay hindi pa ipinatupad"
  #DEFINE FBC_FBC_03		"Ang text encoding ay blanko"
  #DEFINE FBC_I2O5_01		"Ang interleaved na 2 at 5 code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_S2O5_01		"Ang pamantayan na 2 at 5 code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_CODABAR_01	"Ang codabar code ay tumatangap lamang ng mga sumusunod na characters: 0123456789-$:/.+ "
  #DEFINE FBC_128A_01		"Hindi tama ang mga characters para sa code 128 Set A"
  #DEFINE FBC_128B_01		"Hindi tama ang mga characters para sa code 128 Set B"
  #DEFINE FBC_128C_01		"Ang code 128 Set C ay tumatanggap lamang ng mga sumusunod na characters"
  #DEFINE FBC_39EXT_01		"Hindi tama ang mga characters para sa Code 39 Full ASCII"
  #DEFINE FBC_39_01			"Hindi tama ang mga characters para sa Code 39"
  #DEFINE FBC_93EXT_01		"Hindi tama ang mga characters para sa Code 39 Full ASCII"
  #DEFINE FBC_93_01			"Hindi tama ang mga characters para sa Code 93"
  #DEFINE FBC_ITF14_01		"Ang ITF-14: code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_ITF14_02		"ITF-14: Ang haba ng string ay dapat 13 o 14"
  #DEFINE FBC_ITF14_03		"ITF-14: Ang tamang check digit ay"
  #DEFINE FBC_EAN13_01		"Ang EAN-13 code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_EAN13_02		"Ang haba ng string ay dapat 12 o 13. At may karagdagan sa pagitan ng 14 at 18"
  #DEFINE FBC_EAN13_03		"EAN-13: Ang tamang check digit ay"
  #DEFINE FBC_EAN8_01		"Ang EAN-8 ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_EAN8_02		"EAN-8: Ang haba ng string ay dapat 7 o 8. At may karagdagan sa pagitan ng 9 at 13"
  #DEFINE FBC_EAN8_03		"EAN-8: Ang correct check digit ay"
  #DEFINE FBC_UPCA_01		"Ang UPC-A code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_UPCA_02		"UPC-A: Ang haba ng string ay dapat 11 0 12. At may karagdagan sa pagitan ng 12 at 17"
  #DEFINE FBC_UPCA_03		"UPC-A: Ang tamang check digit ay"
  #DEFINE FBC_UPCB_01		"ANg UPC-E code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_UPCB_02		"UPC-E: Ang haba ng string ay dapat 6 o 7. AT may karagdagan sa pagitan ng 8 at 12"
  #DEFINE FBC_UPCB_03		"UPC-E: The correct check digit is " "UPC-E: Ang tamang check digit ay"
  #DEFINE FBC_MSI_01		"Ang MSI/Plessy code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_11_01			"Ang code 11 ay tumatanggap lamang ng mga numero at - (Dash)"
  #DEFINE FBC_POSTNET_01	"Ang PostNet code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_POSTNET_02	"PostNet: Ang haba ng string ay dapat 5,9,11"
  #DEFINE FBC_IMB_01		"Ang Intelligent Mail Barcode ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_IMB_02		"Intelligent mail Barcode: Ang haba ng string ay dapat 5,9,11"
  #DEFINE FBC_IMB_99		"Abangan ang Intelligent Mail Barcode"
  #DEFINE FBC_TELEPEN_01	"Hindi tama ang character para sa Telepen code"
  #DEFINE FBC_PHARMA1_01	"Ang Pharmacode ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Ang Input Values ay dapat sa pagitan ng 3 at 131070"
  #DEFINE FBC_PHARMA1_03	"Ang Pharmacode ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Ang input values ay dapat sa pagitan ng 3 at 64570080"
  #DEFINE FBC_SUPP5_01		"Ang Supplemental 5 code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_SUPP2_01		"Ang Supplemental 2 code ay tumatanggap lamang ng mga numero"
  #DEFINE FBC_EAN128_01		"Hindi tama ang mga characters para sa EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Hindi tama ang mga characters para sa Code RM4SCC"
  #DEFINE FBC_KIX_01		"Hindi tama ang mga characters para sa KIX-Code"

#ELIF FBC_LANGUAGE = "FRENCH"
  *--------------------------------
  * INDONESIAN FRENCH
  * Translate by Samir H.
  *--------------------------------
  #DEFINE FBC_FBC_01		"Police ou style n'est pas autorisé dans GDI+"
  #DEFINE FBC_FBC_02		"Cette symbologie n'est pas encore mise en œuvre."
  #DEFINE FBC_FBC_03		"Le texte à coder est vide."
  #DEFINE FBC_I2O5_01		"Le code Interleaved 2 of 5 n'accepte que des caractères numériques."
  #DEFINE FBC_S2O5_01		"Le code Standard 2 of 5 n'accepte que des caractères numériques."
  #DEFINE FBC_CODABAR_01	"Le code Codabar accepte uniquement les caractères suivants: 0123456789 -$:/.+"
  #DEFINE FBC_128A_01		"Caractères non valides pour le code Code 128 Set A."
  #DEFINE FBC_128B_01		"Caractères non valides pour le code Code 128 Set B."
  #DEFINE FBC_128C_01		"Le code Code 128 Set C n'accepte que des caractères numériques."
  #DEFINE FBC_39EXT_01		"Caractères non valides pour le code Code 39 Full ASCII."
  #DEFINE FBC_39_01			"Caractères non valides pour le code Code 39."
  #DEFINE FBC_93EXT_01		"Caractères non valides pour le code Code 93 Full ASCII."
  #DEFINE FBC_93_01			"Caractères non valides pour le code Code 93."
  #DEFINE FBC_ITF14_01		"Le code ITF-14 n'accepte que des caractères numériques."
  #DEFINE FBC_ITF14_02		"ITF-14: La longueur de la chaîne doit être de 13 ou 14."
  #DEFINE FBC_ITF14_03		"ITF-14: Le chiffre de contrôle correct est "
  #DEFINE FBC_EAN13_01		"Le code EAN-13 n'accepte que des caractères numériques."
  #DEFINE FBC_EAN13_02		"La longueur de la chaîne doit être de 12 ou 13. Avec supplément entre 14 et 18."
  #DEFINE FBC_EAN13_03		"EAN-13: Le chiffre de contrôle correct est "
  #DEFINE FBC_EAN8_01		"Le code EAN-8 n'accepte que des caractères numériques."
  #DEFINE FBC_EAN8_02		"EAN-8: La longueur de la chaîne doit être de 7 ou 8. Avec supplément entre 9 et 13."
  #DEFINE FBC_EAN8_03		"EAN-8: Le chiffre de contrôle correct est "
  #DEFINE FBC_UPCA_01		"Le code UPC-A n'accepte que des caractères numériques."
  #DEFINE FBC_UPCA_02		"UPC-A: La longueur de la chaîne doit être de 11 ou 12. Avec supplément entre 13 et 17."
  #DEFINE FBC_UPCA_03		"UPC-A: Le chiffre de contrôle correct est "
  #DEFINE FBC_UPCB_01		"Le code UPC-E n'accepte que des caractères numériques."
  #DEFINE FBC_UPCB_02		"UPC-E: La longueur de la chaîne doit être de 6 ou 7. Avec supplément entre 8 et 12."
  #DEFINE FBC_UPCB_03		"UPC-E: Le chiffre de contrôle correct est "
  #DEFINE FBC_MSI_01		"Le code MSI/Plessey n'accepte que des caractères numériques."
  #DEFINE FBC_11_01			"Le code Code 11 n'accepte que des caractères numériques et - (Tiret)."
  #DEFINE FBC_POSTNET_01	"Le code PostNet n'accepte que des caractères numériques."
  #DEFINE FBC_POSTNET_02	"PostNet: La longueur de la chaîne doit être de 5, 9, ou 11"
  #DEFINE FBC_IMB_01		"Le code Intelligent Mail Barcode n'accepte que des caractères numériques."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: La longueur de la chaîne doit être de 5, 9, ou 11"
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode bientôt..."
  #DEFINE FBC_TELEPEN_01	"Caractère non valide pour le code Telepen."
  #DEFINE FBC_PHARMA1_01	"Le code Pharmacode n'accepte que des caractères numériques."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Valeurs d'entrée entre 3 et 131070."
  #DEFINE FBC_PHARMA1_03	"Le code Pharmacode n'accepte que des caractères numériques."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Valeurs d'entrée entre 4 et 64570080."
  #DEFINE FBC_SUPP5_01		"Le code Supplemental 5 n'accepte que des caractères numériques."
  #DEFINE FBC_SUPP2_01		"Le code Supplemental 2 n'accepte que des caractères numériques."
  #DEFINE FBC_EAN128_01		"Caractères non valides pour le code EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Caractères non valides pour le code Code RM4SCC."
  #DEFINE FBC_KIX_01		"Caractères non valides pour le code KIX-Code."

#ELIF FBC_LANGUAGE = "SERBIAN"
  *--------------------------------
  * SERBIAN LANGUAGE
  * Translate by Michael Kopljan
  *--------------------------------
  #DEFINE FBC_FBC_01		"Font ili stil nije dozvoljen u GDI+."
  #DEFINE FBC_FBC_02		"Tip barkoda nije implementiran."
  #DEFINE FBC_FBC_03		"Nepostojanje texta koji treba da se enkoduje."
  #DEFINE FBC_I2O5_01		"Interleaved 2 od 5 barkod prihvata samo numerièke podatke."
  #DEFINE FBC_S2O5_01		"Standard 2 od 5 barkod prihvata samo numerièke podatke."
  #DEFINE FBC_CODABAR_01	"Codabar barkod prihvata samo sledeæe karaktere: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Postojanje nedozvoljenih karaktera za barkod Code 128 Set A."
  #DEFINE FBC_128B_01		"Postojanje nedozvoljenih karaktera za barkod Code 128 Set B."
  #DEFINE FBC_128C_01		"Barkod Code 128 Set C prihvata samo numerièke znakove."
  #DEFINE FBC_39EXT_01		"Nedozvoljeni karakter za barkod Code 39 pun ASCII."
  #DEFINE FBC_39_01			"Nedozvoljeni karakteri za barkod Code 39."
  #DEFINE FBC_93EXT_01		"Nedozvoljeni karakter za barkod Code 93 pun ASCII."
  #DEFINE FBC_93_01			"Nedozvoljeni karakteri za barkod Code 93."
  #DEFINE FBC_ITF14_01		"ITF-14 barkod prihvata samo numerièke znakove."
  #DEFINE FBC_ITF14_02		"ITF-14: dužina stringa mora biti 13 ili 14 znakova."
  #DEFINE FBC_ITF14_03		"ITF-14: taèna kotrolna cifra je "
  #DEFINE FBC_EAN13_01		"EAN-13 barkod prihvata samo numerièke znakove."
  #DEFINE FBC_EAN13_02		"Dužina stringa mora biti 12 ili 13 znakova. Sa dodatkom izmeðu 14 i 18."
  #DEFINE FBC_EAN13_03		"EAN-13: taèna kotrolna cifra je "
  #DEFINE FBC_EAN8_01		"The EAN-8 barkod prihvata samo numerièke znakove."
  #DEFINE FBC_EAN8_02		"EAN-8: Dužina stringa mora biti 7 ili 8 znakova. Sa dodatkom izmeðu 9 i 13."
  #DEFINE FBC_EAN8_03		"EAN-8: taèna kotrolna cifra je "
  #DEFINE FBC_UPCA_01		"UPC-A barkod prihvata samo numerièke znakove."
  #DEFINE FBC_UPCA_02		"UPC-A: Dužina stringa mora biti 11 ili 12 znakova. Sa dodatkom izmeðu 13 i 17."
  #DEFINE FBC_UPCA_03		"UPC-A: taèna kotrolna cifra je "
  #DEFINE FBC_UPCB_01		"UPC-E barkod prihvata samo numerièke znakove."
  #DEFINE FBC_UPCB_02		"UPC-E: Dužina stringa mora biti 6 or 7 znakova. Sa dodatkom izmeðu 8 i 12."
  #DEFINE FBC_UPCB_03		"UPC-E: taèna kotrolna cifra je "
  #DEFINE FBC_MSI_01		"MSI/Plessey barkod prihvata samo numerièke znakove."
  #DEFINE FBC_11_01			"Code 11 barkod prihvata samo numerièke znakove i - (crtu)."
  #DEFINE FBC_POSTNET_01	"PostNet barkod prihvata samo numerièke znakove."
  #DEFINE FBC_POSTNET_02	"PostNet: Dužina stringa mora biti 5,9,11 znakova"
  #DEFINE FBC_IMB_01		"Intelligent Mail barkod prihvata samo numerièke znakove."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: Dužina stringa mora biti 5,9,11"
  #DEFINE FBC_IMB_99		"Intelligent Mail barkod uskoro ..."
  #DEFINE FBC_TELEPEN_01	"Nedozvoljeni karakter za barkod Telepen."
  #DEFINE FBC_PHARMA1_01	"Pharmacode barkod prihvata samo numerièke znakove."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Unesite vrednosti izmeðu 3 i 131070."
  #DEFINE FBC_PHARMA1_03	"Pharmacode barkod prihvata samo numerièke znakove."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Unesite vrednosti izmeðu 4 i 64570080."
  #DEFINE FBC_SUPP5_01		"Supplemental 5 barkod prihvata samo numerièke znakove."
  #DEFINE FBC_SUPP2_01		"Supplemental 2 barkod prihvata samo numerièke znakove."
  #DEFINE FBC_EAN128_01		"Nedozvoljeni karakteri za barkod EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Nedozvoljeni karakter za barkod Code RM4SCC."
  #DEFINE FBC_KIX_01		"Nedozvoljeni karakteri za barkod KIX-Code."

#ELSE
  *--------------------------------
  * ENGLISH LANGUAGE BY DEFAULT
  * Translate by VFPEncoding
  *--------------------------------
  #DEFINE FBC_FBC_01		"Font or style is not allowed in GDI+"
  #DEFINE FBC_FBC_02		"Barcode symbology not implemented."
  #DEFINE FBC_FBC_03		"The text encoding is blank."
  #DEFINE FBC_I2O5_01		"The Interleaved 2 of 5 code accepts only numeric characters."
  #DEFINE FBC_S2O5_01		"The Standard 2 of 5 code accepts only numeric characters."
  #DEFINE FBC_CODABAR_01	"Codabar code only accepts the following characters: 0123456789-$:/.+"
  #DEFINE FBC_128A_01		"Invalid characters for Code 128 Set A."
  #DEFINE FBC_128B_01		"Invalid characters for Code 128 Set B."
  #DEFINE FBC_128C_01		"The Code 128 Set C accepts only numeric characters."
  #DEFINE FBC_39EXT_01		"Invalid character for Code 39 Full ASCII."
  #DEFINE FBC_39_01			"Invalid characters for Code 39."
  #DEFINE FBC_93EXT_01		"Invalid character for Code 93 Full ASCII."
  #DEFINE FBC_93_01			"Invalid characters for Code 93."
  #DEFINE FBC_ITF14_01		"The ITF-14 code accepts only numeric characters."
  #DEFINE FBC_ITF14_02		"ITF-14: The length of the string must be 13 or 14."
  #DEFINE FBC_ITF14_03		"ITF-14: The correct check digit is "
  #DEFINE FBC_EAN13_01		"The EAN-13 code accepts only numeric characters."
  #DEFINE FBC_EAN13_02		"The length of the string must be 12 or 13. With supplement between 14 and 18."
  #DEFINE FBC_EAN13_03		"EAN-13: The correct check digit is "
  #DEFINE FBC_EAN8_01		"The EAN-8 code accepts only numeric characters."
  #DEFINE FBC_EAN8_02		"EAN-8: The length of the string must be 7 or 8. With supplement between 9 and 13."
  #DEFINE FBC_EAN8_03		"EAN-8: The correct check digit is "
  #DEFINE FBC_UPCA_01		"The UPC-A code accepts only numeric characters."
  #DEFINE FBC_UPCA_02		"UPC-A: The length of the string must be 11 or 12. With supplement between 13 and 17."
  #DEFINE FBC_UPCA_03		"UPC-A: The correct check digit is "
  #DEFINE FBC_UPCB_01		"The UPC-E code accepts only numeric characters."
  #DEFINE FBC_UPCB_02		"UPC-E: The length of the string must be 6 or 7. With supplement between 8 and 12."
  #DEFINE FBC_UPCB_03		"UPC-E: The correct check digit is "
  #DEFINE FBC_MSI_01		"The MSI/Plessey code accepts only numeric characters."
  #DEFINE FBC_11_01			"The Code 11 accepts only numeric characters and - (Dash)."
  #DEFINE FBC_POSTNET_01	"The PostNet code accepts only numeric characters."
  #DEFINE FBC_POSTNET_02	"PostNet: The length of the string must be 5,9,11"
  #DEFINE FBC_IMB_01		"The Intelligent Mail Barcode accepts only numeric characters."
  #DEFINE FBC_IMB_02		"Intelligent Mail Barcode: The length of the string must be 5, 9 or 11"
  #DEFINE FBC_IMB_99		"Intelligent Mail Barcode soon ..."
  #DEFINE FBC_TELEPEN_01	"Invalid character for Telepen code."
  #DEFINE FBC_PHARMA1_01	"The Pharmacode accepts only numeric characters."
  #DEFINE FBC_PHARMA1_02	"Pharmacode: Input values between 3 and 131070."
  #DEFINE FBC_PHARMA1_03	"The Pharmacode accepts only numeric characters."
  #DEFINE FBC_PHARMA2_01	"Two Track Pharmacode: Input values between 4 and 64570080."
  #DEFINE FBC_SUPP5_01		"The Supplemental 5 code accepts only numeric characters."
  #DEFINE FBC_SUPP2_01		"The Supplemental 2 code accepts only numeric characters."
  #DEFINE FBC_EAN128_01		"Invalid characters for EAN/UCC/GS1 128."
  #DEFINE FBC_RM4SCC_01		"Invalid character for Code RM4SCC"
  #DEFINE FBC_KIX_01		"Invalid character for KIX-Code"

#ENDIF

*--------------------------------------------------------------------------------------
* FoxBarcode Symbologies List
*--------------------------------------------------------------------------------------
#DEFINE FBC_CODE_128		110 && Code 128 (Sets A, B and C)
#DEFINE FBC_CODE_39			120 && Code 39
#DEFINE FBC_CODE_39EXT		121 && Code 39 Extended or Full ASCII
#DEFINE FBC_CODE_93			122 && Code 93
#DEFINE FBC_CODE_93EXT		123 && Code 93 Extended or Full ASCII
#DEFINE FBC_CODE_S2OF5		131 && Standard 2 of 5
#DEFINE FBC_CODE_I2OF5		132 && Interleaved 2 of 5
#DEFINE FBC_CODE_EAN8		150 && EAN-8
#DEFINE FBC_CODE_EAN13		151 && EAN-13
#DEFINE FBC_CODE_ITF14		152 && ITF-14
#DEFINE FBC_CODE_EAN14		152 && EAN-14
#DEFINE FBC_CODE_DUN14		152 && DUN-14
#DEFINE FBC_CODE_EAN128		159 && EAN-128
#DEFINE FBC_CODE_UCC128		159 && UCC-128
#DEFINE FBC_CODE_GS1128		159 && GS1-128
#DEFINE FBC_CODE_UPCE		160 && UPC-E
#DEFINE FBC_CODE_UPCA		161 && UPC-A
#DEFINE FBC_CODE_CODABAR	170 && Codabar
#DEFINE FBC_CODE_11			171 && Code 11
#DEFINE FBC_CODE_MSI		172 && MSI/Plessey
#DEFINE FBC_CODE_TELEPEN	173 && Telepen
#DEFINE FBC_CODE_PHARMA1	174 && One Track Pharmacode
#DEFINE FBC_CODE_PHARMA2	175 && Two Track Pharmacode
#DEFINE FBC_CODE_POSTNET	180 && PostNet (U.S. Postal Service)
#DEFINE FBC_CODE_IMB		181 && Intelligent Mail Barcode (U.S. Postal Service)
#DEFINE FBC_CODE_RM4SCC		182	&& RM4SCC (Royal Mail)
#DEFINE FBC_CODE_KIX		183 && KIX Code (Dutch Postal)

*--------------------------------------------------------------------------------------
* FoxBarcode Class Definition
*--------------------------------------------------------------------------------------
DEFINE CLASS FoxBarcode AS CUSTOM

  *--- Internal use
  PROTECTED cPattern, nLenPattern, nTextHeight, nFontHeight, cFontStyle
  PROTECTED nBarWidth, nQuietZone
  PROTECTED nImageWidth
  PROTECTED cCheckDigit, cTextValue
  PROTECTED oGdi, oImg, oGra

  *-- Properties
  cText = "" && Text to encode
  cTextValue = "" && Value of the text ready for encoding.

  *-- Barcode symbologies
  nBarcodeType = FBC_CODE_128 && Barcode type. See "FoxBarcode Symbologies List"
  nFactor = 1 && Barcode size [1..9]
  nQuietZone = 10 && Quit zone in pixels
  nBarWidth = 0 && Bar width
  nMargin = 0 && Margin around the barcode

  *-- Only some barcode specific symbologies
  nRatio = 3 && Ratio between the narrow bar and the wide bar
  lAddCheckDigit = .T. && Calculate check digit
  cSet128 = "B" && Set Code 128
  nBearerBar = 1 && 0=None, 1=Rectangle, 2=Top and Bottom - Only ITF-14
  nBearerBarWidth = 0 && In pixels
  cSupplementalText = "" && EAN and UPC code supplemental text
  lUseAppId = .T. && Use Application Identifiers. Only EAN/UCC/GS1 128

  *-- Barcode image
  nImageHeight = 100 && in pixels
  nImageWidth = 0 && in pixels
  nRotation = 0 && Image rotation [0=0°, 1=90°, 2=180°, 3=270°]
  nResolution = 300 && Dpi
  cImageType = "JPG"  && Image type ["JPG", "GIF", "PNG", "BMP", "TIF"]
  cImageFile = "" && Image file name, if empty autogenerate file name

  *-- Human-readable text
  cHumanReadableText = "" && Human-readable text to display
  cCheckDigit = "" && Check digit in human readable
  lShowCheckDigit = .T. && Show check digit in human readable text
  lShowStartStopChars = .T. && Show start and stop characters in human readable text
  lShowHumanReadableText = .T. && Shows the human-readable text
  nAlignText = 1 && [0=Left, 1=Center, 2=Right]
  nTextHeight = 14.500  && Text height
  nFontSize = 8.500 && Real font size
  nFontHeight = 2.833  && Size according to factor
  cFontName = "Arial" && Font name
  cFontStyle = "N" && Font Style
  lFontBold = .F. && Font bold
  lFontItalic = .F. && Fon italic

  *-- Colours
  nBackColor = RGB(255,255,255) && Background color image (recommend White)
  nBarsColor = RGB(0,0,0) && Bars Colors (recommend Black)
  nFontColor = RGB(0,0,0) && Font color (recommend Black)

  *-- Internal use
  cPattern = "" && Encoded string
  nLenPattern = 0 && Encoded string Lenght
  cMsgError = "" && Error message
  cTempPath = "" && Windows temp folder + SYS(2015)

  *--- gpImage object
  oGdi = NULL && Object Gdi
  oImg = NULL && Object Image
  oGra = NULL && Object Graphic

  *------------------------------------------------------
  * PROCEDURE BarcodePattern()
  *------------------------------------------------------
  * Generates the barcode pattern according to the type
  *------------------------------------------------------
  PROCEDURE BarcodePattern()

    THIS.cMsgError = ""

    *-- Validates that the font and style are permitted by GDI+
    IF THIS.lShowHumanReadableText AND ;
        NOT THIS.IsFontTrueType(THIS.cFontName) AND ;
        NOT THIS.IsGdipFont(THIS.cFontName, THIS.cFontStyle)
      THIS.cMsgError = FBC_FBC_01
      THIS.cPattern = NULL
      RETURN THIS.cPattern
    ENDIF

    IF NOT EMPTY(THIS.cTextValue)

      DO CASE
        CASE THIS.nBarcodeType = FBC_CODE_128 && Code 128
          THIS.cPattern = THIS.Code_128()

        CASE THIS.nBarcodeType = FBC_CODE_39 && Code 39
          THIS.cPattern = THIS.Code_39()

        CASE THIS.nBarcodeType = FBC_CODE_39EXT && Code 39 Estended or ASCII Full
          THIS.cPattern = THIS.Code_39Ext()

        CASE THIS.nBarcodeType = FBC_CODE_93 && Code 93
          THIS.cPattern = THIS.Code_93()

        CASE THIS.nBarcodeType = FBC_CODE_93EXT && Code 93 Extended or Full ASCII
          THIS.cPattern = THIS.Code_93Ext()

        CASE THIS.nBarcodeType = FBC_CODE_S2OF5 && Standard 2 of 5
          THIS.cPattern = THIS.Code_S2of5()

        CASE THIS.nBarcodeType = FBC_CODE_I2OF5 && Interleaved 2 of 5
          THIS.cPattern = THIS.Code_I2of5()

        CASE THIS.nBarcodeType = FBC_CODE_ITF14 && ITF-14
          THIS.cPattern = THIS.Code_Itf14()

        CASE THIS.nBarcodeType = FBC_CODE_EAN13 && EAN-13
          THIS.cPattern = THIS.Code_Ean13()

        CASE THIS.nBarcodeType = FBC_CODE_EAN8 && EAN-8
          THIS.cPattern = THIS.Code_Ean8()

        CASE THIS.nBarcodeType = FBC_CODE_EAN128 && EAN-128
          THIS.cPattern = THIS.Code_Ean128()

        CASE THIS.nBarcodeType = FBC_CODE_UPCA && UPC-A
          THIS.cPattern = THIS.Code_UpcA()

        CASE THIS.nBarcodeType = FBC_CODE_UPCE && UPC-E
          THIS.cPattern = THIS.Code_UpcE()

        CASE THIS.nBarcodeType = FBC_CODE_CODABAR && Codabar
          THIS.cPattern = THIS.Code_Codabar()

        CASE THIS.nBarcodeType = FBC_CODE_11 && Code 11
          THIS.cPattern = THIS.Code_11()

        CASE THIS.nBarcodeType = FBC_CODE_MSI && Plessey
          THIS.cPattern = THIS.Code_MSIPlessey()

        CASE THIS.nBarcodeType = FBC_CODE_TELEPEN && Telepen
          THIS.cPattern = THIS.Code_Telepen()

        CASE THIS.nBarcodeType = FBC_CODE_PHARMA1 && One Track Pharmacode
          THIS.cPattern = THIS.Code_Pharmacode1()

        CASE THIS.nBarcodeType = FBC_CODE_PHARMA2 && Two Track Pharmacode
          THIS.cPattern = THIS.Code_Pharmacode2()

        CASE THIS.nBarcodeType = FBC_CODE_POSTNET && PostNet
          THIS.cPattern = THIS.Code_PostNet()

        CASE THIS.nBarcodeType = FBC_CODE_IMB && Intelligent Mail Barcode
          THIS.cPattern = THIS.Code_IMB()

        CASE THIS.nBarcodeType = FBC_CODE_RM4SCC && RM4SCC (Royal Mail)
          THIS.cPattern = THIS.Code_RM4SCC()

        CASE THIS.nBarcodeType = FBC_CODE_KIX && KIX-Code (Dutch Postal)
          THIS.cPattern = THIS.Code_KIX()

        OTHERWISE
          THIS.cPattern = NULL
          THIS.cMsgError = FBC_FBC_02
      ENDCASE

    ELSE && NOT EMPTY(THIS.cTextValue)

      THIS.cPattern = NULL
      THIS.cMsgError = FBC_FBC_03

    ENDIF && NOT EMPTY(THIS.cTextValue)

    IF ISNULL(THIS.cPattern)
      *-- Not generated the Pattern string
      RETURN THIS.cPattern
    ENDIF && ISNULL(THIS.cPattern)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE BarcodeImage(tcValue, tcImageFile, tcSuperPro)
  *------------------------------------------------------
  * Generated barcode image with GPIMAGE class
  *------------------------------------------------------
  PROCEDURE BarcodeImage(tcValue, tcImageFile, tcSuperPro)

    LOCAL ARRAY laSuperPro(1)
    LOCAL lcProper, lnCon

    *-- Properties in 3rd. parameter
    IF NOT EMPTY(tcSuperPro)
      THIS.ResetProperties()
      tcSuperPro = ALLTRIM(CHRTRAN(tcSuperPro, ",", CHR(13)))
      ALINES(laSuperPro, tcSuperPro)
      FOR lnCon = 1 TO ALEN(laSuperPro)
        lcProper = "THIS."+SUBSTR(laSuperPro(lnCon), 1, AT("=", laSuperPro[lnCon]) - 1)
        IF TYPE(lcProper) # "U"
          laSuperPro(lnCon) = "THIS."+laSuperPro(lnCon)
          &laSuperPro[lnCon]
        ENDIF
      ENDFOR
      IF NOT EMPTY(THIS.cText)
        tcValue = THIS.cText
      ENDIF
    ENDIF

    IF EMPTY(tcValue)
      tcValue = THIS.cText
    ENDIF

    STORE tcValue TO THIS.cText, THIS.cTextValue, THIS.cHumanReadableText

    *--- Generates the pattern
    THIS.BarcodePattern()

    *-- GPIMAGE
    THIS.oGdi = CREATEOBJECT("gpInit")
    THIS.oImg = CREATEOBJECT("gpImage2")

    *--- Invalid Propeties / Code / Font / Style
    IF ISNULL(THIS.cPattern)

      LOCAL lnFontHeight, lcDisplayFontName, laListFontName(10), ln
      *-- Create an error message image
      THIS.nImageWidth = THIS.nImageHeight * 2.5  && 1.5
      THIS.oImg.CREATE(THIS.nImageWidth, THIS.nImageHeight)
      THIS.oImg.HorizontalResolution = THIS.nResolution
      THIS.oImg.VerticalResolution = THIS.nResolution
      THIS.oGra = CREATEOBJECT("Graphics",THIS.oImg.GetImage())
      THIS.oGra.SetBrush(THIS.nBackColor)
      THIS.oGra.SetRect(0,0,THIS.nImageWidth, THIS.nImageHeight)
      THIS.oGra.FillRect(0,0,THIS.nImageWidth, THIS.nImageHeight)
      THIS.oGra.SetAlignment(1,1,0)
      THIS.oGra.SetBrush(THIS.nFontColor)
      lnFontHeight = (THIS.nFontSize * 1.25) / THIS.nResolution * 100
      *-- Use a valid Gdi+ Font
      laListFontName(1) = "Courier New"
      laListFontName(2) = "Times New Roman"
      laListFontName(3) = "MS Sans Serif"
      laListFontName(4) = "Tahoma"
      laListFontName(5) = "Verdana"
      laListFontName(6) = "Comic Sans MS"
      laListFontName(7) = "Trebuchet MS"
      laListFontName(8) = "Arial"
      laListFontName(9) = "Georgia"
      laListFontName(10) = "Segoe UI"
      FOR ln = 1 TO 10
        IF THIS.IsFontTrueType(laListFontName(ln)) AND THIS.IsGdipFont(laListFontName(ln),"N")
          lcDisplayFontName = laListFontName(ln)
          EXIT
        ENDIF
      ENDFOR
      THIS.oGra.DrawString(THIS.cMsgError, lcDisplayFontName, lnFontHeight, "N")
      THIS.oGra.SetPen(THIS.nBarsColor, 1)
      THIS.oGra.DrawRect(0, 0, THIS.nImageWidth - 1, THIS.nImageHeight - 1)

    ELSE && ISNULL(THIS.cPattern)

      *-- Barcode + BearerBar + Human Readable + QuietZone + Supplemental
      THIS.nBearerBarWidth = IIF(THIS.nBarcodeType = FBC_CODE_ITF14 AND THIS.nBearerBar # 0, CEILING(THIS.nQuietZone / 4 * THIS.nFactor) , 0) && Bearer Bar Width
      THIS.cPattern = REPLICATE( "@", THIS.nBearerBarWidth * 2) + REPLICATE( "@", THIS.nQuietZone) + THIS.cPattern + REPLICATE( "@", THIS.nQuietZone) + REPLICATE( "@", THIS.nBearerBarWidth * 2)
      THIS.nLenPattern = LEN(THIS.cPattern)

      *-- Image Size
      THIS.nImageWidth = (THIS.nMargin * 2 ) + (THIS.nLenPattern * THIS.nFactor)

      *-- Create image
      THIS.oImg.CREATE(THIS.nImageWidth,THIS.nImageHeight)
      THIS.oImg.HorizontalResolution = THIS.nResolution
      THIS.oImg.VerticalResolution = THIS.nResolution
      THIS.oGra = CREATEOBJECT("Graphics",THIS.oImg.GetImage())
      THIS.oGra.SetBrush(THIS.nBackColor)
      THIS.oGra.FillRect(0,0,THIS.nImageWidth,THIS.nImageHeight)
      THIS.oGra.SetPen(THIS.nBarsColor, THIS.nFactor)

      LOCAL lnHRH && Human Readable Height

      IF THIS.lShowHumanReadableText
        lnHRH = THIS.nImageHeight - THIS.nTextHeight
      ELSE
        lnHRH = THIS.nImageHeight
      ENDIF

      LOCAL ln, lnCol

      *-- Barcode types
      DO CASE
        CASE THIS.nBarcodeType = FBC_CODE_POSTNET && PostNet
          FOR ln = 1 TO THIS.nLenPattern
            lnCol = ln - 1
            DO CASE
              CASE SUBSTR(THIS.cPattern, ln, 1) == "2"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor  + THIS.nMargin,  THIS.nMargin, lnCol * THIS.nFactor  + THIS.nMargin, lnHRH - THIS.nMargin )
              CASE SUBSTR(THIS.cPattern, ln, 1) == "1"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, lnHRH/1.90, lnCol * THIS.nFactor + THIS.nMargin, CEILING(lnHRH - THIS.nMargin))
            ENDCASE
          ENDFOR

        CASE THIS.nBarcodeType = FBC_CODE_IMB ; && Intelligent Mail Barcode
          OR THIS.nBarcodeType = FBC_CODE_KIX ; && KIX-Code
          OR THIS.nBarcodeType = FBC_CODE_RM4SCC  && RM4SCC

          FOR ln = 1 TO THIS.nLenPattern
            lnCol = ln - 1
            LOCAL lnFull
            lnFull = lnHRH - 2 * THIS.nMargin
            DO CASE
              CASE SUBSTR(THIS.cPattern, ln, 1) == "A" && Asc
                THIS.oGra.DrawLine(lnCol * THIS.nFactor  + THIS.nMargin, THIS.nMargin, lnCol * THIS.nFactor  + THIS.nMargin, THIS.nMargin + lnFull * .66 )
              CASE SUBSTR(THIS.cPattern, ln, 1) == "D" && Desc
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin + lnFull * .33, lnCol * THIS.nFactor + THIS.nMargin, lnHRH - THIS.nMargin)
              CASE SUBSTR(THIS.cPattern, ln, 1) == "T" && Togle
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin + lnFull * .33, lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin + lnFull * .66)
              CASE SUBSTR(THIS.cPattern, ln, 1) == "F" && Full
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, lnHRH - THIS.nMargin)
            ENDCASE
          ENDFOR

        CASE THIS.nBarcodeType = FBC_CODE_PHARMA2 && Two Track Pharmacode
          LOCAL lnBarFull
          lnBarFull = lnHRH - THIS.nMargin

          FOR ln = 1 TO THIS.nLenPattern
            lnCol = ln - 1
            DO CASE
              CASE SUBSTR(THIS.cPattern, ln, 1) == "A"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor  + THIS.nMargin,  THIS.nMargin, lnCol * THIS.nFactor  + THIS.nMargin, (lnBarFull + THIS.nMargin) / 2)
              CASE SUBSTR(THIS.cPattern, ln, 1) == "D"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, (THIS.nMargin + lnBarFull) / 2, lnCol * THIS.nFactor + THIS.nMargin, lnBarFull)
              CASE SUBSTR(THIS.cPattern, ln, 1) == "F"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, lnBarFull)
              OTHERWISE
                * Space
            ENDCASE
          ENDFOR

        OTHERWISE && Rest of bar codes
          FOR ln = 1 TO THIS.nLenPattern
            lnCol = ln - 1
            IF SUBSTR(THIS.cPattern, ln, 1) == "1"
              THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, lnHRH - THIS.nMargin)
            ENDIF
          ENDFOR
      ENDCASE

      IF THIS.lShowHumanReadableText

        LOCAL lnLeft, lnRigth, lnTextMargin, lcBin
        *-- Clear zone
        lnTextMargin = (THIS.nBearerBarWidth + THIS.nQuietZone - 2) * THIS.nFactor + THIS.nMargin
        THIS.oGra.SetBrush(THIS.nBackColor)
        THIS.oGra.SetRect(lnTextMargin, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, THIS.nImageWidth - lnTextMargin * 2, THIS.nTextHeight)
        THIS.oGra.FillRect(lnTextMargin, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, THIS.nImageWidth - lnTextMargin * 2, THIS.nTextHeight)

        DO CASE
          CASE THIS.nBarcodeType = FBC_CODE_EAN13 && EAN-13
            *-- 1st. digit
            lnLeft = THIS.nMargin - (2 * THIS.nFactor)
            lnRight = (THIS.nQuietZone * THIS.nFactor)
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,1,1), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 2nd to 7th digit
            lnLeft = THIS.nQuietZone * THIS.nFactor + THIS.nMargin
            lnRight = 48 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,2,6), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 8th to 13th digit
            lnLeft = ((THIS.nQuietZone + 46) * THIS.nFactor) + THIS.nMargin
            lnRight = 48 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,8,6), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)

            *-- Supplemental
            IF NOT EMPTY(THIS.cSupplementalText)
              lnLeft = (((2 * THIS.nQuietZone) + 91) * THIS.nFactor) + THIS.nMargin
              lnRight = (LEN(THIS.cSupplementalText) + 1) * 9 * THIS.nFactor
              THIS.oGra.SetBrush(THIS.nBackColor)
              THIS.oGra.SetRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.FillRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.SetAlignment(1 , 1, 0)
              THIS.oGra.SetBrush(THIS.nFontColor)
              THIS.oGra.DrawString(THIS.cSupplementalText, THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            ENDIF

            *-- Redraw lines
            lcBin = REPLICATE( "0", THIS.nQuietZone) + "101" + REPLICATE("0", 6*7) + "01010" +  REPLICATE("0", 6*7) + "101" + REPLICATE( "0", THIS.nQuietZone)
            FOR ln = 1 TO LEN(lcBin)
              lnCol = ln - 1
              IF SUBSTR(lcBin, ln, 1) = "1"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight - THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight/2 - THIS.nMargin - 2)
              ENDIF
            ENDFOR

          CASE THIS.nBarcodeType = FBC_CODE_EAN8 && EAN-8
            *-- 1st to 4th digit
            lnLeft = THIS.nQuietZone * THIS.nFactor + THIS.nMargin
            lnRight = 34 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,1,4), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 5th to 8th digit
            lnLeft = ((THIS.nQuietZone + 32) * THIS.nFactor) + THIS.nMargin + 1
            lnRight = 34 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,5,4), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)

            *-- Supplemental
            IF NOT EMPTY(THIS.cSupplementalText)
              lnLeft = (((2 * THIS.nQuietZone) + 64) * THIS.nFactor) + THIS.nMargin
              lnRight = (LEN(THIS.cSupplementalText) + 1) * 9 * THIS.nFactor
              THIS.oGra.SetBrush(THIS.nBackColor)
              THIS.oGra.SetRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.FillRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.SetAlignment(1 , 1, 0)
              THIS.oGra.SetBrush(THIS.nFontColor)
              THIS.oGra.DrawString(THIS.cSupplementalText, THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            ENDIF

            *-- Redraw lines
            lcBin = REPLICATE( "0", THIS.nQuietZone) + "101" + REPLICATE("0", 4*7) + "01010" +  REPLICATE("0", 4*7) + "101" + REPLICATE( "0", THIS.nQuietZone)
            FOR ln = 1 TO LEN(lcBin)
              lnCol = ln - 1
              IF SUBSTR(lcBin, ln, 1) = "1"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight - THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight/2 - THIS.nMargin - 2)
              ENDIF
            ENDFOR

          CASE THIS.nBarcodeType = FBC_CODE_UPCA && UPC-A
            *-- 1st. digit
            lnLeft = THIS.nMargin
            lnRight = (THIS.nQuietZone * THIS.nFactor)
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,1,1), THIS.cFontName, THIS.nFontHeight * 0.85, THIS.cFontStyle)
            *-- 2nd to 6th digit
            lnLeft = (THIS.nQuietZone + 5) * THIS.nFactor + THIS.nMargin
            lnRight = (44) * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,2,5), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 7th to 12th digit
            lnLeft = ((THIS.nQuietZone + 45) * THIS.nFactor) + THIS.nMargin
            lnRight = 44 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,7,5), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 12st. digit
            lnLeft = (103 * THIS.nFactor) + THIS.nMargin
            lnRight = THIS.nQuietZone * THIS.nFactor + (4 * THIS.nFactor)
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,12,1), THIS.cFontName, THIS.nFontHeight * 0.85, THIS.cFontStyle)

            *-- Supplemental
            IF NOT EMPTY(THIS.cSupplementalText)
              lnLeft = (((2 * THIS.nQuietZone) + 92) * THIS.nFactor) + THIS.nMargin
              lnRight = (LEN(THIS.cSupplementalText) + 1) * 9 * THIS.nFactor
              THIS.oGra.SetBrush(THIS.nBackColor)
              THIS.oGra.SetRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.FillRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.SetAlignment(1 , 1, 0)
              THIS.oGra.SetBrush(THIS.nFontColor)
              THIS.oGra.DrawString(THIS.cSupplementalText, THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            ENDIF

            *-- Redraw lines
            lcBin = LEFT(THIS.cPattern, THIS.nQuietZone + 3 + 7) + REPLICATE("0", 5 * 7) + "01010" +  REPLICATE("0", 5 * 7) + SUBSTR(THIS.cPattern, THIS.nQuietZone + 3 + 5 + (11 * 7) + 1, 7 + 3 + 1)
            FOR ln = 1 TO LEN(lcBin)
              lnCol = ln - 1
              IF SUBSTR(lcBin, ln, 1) = "1"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight - THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight/2 - THIS.nMargin - 2)
              ENDIF
            ENDFOR

          CASE THIS.nBarcodeType = FBC_CODE_UPCE && UPC-E
            *-- 1st. digit
            lnLeft = THIS.nMargin
            lnRight = (THIS.nQuietZone * THIS.nFactor)
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,1,1), THIS.cFontName, THIS.nFontHeight * 0.85, THIS.cFontStyle)
            *-- 2nd to 6th digit
            lnLeft = ((THIS.nQuietZone) * THIS.nFactor) + THIS.nMargin - 1
            lnRight = 48 * THIS.nFactor
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,2,6), THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            *-- 8th. digit
            lnLeft = (60 * THIS.nFactor) + THIS.nMargin - (1 * THIS.nFactor)
            lnRight = (THIS.nQuietZone * THIS.nFactor) + (4 * THIS.nFactor)
            THIS.oGra.SetBrush(THIS.nBackColor)
            THIS.oGra.SetRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.FillRect(lnLeft, THIS.nImageHeight - THIS.nTextHeight - THIS.nMargin, lnRight, THIS.nTextHeight)
            THIS.oGra.SetAlignment(1 , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(SUBSTR(THIS.cHumanReadableText,8,1), THIS.cFontName, THIS.nFontHeight * 0.85, THIS.cFontStyle)

            *-- Supplemental
            IF NOT EMPTY(THIS.cSupplementalText)
              lnLeft = (((2 * THIS.nQuietZone) + 48) * THIS.nFactor) + THIS.nMargin
              lnRight = (LEN(THIS.cSupplementalText) + 1) * 9 * THIS.nFactor
              THIS.oGra.SetBrush(THIS.nBackColor)
              THIS.oGra.SetRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.FillRect(lnLeft, THIS.nMargin, lnRight, THIS.nTextHeight)
              THIS.oGra.SetAlignment(1 , 1, 0)
              THIS.oGra.SetBrush(THIS.nFontColor)
              THIS.oGra.DrawString(THIS.cSupplementalText, THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
            ENDIF

            *-- Redraw lines
            lcBin = LEFT(THIS.cPattern, THIS.nQuietZone + 4 ) + REPLICATE("0", 6 * 7)  + "10101"
            FOR ln = 1 TO LEN(lcBin)
              lnCol = ln - 1
              IF SUBSTR(lcBin, ln, 1) = "1"
                THIS.oGra.DrawLine(lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight- THIS.nTextHeight - THIS.nMargin, lnCol * THIS.nFactor + THIS.nMargin, THIS.nImageHeight - THIS.nTextHeight/2 - THIS.nMargin - 2)
              ENDIF
            ENDFOR

          OTHERWISE  && The rest of the bar code
            THIS.oGra.SetAlignment(THIS.nAlignText , 1, 0)
            THIS.oGra.SetBrush(THIS.nFontColor)
            THIS.oGra.DrawString(THIS.cHumanReadableText, THIS.cFontName, THIS.nFontHeight, THIS.cFontStyle)
        ENDCASE
      ENDIF

      *-- Only the bar code ITF-14 can be Bearer Bar
      IF THIS.nBarcodeType = FBC_CODE_ITF14 AND THIS.nBearerBar # 0
        THIS.oGra.SetPen(THIS.nBarsColor, THIS.nBearerBarWidth)
        DO CASE
          CASE THIS.nBearerBar = 2 && Top and Bottom
            *-- Top
            THIS.oGra.DrawLine(THIS.nMargin , FLOOR(THIS.nMargin + THIS.nBearerBarWidth/2), THIS.nImageWidth - THIS.nMargin, FLOOR(THIS.nMargin + THIS.nBearerBarWidth/2))
            *-- Bottom
            IF THIS.lShowHumanReadableText
              THIS.oGra.DrawLine(THIS.nMargin, FLOOR(THIS.nImageHeight - THIS.nMargin - THIS.nTextHeight- THIS.nBearerBarWidth/2), THIS.nImageWidth - THIS.nMargin, FLOOR(THIS.nImageHeight - THIS.nMargin - THIS.nTextHeight - THIS.nBearerBarWidth/2))
            ELSE
              THIS.oGra.DrawLine(THIS.nMargin, FLOOR(THIS.nImageHeight - THIS.nMargin - THIS.nBearerBarWidth/2), THIS.nImageWidth - THIS.nMargin, FLOOR(THIS.nImageHeight - THIS.nMargin - THIS.nBearerBarWidth/2))
            ENDIF

          OTHERWISE && Box
            IF THIS.lShowHumanReadableText
              THIS.oGra.DrawRect( FLOOR(THIS.nBearerBarWidth/2 + THIS.nMargin), FLOOR(THIS.nMargin + THIS.nBearerBarWidth/2), THIS.nImageWidth - THIS.nBearerBarWidth - THIS.nMargin * 2, CEILING(THIS.nImageHeight - THIS.nMargin * 2 - THIS.nBearerBarWidth - THIS.nTextHeight))
            ELSE
              THIS.oGra.DrawRect( FLOOR(THIS.nBearerBarWidth/2 + THIS.nMargin), FLOOR(THIS.nMargin + THIS.nBearerBarWidth/2), THIS.nImageWidth - THIS.nBearerBarWidth - THIS.nMargin * 2, CEILING(THIS.nImageHeight - THIS.nMargin * 2 - THIS.nBearerBarWidth))
            ENDIF
        ENDCASE
      ENDIF

      *-- Rotation of image
      THIS.oImg.ROTATEFLIP(THIS.nRotation)
    ENDIF && ISNULL(THIS.cPattern)

    *--- Comment this line, only to examples
    *    THIS.oImg.ToClipboard()

    *-- Save the image
    LOCAL lcFolder
    IF EMPTY(tcImageFile)
      lcFolder = ADDBS(THIS.cTempPath)
      IF NOT DIRECTORY(lcFolder)
        MD (lcFolder)
      ENDIF
      tcImageFile = FORCEEXT(lcFolder + SYS(2015), THIS.cImageType)
    ELSE
      lcFolder = JUSTPATH(tcImageFile)
      IF NOT DIRECTORY(lcFolder)
        MD (lcFolder)
      ENDIF
      tcImageFile = FORCEEXT(tcImageFile, THIS.cImageType)
    ENDIF
    DO CASE
      CASE THIS.cImageType = "JPG"
        THIS.oImg.SaveAsJPEG(tcImageFile,100)
      CASE THIS.cImageType = "BMP"
        THIS.oImg.SaveAsBMP(tcImageFile)
      CASE THIS.cImageType = "GIF"
        THIS.oImg.SaveAsGIF(tcImageFile)
      CASE THIS.cImageType = "PNG"
        THIS.oImg.SaveAsPNG(tcImageFile)
      CASE THIS.cImageType = "TIF"
        THIS.oImg.SaveAsTIFF(tcImageFile)
      OTHERWISE
        THIS.cImageType = "JPG"
        THIS.oImg.SaveAsJPEG(FORCEEXT(tcImageFile, THIS.cImageType),100)
    ENDCASE

    THIS.oGra = NULL
    THIS.oImg = NULL
    THIS.oGdi = NULL

    THIS.cImageFile = tcImageFile
    CLEAR RESOURCES (tcImageFile)
    RETURN tcImageFile

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE BarcodeTest(tcValue, tcImageFile, tcSuperPro)
  *------------------------------------------------------
  * Test a valid input for a barcode
  *------------------------------------------------------
  PROCEDURE BarcodeTest(tcValue, tcImageFile, tcSuperPro)

    LOCAL ARRAY laSuperPro(1)
    LOCAL lcProper, lnCon

    *-- Properties in 3rd. parameter
    IF NOT EMPTY(tcSuperPro)
      THIS.ResetProperties()
      tcSuperPro = ALLTRIM(CHRTRAN(tcSuperPro, ",", CHR(13)))
      ALINES(laSuperPro, tcSuperPro)
      FOR lnCon = 1 TO ALEN(laSuperPro)
        lcProper = "THIS."+SUBSTR(laSuperPro(lnCon), 1, AT("=", laSuperPro[lnCon]) - 1)
        IF TYPE(lcProper) # "U"
          laSuperPro(lnCon) = "THIS."+laSuperPro(lnCon)
          &laSuperPro[lnCon]
        ENDIF
      ENDFOR
      IF NOT EMPTY(THIS.cText)
        tcValue = THIS.cText
      ENDIF
    ENDIF

    IF EMPTY(tcValue)
      tcValue = THIS.cText
    ENDIF

    STORE tcValue TO THIS.cText, THIS.cTextValue, THIS.cHumanReadableText

    *--- Generates the pattern for test
    THIS.BarcodePattern()
    RETURN NOT ISNULL(THIS.cPattern)
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_I2of5()
  *------------------------------------------------------
  * Generate bar code Interleaved 2 of 5
  *------------------------------------------------------
  PROCEDURE Code_I2of5()

    LOCAL lcValid, lnI, lnJ, lcRet, lcStart, lcStop, lnLen

    *-- Numbers only
    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars not valid
      THIS.cMsgError = FBC_I2O5_01
      RETURN NULL
    ENDIF

    *-- Calculate and add the check digit
    IF THIS.lAddCheckDigit
      THIS.cTextValue = THIS.cTextValue + THIS.CheckDigitEan(THIS.cTextValue)
      IF THIS.lShowCheckDigit
        THIS.cHumanReadableText = THIS.cTextValue
      ENDIF
    ENDIF

    lnLen = LEN(THIS.cTextValue)
    *--- Length must be even
    IF MOD(lnLen,2) # 0
      THIS.cTextValue = "0" + THIS.cTextValue
      lnLen = LEN(THIS.cTextValue)
      *-- Thanks Vishal Anand (India)
      IF THIS.lShowCheckDigit
        THIS.cHumanReadableText = THIS.cTextValue
      ELSE
        THIS.cHumanReadableText = "0" + THIS.cText
      ENDIF
    ENDIF

    LOCAL ARRAY la(10)
    *-- Coding of each character
    la[1] = "NNWWN" && 0
    la[2] = "WNNNW" && 1
    la[3] = "NWNNW" && 2
    la[4] = "WWNNN" && 3
    la[5] = "NNWNW" && 4
    la[6] = "WNWNN" && 5
    la[7] = "NWWNN" && 6
    la[8] = "NNNWW" && 7
    la[9] = "WNNWN" && 8
    la[10] = "NWNWN" && 9
    lcStart = "1010"  && Start
    lcStop = "B01"  && "1101" Stop

    *-- Encode 0s and 1s
    lcRet = ""
    FOR lnJ = 1 TO lnLen STEP 2
      lcPar = SUBSTR(THIS.cTextValue,lnJ,2)
      *-- Interlace each pair
      FOR lnI = 1 TO 5
        lcRet = lcRet + IIF(SUBSTR(la[VAL(LEFT(lcPar,1))+1],lnI,1) = "N", "1", "B") + IIF(SUBSTR(la[VAL(RIGHT(lcPar,1))+1],lnI,1) = "N", "0", "S")
      ENDFOR
    ENDFOR

    *-- Add Start and Stop and apply ratio
    RETURN THIS.ApplyRatio(lcStart + lcRet + lcStop, THIS.nRatio)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_S2of5()
  *------------------------------------------------------
  * Generate bar code Standard 2 of 5
  *------------------------------------------------------
  PROCEDURE Code_S2of5()

    LOCAL lnI, lnJ, lcRet, lcStart, lcStop, lnLen, lcValid, lnSum, lnCon

    *-- Numbers only
    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars not valid
      THIS.cMsgError = FBC_S2O5_01
      RETURN NULL
    ENDIF
    lnLen = LEN(THIS.cTextValue)

    *-- Calculate and add the check digit
    IF THIS.lAddCheckDigit
      lnSum = 0
      lnCon = 1
      FOR lnI = lnLen TO 1 STEP -1
        lnSum = lnSum + VAL(SUBSTR(THIS.cTextValue, lnI, 1)) * IIF(MOD(lnCon,2) = 0, 1, 3)
        lnCon = lnCon + 1
      ENDFOR
      THIS.cTextValue = THIS.cTextValue + TRANSFORM(MOD((10 - MOD(lnSum,10)),10))
      IF THIS.lShowCheckDigit
        THIS.cHumanReadableText = THIS.cTextValue
      ENDIF
      lnLen = LEN(THIS.cTextValue)
    ENDIF

    LOCAL ARRAY la[10]
    *-- Coding of character
    la[1]="1010B0B010" && 0
    la[2]="B0101010B0" && 1
    la[3]="10B01010B0" && 2
    la[4]="B0B0101010" && 3
    la[5]="1010B010B0" && 4
    la[6]="B010B01010" && 5
    la[7]="10B0B01010" && 6
    la[8]="101010B0B0" && 7
    la[9]="B01010B010" && 8
    la[10]="10B010B010" && 9
    lcStart = "B0B010"  && Start
    lcStop = "B010B0"  && Stop

    *-- Encode 0s and 1s
    lcRet = ""
    FOR lnI = 1 TO lnLen
      lcRet = lcRet + la(VAL(SUBSTR(THIS.cTextValue, lnI, 1)) + 1)
    ENDFOR

    *-- Add Start and Stop and apply ratio
    RETURN THIS.ApplyRatio(lcStart + lcRet + lcStop, THIS.nRatio)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Codabar()
  *------------------------------------------------------
  * Generate Codabar bar code
  *------------------------------------------------------
  PROCEDURE Code_Codabar()

    LOCAL lcRet, lcValid, lcChar, ln

    THIS.cTextValue = ALLTRIM(UPPER(THIS.cTextValue))

    *-- Start char
    IF NOT LEFT(THIS.cTextValue, 1) $ "ABCDTN*E"
      THIS.cTextValue = "A" + THIS.cTextValue
    ENDIF

    *-- Stop char
    IF NOT RIGHT(THIS.cTextValue, 1) $ "ABCDTN*E"
      THIS.cTextValue = THIS.cTextValue + "B"
    ENDIF

    *-- Chars valid only
    lcValid = "0123456789-$:/.+"
    IF NOT EMPTY(CHRTRAN(SUBSTR(THIS.cTextValue, 2, LEN(THIS.cTextValue) - 2), lcValid, ""))
      *-- Chars not valid
      THIS.cMsgError = FBC_CODABAR_01
      RETURN NULL
    ENDIF

    lcRet = ""
    FOR ln = 1 TO LEN(THIS.cTextValue)
      lcChar = SUBST(THIS.cTextValue, ln, 1)
      DO CASE
        CASE lcChar = "0"
          lcRet = lcRet + "101010001110"
        CASE lcChar = "1"
          lcRet = lcRet + "101011100010"
        CASE lcChar = "2"
          lcRet = lcRet + "101000101110"
        CASE lcChar = "3"
          lcRet = lcRet + "111000101010"
        CASE lcChar = "4"
          lcRet = lcRet + "101110100010"
        CASE lcChar = "5"
          lcRet = lcRet + "111010100010"
        CASE lcChar = "6"
          lcRet = lcRet + "100010101110"
        CASE lcChar = "7"
          lcRet = lcRet + "100010111010"
        CASE lcChar = "8"
          lcRet = lcRet + "100011101010"
        CASE lcChar = "9"
          lcRet = lcRet + "111010001010"
        CASE lcChar = "-"
          lcRet = lcRet + "101000111010"
        CASE lcChar = "$"
          lcRet = lcRet + "101110001010"
        CASE lcChar = ":"
          lcRet = lcRet + "11101011101110"
        CASE lcChar = "/"
          lcRet = lcRet + "11101110101110"
        CASE lcChar = "."
          lcRet = lcRet + "11101110111010"
        CASE lcChar = "+"
          lcRet = lcRet + "10111011101110"
        CASE lcChar = "A"
          lcRet = lcRet + "10111000100010" && Start/Stop A
        CASE lcChar = "B"
          lcRet = lcRet + "10100010001110" && Start/Stop B
        CASE lcChar = "C"
          lcRet = lcRet + "10001000101110" && Start/Stop C
        CASE lcChar = "D"
          lcRet = lcRet + "10100011100010" && Start/Stop D
        CASE lcChar = "T"
          lcRet = lcRet + "10111000100010" && Start/Stop T
        CASE lcChar = "N"
          lcRet = lcRet + "10001000101110" && Start/Stop N
        CASE lcChar = "*"
          lcRet = lcRet + "10100010001110" && Start/Stop *
        CASE lcChar = "E"
          lcRet = lcRet + "10100011100010" && Start/Stop E
      ENDCASE

    ENDFOR

    IF THIS.lShowStartStopChars
      THIS.cHumanReadableText = THIS.cTextValue
    ELSE
      THIS.cHumanReadableText = SUBSTR(THIS.cTextValue, 2, LEN(THIS.cTextValue) - 2)
    ENDIF
    THIS.cHumanReadableText = THIS.AddSpace(THIS.cHumanReadableText)

    *--  Apply ratio
    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_128()
  *------------------------------------------------------
  * Generate Code128 bar code (Sets A, B and C)
  *------------------------------------------------------
  PROCEDURE Code_128()

    LOCAL lnSum, lnLen, lc, ln, lcStart, lcStop, lcRet

    *-- Valid chars
    * Set A = [CHR(0)..CHR(95)]
    * Set B = [CHR(32)..CHR(127)]
    * Set C = [CHR(48)..CHR(57)] -> [0..9]

    DO CASE
      CASE UPPER(THIS.cSet128) = "A"
        IF NOT THIS.ValidAscii(THIS.cTextValue,0,95)
          *-- Chars not valid
          THIS.cMsgError = FBC_128A_01
          RETURN NULL
        ENDIF
        lnSum = 103

      CASE UPPER(THIS.cSet128) = "B"
        IF NOT THIS.ValidAscii(THIS.cTextValue,32,127)
          *-- Chars not valid
          THIS.cMsgError = FBC_128B_01
          RETURN NULL
        ENDIF
        lnSum = 104

      CASE UPPER(THIS.cSet128) = "C"
        IF NOT THIS.ValidAscii(THIS.cTextValue,48,57)
          *-- Chars not valid
          THIS.cMsgError = FBC_128C_01
          RETURN NULL
        ENDIF

        *--- Length must be even
        IF MOD(LEN(THIS.cTextValue),2) # 0
          THIS.cTextValue = "0" + THIS.cTextValue
          THIS.cHumanReadableText = THIS.cTextValue
        ENDIF

        THIS.cTextValue = THIS.Pair2Char(THIS.cTextValue)
        lnSum = 105

    ENDCASE

    LOCAL ARRAY laCod128[106]
    laCod128[1] = "11011001100"
    laCod128[2] = "11001101100"
    laCod128[3] = "11001100110"
    laCod128[4] = "10010011000"
    laCod128[5] = "10010001100"
    laCod128[6] = "10001001100"
    laCod128[7] = "10011001000"
    laCod128[8] = "10011000100"
    laCod128[9] = "10001100100"
    laCod128[10] = "11001001000"
    laCod128[11] = "11001000100"
    laCod128[12] = "11000100100"
    laCod128[13] = "10110011100"
    laCod128[14] = "10011011100"
    laCod128[15] = "10011001110"
    laCod128[16] = "10111001100"
    laCod128[17] = "10011101100"
    laCod128[18] = "10011100110"
    laCod128[19] = "11001110010"
    laCod128[20] = "11001011100"
    laCod128[21] = "11001001110"
    laCod128[22] = "11011100100"
    laCod128[23] = "11001110100"
    laCod128[24] = "11101101110"
    laCod128[25] = "11101001100"
    laCod128[26] = "11100101100"
    laCod128[27] = "11100100110"
    laCod128[28] = "11101100100"
    laCod128[29] = "11100110100"
    laCod128[30] = "11100110010"
    laCod128[31] = "11011011000"
    laCod128[32] = "11011000110"
    laCod128[33] = "11000110110"
    laCod128[34] = "10100011000"
    laCod128[35] = "10001011000"
    laCod128[36] = "10001000110"
    laCod128[37] = "10110001000"
    laCod128[38] = "10001101000"
    laCod128[39] = "10001100010"
    laCod128[40] = "11010001000"
    laCod128[41] = "11000101000"
    laCod128[42] = "11000100010"
    laCod128[43] = "10110111000"
    laCod128[44] = "10110001110"
    laCod128[45] = "10001101110"
    laCod128[46] = "10111011000"
    laCod128[47] = "10111000110"
    laCod128[48] = "10001110110"
    laCod128[49] = "11101110110"
    laCod128[50] = "11010001110"
    laCod128[51] = "11000101110"
    laCod128[52] = "11011101000"
    laCod128[53] = "11011100010"
    laCod128[54] = "11011101110"
    laCod128[55] = "11101011000"
    laCod128[56] = "11101000110"
    laCod128[57] = "11100010110"
    laCod128[58] = "11101101000"
    laCod128[59] = "11101100010"
    laCod128[60] = "11100011010"
    laCod128[61] = "11101111010"
    laCod128[62] = "11001000010"
    laCod128[63] = "11110001010"
    laCod128[64] = "10100110000"
    laCod128[65] = "10100001100"
    laCod128[66] = "10010110000"
    laCod128[67] = "10010000110"
    laCod128[68] = "10000101100"
    laCod128[69] = "10000100110"
    laCod128[70] = "10110010000"
    laCod128[71] = "10110000100"
    laCod128[72] = "10011010000"
    laCod128[73] = "10011000010"
    laCod128[74] = "10000110100"
    laCod128[75] = "10000110010"
    laCod128[76] = "11000010010"
    laCod128[77] = "11001010000"
    laCod128[78] = "11110111010"
    laCod128[79] = "11000010100"
    laCod128[80] = "10001111010"
    laCod128[81] = "10100111100"
    laCod128[82] = "10010111100"
    laCod128[83] = "10010011110"
    laCod128[84] = "10111100100"
    laCod128[85] = "10011110100"
    laCod128[86] = "10011110010"
    laCod128[87] = "11110100100"
    laCod128[88] = "11110010100"
    laCod128[89] = "11110010010"
    laCod128[90] = "11011011110"
    laCod128[91] = "11011110110"
    laCod128[92] = "11110110110"
    laCod128[93] = "10101111000"
    laCod128[94] = "10100011110"
    laCod128[95] = "10001011110"
    laCod128[96] = "10111101000"
    laCod128[97] = "10111100010" && FNC3
    laCod128[98] = "11110101000" && FNC2
    laCod128[99] = "11110100010" && Shift
    laCod128[100] = "10111011110"
    laCod128[101] = "10111101110" && FNC4
    laCod128[102] = "11101011110"
    laCod128[103] = "11110101110" && FNC1
    laCod128[104] = "11010000100" && Start A
    laCod128[105] = "11010010000" && Start B
    laCod128[106] = "11010011100" && Start C

    lcStart = laCod128(lnSum + 1)
    lcStop = "1100011101011" && Stop

    *-- Always calculates the check digit
    FOR ln = 1 TO LEN(THIS.cTextValue)
      lnSum = lnSum + (ASC(SUBSTR(THIS.cTextValue, ln, 1)) - 32) * ln
    ENDFOR
    THIS.cTextValue = THIS.cTextValue + CHR(MOD(lnSum,103) + 32)
    lnLen = LEN(THIS.cTextValue)

    *-- Encode 0s and 1s
    lcRet = ""
    FOR ln = 1 TO lnLen
      lcRet = lcRet + laCod128(ASC(SUBSTR(THIS.cTextValue, ln, 1)) - 32 + 1)
    ENDFOR

    *-- Add Start and Stop
    RETURN lcStart + lcRet + lcStop

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_39Ext()
  *------------------------------------------------------
  * Generate Code 39 Extended bar code
  *------------------------------------------------------
  PROCEDURE Code_39Ext()

    LOCAL lcRet, lnLen, lnSum, lnAsc, lcStart, lcStop

    IF NOT THIS.ValidAscii(THIS.cTextValue,0,127)
      *-- Chars not valid
      THIS.cMsgError = FBC_39EXT_01
      RETURN NULL
    ENDIF

    lnLen = LEN(THIS.cTextValue)

    LOCAL ARRAY laCod39Ext[128]
    laCod39Ext(1) = "%U"
    laCod39Ext(2) = "$A"
    laCod39Ext(3) = "$B"
    laCod39Ext(4) = "$C"
    laCod39Ext(5) = "$D"
    laCod39Ext(6) = "$E"
    laCod39Ext(7) = "$F"
    laCod39Ext(8) = "$G"
    laCod39Ext(9) = "$H"
    laCod39Ext(10) = "$I"
    laCod39Ext(11) = "$J"
    laCod39Ext(12) = "$K"
    laCod39Ext(13) = "$L"
    laCod39Ext(14) = "$M"
    laCod39Ext(15) = "$N"
    laCod39Ext(16) = "$O"
    laCod39Ext(17) = "$P"
    laCod39Ext(18) = "$Q"
    laCod39Ext(19) = "$R"
    laCod39Ext(20) = "$S"
    laCod39Ext(21) = "$T"
    laCod39Ext(22) = "$U"
    laCod39Ext(23) = "$V"
    laCod39Ext(24) = "$W"
    laCod39Ext(25) = "$X"
    laCod39Ext(26) = "$Y"
    laCod39Ext(27) = "$Z"
    laCod39Ext(28) = "%A"
    laCod39Ext(29) = "%B"
    laCod39Ext(30) = "%C"
    laCod39Ext(31) = "%D"
    laCod39Ext(32) = "%E"
    laCod39Ext(33) = SPACE(1)
    laCod39Ext(34) = "/A"
    laCod39Ext(35) = "/B"
    laCod39Ext(36) = "/C"
    laCod39Ext(37) = "/D"
    laCod39Ext(38) = "/E"
    laCod39Ext(39) = "/F"
    laCod39Ext(40) = "/G"
    laCod39Ext(41) = "/H"
    laCod39Ext(42) = "/I"
    laCod39Ext(43) = "/J"
    laCod39Ext(44) = "/K"
    laCod39Ext(45) = "/L"
    laCod39Ext(46) = "-"
    laCod39Ext(47) = "."
    laCod39Ext(48) = "/O"
    laCod39Ext(49) = "0"
    laCod39Ext(50) = "1"
    laCod39Ext(51) = "2"
    laCod39Ext(52) = "3"
    laCod39Ext(53) = "4"
    laCod39Ext(54) = "5"
    laCod39Ext(55) = "6"
    laCod39Ext(56) = "7"
    laCod39Ext(57) = "8"
    laCod39Ext(58) = "9"
    laCod39Ext(59) = "/Z"
    laCod39Ext(60) = "%F"
    laCod39Ext(61) = "%G"
    laCod39Ext(62) = "%H"
    laCod39Ext(63) = "%I"
    laCod39Ext(64) = "%J"
    laCod39Ext(65) = "%V"
    laCod39Ext(66) = "A"
    laCod39Ext(67) = "B"
    laCod39Ext(68) = "C"
    laCod39Ext(69) = "D"
    laCod39Ext(70) = "E"
    laCod39Ext(71) = "F"
    laCod39Ext(72) = "G"
    laCod39Ext(73) = "H"
    laCod39Ext(74) = "I"
    laCod39Ext(75) = "J"
    laCod39Ext(76) = "K"
    laCod39Ext(77) = "L"
    laCod39Ext(78) = "M"
    laCod39Ext(79) = "N"
    laCod39Ext(80) = "O"
    laCod39Ext(81) = "P"
    laCod39Ext(82) = "Q"
    laCod39Ext(83) = "R"
    laCod39Ext(84) = "S"
    laCod39Ext(85) = "T"
    laCod39Ext(86) = "U"
    laCod39Ext(87) = "V"
    laCod39Ext(88) = "W"
    laCod39Ext(89) = "X"
    laCod39Ext(90) = "Y"
    laCod39Ext(91) = "Z"
    laCod39Ext(92) = "%K"
    laCod39Ext(93) = "%L"
    laCod39Ext(94) = "%M"
    laCod39Ext(95) = "%N"
    laCod39Ext(96) = "%O"
    laCod39Ext(97) = "%W"
    laCod39Ext(98) = "+A"
    laCod39Ext(99) = "+B"
    laCod39Ext(100) = "+C"
    laCod39Ext(101) = "+D"
    laCod39Ext(102) = "+E"
    laCod39Ext(103) = "+F"
    laCod39Ext(104) = "+G"
    laCod39Ext(105) = "H"
    laCod39Ext(106) = "+I"
    laCod39Ext(107) = "+J"
    laCod39Ext(108) = "+K"
    laCod39Ext(109) = "+L"
    laCod39Ext(110) = "+M"
    laCod39Ext(111) = "+N"
    laCod39Ext(112) = "+O"
    laCod39Ext(113) = "+P"
    laCod39Ext(114) = "+Q"
    laCod39Ext(115) = "+R"
    laCod39Ext(116) = "+S"
    laCod39Ext(117) = "+T"
    laCod39Ext(118) = "+U"
    laCod39Ext(119) = "+V"
    laCod39Ext(120) = "+W"
    laCod39Ext(121) = "+X"
    laCod39Ext(122) = "+Y"
    laCod39Ext(123) = "+Z"
    laCod39Ext(124) = "%P"
    laCod39Ext(125) = "%Q"
    laCod39Ext(126) = "%R"
    laCod39Ext(127) = "%S"
    laCod39Ext(128) = "%T"

    *-- Expanding Characters
    lcTag = ""
    FOR ln = 1 TO lnLen
      lcTag = lcTag + laCod39Ext(ASC(SUBSTR(THIS.cTextValue,ln,1))+1)
    ENDFOR
    THIS.TAG = THIS.cTextValue
    THIS.cTextValue = lcTag
    lcRet = THIS.Code_39()
    THIS.cTextValue = THIS.TAG

    THIS.cHumanReadableText = IIF(THIS.lShowStartStopChars, "*", "") + THIS.cTextValue + IIF(THIS.lAddCheckDigit AND THIS.lShowCheckDigit, THIS.cCheckDigit, "") + IIF(THIS.lShowStartStopChars, "*", "")
    THIS.cHumanReadableText = THIS.AddSpace(THIS.cHumanReadableText)

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_39()
  *------------------------------------------------------
  * Generate Code 39 bar code
  *------------------------------------------------------
  PROCEDURE Code_39()

    LOCAL lcRet, lcValid, lnLen, lnSum, lnPos

    THIS.cTextValue = UPPER(THIS.cTextValue)
    lcValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%"

    IF NOT EMPTY(CHRTRAN(THIS.cTextValue, lcValid, ""))
      *-- Chars not valid
      THIS.cMsgError = FBC_39_01
      RETURN NULL
    ENDIF

    lnLen = LEN(THIS.cTextValue)

    LOCAL ARRAY laCod39[43]
    laCod39[1]="101SB0B010"   && 0
    laCod39[2]="B01S1010B0"   && 1
    laCod39[3]="10BS1010B0"   && 2
    laCod39[4]="B0BS101010"   && 3
    laCod39[5]="101SB010B0"   && 4
    laCod39[6]="B01SB01010"   && 5
    laCod39[7]="10BSB01010"   && 6
    laCod39[8]="101S10B0B0"   && 7
    laCod39[9]="B01S10B010"   && 8
    laCod39[10]="10BS10B010"   && 9
    laCod39[11]="B0101S10B0"   && A
    laCod39[12]="10B01S10B0"   && B
    laCod39[13]="B0B01S1010"   && C
    laCod39[14]="1010BS10B0"   && D
    laCod39[15]="B010BS1010"   && E
    laCod39[16]="10B0BS1010"   && F
    laCod39[17]="10101SB0B0"   && G
    laCod39[18]="B0101SB010"   && H
    laCod39[19]="10B01SB010"   && I
    laCod39[20]="1010BSB010"   && J
    laCod39[21]="B010101SB0"   && K
    laCod39[22]="10B0101SB0"   && L
    laCod39[23]="B0B0101S10"   && M
    laCod39[24]="1010B01SB0"   && N
    laCod39[25]="B010B01S10"   && O
    laCod39[26]="10B0B01S10"   && P
    laCod39[27]="101010BSB0"   && Q
    laCod39[28]="B01010BS10"   && R
    laCod39[29]="10B010BS10"   && S
    laCod39[30]="1010B0BS10"   && T
    laCod39[31]="BS101010B0"   && U
    laCod39[32]="1SB01010B0"   && V
    laCod39[33]="BSB0101010"   && W
    laCod39[34]="1S10B010B0"   && X
    laCod39[35]="BS10B01010"   && Y
    laCod39[36]="1SB0B01010"   && Z
    laCod39[37]="1S1010B0B0"   && -
    laCod39[38]="BS1010B010"   && .
    laCod39[39]="1SB010B010"   && SPACE
    laCod39[40]="1S1S1S1010"   && $
    laCod39[41]="1S1S101S10"   && /
    laCod39[42]="1S101S1S10"   && +
    laCod39[43]="101S1S1S10"   && %

    lcStart = "1S10B0B010"   && * Start
    lcStop = "1S10B0B01"   && * Stop

    *-- Encode 0s and 1s
    lcRet = ""
    lnSum = 0
    FOR ln = 1 TO lnLen
      lnPos = AT(SUBSTR(THIS.cTextValue, ln, 1),lcValid)
      lcRet = lcRet + laCod39(lnPos)
      lnSum = lnSum + lnPos - 1
    ENDFOR

    IF THIS.lAddCheckDigit
      THIS.cCheckDigit = SUBSTR(lcValid, MOD(lnSum,43)+1, 1)
      lcRet = lcRet + laCod39(MOD(lnSum,43)+1)
    ENDIF

    THIS.cHumanReadableText = IIF(THIS.lShowStartStopChars, "*", "") + THIS.cTextValue + IIF(THIS.lAddCheckDigit AND THIS.lShowCheckDigit, THIS.cCheckDigit, "") + IIF(THIS.lShowStartStopChars, "*", "")
    THIS.cHumanReadableText = THIS.AddSpace(THIS.cHumanReadableText)

    *-- Add Start and Stop and apply ratio
    RETURN THIS.ApplyRatio(lcStart + lcRet + lcStop, THIS.nRatio)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_93Ext()
  *------------------------------------------------------
  * Generate Code 93 Extended bar code
  *------------------------------------------------------
  PROCEDURE Code_93Ext()

    LOCAL lcRet, lnLen, lnSum, lnAsc, lcStart, lcStop

    IF NOT THIS.ValidAscii(THIS.cTextValue,0,127)
      *-- Chars not valid
      THIS.cMsgError = FBC_93EXT_01
      RETURN NULL
    ENDIF

    lnLen = LEN(THIS.cTextValue)

    LOCAL ARRAY laCod93Ext[128]
    laCod93Ext(1) = "#U"
    laCod93Ext(2) = "=A"
    laCod93Ext(3) = "=B"
    laCod93Ext(4) = "=C"
    laCod93Ext(5) = "=D"
    laCod93Ext(6) = "=E"
    laCod93Ext(7) = "=F"
    laCod93Ext(8) = "=G"
    laCod93Ext(9) = "=H"
    laCod93Ext(10) = "=I"
    laCod93Ext(11) = "=J"
    laCod93Ext(12) = "=K"
    laCod93Ext(13) = "=L"
    laCod93Ext(14) = "=M"
    laCod93Ext(15) = "=N"
    laCod93Ext(16) = "=O"
    laCod93Ext(17) = "=P"
    laCod93Ext(18) = "=Q"
    laCod93Ext(19) = "=R"
    laCod93Ext(20) = "=S"
    laCod93Ext(21) = "=T"
    laCod93Ext(22) = "=U"
    laCod93Ext(23) = "=V"
    laCod93Ext(24) = "=W"
    laCod93Ext(25) = "=X"
    laCod93Ext(26) = "=Y"
    laCod93Ext(27) = "=Z"
    laCod93Ext(28) = "#A"
    laCod93Ext(29) = "#B"
    laCod93Ext(30) = "#C"
    laCod93Ext(31) = "#D"
    laCod93Ext(32) = "#E"
    laCod93Ext(33) = SPACE(1)
    laCod93Ext(34) = "&A"
    laCod93Ext(35) = "&B"
    laCod93Ext(36) = "&C"
    laCod93Ext(37) = "$" && "&D"
    laCod93Ext(38) = "%" && "&E"
    laCod93Ext(39) = "&F"
    laCod93Ext(40) = "&G"
    laCod93Ext(41) = "&H"
    laCod93Ext(42) = "&I"
    laCod93Ext(43) = "&J"
    laCod93Ext(44) = "+" && "&K"
    laCod93Ext(45) = "&L"
    laCod93Ext(46) = "-" && "&M"
    laCod93Ext(47) = "." && "&N"
    laCod93Ext(48) = "/" && "&O"
    laCod93Ext(49) = "0"
    laCod93Ext(50) = "1"
    laCod93Ext(51) = "2"
    laCod93Ext(52) = "3"
    laCod93Ext(53) = "4"
    laCod93Ext(54) = "5"
    laCod93Ext(55) = "6"
    laCod93Ext(56) = "7"
    laCod93Ext(57) = "8"
    laCod93Ext(58) = "9"
    laCod93Ext(59) = "&Z"
    laCod93Ext(60) = "#F"
    laCod93Ext(61) = "#G"
    laCod93Ext(62) = "#H"
    laCod93Ext(63) = "#I"
    laCod93Ext(64) = "#J"
    laCod93Ext(65) = "#V"
    laCod93Ext(66) = "A"
    laCod93Ext(67) = "B"
    laCod93Ext(68) = "C"
    laCod93Ext(69) = "D"
    laCod93Ext(70) = "E"
    laCod93Ext(71) = "F"
    laCod93Ext(72) = "G"
    laCod93Ext(73) = "H"
    laCod93Ext(74) = "I"
    laCod93Ext(75) = "J"
    laCod93Ext(76) = "K"
    laCod93Ext(77) = "L"
    laCod93Ext(78) = "M"
    laCod93Ext(79) = "N"
    laCod93Ext(80) = "O"
    laCod93Ext(81) = "P"
    laCod93Ext(82) = "Q"
    laCod93Ext(83) = "R"
    laCod93Ext(84) = "S"
    laCod93Ext(85) = "T"
    laCod93Ext(86) = "U"
    laCod93Ext(87) = "V"
    laCod93Ext(88) = "W"
    laCod93Ext(89) = "X"
    laCod93Ext(90) = "Y"
    laCod93Ext(91) = "Z"
    laCod93Ext(92) = "#K"
    laCod93Ext(93) = "#L"
    laCod93Ext(94) = "#M"
    laCod93Ext(95) = "#N"
    laCod93Ext(96) = "#O"
    laCod93Ext(97) = "#W"
    laCod93Ext(98) = "@A"
    laCod93Ext(99) = "@B"
    laCod93Ext(100) = "@C"
    laCod93Ext(101) = "@D"
    laCod93Ext(102) = "@E"
    laCod93Ext(103) = "@F"
    laCod93Ext(104) = "@G"
    laCod93Ext(105) = "H"
    laCod93Ext(106) = "@I"
    laCod93Ext(107) = "@J"
    laCod93Ext(108) = "@K"
    laCod93Ext(109) = "@L"
    laCod93Ext(110) = "@M"
    laCod93Ext(111) = "@N"
    laCod93Ext(112) = "@O"
    laCod93Ext(113) = "@P"
    laCod93Ext(114) = "@Q"
    laCod93Ext(115) = "@R"
    laCod93Ext(116) = "@S"
    laCod93Ext(117) = "@T"
    laCod93Ext(118) = "@U"
    laCod93Ext(119) = "@V"
    laCod93Ext(120) = "@W"
    laCod93Ext(121) = "@X"
    laCod93Ext(122) = "@Y"
    laCod93Ext(123) = "@Z"
    laCod93Ext(124) = "#P"
    laCod93Ext(125) = "#Q"
    laCod93Ext(126) = "#R"
    laCod93Ext(127) = "#S"
    laCod93Ext(128) = "#T"

    *-- Expanding Characters
    lcTag = ""
    FOR ln = 1 TO lnLen
      lcTag = lcTag + laCod93Ext(ASC(SUBSTR(THIS.cTextValue,ln,1))+1)
    ENDFOR

    THIS.TAG = THIS.cTextValue
    THIS.cTextValue = lcTag
    lcRet = THIS.Code_93()
    THIS.cTextValue = THIS.TAG

    THIS.cHumanReadableText = THIS.cTextValue + IIF(THIS.lShowCheckDigit, THIS.cCheckDigit, "")

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_93()
  *------------------------------------------------------
  * Generate Code 93 bar code
  *------------------------------------------------------
  PROCEDURE Code_93()

    LOCAL lcRet, lcValid, lnLen, lnSum, lnPos

    THIS.cTextValue = UPPER(THIS.cTextValue)

    lcValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%=#&@"
    IF NOT EMPTY(CHRTRAN(THIS.cTextValue, lcValid, ""))
      *-- Chars not valid
      THIS.cMsgError = FBC_93_01
      RETURN NULL
    ENDIF

    lnLen = LEN(THIS.cTextValue)

    LOCAL ARRAY laCod93[47]
    laCod93(1) = "100010100"  &&  0
    laCod93(2) = "101001000"  &&  1
    laCod93(3) = "101000100"  &&  2
    laCod93(4) = "101000010"  &&  3
    laCod93(5) = "100101000"  &&  4
    laCod93(6) = "100100100"  &&  5
    laCod93(7) = "100100010"  &&  6
    laCod93(8) = "101010000"  &&  7
    laCod93(9) = "100010010"  &&  8
    laCod93(10) = "100001010"  &&  9
    laCod93(11) = "110101000"  &&  A
    laCod93(12) = "110100100"  &&  B
    laCod93(13) = "110100010"  &&  C
    laCod93(14) = "110010100"  &&  D
    laCod93(15) = "110010010"  &&  E
    laCod93(16) = "110001010"  &&  F
    laCod93(17) = "101101000"  &&  G
    laCod93(18) = "101100100"  &&  H
    laCod93(19) = "101100010"  &&  I
    laCod93(20) = "100110100"  &&  J
    laCod93(21) = "100011010"  &&  K
    laCod93(22) = "101011000"  &&  L
    laCod93(23) = "101001100"  &&  M
    laCod93(24) = "101000110"  &&  N
    laCod93(25) = "100101100"  &&  O
    laCod93(26) = "100010110"  &&  P
    laCod93(27) = "110110100"  &&  Q
    laCod93(28) = "110110010"  &&  R
    laCod93(29) = "110101100"  &&  S
    laCod93(30) = "110100110"  &&  T
    laCod93(31) = "110010110"  &&  U
    laCod93(32) = "110011010"  &&  V
    laCod93(33) = "101101100"  &&  W
    laCod93(34) = "101100110"  &&  X
    laCod93(35) = "100110110"  &&  Y
    laCod93(36) = "100111010"  &&  Z
    laCod93(37) = "100101110"  &&  -
    laCod93(38) = "111010100"  &&  .
    laCod93(39) = "111010010"  &&  SPACE
    laCod93(40) = "111001010"  &&  $
    laCod93(41) = "101101110"  &&  /
    laCod93(42) = "101110110"  &&  +
    laCod93(43) = "110101110"  &&   %
    laCod93(44) = "100100110"  &&  ($) =
    laCod93(45) = "111011010"  &&  (%) #   /
    laCod93(46) = "111010110"  &&  (/) &   +
    laCod93(47) = "100110010"  &&  (+) @   %

    lcStart = "101011110"  &&  Start
    lcStop = "1010111101"  &&  Stop with termination bar

    lcTag = THIS.cTextValue

    *-- Encode 0s and 1s
    lcRet = ""
    FOR ln = 1 TO lnLen
      lnPos = AT(SUBSTR(lcTag, ln, 1),lcValid)
      lcRet = lcRet + laCod93(lnPos)
    ENDFOR

    *-- Always with two Check Digit
    *-- First Check Digit
    lnSum = 0
    lnCon = 1
    FOR ln = lnLen TO 1 STEP -1
      lnPos = AT(SUBSTR(lcTag, ln, 1), lcValid)
      lnSum = lnSum + ((lnPos - 1) * lnCon)
      lnCon = lnCon + 1
      IF lnCon > 20
        lnCon = 1
      ENDIF
    ENDFOR
    lnCheckDigit = MOD(lnSum,47)
    lcCheckDigit = SUBSTR(lcValid, lnCheckDigit + 1, 1)
    lcRet = lcRet + laCod93(lnCheckDigit + 1)
    lcTag = lcTag + lcCheckDigit
    lnLen = LEN(lcTag)
    THIS.cCheckDigit = lcCheckDigit

    *-- Second Check Digit
    lnSum = 0
    lnCon = 1
    FOR ln = lnLen TO 1 STEP -1
      lnPos = AT(SUBSTR(lcTag, ln, 1),lcValid)
      lnSum = lnSum + ((lnPos - 1) * lnCon)
      lnCon = lnCon + 1
      IF lnCon > 15
        lnCon = 1
      ENDIF
    ENDFOR
    lnCheckDigit = MOD(lnSum,47)
    lcCheckDigit = SUBSTR(lcValid, lnCheckDigit + 1, 1)
    lcRet = lcRet + laCod93(lnCheckDigit+1)
    lcTag = lcTag + lcCheckDigit
    lnLen = LEN(lcTag)

    THIS.cCheckDigit = THIS.cCheckDigit + lcCheckDigit
    THIS.cCheckDigit = CHRTRAN(THIS.cCheckDigit, "=#&@", "$%/+")

    THIS.cHumanReadableText =  THIS.cTextValue + IIF(THIS.lShowCheckDigit, THIS.cCheckDigit, "")
    *THIS.cHumanReadableText = THIS.AddSpace(THIS.cHumanReadableText)

    *-- Add Start and Stop
    RETURN lcStart + lcRet + lcStop

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Itf14()
  *------------------------------------------------------
  * Generate EAN-14 or ITF-14 bar code
  *------------------------------------------------------
  PROCEDURE Code_Itf14()

    LOCAL lcValid

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_ITF14_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(LEN(THIS.cTextValue),13,14)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_ITF14_02
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) = 14
      *-- Check digit not valid
      lcCheckDigit = THIS.CheckDigitEan(LEFT(THIS.cTextValue,13))
      IF lcCheckDigit <> RIGHT(THIS.cTextValue,1)
        THIS.cMsgError = FBC_ITF14_03 + lcCheckDigit
        RETURN NULL
      ELSE
        THIS.cTextValue = LEFT(THIS.cTextValue,13)
      ENDIF
    ENDIF

    *-- Ok
    RETURN THIS.Code_I2of5()

  ENDPROC
  *------------------------------------------------------
  * PROCEDURE Code_Ean13()
  *------------------------------------------------------
  * Generate EAN-13 bar code
  *------------------------------------------------------
  PROCEDURE Code_Ean13()

    LOCAL lcValid, lcRet, lc, lcStartStop, lcCenter

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_EAN13_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(LEN(THIS.cTextValue),12,18)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_EAN13_02
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) = 13
      *-- Check digit not valid
      lcCheckDigit = THIS.CheckDigitEan(LEFT(THIS.cTextValue,12))
      IF lcCheckDigit <> RIGHT(THIS.cTextValue,1)
        THIS.cMsgError = FBC_EAN13_03 + lcCheckDigit
        RETURN NULL
      ELSE
        THIS.cTextValue = LEFT(THIS.cTextValue,12)
      ENDIF
    ENDIF

    IF LEN(THIS.cTextValue) > 13 && with supplemental
      THIS.cSupplementalText = SUBSTR(THIS.cTextValue,14)
      THIS.cTextValue = LEFT(THIS.cTextValue,12)
    ELSE
      THIS.cSupplementalText = ""
    ENDIF

    LOCAL ARRAY laSet(10), laA(10), laB(10), laC(10)
    *--- Characters set table
    *--- As "lnPri" (¡DO NOT CHANGE!)
    laSet(1) = "AAAAAACCCCCC"   && 0
    laSet(2) = "AABABBCCCCCC"   && 1
    laSet(3) = "AABBABCCCCCC"   && 2
    laSet(4) = "AABBBACCCCCC"   && 3
    laSet(5) = "ABAABBCCCCCC"   && 4
    laSet(6) = "ABBAABCCCCCC"   && 5
    laSet(7) = "ABBBAACCCCCC"   && 6
    laSet(8) = "ABABABCCCCCC"   && 7
    laSet(9) = "ABABBACCCCCC"   && 8
    laSet(10) = "ABBABACCCCCC"   && 9

    *-- Left Set A
    laA(1) = "0001101"
    laA(2) = "0011001"
    laA(3) = "0010011"
    laA(4) = "0111101"
    laA(5) = "0100011"
    laA(6) = "0110001"
    laA(7) = "0101111"
    laA(8) = "0111011"
    laA(9) = "0110111"
    laA(10) = "0001011"

    *-- Left Set B
    laB(1) = "0100111"
    laB(2) = "0110011"
    laB(3) = "0011011"
    laB(4) = "0100001"
    laB(5) = "0011101"
    laB(6) = "0111001"
    laB(7) = "0000101"
    laB(8) = "0010001"
    laB(9) = "0001001"
    laB(10) = "0010111"

    *-- Right Set
    laC(1) = "1110010"
    laC(2) = "1100110"
    laC(3) = "1101100"
    laC(4) = "1000010"
    laC(5) = "1011100"
    laC(6) = "1001110"
    laC(7) = "1010000"
    laC(8) = "1000100"
    laC(9) = "1001000"
    laC(10) = "1110100"

    lcStartStop = "101"
    lcCenter = "01010"

    *-- Check digit EAN
    THIS.cTextValue = THIS.cTextValue + THIS.CheckDigitEan(THIS.cTextValue)
    THIS.cHumanReadableText = THIS.cTextValue

    lcRet = lcStartStop

    *-- 1st char
    lcSet = laSet(VAL(SUBS(THIS.cTextValue,1,1))+1)

    FOR lnI = 2 TO 7
      lc = "la" + SUBSTR(lcSet,lnI-1,1)
      lcRet = lcRet + &lc(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcCenter

    FOR lnI = 8 TO 13
      lcRet = lcRet + laC(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcStartStop

    *-- Supplemental
    IF NOT EMPTY(THIS.cSupplementalText)
      IF BETWEEN(LEN(THIS.cSupplementalText),1,2)
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup2()
      ELSE
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup5()
      ENDIF
    ENDIF

    RETURN lcRet
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Ean8()
  *------------------------------------------------------
  * Generate EAN-8 bar code
  *------------------------------------------------------
  FUNCTION Code_Ean8()
    LOCAL lcValid, lcStartStop, lcCenter, lcRet

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_EAN8_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(LEN(THIS.cTextValue),7,13)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_EAN8_02
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) = 8
      *-- Check digit not valid
      lcCheckDigit = THIS.CheckDigitEan(LEFT(THIS.cTextValue,7))
      IF lcCheckDigit <> RIGHT(THIS.cTextValue,1)
        THIS.cMsgError = FBC_EAN8_03 + lcCheckDigit
        RETURN NULL
      ELSE
        THIS.cTextValue = LEFT(THIS.cTextValue,7)
      ENDIF
    ENDIF

    IF LEN(THIS.cTextValue) > 8 && with supplemental
      THIS.cSupplementalText = SUBSTR(THIS.cTextValue,9)
      THIS.cTextValue = LEFT(THIS.cTextValue,7)
    ELSE
      THIS.cSupplementalText = ""
    ENDIF

    *-- Check digit EAN
    THIS.cTextValue = THIS.cTextValue + THIS.CheckDigitEan(THIS.cTextValue)
    THIS.cHumanReadableText = THIS.cTextValue

    LOCAL ARRAY laA(10), laC(10)
    *-- Left Set
    laA[1] ="0001101"   && 0
    laA[2] ="0011001"   && 1
    laA[3] ="0010011"   && 2
    laA[4] ="0111101"   && 3
    laA[5] ="0100011"   && 4
    laA[6] ="0110001"   && 5
    laA[7] ="0101111"   && 6
    laA[8] ="0111011"   && 7
    laA[9] ="0110111"   && 8
    laA[10]="0001011"   && 9

    *-- Right Set
    laC[1] ="1110010"   && 0
    laC[2] ="1100110"   && 1
    laC[3] ="1101100"   && 2
    laC[4] ="1000010"   && 3
    laC[5] ="1011100"   && 4
    laC[6] ="1001110"   && 5
    laC[7] ="1010000"   && 6
    laC[8] ="1000100"   && 7
    laC[9] ="1001000"   && 8
    laC[10]="1110100"   && 9

    lcStartStop = "101"
    lcCenter = "01010"

    lcRet = lcStartStop

    FOR lnI = 1 TO 4
      lcRet = lcRet + laA(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcCenter

    FOR lnI = 5 TO 8
      lcRet = lcRet + laC(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcStartStop

    *-- Supplemental
    IF NOT EMPTY(THIS.cSupplementalText)
      IF BETWEEN(LEN(THIS.cSupplementalText),1,2)
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup2()
      ELSE
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup5()
      ENDIF
    ENDIF

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_UpcA()
  *------------------------------------------------------
  * Generate UPC-A bar code
  *------------------------------------------------------
  FUNCTION Code_UpcA()
    LOCAL lcValid, lcStartStop, lcCenter

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_UPCA_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(LEN(THIS.cTextValue),11,17)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_UPCA_02
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) = 12
      *-- Check digit not valid
      lcCheckDigit = THIS.CheckDigitEan(LEFT(THIS.cTextValue,11))
      IF lcCheckDigit <> RIGHT(THIS.cTextValue,1)
        THIS.cMsgError = FBC_UPCA_03 + lcCheckDigit
        RETURN NULL
      ELSE
        THIS.cTextValue = LEFT(THIS.cTextValue,11)
      ENDIF
    ENDIF

    IF LEN(THIS.cTextValue) > 12 && with supplemental
      THIS.cSupplementalText = SUBSTR(THIS.cTextValue,13)
      THIS.cTextValue = LEFT(THIS.cTextValue,11)
    ELSE
      THIS.cSupplementalText = ""
    ENDIF

    *-- Check digit UPC
    THIS.cTextValue = THIS.cTextValue + THIS.CheckDigitEan(THIS.cTextValue)
    THIS.cHumanReadableText = THIS.cTextValue

    LOCAL ARRAY laA(10), laC(10)
    *-- Left Set
    laA(1) = "0001101"
    laA(2) = "0011001"
    laA(3) = "0010011"
    laA(4) = "0111101"
    laA(5) = "0100011"
    laA(6) = "0110001"
    laA(7) = "0101111"
    laA(8) = "0111011"
    laA(9) = "0110111"
    laA(10) = "0001011"

    *-- Right Set
    laC(1) = "1110010"
    laC(2) = "1100110"
    laC(3) = "1101100"
    laC(4) = "1000010"
    laC(5) = "1011100"
    laC(6) = "1001110"
    laC(7) = "1010000"
    laC(8) = "1000100"
    laC(9) = "1001000"
    laC(10) = "1110100"

    lcStartStop = "101"
    lcCenter = "01010"

    lcRet = lcStartStop

    FOR lnI = 1 TO 6
      lcRet = lcRet + laA(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcCenter

    FOR lnI = 7 TO 12
      lcRet = lcRet + laC(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
    ENDFOR

    lcRet = lcRet + lcStartStop

    *-- Supplemental
    IF NOT EMPTY(THIS.cSupplementalText)
      IF BETWEEN(LEN(THIS.cSupplementalText),1,2)
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup2()
      ELSE
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup5()
      ENDIF
    ENDIF

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_UpcE()
  *------------------------------------------------------
  * Generate UPC-E bar code
  *------------------------------------------------------

  FUNCTION Code_UpcE()
    LOCAL lcValid, lcUpcA, lcStart, lcStop, lcRet, lcParity

    lcUpcA = "0"

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_UPCB_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(LEN(THIS.cTextValue),6,12)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_UPCB_02
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) = 7
      *-- Check digit not valid
      lcCheckDigit = THIS.CheckDigitEan(LEFT(THIS.cTextValue,6))
      IF lcCheckDigit <> RIGHT(THIS.cTextValue,1)
        THIS.cMsgError = FBC_UPCB_03 + lcCheckDigit
        RETURN NULL
      ELSE
        THIS.cTextValue = LEFT(THIS.cTextValue,6)
      ENDIF
    ENDIF

    IF LEN(THIS.cTextValue) > 7 && with supplemental
      THIS.cSupplementalText = SUBSTR(THIS.cTextValue,8)
      THIS.cTextValue = LEFT(THIS.cTextValue,6)
    ELSE
      THIS.cSupplementalText = ""
    ENDIF

    *-- UPC-E to UPC-A
    DO CASE
      CASE RIGHT(THIS.cTextValue, 1)= "0" OR RIGHT(THIS.cTextValue ,1) = "1" OR RIGHT(THIS.cTextValue ,1) = "2"
        lcUpcA = lcUpcA + LEFT(THIS.cTextValue, 2) + RIGHT(THIS.cTextValue, 1) + "0000" +  SUBSTR(THIS.cTextValue, 3, 3)
      CASE RIGHT(THIS.cTextValue, 1)= "3"
        lcUpcA = lcUpcA + LEFT(THIS.cTextValue, 3) + "00000" +  SUBSTR(THIS.cTextValue, 4, 2)
      CASE RIGHT(THIS.cTextValue, 1)= "4"
        lcUpcA = lcUpcA + LEFT(THIS.cTextValue, 4) + "00000" +  SUBSTR(THIS.cTextValue, 5, 1)
      OTHERWISE
        lcUpcA = lcUpcA + LEFT(THIS.cTextValue, 5) + "0000" + RIGHT(THIS.cTextValue, 1)
    ENDCASE
    lcUpcA = THIS.CheckDigitEan(lcUpcA)

    THIS.cHumanReadableText = "0" + THIS.cTextValue + lcUpcA

    LOCAL ARRAY  laB(10), laC(10), laA(10)
    *-- UPC-E PARITY ENCODING TABLE
    laA(1) = "EEEOOO"  &&,"OOOEEE"
    laA(2) = "EEOEOO"  &&,"OOEOEE"
    laA(3) = "EEOOEO"  &&,"OOEEOE"
    laA(4) = "EEOOOE"  &&,"OOEEEO"
    laA(5) = "EOEEOO"  &&,"OEOOEE"
    laA(6) = "EOOEEO"  &&,"OEEOOE"
    laA(7) = "EOOOEE"  &&,"OEEEOO"
    laA(8) = "EOEOEO"  &&,"OEOEOE"
    laA(9) = "EOEOOE"  &&,"OEOEEO"
    laA(10) = "EOOEOE"  &&,"OEEOEO"

    laB(1) = "0001101"
    laB(2) = "0011001"
    laB(3) = "0010011"
    laB(4) = "0111101"
    laB(5) = "0100011"
    laB(6) = "0110001"
    laB(7) = "0101111"
    laB(8) = "0111011"
    laB(9) = "0110111"
    laB(10) = "0001011"

    laC(1) = "0100111"
    laC(2) = "0110011"
    laC(3) = "0011011"
    laC(4) = "0100001"
    laC(5) = "0011101"
    laC(6) = "0111001"
    laC(7) = "0000101"
    laC(8) = "0010001"
    laC(9) = "0001001"
    laC(10) = "0010111"

    lcStart = "101"
    lcStop = "010101"

    lcRet = ""

    lcParity = laA(VAL(lcUpcA) + 1)
    FOR lnI = 1 TO 6
      IF SUBS(lcParity,lnI,1) = "O"
        lcRet = lcRet + laB(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
      ELSE
        lcRet = lcRet + laC(VAL(SUBS(THIS.cTextValue,lnI,1))+1)
      ENDIF
    ENDFOR

    lcRet = lcStart + lcRet + lcStop

    *-- Supplemental
    IF NOT EMPTY(THIS.cSupplementalText)
      IF BETWEEN(LEN(THIS.cSupplementalText),1,2)
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup2()
      ELSE
        lcRet = lcRet + REPLICATE("@", THIS.nQuietZone) + THIS.Code_Sup5()
      ENDIF
    ENDIF

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_MSIPlessey()
  *------------------------------------------------------
  * Generate bar code MSI/Plessey.
  *------------------------------------------------------
  PROCEDURE Code_MSIPlessey()

    LOCAL lnI, lnJ, lcRet, lcStart, lcStop, lnLen, lcValid, lcSum1, lcSum2, lnSum3, lnSum4, lnCon

    *-- Numbers only
    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars not valid
      THIS.cMsgError = FBC_MSI_01
      RETURN NULL
    ENDIF
    lnLen = LEN(THIS.cTextValue)

    *-- Calculate and add the check digit
    IF THIS.lAddCheckDigit
      lcSum1 = ""
      lcSum2 = ""
      lnSum3 = 0
      lnSum4 = 0
      FOR lnI = 1 TO lnLen
        IF MOD(lnI, 2) = 0
          lcSum1 = lcSum1 + SUBSTR(THIS.cTextValue, lnI, 1)
        ELSE
          lcSum2 = lcSum2 + SUBSTR(THIS.cTextValue, lnI, 1)
        ENDIF
      ENDFOR
      IF MOD(lnLen,2) = 0
        lnCon = VAL(lcSum1) * 2
        FOR lnI = 1 TO LEN(TRANSFORM(lnCon))
          lnSum3 = lnSum3 + VAL(SUBSTR(TRANSFORM(lnCon), lnI, 1))
        ENDFOR
        FOR lnI = 1 TO LEN(lcSum2)
          lnSum4 = lnSum4 + VAL(SUBSTR(TRANSFORM(lcSum2), lnI, 1))
        ENDFOR
      ELSE
        lnCon = VAL(lcSum2) * 2
        FOR lnI = 1 TO LEN(TRANSFORM(lnCon))
          lnSum3 = lnSum3 + VAL(SUBSTR(TRANSFORM(lnCon), lnI, 1))
        ENDFOR
        FOR lnI = 1 TO LEN(lcSum1)
          lnSum4 = lnSum4 + VAL(SUBSTR(TRANSFORM(lcSum1), lnI, 1))
        ENDFOR
      ENDIF

      THIS.cTextValue = THIS.cTextValue + TRANSFORM(10 - (MOD(lnSum3 + lnSum4, 10)))

      IF THIS.lShowCheckDigit
        THIS.cHumanReadableText = THIS.cTextValue
      ENDIF
      lnLen = LEN(THIS.cTextValue)
    ENDIF

    LOCAL ARRAY  la[10]
    *-- Coding of each character
    la[1]="1S1S1S1S" && 0
    la[2]="1S1S1SB0" && 1
    la[3]="1S1SB01S" && 2
    la[4]="1S1SB0B0" && 3
    la[5]="1SB01S1S" && 4
    la[6]="1SB01SB0" && 5
    la[7]="1SB0B01S" && 6
    la[8]="1SB0B0B0" && 7
    la[9]="B01S1S1S" && 8
    la[10]="B01S1SB0" && 9
    lcStart = "B0"  && Start
    lcStop = "1S1"  && Stop

    *-- Encode 0s and 1s
    lcRet = ""
    FOR lnI = 1 TO lnLen
      lcRet = lcRet + la(VAL(SUBSTR(THIS.cTextValue, lnI, 1)) + 1)
    ENDFOR
    *-- Add Start and Stop and apply ratio
    RETURN THIS.ApplyRatio(lcStart + lcRet + lcStop, THIS.nRatio)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_11
  *------------------------------------------------------
  * Generate bar code 11
  *------------------------------------------------------
  PROCEDURE Code_11()

    LOCAL lnI, lnJ, lcRet, lcStart, lcStop, lnLen, lcValid, lnSum, lnCon

    *-- Numbers only
    lcValid = "1234567890-"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars not valid
      THIS.cMsgError = FBC_11_01
      RETURN NULL
    ENDIF
    lnLen = LEN(THIS.cTextValue)

    *-- Calculate and add the check digit (C)
    IF THIS.lAddCheckDigit
      lnSum = 0
      lnCon = 1
      FOR lnI = lnLen TO 1 STEP -1
        IF ISDIGIT(SUBSTR(THIS.cTextValue, lnI, 1))
          lnSum = lnSum + VAL(SUBSTR(THIS.cTextValue, lnI, 1)) * lnCon
        ELSE
          lnSum = lnSum + (10 * lnCon)
        ENDIF
        lnCon = lnCon + 1
        IF lnCon > 10
          lnCon = 1
        ENDIF
      ENDFOR

      THIS.cTextValue = THIS.cTextValue + IIF(TRANSFORM(MOD(lnSum, 11)) = "10", "-", TRANSFORM(MOD(lnSum, 11)))
      lnLen = LEN(THIS.cTextValue)

      *-- Second check digit (K)
      IF lnLen > 10
        lnSum = 0
        lnCon = 1
        FOR lnI = lnLen TO 1 STEP -1
          IF ISDIGIT(SUBSTR(THIS.cTextValue, lnI, 1))
            lnSum = lnSum + VAL(SUBSTR(THIS.cTextValue, lnI, 1)) * lnCon
          ELSE
            lnSum = lnSum + (10 * lnCon)
          ENDIF
          lnCon = lnCon + 1
          IF lnCon > 9
            lnCon = 1
          ENDIF
        ENDFOR

        THIS.cTextValue = THIS.cTextValue + IIF(TRANSFORM(MOD(lnSum, 11)) = "10", "-", TRANSFORM(MOD(lnSum, 11)))
        lnLen = LEN(THIS.cTextValue)

      ENDIF
      IF THIS.lShowCheckDigit
        THIS.cHumanReadableText = THIS.cTextValue
      ENDIF
      lnLen = LEN(THIS.cTextValue)
    ENDIF

    LOCAL ARRAY la[11]
    *-- Coding of each character
    la[1] = "1010110" && 0
    la[2] = "11010110" && 1
    la[3] = "10010110" && 2
    la[4] = "11001010" && 3
    la[5] = "10110110" && 4
    la[6] = "11011010" && 5
    la[7] = "10011010" && 6
    la[8] = "10100110" && 7
    la[9] = "11010010" && 8
    la[10] = "1101010" && 9
    la[11] = "1011010" && -
    lcStart = "10110010"  && Start
    lcStop = "1011001"  && Stop

    *-- Encode 0s and 1s
    lcRet = ""
    FOR lnI = 1 TO lnLen
      IF ISDIGIT(SUBSTR(THIS.cTextValue, lnI, 1))
        lcRet = lcRet + la(VAL(SUBSTR(THIS.cTextValue, lnI, 1)) + 1)
      ELSE
        lcRet = lcRet + la[11]  && -
      ENDIF
    ENDFOR
    *-- Add Start and Stop
    RETURN lcStart + lcRet + lcStop

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_PostNet()
  *------------------------------------------------------
  * Generate PostNet barcode
  *------------------------------------------------------
  FUNCTION Code_PostNet()
    LOCAL lnI, lcValid, lcRet, lnControl, lcCheck

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_POSTNET_01
      RETURN NULL
    ENDIF

    IF LEN(THIS.cTextValue) # 5 AND LEN(THIS.cTextValue) # 9 AND LEN(THIS.cTextValue) # 11
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_POSTNET_02
      RETURN NULL
    ENDIF

    lnControl = 0
    FOR lnI = 1 TO LEN(THIS.cTextValue)
      lnControl = lnControl + VAL(SUBSTR(THIS.cTextValue, lnI, 1))
    ENDFOR

    lcCheck = TRANSFORM(MOD(10 - MOD(lnControl, 10), 10))

    *--
    THIS.cTextValue = THIS.cTextValue + lcCheck
    *THIS.cHumanReadableText = ""

    LOCAL ARRAY laA(10)
    *-- Left Set
    laA[1] ="2020101010"   && 0
    laA[2] ="1010102020"   && 1
    laA[3] ="1010201020"   && 2
    laA[4] ="1010202010"   && 3
    laA[5] ="1020101020"   && 4
    laA[6] ="1020102010"   && 5
    laA[7] ="1020201010"   && 6
    laA[8] ="2010101020"   && 7
    laA[9] ="2010102010"   && 8
    laA[10]="2010201010"   && 9

    lcRet = "20"

    FOR lnI = 1 TO LEN(THIS.cTextValue)
      lcRet = lcRet + laA(VAL(SUBSTR(THIS.cTextValue, lnI, 1 )) + 1)
    ENDFOR

    RETURN lcRet + "2"

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_IMB()
  *------------------------------------------------------
  * Generate Intelligent Mail Barcode
  *------------------------------------------------------
  FUNCTION Code_IMB()
    *!*	    LOCAL lnI, lcValid, lcRet, lnControl, lcCheck

    *!*	    lcValid = "1234567890"
    *!*	    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
    *!*	      *-- Chars or lenght not valid
    *!*	      THIS.cMsgError = FBC_IMB_01
    *!*	      RETURN NULL
    *!*	    ENDIF

    *!*	    IF LEN(THIS.cTextValue) # 5 AND LEN(THIS.cTextValue) # 9 AND LEN(THIS.cTextValue) # 11
    *!*	      *-- Chars or lenght not valid
    *!*	      THIS.cMsgError = FBC_IMB_02
    *!*	      RETURN NULL
    *!*	    ENDIF

    *!*	    RETURN THIS.AddSpace(THIS.cTextValue,1)
    *-- Chars or lenght not valid

    THIS.cMsgError = FBC_IMB_99
    RETURN NULL

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_RM4SCC()
  *------------------------------------------------------
  * Generate RM4SCC Code (Royal Mail)
  *------------------------------------------------------
  FUNCTION Code_RM4SCC()
    LOCAL lnI, lcValid, lcRet, lnTop, lnBot, lc, lcStart, lcStop

    THIS.cTextValue = UPPER(THIS.cTextValue)
    lcValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_IMB_01
      RETURN NULL
    ENDIF

    *!*	    IF LEN(THIS.cTextValue) # 5 AND LEN(THIS.cTextValue) # 9 AND LEN(THIS.cTextValue) # 11
    *!*	      *-- Chars or lenght not valid
    *!*	      THIS.cMsgError = FBC_IMB_02
    *!*	      RETURN NULL
    *!*	    ENDIF

    *-- Check Digit
    lnTop = 0
    lnBot = 0
    FOR lnI = 1 TO LEN(THIS.cTextValue)
      lnPos = AT(SUBST(THIS.cTextValue, lnI, 1), lcValid)
      lnTop = lnTop + INT((lnPos - 1) / 6) + 1
      lnBot = lnBot + ((lnPos - 1) % 6) + 1
    ENDFOR
    THIS.cTextValue = THIS.cTextValue + SUBS(lcValid, 6 * ((lnTop - 1) % 6) + ((lnBot - 1) % 6) + 1, 1)

    LOCAL ARRAY laRM4SCC(36)
    laRM4SCC(1) =  "T0T0F0F0" && 0
    laRM4SCC(2) =  "T0D0A0F0" && 1
    laRM4SCC(3) =  "T0D0F0A0" && 2
    laRM4SCC(4) =  "D0T0A0F0" && 3
    laRM4SCC(5) =  "D0T0F0A0" && 4
    laRM4SCC(6) =  "D0D0A0A0" && 5
    laRM4SCC(7) =  "T0A0D0F0" && 6
    laRM4SCC(8) =  "T0F0T0F0" && 7
    laRM4SCC(9) =  "T0F0D0A0" && 8
    laRM4SCC(10) = "D0A0T0F0" && 9
    laRM4SCC(11) = "D0A0D0A0" && A
    laRM4SCC(12) = "D0F0T0A0" && B
    laRM4SCC(13) = "T0A0F0D0" && C
    laRM4SCC(14) = "T0F0A0D0" && D
    laRM4SCC(15) = "T0F0F0T0" && E
    laRM4SCC(16) = "D0A0A0D0" && F
    laRM4SCC(17) = "D0A0F0T0" && G
    laRM4SCC(18) = "D0F0A0T0" && H
    laRM4SCC(19) = "A0T0D0F0" && I
    laRM4SCC(20) = "A0D0T0F0" && J
    laRM4SCC(21) = "A0D0D0A0" && K
    laRM4SCC(22) = "F0T0T0F0" && L
    laRM4SCC(23) = "F0T0D0A0" && M
    laRM4SCC(24) = "F0D0T0A0" && N
    laRM4SCC(25) = "A0T0F0D0" && O
    laRM4SCC(26) = "A0D0A0D0" && P
    laRM4SCC(27) = "A0D0F0T0" && Q
    laRM4SCC(28) = "F0T0A0D0" && R
    laRM4SCC(29) = "F0T0F0T0" && S
    laRM4SCC(30) = "F0D0A0T0" && T
    laRM4SCC(31) = "A0A0D0D0" && U
    laRM4SCC(32) = "A0F0T0D0" && V
    laRM4SCC(33) = "A0F0D0T0" && W
    laRM4SCC(34) = "F0A0T0D0" && X
    laRM4SCC(35) = "F0A0D0T0" && Y
    laRM4SCC(36) = "F0F0T0T0" && Z
    lcStart = "A0"
    lcStop = "F"

    lcRet = ""
    FOR lnI = 1 TO LEN(THIS.cTextValue)
      lc = SUBSTR(THIS.cTextValue, lnI, 1)
      lcRet = lcRet + laRM4SCC(AT(lc, lcValid))
    ENDFOR

    RETURN lcStart + lcRet + lcStop

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_KIX()
  *------------------------------------------------------
  * Generate KIX-Code (Dutch Postal)
  *------------------------------------------------------
  FUNCTION Code_KIX()
    LOCAL lnI, lcValid, lcRet, lc

    THIS.cTextValue = UPPER(THIS.cTextValue)
    lcValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_IMB_01
      RETURN NULL
    ENDIF
    *!*	    IF LEN(THIS.cTextValue) # 5 AND LEN(THIS.cTextValue) # 9 AND LEN(THIS.cTextValue) # 11
    *!*	      *-- Chars or lenght not valid
    *!*	      THIS.cMsgError = FBC_IMB_02
    *!*	      RETURN NULL
    *!*	    ENDIF

    *!*	    RETURN THIS.AddSpace(THIS.cTextValue,1)

    LOCAL ARRAY laKIX(36)
    laKIX(1) =  "T0T0F0F0" && 0
    laKIX(2) =  "T0D0A0F0" && 1
    laKIX(3) =  "T0D0F0A0" && 2
    laKIX(4) =  "D0T0A0F0" && 3
    laKIX(5) =  "D0T0F0A0" && 4
    laKIX(6) =  "D0D0A0A0" && 5
    laKIX(7) =  "T0A0D0F0" && 6
    laKIX(8) =  "T0F0T0F0" && 7
    laKIX(9) =  "T0F0D0A0" && 8
    laKIX(10) = "D0A0T0F0" && 9
    laKIX(11) = "D0A0D0A0" && A
    laKIX(12) = "D0F0T0A0" && B
    laKIX(13) = "T0A0F0D0" && C
    laKIX(14) = "T0F0A0D0" && D
    laKIX(15) = "T0F0F0T0" && E
    laKIX(16) = "D0A0A0D0" && F
    laKIX(17) = "D0A0F0T0" && G
    laKIX(18) = "D0F0A0T0" && H
    laKIX(19) = "A0T0D0F0" && I
    laKIX(20) = "A0D0T0F0" && J
    laKIX(21) = "A0D0D0A0" && K
    laKIX(22) = "F0T0T0F0" && L
    laKIX(23) = "F0T0D0A0" && M
    laKIX(24) = "F0D0T0A0" && N
    laKIX(25) = "A0T0F0D0" && O
    laKIX(26) = "A0D0A0D0" && P
    laKIX(27) = "A0D0F0T0" && Q
    laKIX(28) = "F0T0A0D0" && R
    laKIX(29) = "F0T0F0T0" && S
    laKIX(30) = "F0D0A0T0" && T
    laKIX(31) = "A0A0D0D0" && U
    laKIX(32) = "A0F0T0D0" && V
    laKIX(33) = "A0F0D0T0" && W
    laKIX(34) = "F0A0T0D0" && X
    laKIX(35) = "F0A0D0T0" && Y
    laKIX(36) = "F0F0T0T0" && Z

    lcRet = ""
    FOR lnI = 1 TO LEN(THIS.cTextValue)
      lc = SUBSTR(THIS.cTextValue, lnI, 1)
      lcRet = lcRet + laKIX(AT(lc, lcValid))
    ENDFOR

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Telepen()
  *------------------------------------------------------
  * Generate Code Telepen
  *------------------------------------------------------
  PROCEDURE Code_Telepen()

    LOCAL lcRet, lnLen, lnSum, lnAsc, lcStart, lcStop, laTelepen, nlControl, lcDigit

    IF NOT THIS.ValidAscii(THIS.cTextValue,0,127)
      *-- Chars not valid
      THIS.cMsgError = FBC_TELEPEN_01
      RETURN NULL
    ENDIF

    lnLen = LEN(THIS.cTextValue)

    lcDigit = "1234567890"
    IF CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcDigit,""),"") == THIS.cTextValue AND MOD(lnLen, 2) = 0
      lcDigit = .T.
    ELSE
      lcDigit = .F.
    ENDIF

    LOCAL ARRAY laTelepen[128]
    laTelepen(1) = "B0B0B0B0"
    laTelepen(2) = "10B0B0B010"
    laTelepen(3) = "BSB0B010"
    laTelepen(4) = "1010B0B0B0"
    laTelepen(5) = "B010B0B010"
    laTelepen(6) = "10BSB0B0"
    laTelepen(7) = "1S1SB0B0"
    laTelepen(8) = "101010B0B010"
    laTelepen(9) = "B0BSB010"
    laTelepen(10) = "10B010B0B0"
    laTelepen(11) = "BS10B0B0"
    laTelepen(12) = "1010BSB010"
    laTelepen(13) = "B01010B0B0"
    laTelepen(14) = "101S1SB010"
    laTelepen(15) = "1S101SB010"
    laTelepen(16) = "10101010B0B0"
    laTelepen(17) = "B0B010B010"
    laTelepen(18) = "10B0BSB0"
    laTelepen(19) = "BSBSB0"
    laTelepen(20) = "1010B010B010"
    laTelepen(21) = "B010BSB0"
    laTelepen(22) = "10BS10B010"
    laTelepen(23) = "1S1S10B010"
    laTelepen(24) = "101010BSB0"
    laTelepen(25) = "B01S1SB0"
    laTelepen(26) = "10B01010B010"
    laTelepen(27) = "BS1010B010"
    laTelepen(28) = "10101S1SB0"
    laTelepen(29) = "B0101010B010"
    laTelepen(30) = "101S101SB0"
    laTelepen(31) = "1S10101SB0"
    laTelepen(32) = "1010101010B010"
    laTelepen(33) = "B0B0BS10"
    laTelepen(34) = "10B0B010B0"
    laTelepen(35) = "BSB010B0"
    laTelepen(36) = "1010B0BS10"
    laTelepen(37) = "B010B010B0"
    laTelepen(38) = "10BSBS10"
    laTelepen(39) = "1S1SBS10"
    laTelepen(40) = "101010B010B0"
    laTelepen(41) = "B0BS10B0"
    laTelepen(42) = "10B010BS10"
    laTelepen(43) = "BS10BS10"
    laTelepen(44) = "1010BS10B0"
    laTelepen(45) = "B01010BS10"
    laTelepen(46) = "101S1S10B0"
    laTelepen(47) = "1S101S10B0"
    laTelepen(48) = "10101010BS10"
    laTelepen(49) = "B0B01010B0"
    laTelepen(50) = "10B01S1S10"
    laTelepen(51) = "BS1S1S10"
    laTelepen(52) = "1010B01010B0"
    laTelepen(53) = "B0101S1S10"
    laTelepen(54) = "10BS1010B0"
    laTelepen(55) = "1S1S1010B0"
    laTelepen(56) = "1010101S1S10"
    laTelepen(57) = "B01S101S10"
    laTelepen(58) = "10B0101010B0"
    laTelepen(59) = "BS101010B0"
    laTelepen(60) = "10101S101S10"
    laTelepen(61) = "B010101010B0"
    laTelepen(62) = "101S10101S10"
    laTelepen(63) = "1S1010101S10"
    laTelepen(64) = "101010101010B0"
    laTelepen(65) = "B0B0B01010"
    laTelepen(66) = "10B0B0BS"
    laTelepen(67) = "BSB0BS"
    laTelepen(68) = "1010B0B01010"
    laTelepen(69) = "B010B0BS"
    laTelepen(70) = "10BSB01010"
    laTelepen(71) = "1S1SB01010"
    laTelepen(72) = "101010B0BS"
    laTelepen(73) = "B0BSBS"
    laTelepen(74) = "10B010B01010"
    laTelepen(75) = "BS10B01010"
    laTelepen(76) = "1010BSBS"
    laTelepen(77) = "B01010B01010"
    laTelepen(78) = "101S1SBS"
    laTelepen(79) = "1S101SBS"
    laTelepen(80) = "10101010B01010"
    laTelepen(81) = "B0B010BS"
    laTelepen(82) = "10B0BS1010"
    laTelepen(83) = "BSBS1010"
    laTelepen(84) = "1010B010BS"
    laTelepen(85) = "B010BS1010"
    laTelepen(86) = "10BS10BS"
    laTelepen(87) = "1S1S10BS"
    laTelepen(88) = "101010BS1010"
    laTelepen(89) = "B01S1S1010"
    laTelepen(90) = "10B01010BS"
    laTelepen(91) = "BS1010BS"
    laTelepen(92) = "10101S1S1010"
    laTelepen(93) = "B0101010BS"
    laTelepen(94) = "101S101S1010"
    laTelepen(95) = "1S10101S1010"
    laTelepen(96) = "1010101010BS"
    laTelepen(97) = "B0B01S1S"
    laTelepen(98) = "10B0B0101010"
    laTelepen(99) = "BSB0101010"
    laTelepen(100) = "1010B01S1S"
    laTelepen(101) = "B010B0101010"
    laTelepen(102) = "10BS1S1S"
    laTelepen(103) = "1S1S1S1S"
    laTelepen(104) = "101010B0101010"
    laTelepen(105) = "B0BS101010"
    laTelepen(106) = "10B0101S1S"
    laTelepen(107) = "BS101S1S"
    laTelepen(108) = "1010BS101010"
    laTelepen(109) = "B010101S1S"
    laTelepen(110) = "101S1S101010"
    laTelepen(111) = "1S101S101010"
    laTelepen(112) = "101010101S1S"
    laTelepen(113) = "B0B010101010"
    laTelepen(114) = "10B01S101S"
    laTelepen(115) = "BS1S101S"
    laTelepen(116) = "1010B010101010"
    laTelepen(117) = "B0101S101S"
    laTelepen(118) = "10BS10101010"
    laTelepen(119) = "1S1S10101010"
    laTelepen(120) = "1010101S101S"
    laTelepen(121) = "B01S10101S"
    laTelepen(122) = "10B01010101010"
    laTelepen(123) = "BS1010101010"
    laTelepen(124) = "10101S10101S"
    laTelepen(125) = "B0101010101010"
    laTelepen(126) = "101S1010101S"
    laTelepen(127) = "1S101010101S"
    laTelepen(128) = "1010101010101010"    && DEL

    lnLen = LEN(THIS.cTextValue)

    *-- Always calculates the check digit
    lnSum = 0
    IF lcDigit
      FOR ln = 1 TO lnLen STEP 2
        lnSum = lnSum + (VAL(SUBSTR(THIS.cTextValue, ln, 2)) + 27)
      ENDFOR
    ELSE
      FOR ln = 1 TO lnLen
        lnSum = lnSum + (ASC(SUBSTR(THIS.cTextValue, ln, 1)))
      ENDFOR
    ENDIF

    lnControl = IIF(MOD(lnSum, 127) > 0, MOD(lnSum, 127), MOD(lnSum, 127) * -1)

    lnLen = LEN(THIS.cTextValue)

    *-- Encode 0s and 1s
    lcRet = ""
    IF lcDigit
      lcStart = "1010101011101000"  && by GBG
      lcStop =  "1110100010101010"  && by GBG
      FOR ln = 1 TO lnLen STEP 2
        lcRet = lcRet + laTelepen(VAL(SUBSTR(THIS.cTextValue, ln, 2)) + 27 + 1)
      ENDFOR
      lcRet = lcRet + laTelepen(127 - lnControl + 1)
    ELSE
      lcStart = laTelepen(ASC("_") + 1)
      lcStop = SUBSTR(laTelepen(ASC("z") + 1), 1, 15)
      THIS.cTextValue = THIS.cTextValue + CHR(127 - lnControl)
      lnLen = LEN(THIS.cTextValue)
      FOR ln = 1 TO lnLen
        lcRet = lcRet + laTelepen(ASC(SUBSTR(THIS.cTextValue, ln, 1)) + 1)
      ENDFOR
    ENDIF

    *-- Add Start and Stop and apply ratio
    RETURN THIS.ApplyRatio(lcStart + lcRet + lcStop, THIS.nRatio)

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Pharmacode1()
  *------------------------------------------------------
  * Generate One Track Pharmacode barcode
  * FBC_CODE_PHARMA1 174
  *------------------------------------------------------
  FUNCTION Code_Pharmacode1()
    LOCAL lnI, lcValid, lcRet

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_PHARMA1_01
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(VAL(THIS.cTextValue),3,131070)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_PHARMA1_02
      RETURN NULL
    ENDIF

    lcRet = ""
    lnI = VAL(THIS.cTextValue)
    DO WHILE lnI > 0
      IF MOD(lnI,2) = 0
        lcRet = "111" + lcRet
        lnI = (lnI-2)/2
      ELSE
        lcRet = "1" + lcRet
        lnI = (lnI-1)/2
      ENDIF
      IF lnI > 0
        *-- Space
        lcRet = "00" + lcRet
      ENDIF
    ENDDO
    RETURN lcRet
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Pharmacode2()
  *------------------------------------------------------
  * Generate Two Track Pharmacode barcode
  * FBC_CODE_PHARMA2 175
  *------------------------------------------------------
  FUNCTION Code_Pharmacode2()
    LOCAL lnI, lcValid, lcRet

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cTextValue,CHRTRAN(THIS.cTextValue,lcValid,""),"") == THIS.cTextValue
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_PHARMA1_03
      RETURN NULL
    ENDIF

    IF NOT BETWEEN(VAL(THIS.cTextValue),4,64570080)
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_PHARMA2_01
      RETURN NULL
    ENDIF

    lcRet = ""
    lnI = VAL(THIS.cTextValue)

    DO WHILE lnI > 0
      lnR = MOD(lnI,3)
      DO CASE
        CASE lnR = 0
          *-- Full
          lcRet = "FFF" + lcRet
          lnI = (lnI-3)/3
        CASE lnR = 1
          *-- Desc
          lcRet = "DDD" + lcRet
          lnI = (lnI-1)/3
        CASE lnR = 2
          *-- Asc
          lcRet = "AAA" + lcRet
          lnI = (lnI-2)/3
      ENDCASE
      IF lnI > 0
        *-- Space
        lcRet = "SSS" + lcRet
      ENDIF
    ENDDO
    RETURN lcRet
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Sup5()
  *------------------------------------------------------
  * Generate UPC/EAN Supplemental 5
  *------------------------------------------------------
  FUNCTION Code_Sup5()
    LOCAL lnI, lcValid, lcStart, lcRet, lcControl

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cSupplementalText,CHRTRAN(THIS.cSupplementalText,lcValid,""),"") == THIS.cSupplementalText
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_SUPP5_01
      RETURN NULL
    ENDIF

    *--
    THIS.cSupplementalText = PADL(THIS.cSupplementalText, 5, "0")
    * THIS.cHumanReadableText = THIS.cSupplementalText

    LOCAL ARRAY laA(10), laB(10), laParity(10)
    laParity(1) ="EEOOO"
    laParity(2) ="EOEOO"
    laParity(3) ="EOOEO"
    laParity(4) ="EOOOE"
    laParity(5) ="OEEOO"
    laParity(6) ="OOEEO"
    laParity(7) ="OOOEE"
    laParity(8) ="OEOEO"
    laParity(9) ="OEOOE"
    laParity(10)="OOEOE"

    lcControl = RIGHT(STR(VAL(SUBSTR( THIS.cSupplementalText, 1, 1 )) * 3 + VAL(SUBSTR(THIS.cSupplementalText, 3, 1 )) * 3 + ;
      VAL(SUBSTR(THIS.cSupplementalText, 5, 1 )) * 3 + VAL(SUBSTR(THIS.cSupplementalText, 2, 1 )) * 9 + ;
      VAL(SUBSTR(THIS.cSupplementalText, 4, 1 )) * 9, 5, 0 ), 1 )

    lcControl = laParity(VAL(lcControl) + 1)

    *-- Left Set
    laA[1] ="0001101"   && 0
    laA[2] ="0011001"   && 1
    laA[3] ="0010011"   && 2
    laA[4] ="0111101"   && 3
    laA[5] ="0100011"   && 4
    laA[6] ="0110001"   && 5
    laA[7] ="0101111"   && 6
    laA[8] ="0111011"   && 7
    laA[9] ="0110111"   && 8
    laA[10]="0001011"   && 9

    *-- Right Set
    laB[1] ="0100111"   && 0
    laB[2] ="0110011"   && 1
    laB[3] ="0011011"   && 2
    laB[4] ="0100001"   && 3
    laB[5] ="0011101"   && 4
    laB[6] ="0111001"   && 5
    laB[7] ="0000101"   && 6
    laB[8] ="0010001"   && 7
    laB[9] ="0001001"   && 8
    laB[10]="0010111"   && 9

    lcStart = "1011"

    lcRet = lcStart

    FOR lnI = 1 TO 5
      IF SUBSTR(lcControl, lnI, 1 ) = "O"
        lcRet = lcRet + laA(VAL(SUBSTR(THIS.cSupplementalText, lnI, 1 )) + 1)
      ELSE
        lcRet = lcRet + laB(VAL(SUBSTR(THIS.cSupplementalText, lnI, 1 )) + 1)
      ENDIF
      IF lnI < 5
        lcRet = lcRet + "01"
      ENDIF
    ENDFOR

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Sup2()
  *------------------------------------------------------
  * Generate UPC/EAN Supplemental 2
  *------------------------------------------------------
  FUNCTION Code_Sup2()
    LOCAL lnI, lcValid, lcStart, lcRet, lcControl

    lcValid = "1234567890"
    IF NOT CHRTRAN(THIS.cSupplementalText,CHRTRAN(THIS.cSupplementalText,lcValid,""),"") == THIS.cSupplementalText
      *-- Chars or lenght not valid
      THIS.cMsgError = FBC_SUPP2_01
      RETURN NULL
    ENDIF

    *--
    THIS.cSupplementalText = PADL(THIS.cSupplementalText, 2, "0")
    *  THIS.cHumanReadableText = THIS.cTextValue

    LOCAL ARRAY laA(10), laB(10), laParity(4)
    laParity(1) = "OO"
    laParity(2) = "OE"
    laParity(3) = "EO"
    laParity(4) = "EE"

    lcControl = laParity(MOD(VAL(THIS.cSupplementalText), 4) + 1)

    *-- Left Set
    laA[1] ="0001101"   && 0
    laA[2] ="0011001"   && 1
    laA[3] ="0010011"   && 2
    laA[4] ="0111101"   && 3
    laA[5] ="0100011"   && 4
    laA[6] ="0110001"   && 5
    laA[7] ="0101111"   && 6
    laA[8] ="0111011"   && 7
    laA[9] ="0110111"   && 8
    laA[10]="0001011"   && 9

    *-- Right Set
    laB[1] ="0100111"   && 0
    laB[2] ="0110011"   && 1
    laB[3] ="0011011"   && 2
    laB[4] ="0100001"   && 3
    laB[5] ="0011101"   && 4
    laB[6] ="0111001"   && 5
    laB[7] ="0000101"   && 6
    laB[8] ="0010001"   && 7
    laB[9] ="0001001"   && 8
    laB[10]="0010111"   && 9

    lcStart = "1011"
    lcRet = lcStart

    FOR lnI = 1 TO 2
      IF SUBSTR(lcControl, lnI, 1 ) = "O"
        lcRet = lcRet + laA(VAL(SUBSTR(THIS.cSupplementalText, lnI, 1 )) + 1)
      ELSE
        lcRet = lcRet + laB(VAL(SUBSTR(THIS.cSupplementalText, lnI, 1 )) + 1)
      ENDIF
      IF lnI = 1
        lcRet = lcRet + "01"
      ENDIF
    ENDFOR

    RETURN lcRet

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Code_Ean128()
  *------------------------------------------------------
  * Generate EAN/UCC/GS1 128 bar code
  *------------------------------------------------------
  PROCEDURE Code_Ean128()

    IF NOT THIS.ValidAscii(THIS.cTextValue,0,127)
      *-- Chars not valid
      THIS.cMsgError = FBC_EAN128_01
      RETURN NULL
    ENDIF

    *-- Special characters
    #DEFINE FBC_SHIFT CHR(98 + 32)
    #DEFINE FBC_CODEC CHR(99 + 32)
    #DEFINE FBC_CODEB CHR(100 + 32)
    #DEFINE FBC_CODEA CHR(101 + 32)
    #DEFINE FBC_FNC1 CHR(102 + 32)

    *-- Use Application Identifiers. Ex (01)01234567890128(15)101231(10)BATCH
    IF THIS.lUseAppId
      *-- Replacement parentheses
      THIS.cTextValue = CHRTRAN(THIS.cTextValue, "()", FBC_FNC1 )
    ENDIF

    *-- Add FNC1 if necessary
    IF LEFT(THIS.cTextValue,1) <> FBC_FNC1
      THIS.cTextValue = FBC_FNC1 + THIS.cTextValue
    ENDIF

    *-- Current Set
    LOCAL lnSum, lcStart, lcStop, lnLen, lcRet
    IF THIS.IsNumeric(SUBSTR(THIS.cTextValue,2,4))
      lcCurrentSet = "C"
      lnSum = 105 && C
    ELSE
      IF THIS.ValidAscii(THIS.cTextValue,32,134)
        lcCurrentSet = "B"
        lnSum = 104 && B
      ELSE
        lcCurrentSet = "A"
        lnSum = 103 && A
      ENDIF
    ENDIF

    *-- Check all string
    LOCAL lcPar, lcStr, ln
    STORE "" TO lcStr, lcPar
    FOR ln = 1 TO LEN(THIS.cTextValue)
      lcPar = lcPar + SUBSTR(THIS.cTextValue,ln,1)
      IF LEN(lcPar) = 1
        IF INLIST(lcPar, FBC_FNC1, FBC_SHIFT, FBC_CODEC, FBC_CODEB, FBC_CODEA)
          *-- Control code
          lcStr = lcStr + lcPar
        ELSE  && INLIST(...
          IF ISDIGIT(lcPar) AND ln < LEN(THIS.cTextValue)
            LOOP
          ELSE && ISDIGIT(lcPar)
            IF lcCurrentSet = "C"
              IF THIS.ValidAscii(SUBSTR(THIS.cTextValue,ln),32,134) && The rest
                lcCurrentSet = "B"
                lcStr = lcStr + FBC_CODEB + lcPar
              ELSE && THIS.ValidAscii(
                lcCurrentSet = "A"
                lcStr = lcStr + FBC_CODEA + lcPar
              ENDIF && THIS.ValidAscii(
            ELSE && lcCurrentSet = "C"
              lcStr = lcStr + lcPar
            ENDIF && lcCurrentSet = "C"
          ENDIF && ISDIGIT(lcPar)
        ENDIF  && INLIST(...
      ELSE && LEN(lcPar) = 1
        IF THIS.IsNumeric(lcPar)
          IF lcCurrentSet = "C"
            lcStr = lcStr + THIS.Pair2Char(lcPar)
          ELSE && lcCurrentSet = "C"
            *-- Change Current Set C if 4 digit are numeric
            IF THIS.IsNumeric(SUBSTR(THIS.cTextValue,ln+1,2))
              lcCurrentSet = "C"
              lcStr = lcStr + FBC_CODEC + THIS.Pair2Char(lcPar)
            ELSE && THIS.IsNumeric(SUBSTR(THIS.cTextValue,ln+1,2))
              lcStr = lcStr + lcPar
            ENDIF && THIS.IsNumeric(SUBSTR(THIS.cTextValue,ln+1,2))
          ENDIF && lcCurrentSet = "C"
        ELSE && THIS.IsNumeric(lcPar)
          *-- 1st. is digit
          IF lcCurrentSet = "C"
            IF THIS.ValidAscii(SUBSTR(THIS.cTextValue,ln),32,134) && The rest
              lcCurrentSet = "B"
              lcStr = lcStr + FBC_CODEB + lcPar
            ELSE && THIS.ValidAscii(
              lcCurrentSet = "A"
              lcStr = lcStr + FBC_CODEA + lcPar
            ENDIF && THIS.ValidAscii(
          ELSE && lcCurrentSet = "C"
            lcStr = lcStr + lcPar
          ENDIF && lcCurrentSet = "C"
        ENDIF &&  && THIS.IsNumeric(lcPar)
      ENDIF && LEN(lcPar) = 1
      lcPar = ""
    ENDFOR

    THIS.cTextValue = lcStr

    LOCAL ARRAY laEan128[106]
    laEan128[1] = "11011001100"
    laEan128[2] = "11001101100"
    laEan128[3] = "11001100110"
    laEan128[4] = "10010011000"
    laEan128[5] = "10010001100"
    laEan128[6] = "10001001100"
    laEan128[7] = "10011001000"
    laEan128[8] = "10011000100"
    laEan128[9] = "10001100100"
    laEan128[10] = "11001001000"
    laEan128[11] = "11001000100"
    laEan128[12] = "11000100100"
    laEan128[13] = "10110011100"
    laEan128[14] = "10011011100"
    laEan128[15] = "10011001110"
    laEan128[16] = "10111001100"
    laEan128[17] = "10011101100"
    laEan128[18] = "10011100110"
    laEan128[19] = "11001110010"
    laEan128[20] = "11001011100"
    laEan128[21] = "11001001110"
    laEan128[22] = "11011100100"
    laEan128[23] = "11001110100"
    laEan128[24] = "11101101110"
    laEan128[25] = "11101001100"
    laEan128[26] = "11100101100"
    laEan128[27] = "11100100110"
    laEan128[28] = "11101100100"
    laEan128[29] = "11100110100"
    laEan128[30] = "11100110010"
    laEan128[31] = "11011011000"
    laEan128[32] = "11011000110"
    laEan128[33] = "11000110110"
    laEan128[34] = "10100011000"
    laEan128[35] = "10001011000"
    laEan128[36] = "10001000110"
    laEan128[37] = "10110001000"
    laEan128[38] = "10001101000"
    laEan128[39] = "10001100010"
    laEan128[40] = "11010001000"
    laEan128[41] = "11000101000"
    laEan128[42] = "11000100010"
    laEan128[43] = "10110111000"
    laEan128[44] = "10110001110"
    laEan128[45] = "10001101110"
    laEan128[46] = "10111011000"
    laEan128[47] = "10111000110"
    laEan128[48] = "10001110110"
    laEan128[49] = "11101110110"
    laEan128[50] = "11010001110"
    laEan128[51] = "11000101110"
    laEan128[52] = "11011101000"
    laEan128[53] = "11011100010"
    laEan128[54] = "11011101110"
    laEan128[55] = "11101011000"
    laEan128[56] = "11101000110"
    laEan128[57] = "11100010110"
    laEan128[58] = "11101101000"
    laEan128[59] = "11101100010"
    laEan128[60] = "11100011010"
    laEan128[61] = "11101111010"
    laEan128[62] = "11001000010"
    laEan128[63] = "11110001010"
    laEan128[64] = "10100110000"
    laEan128[65] = "10100001100"
    laEan128[66] = "10010110000"
    laEan128[67] = "10010000110"
    laEan128[68] = "10000101100"
    laEan128[69] = "10000100110"
    laEan128[70] = "10110010000"
    laEan128[71] = "10110000100"
    laEan128[72] = "10011010000"
    laEan128[73] = "10011000010"
    laEan128[74] = "10000110100"
    laEan128[75] = "10000110010"
    laEan128[76] = "11000010010"
    laEan128[77] = "11001010000"
    laEan128[78] = "11110111010"
    laEan128[79] = "11000010100"
    laEan128[80] = "10001111010"
    laEan128[81] = "10100111100"
    laEan128[82] = "10010111100"
    laEan128[83] = "10010011110"
    laEan128[84] = "10111100100"
    laEan128[85] = "10011110100"
    laEan128[86] = "10011110010"
    laEan128[87] = "11110100100"
    laEan128[88] = "11110010100"
    laEan128[89] = "11110010010"
    laEan128[90] = "11011011110"
    laEan128[91] = "11011110110"
    laEan128[92] = "11110110110"
    laEan128[93] = "10101111000"
    laEan128[94] = "10100011110"
    laEan128[95] = "10001011110"
    laEan128[96] = "10111101000" && DEL
    laEan128[97] = "10111100010" && FNC3
    laEan128[98] = "11110101000" && FNC2
    laEan128[99] = "11110100010" && Shift
    laEan128[100] = "10111011110" &&      / Code C
    laEan128[101] = "10111101110" && FNC4 / Code B
    laEan128[102] = "11101011110" &&      / Code A
    laEan128[103] = "11110101110" && FNC1
    laEan128[104] = "11010000100" && Start A
    laEan128[105] = "11010010000" && Start B
    laEan128[106] = "11010011100" && Start C

    lcStart = laEan128(lnSum + 1)
    lcStop = "1100011101011" && Stop

    *-- Always calculates the check digit
    FOR ln = 1 TO LEN(THIS.cTextValue)
      lnSum = lnSum + (ASC(SUBSTR(THIS.cTextValue, ln, 1)) - 32) * ln
    ENDFOR
    THIS.cTextValue = THIS.cTextValue + CHR(MOD(lnSum,103) + 32)
    lnLen = LEN(THIS.cTextValue)

    *-- Encode 0s and 1s
    lcRet = ""
    FOR ln = 1 TO lnLen
      lcRet = lcRet + laEan128(ASC(SUBSTR(THIS.cTextValue, ln, 1)) - 32 + 1)
    ENDFOR

    *-- Add Start and Stop
    RETURN lcStart + lcRet + lcStop

  ENDPROC

  *------------------------------------------------------
  * PROCEDURE nFactor_Assign
  *------------------------------------------------------
  * Assign method
  *------------------------------------------------------
  PROCEDURE nFactor_Assign(tnValue)
    THIS.nFactor = tnValue
    THIS.nFontHeight = THIS.nFactor * (THIS.nFontSize / THIS.nResolution) * 100
    THIS.nTextHeight = (THIS.nFontSize + 6 ) * THIS.nFactor
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE nResolution_Assign
  *------------------------------------------------------
  * Assign method
  *------------------------------------------------------
  PROCEDURE nResolution_Assign(tnValue)
    THIS.nResolution = tnValue
    THIS.nFontHeight = THIS.nFactor * (THIS.nFontSize / THIS.nResolution) * 100
    THIS.nTextHeight = (THIS.nFontSize + 6 ) * THIS.nFactor
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE nFontSize_Assign(tnValue)
  *------------------------------------------------------
  * Assign method
  *------------------------------------------------------
  PROCEDURE nFontSize_Assign(tnValue)
    THIS.nFontSize = tnValue
    THIS.nFontHeight = THIS.nFactor * (THIS.nFontSize / THIS.nResolution) * 100
    THIS.nTextHeight = (THIS.nFontSize + 6 ) * THIS.nFactor
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE lFontBold_Assign(tlValue)
  *------------------------------------------------------
  * Assign method
  *------------------------------------------------------
  PROCEDURE lFontBold_Assign(tlValue)
    THIS.lFontBold = tlValue
    THIS.cFontStyle = IIF(THIS.lFontBold, "B", "N") + IIF(THIS.lFontItalic, "I", "")
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE lFontItalic_Assign(tlValue)
  *------------------------------------------------------
  * Assign method
  *------------------------------------------------------
  PROCEDURE lFontItalic_Assign(tlValue)
    THIS.lFontItalic = tlValue
    THIS.cFontStyle = IIF(THIS.lFontBold, "B", "N") + IIF(THIS.lFontItalic, "I", "")
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Init()
  *------------------------------------------------------
  PROCEDURE INIT()
    THIS.cTempPath = ADDBS(THIS.TempPath() + SYS(2015))
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE Destroy()
  *------------------------------------------------------
  PROCEDURE DESTROY()
    THIS.EmptyFolder(THIS.cTempPath)
    IF DIRECTORY(THIS.cTempPath)
      RD (THIS.cTempPath)
    ENDIF
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE ResetProperties()
  *---------------------------------------------------------
  * Reset to default properties
  *---------------------------------------------------------
  PROCEDURE ResetProperties()
    LOCAL lo, ln, la(1), lcProp
    lo = CREATEOBJECT("FoxBarcode")
    FOR ln = 1 TO AMEMBERS(la, lo)
      lcProp = "This." + la(ln)
      IF PEMSTATUS(lo,la(ln),4) AND ;
          PEMSTATUS(lo,la(ln),3) = "Property" AND ;
          NOT PEMSTATUS(lo,la(ln),2) AND ;
          TYPE(lcProp) $ "NLC" AND ;
          NOT INLIST(UPPER(la(ln)),"CTEMPPATH","CIMAGEFILE")
        &lcProp = EVALUATE("lo." + la(ln))
      ENDIF
    ENDFOR
    lo = NULL
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE BarcodeCopyToClipboard()
  *---------------------------------------------------------
  * Copy barcode image to clipboard
  *---------------------------------------------------------
  PROCEDURE BarcodeCopyToClipboard()
    LOCAL loGDIP, loImageCopy
    loGDIP = CREATEOBJECT("gpInit")
    loImgCopy = CREATEOBJECT("gpImage2")
    loImgCopy.LOAD(THIS.cImageFile)
    loImgCopy.ToClipboard()
    RETURN IIF(FILE(THIS.cImageFile), .T., .F.)
  ENDPROC

  *------------------------------------------------------

  **********************
  *** Common methods ***
  **********************

  *------------------------------------------------------
  * PROCEDURE CheckDigitEan(tcText)
  *------------------------------------------------------
  * Calculates check digit for EAN, UPC and I2of5
  *------------------------------------------------------
  PROCEDURE CheckDigitEan(tcText)
    LOCAL lnSum, lnI, lnJ
    STORE 0 TO lnSum, lnJ
    FOR lnI = LEN(tcText) TO 1 STEP -1
      lnJ = lnJ + 1
      lnSum = lnSum + (VAL(SUBSTR(tcText, lnI, 1)) * IIF(MOD(lnJ, 2) = 0, 1, 3))
    ENDFOR
    RETURN TRANSFORM(MOD(10 - MOD(lnSum, 10), 10))
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE AddSpace(tcText, tnSpaces)
  *------------------------------------------------------
  * Add n spaces between each character
  *------------------------------------------------------
  PROCEDURE AddSpace(tcText, tnSpaces)
    LOCAL lc, ln, lnLen
    IF EMPTY(tnSpaces)
      tnSpaces = 1
    ENDIF
    lc = ""
    lnLen = LEN(tcText)
    FOR ln = 1 TO lnLen
      lc = lc + SUBSTR(tcText, ln, 1) + IIF(ln = lnLen, SPACE(0), SPACE(tnSpaces))
    ENDFOR
    RETURN lc
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE ValidAscii(tcText, tn1, tn2)
  *------------------------------------------------------
  * Valid each character Ascii
  *------------------------------------------------------
  PROCEDURE ValidAscii(tcText, tn1, tn2)
    LOCAL lnI, lnRet
    lnRet = .T.
    FOR lnI = 1 TO LEN(tcText)
      IF NOT BETWEEN(ASC(SUBSTR(tcText,lnI,1)),tn1,tn2)
        lnRet = .F.
        EXIT
      ENDIF
    ENDFOR
    RETURN lnRet
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE ApplyRatio(tcEncoded, tnRatio)
  *------------------------------------------------------
  * Apply ratio between bar
  *------------------------------------------------------
  PROCEDURE ApplyRatio(tcEncoded, tnRatio)
    LOCAL lcRet
    tcEncoded = STRTRAN(tcEncoded, "B", REPLICATE("1", tnRatio))
    tcEncoded = STRTRAN(tcEncoded, "S", REPLICATE("0", tnRatio))
    RETURN tcEncoded
  ENDPROC

  *------------------------------------------------------
  * PROCEDURE EmptyFolder(tcFolder)
  *------------------------------------------------------
  * Empty temporary image folder
  *------------------------------------------------------
  PROCEDURE EmptyFolder(tcFolder)
    LOCAL loFso AS OBJECT
    DO CASE
      CASE EMPTY(tcFolder)
        RETURN .F.
      CASE NOT DIRECTORY(tcFolder)
        RETURN .F.
    ENDCASE
    loFso  = CREATEOBJECT("Scripting.FileSystemObject")
    lcMask = ADDBS(tcFolder)+"*.*"
    loFso.DeleteFile(lcMask, .T.)
    RETURN  .T.
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE DeleteFolder(pcFolder)
  *---------------------------------------------------------
  PROCEDURE DeleteFolder(pcFolder)
    LOCAL loFso AS OBJECT
    DO CASE
      CASE EMPTY(pcFolder)
        RETURN .F.
      CASE NOT DIRECTORY(pcFolder)
        RETURN .F.
    ENDCASE
    loFso  = CREATEOBJECT("Scripting.FileSystemObject")
    RETURN loFso.DeleteFolder(pcFolder)
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE TempPath()
  *---------------------------------------------------------
  * Returns the path for temporary files
  *---------------------------------------------------------
  PROCEDURE TempPath()
    LOCAL lcPath, lnRet
    lcPath = SPACE(255)
    lnSize = 255
    DECLARE INTEGER GetTempPath IN WIN32API ;
      INTEGER nBufSize, ;
      STRING @cPathName
    lnRet = GetTempPath(lnSize, @lcPath)
    IF lnRet <= 0
      lcPath = ADDBS(FULLPATH("TEMP"))
    ELSE
      lcPath = ADDBS(SUBSTR(lcPath, 1, lnRet))
    ENDIF
    RETURN lcPath
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE Pair2Char(tcPair)
  *---------------------------------------------------------
  * Convert the pairs of numbers to char
  *---------------------------------------------------------
  PROCEDURE Pair2Char(tcPair)
    LOCAL lcRet, ln
    lcRet = ""
    FOR ln = 1 TO LEN(tcPair) STEP 2
      lcRet = lcRet + CHR(VAL(SUBS(tcPair, ln, 2)) + 32)
    ENDFOR
    RETURN lcRet
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE IsNumeric(tcString)
  *---------------------------------------------------------
  * Valid all chars are numerics
  *---------------------------------------------------------
  PROCEDURE IsNumeric(tcString)
    RETURN EMPTY(CHRTRAN(tcString,"1234567890",""))
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE IsFontTrueType(tcFontName)
  *---------------------------------------------------------
  * Validates that the font is TrueType
  * Thanks to Koen Piller (Netherlands)
  *---------------------------------------------------------
  PROCEDURE IsFontTrueType(tcFontName)
    LOCAL lnPitchFamily, lnFP
    lnPitchFamily = FONTMETRIC(16,ALLTRIM(tcFontName),10)
    lnFP = BITAND(lnPitchFamily,0x0F)
    RETURN BITAND(lnFP,0x04) <> 0
  ENDPROC

  *---------------------------------------------------------
  * PROCEDURE IsGdipFont(tcFontName, tcFontStyle)
  *---------------------------------------------------------
  * Validates that the font and style are permitted by GDI+
  * Thanks to Cesar Chalom (Brazil)
  *---------------------------------------------------------
  PROCEDURE IsGdipFont(tcFontName, tcFontStyle)
    * The Gdi+ API declarations were "Aliased" to avoid problems
    * with other possible Gdi+ classes working at the same time

    IF VERSION(5) < 700
      RETURN .T.
    ENDIF

    IF EMPTY(tcFontName)
      RETURN .F.
    ENDIF

    IF EMPTY(tcFontStyle)
      tcFontStyle = "N"
    ENDIF

    * GDI+ Initialization and Shutdown
    DECLARE LONG GdiplusStartup IN GDIPLUS.DLL ;
      AS FBC_GdiplusStartup ;
      LONG @ token, STRING @ INPUT, LONG @ OUTPUT

    DECLARE LONG GdiplusShutdown IN GDIPLUS.DLL ;
      AS FBC_GdiplusShutdown ;
      LONG token

    * FontFamily functions
    DECLARE INTEGER GdipCreateFontFamilyFromName IN GDIPLUS.DLL ;
      AS FBC_GdipCreateFontFamilyFromName ;
      STRING FamilyName, INTEGER FontCollection, INTEGER @FontFamily

    DECLARE INTEGER GdipDeleteFontFamily IN GDIPLUS.DLL ;
      AS FBC_GdipDeleteFontFamily ;
      INTEGER FontFamily

    LOCAL lcStartupInput, lcGdipToken
    lcStartupInput = CHR(1) + REPLICATE(CHR(0), 15)	&& GdiplusStartupInput structure (sizeof = 16)
    * Initialize GDI+
    lcGdipToken = 0
    IF FBC_GdiplusStartup(@lcGdipToken, @lcStartupInput, 0) <> 0
      RETURN .F. && Could not initialize Gdi+
    ENDIF

    LOCAL lnStatus, lhFontFamily, llCanUse, lcFontName
    lhFontFamily = 0
    lcFontName  = THIS.Widestr(tcFontName)
    lnStatus = FBC_GdipCreateFontFamilyFromName(lcFontName, 0, @lhFontFamily)

    DECLARE INTEGER GdipIsStyleAvailable IN GDIPLUS.DLL ;
      AS FBC_GdipIsStyleAvailable ;
      INTEGER nFontFamily, INTEGER nStyle, INTEGER @bIsAvailable

    LOCAL lnAvailable, lnFontStyle
    lnAvailable = 0
    lnFontStyle = 0 + IIF("B" $ tcFontStyle, 1, 0) + IIF("I" $ tcFontStyle, 2, 0)

    *-- Add by VFPEncoding
    lnStatus = FBC_GdipIsStyleAvailable(lhFontFamily, lnFontStyle, @lnAvailable )

    llCanUse = lnAvailable <> 0
    IF llCanUse
      * Clear the Gdi+ FontFamily created
      lnStatus = FBC_GdipDeleteFontFamily(lhFontFamily)
    ENDIF
    * Clear the Gdi+ handle
    lnStatus = FBC_GdiplusShutdown(lcGdipToken)
    RETURN llCanUse
  ENDPROC

  *---------------------------------------------------------
  * PROTECTED FUNCTION WideStr(tcStr)
  * Thanks to gpImage2
  *---------------------------------------------------------
  PROTECTED FUNCTION WideStr(tcStr)
    IF VERSION(5) >= 700
      RETURN STRCONV(tcStr + CHR(0), 5)
    ELSE
      LOCAL lnLen, lcWideStr
      lnLen = 2 * (LEN(tcStr) + 1)
      lcWideStr = REPLICATE(CHR(0), lnLen)
      DECLARE LONG MultiByteToWideChar IN kernel32 ;
        AS FBC_MultiByteToWideChar ;
        LONG iCodePage, LONG dwFlags, STRING @ lpStr, LONG iMultiByte, ;
        STRING @ lpWideStr, LONG iWideChar
      FBC_MultiByteToWideChar(0, 0, @tcStr, LEN(tcStr), @lcWideStr, lnLen)
      RETURN lcWideStr
    ENDIF
  ENDFUNC

  *---------------------------------------------------------

ENDDEFINE && FoxBarcode

*--------------------------------------------------------------------------------------
* END DEFINE FoxBarcode Class
*--------------------------------------------------------------------------------------
