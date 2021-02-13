{{SD-Karten-Version
┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Autor: Reinhard Zielinski                                                                            │
│ Copyright (c) 2013 Reinhard Zielinski                                                                │
│ See end of file for terms of use.                                                                    │
│ Die Nutzungsbedingungen befinden sich am Ende der Datei                                              │
└──────────────────────────────────────────────────────────────────────────────────────────────────────┘

Informationen   : hive-project.de
Kontakt         : zille09@gmail.com
System          : TriOS
Name            : PLEXUS - Zentrale Kommunikationseinheit der Borg
Chip            : Regnatix
Typ             : Loader-Programm für Plexus - TRIOS-Version
Version         : 01
Subversion      : 01-TRIOS

Funktion        : "Startdatei für PLEXUS - unter TRIOS lauffähig, startet den Administra- und Bellatrixcode von SD-Karte

Logbuch         :
'############################################# Version 1.00 #################################################################################################################
04-08-2013      : -Erster Versuch der Herauslösung der Startfunktionen aus der eigentlichen Plexus-Shell, es werden alle Startparameter in den E-Ram geladen und dann
                   die eigentliche Shell gestartet
                  -Außerdem wird das Plexus-Logo beim Start angezeigt -> das sieht cool aus ;-)

16-08-2013        -LOGO wurde Borg-mäßig in grün geändert - nu is noch cooler ;-)
                  -Scrolltext für unser Motto hinzugefügt - nu is aber Schluss mit cool

'############################################# Version 1.01 #################################################################################################################
15-10-2013        -LOGO-Farbgebung geändert, jetzt bunter, weil Plexus Version 2.0 geladen wird
19-10-2013        -Fehler in Iniload behoben, es wurde der Venatrix- und Sepia-Marker an die falsche Stelle im Ram abgelegt
07-11-2013        -Fehldarstellung beim Löschen des Start-Logo's behoben (jetzt wird der Bildschirm mit der aktuellen Shell-Hintergrundfarbe gelöscht)

'############################################# VERSION 1.02 #################################################################################################################
19-03-2014        -Laderoutine für die Error-und Systemtexte geändert, jeder Text hat jetzt eine feste Adresse, ist beim laden zwar langsamer aber die Texte
                  -werden viel schneller aus dem Ram geladen und angezeigt, egal wieviele Texte vorhanden sind
'############################################# VERSION 1.03 #################################################################################################################
12-02-2021        -Iniload-Routine korrigiert (2Byte Versatz beim Laden) dadurch wurde der Mauspfeil falsch dargestellt

}}

OBJ
        ios: "reg-ios-Modul"

CON

_CLKMODE     = XTAL1 + PLL16X
_XINFREQ     = 5_000_000

'-------- Speicher für diverse Texte ------------
TXT_RAM   = $20000
vidnfo    = $21000
sndnfo    = $21200
prgnfo    = $21400
Verz_RAM  = $22000
hlptxt    = $25000

'MENU_RAM  = $22000
'-------- Speicher für DLL-Namen ----------------
DLL_RAM   = $30000
'-------- Speicher für Titelliste ---------------
DMP_RAM   = $40000
'-------- Speicher für Screensaver --------------
SCREEN_SV = $63000
'-------- Speicher für Systemfont ---------------
SYS_FONT  = $66800 '....$52BFF      ' ab hier liegt der System-Font 11kb


MOUSE_RAM = $69400 '....$6943F      ' User-Mouse-Pointer 64byte

'-------- Speicher für Dateiliste ---------------
DIR_RAM   = $69440 '....$7DFFF
'-------- YMODEM Temp-Speicher ------------------
YMODEM_RAM= $7E400 '... $7E417   Name, der zu sendenden Datei, Was soll gemacht werden(0Empfang,1Senden)+Dirmarker

RETURN_POINT= $7E420'                 Aktion nach Rückkehr aus YModem (zBsp.Explorer öffnen)

LINK_RAM  = $7FE00
PARA_RAM  = $7FE40
SETTING_RAM = $7FF00 'Hier stehen die System-Settings
SEPIA_RAM   = $7FFA0 '..7FFA1
'Bereich 7FFF1-7FFFF 'Systemflags für Plexus und Basic
START_FLAG  = $7FFFF 'Flag das Plexus schonmal gestartet wurde ->Logo unterdrücken

Plex = $80000

'                                          +----------- flash
'                                          |+---------- com
'                                          || +-------- i2c
'                                          || |+------- rtc
'                                          || ||+------ lan
'                                          || |||+----- sid
'                                          || ||||+---- wav
'                                          || |||||+--- hss
'                                          || ||||||+-- bootfähig
'                                          || |||||||+- dateisystem
 ADM_SPEC       = %00000000_00000000_00000010_11010011

'******************Farben ********************************************************
  #$FC, Light_Grey, #$A8, Grey, #$54, Dark_Grey
  #$C0, Light_Red, #$80, Red, #$40, Dark_Red
  #$30, Light_Green, #$20, Green, #$10, Dark_Green
  #$1F, Light_Blue, #$09, Blue, #$04, Dark_Blue
  #$F0, Light_Orange, #$E6, Orange, #$92, Dark_Orange
  #$CC, Light_Purple, #$88, Purple, #$44, Dark_Purple
  #$3C, Light_Teal, #$28, Teal, #$14, Dark_Teal
  #$FF, White, #$00, Black

 OUTSIDE        = Dark_blue
 MIDDELSIDE     = blue
 INSIDE         = Light_blue
 TITLERAND      = DARK_blue
 TEXTCOL        = light_TEAL
 VERSIONTEXT    = WHITE
 WELCOMTEXT     = BLACK
 LOGOBOX        = light_TEAL
 LOGOCOL        = BLACK
 LOADERBAR      = light_TEAL

obj    gc:"glob-con"
VAR
'systemvariablen
  byte font[25]                    'Hilfsstring für Strings aus dem Ram
  byte colors[15]
  long systemdir                   'Systemverzeichnis-Marker

dat
   ini           byte "REG.INI",0               'Ini-Datei für Farbwerte, Dateiverknüpfungen und Systemeinstellungen
   errortxt      byte "ERROR.TXT",0
   video         byte "VIDEO.NFO",0
   sound         byte "SOUND.NFO",0
   prg           byte "PRG.NFO",0
   help          byte "help.txt",0
'   Trash         byte "TRASH       ",0
   dll_lst       byte "DLL.LST",0               'Dll-Namensliste
   plexus        byte "PLEXUS.DLL",0            'Plexus-Hauptprogramm
   SYSTEM        Byte "PLEXUS      ",0          'Plexus-Systemverzeichnis
   Version       byte "Version 2.5",0
   'sepia         byte "sepia.ini",0
   sysfont       byte "REG.FNT",0
   scrsaver      byte "PLEXUS.DAT",0
   scroll        byte "RESISTANCE IS FUTIL.",0

{
   dll0 byte "YMODEM.DLL",0
   dll1 byte "BASRUN.DLL",0
   dll2 byte "SEPIA.DLL",0
   dll3 byte "VENATRIX.DLL",0
   dll4 byte "DOS.DLL",0
   dll5 byte "DCF.DLL",0
   dll6 byte "BLTOOTH.DLL",0
   dll7 byte "FONT.DLL",0
   dll8 byte "WAVE.DLL",0
   dll9 byte "IRC.DLL",0
   dll10 byte "EEPROM.DLL",0

   dlls word @dll0,@dll1,@dll2,@dll3,@dll4,@dll5,@dll6,@dll7,@dll8,@dll9,@dll10
}
PUB main | i,a

    ios.start
    ios.sdmount                                         'sd-card mounten
    activate_dirmarker(0)
    ios.sdchdir(@system)                                'in's System-Verzeichnis springen
    systemdir:=get_dirmarker                            'System-Dirmarker lesen
    if ios.admgetspec<>ADM_SPEC
       ios.admload(string("PLEXUS.ADM"))                'Administracode laden

    activate_dirmarker(systemdir)                       'nach dem Neustart von Administra wieder ins Systemverzeichnis springen

    'if ios.bel_get<>88
    ios.belload(string("PLEXUS.BEL"))                'Bellatrixcode laden
    waitcnt(clkfreq+cnt)


    '***************** Initialisierung ohne Ini-Datei ****************************
    if iniload                                          'wenn keine Ini da ist, standardwerte setzen
       colors[0]:=light_blue
       colors[1]:=white
       colors[2]:=light_blue
       colors[3]:=white
       colors[4]:=dark_blue
       colors[5]:=white
       colors[6]:=grey
       colors[7]:=white
       colors[8]:=white
       colors[9]:=dark_blue
       colors[10]:=blue
       colors[11]:=white
       colors[12]:=purple
       colors[13]:=black
       colors[14]:=grey
       i:=SETTING_RAM
       a:=0
       repeat 15
           ios.ram_wrbyte(colors[a++],i++)

       ios.ram_wrbyte(7,i++)                'baudrate setzen auf 57600
       ios.ram_wrbyte(1,i++)                'show hidden files
       ios.ram_wrbyte(1,i++)                'use trash
       ios.ram_wrbyte(0,i++)                'Venatrix nicht verwenden
       ios.ram_wrbyte(0,i++)                'Sepia nicht verwenden
    '****************** Hauptbildschirm ******************************************
    ios.printchar(12)                    'cls

    '******************************************************************************
    '*Wird Plexus aus beendeten Bin Dateien geladen, wird das Logo nicht angezeigt*
    '******************************************************************************
    if ios.ram_rdbyte(START_FLAG)<>235                   'Plexus-Warmstart-Flag gesetzt?
       ios.ram_wrbyte(0,RETURN_POINT)
       ios.ram_fill(TXT_RAM,$32BFF,0)                    '1.Ram-Bank löschen
       LoadTiletoRam(@sysfont,SYS_FONT)                  'Systemfont auf jeden Fall in den Ram laden
       LoadTiletoRam(@scrsaver,SCREEN_SV)                'Plexus-Logo in den Ram laden
       loadtile(SCREEN_SV)                               'Plexus-Logo nach Bella laden
       ios.display2dbox(OUTSIDE,0,0,2,39,0)
       ios.printBoxcolor(0,teal,OUTSIDE,95)
       'ios.set_func(0,ios#printwindow)
       ios.setpos(1,2)
       ios.print(string("WE ARE BORG! YOU WILL BE ASSIMILATED"))
       ios.display2dbox(MIDDELSIDE,3,0,5,39,0)
       ios.display2dbox(INSIDE,6,0,9,39,0)

       ios.display2dbox(TITLERAND,10,0,10,39,0)

       ios.display2dbox(LOGOBOX,11,0,18,39,0)

       ios.display2dbox(TITLERAND,19,0,19,39,0)

       ios.display2dbox(INSIDE,20,0,23,39,0)
       ios.display2dbox(MIDDELSIDE,24,0,26,39,0)
       ios.display2dbox(OUTSIDE,27,0,29,39,0)
       ios.printBoxcolor(0,OUTSIDE,LOGOBOX,95)

       ios.displaypic(LOGOBOX,LOGOCOL,0,11,10,8,22)'light_orange,0,11,10,8,22)        'Plexus-Logo anzeigen
       ios.printBoxcolor(0,WELCOMTEXT,INSIDE,95)
       ios.setpos(7,15)
       ios.print(string("Welcome to"))
       ios.setpos(21,12)
       ios.print(string("for Hive-Computer"))
       ios.printBoxcolor(0,VERSIONTEXT,MIDDELSIDE,95)
       ios.setpos(24,15)
       ios.print(@version)
       ios.printBoxcolor(0,TEXTCOL,OUTSIDE,95)
       ios.setpos(27,11)
       ios.print(string("RESISTANCE IS FUTIL."))

       ios.ram_fill($80000,$8000,0)                         'Speicher leeren

    '--------------------------------------------------------------------------------------
       activate_dirmarker(systemdir)                       'nach dem Neustart von Administra wieder ins Systemverzeichnis springen
       ios.sdopen("R",@errortxt)
       fileload_err(TXT_RAM,1)                            'Fehler-Texte laden
       ios.display2dbox(LOADERBAR,29,0,29,5,0)
       ios.sdopen("R",@dll_lst)
       fileload_err(DLL_RAM,1)                            'dll-namen laden
       ios.display2dbox(LOADERBAR,29,0,29,10,0)
       ios.sdopen("R",@video)
       fileload_err(vidnfo,0)
       ios.display2dbox(LOADERBAR,29,0,29,15,0)
       ios.sdopen("R",@sound)
       fileload_err(sndnfo,0)
       ios.display2dbox(LOADERBAR,29,0,29,20,0)
       ios.sdopen("R",@prg)
       fileload_err(prgnfo,0)
       ios.display2dbox(LOADERBAR,29,0,29,25,0)
       ios.sdopen("R",@help)
       fileload_err(hlptxt,0)
       ios.display2dbox(LOADERBAR,29,0,29,30,0)


    '************************* Plexus wird geladen *************************************

       ios.sdopen("R",@plexus)                           'Plexus.Dll öffnen
       fileload(plex)                                    'Programm-Info laden
       ios.display2dbox(LOADERBAR,29,0,29,39,0)
       ios.printBoxcolor(0,black,ios.ram_rdbyte(SETTING_RAM),95)
       ios.sdclose
       ios.sdunmount
    ios.ld_rambin(2)

con '***************************************************** Diverse Texte in den E-Ram laden **************************************************************************************

PRI fileload(adr)|cont

    cont:=ios.sdfattrib(0)
    ios.sdxgetblk(adr,cont)
    ios.sdclose

PRI fileload_err(adr,mode)| cont,c,b,a,i                'Fileload RAM-Version
    i:=adr

    b:=0
    repeat
           a:=ios.sdgetc
           ios.ram_wrbyte(a,i++)
           b++
              if a==10
                 if mode
                    i:=i+(25-b)
                    b:=0
                    next

    until ios.sdeof
    ios.sdclose

PRI activate_dirmarker(mark)                       'USER-Marker setzen

     ios.sddmput(ios#DM_USER,mark)                 'usermarker wieder in administra setzen
     ios.sddmact(ios#DM_USER)                      'u-marker aktivieren

PRI get_dirmarker:dm                               'USER-Marker lesen

    ios.sddmset(ios#DM_USER)
    dm:=ios.sddmget(ios#DM_USER)

con '********************************* Unterprogramme zur Tile-Verwaltung *********************************************************************************************************
PRI LoadTiletoRam(datei,adress)                         'tile:=tilenr,dateiname,xtile-zahl,ytilezahl

    ios.sdopen("R",datei)')                             'datei öffnen
    ios.sdxgetblk(adress,11264)                         'datei in den Speicher schreiben  (der blockbefehl ist viel schneller als der char-Befehl)
    ios.sdclose

PRI loadtile(adress)                                           'tileset aus eram in bella laden

    'anzahl:=2816        'anzahl longs                 '(16*11*16longs)
    ios.loadtilebuffer(adress,2816) 'laden          'Systemfont-Bereich (Basic verwendet den gleichen Bereich)


PRI iniload:err|i,tmp


       activate_dirmarker(systemdir)

       if ios.sdopen("R",@ini)
          err:=1
       else
          err:=0
          i:=SETTING_RAM
          '---- SYSTEM-SETTINGS IN DEN RAM LADEN -------------
          repeat 21
               ios.ram_wrbyte(ios.sdgetc,i++)
          tmp:=i
          '---- DESKTOP-VERKNÜPFUNGEN IN DEN RAM LADEN -------
          i:=LINK_RAM
          repeat 51
               ios.ram_wrbyte(ios.sdgetc,i++)
          '---- USER-MAUSZEIGER IN DEN RAM LADEN -------------
          i:=MOUSE_RAM
          repeat 64
              ios.ram_wrbyte(ios.sdgetc,i++)
          ios.Mousepointer(MOUSE_RAM)            'MAUSZEIGER ANWENDEN
          ios.displaymouse(0,0)
          '---- LINK-PARAMETER IN DEN RAM LADEN --------------
          i:=PARA_RAM
          repeat 192
              ios.ram_wrbyte(ios.sdgetc,i++)
          '---- DCF-Empfänger benutzen -----------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)
          '---- HC05-Bluetooth-Modul -------------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)
          '---- Extended Titlebar-Anzeige --------------------
          ios.ram_wrbyte(ios.sdgetc,tmp++)

    ios.sdclose



DAT                                                     'lizenz
{{

┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                   TERMS OF USE: MIT License                                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation    │ 
│files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    │
│modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software│
│is furnished to do so, subject to the following conditions:                                                                   │
│                                                                                                                              │
│The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.│
│                                                                                                                              │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          │
│WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         │
│COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   │
│ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
}}
              
